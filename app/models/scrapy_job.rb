require 'redis'

class ScrapyJob
  def self.run
    if File.exists('scraper_running.rb')
      return
    end

    file = File.new('scraper_running.rb', 'r')
    file.close

    companies = Company.where("scraping_configured = true and (last_scrape is null or (date_part('day', age(now(), last_scrape)) > run_every_x_days))")

    companies.each do |company|
      scrape(company)
    end

    File.delete('scraper_running.rb')
  end

  def self.scrape(company)
    puts "Scraping for #{company.name}"
    company.currently_scraping = true
    company.save

    options = [{:type=>"#{company.description_type}",:name=>"Description",:location=>"#{company.description_location}"},
               {:type=>"#{company.name_type}",:name=>"Name",:location=>"#{company.name_location}"},
               {:type=>"#{company.price_type}",:name=>"Price",:location=>"#{company.price_location}"},
               {:type=>"#{company.product_number_type}",:name=>"Skew",:location=>"#{company.product_number_location}"},
               {:type=>"#{company.image_type}",:name=>"Image",:location=>"#{company.image_location}"}]

    @success = nil
    begin
      Sample.where(["company_id = ? and creator = 'System'", company.id]).destroy_all
      
      Anemone.crawl(company.website) do |anemone|
        anemone.storage = Anemone::Storage.Redis({:host => 'viperfish.redistogo.com', :port => '10091', :username => 'itaccounts@dealerignition.com', :password => 'e29c960673834e7cd254ebb3c95c5c26'})
        
        anemone.on_every_page do |page|
          begin
            webpage = Hpricot(open(page.url, 'User-Agent' => 'ruby'))
            
            map = {}
            found = true
            options.each do |item|
              if item[:type] != 'custom'
                div = webpage.search("body").search("[@#{item[:type]}~='#{item[:location]}']")
                if div.length != 0
                  map[item[:name]] = div[0].inner_text
                else
                  found = false
                end
              else
                div = (webpage/"#{item[:location]}").inner_text
                if div != ""
                  map[item[:name]] = div
                else
                  found = false
                end
              end
            end
            
            if found
              map[:page_url] = page.url
              sample = Sample.new
              sample.dealer_sample_id = map["Skew"]
              sample.name = map["Name"]
              sample.image_url = map["Image"]
              sample.creator = 'System'
              sample.sample_type = company.sample_name
              sample.price = map["Price"].to_f
              sample.url = map[:page_url].to_s
              sample.description = map["Description"]
              sample.company_id = company.id
              sample.save!
            end
          rescue Exception => e
            puts e.message
            puts e.backtrace
          end
        end
      end
      
      @success = true
    rescue Exception => e
      @success = false
      puts "#{e.message}"
      puts "#{e.backtrace}"
    ensure
      company = Company.find(company.id)
      company.last_scrape = DateTime::now if @success
      company.currently_scraping = false
      company.save
    end
  end
end
