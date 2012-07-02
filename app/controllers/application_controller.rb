class ApplicationController < ActionController::Base
  include Totango::Adapters::Rails
  check_authorization :except => :close_tutorial
  protect_from_forgery
  
  # Pass in identifiers for Totango
  sp_default :user, proc { current_user.full_name }
  sp_default :organization, proc { current_user.company.name }
  
  layout 'main'

  def confirm_active
    if !current_user.active?
      logout
      flash[:alert] = "Your account has been deactivated. See your account administrator for details."
      redirect_to login_url
    end
  end

  def close_tutorial
    @user = current_user
    @user.display_tutorial = false
    @user.save
    redirect_to :back
  end

  def require_owner
    unless current_user.owner?
      flash[:error] = "Only account owners can see that."
      redirect_to settings_account_path
    end
  end

  DATE_RANGES = {
    :today => "updated_at > TIMESTAMP 'today'",
    :yesterday => "TIMESTAMP 'today' > updated_at AND updated_at > TIMESTAMP 'yesterday'",
    :this_month => "updated_at > CURRENT_DATE - INTERVAL '#{Date.today.day} days'",
    :last_30_days =>  "updated_at > CURRENT_DATE - INTERVAL '30 days'",
    :all_time => "updated_at > TIMESTAMP '-infinity'"
  }

  def searchable_index(model, query_fields)
    if params[:query]
      @records = search(model, params[:query], query_fields)
    else
      @records = model.accessible_by(current_ability)
    end

    respond_to do |format|
      format.html do
        render @records, :layout => false if request.xhr?
      end
      format.json { render :json => @records }
    end
  end

  def search(model, query, query_fields)
    @query = Regexp.escape(query).split.join("|")

    select_fields = query_fields.push(:id).collect do |field|
      "#{model.table_name}.#{field}"
    end

    where_fields = select_fields[0..-1]

    @records = model.accessible_by(current_ability)
                  .select(select_fields)
                  .where("(#{where_fields.join("||")}) ~* ?", @query)

    query = Regexp.compile("(#{@query})", Regexp::IGNORECASE)
    starts_with_query = Regexp.compile("^(#{@query}).*", Regexp::IGNORECASE)
    is_query = Regexp.compile("^(#{@query})$", Regexp::IGNORECASE)

    @records.sort_by! do |record|
      count = 0

      query_fields.each do |field|
        if record.send(field) =~ is_query
          count += 0.5
        elsif record.send(field) =~ starts_with_query
          count += 0.3
        elsif record.send(field) =~ query
          count += 0.2
        end
      end

      -count
    end

    @records
  end

  private

  def not_authenticated
    flash[:error] = "You must login to see that page." unless request.path == "/"
    redirect_to login_url
  end

  rescue_from CanCan::AccessDenied do |exception|
    request.env["HTTP_REFERER"] ||= dashboard_path

    begin
      msg = exception.subject.class.model_name.downcase!
    rescue
      msg = "page"
    end

    redirect_to :back, :flash => { :error => "You do not have permission to #{ exception.action } this #{ msg }." }
  end

end
