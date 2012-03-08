class Quote < ActiveRecord::Base
  validates_presence_of :quote_type
  validates :quote_type, :inclusion => {
    :in => %w( quote estimate ),
    :message => "must be either Quote or Estimate."
  }

  has_many :charges
  before_validation { |q| q.quote_type = q.quote_type.downcase if q.quote_type }

  def total
    total = 0

    charges.each do |c|
      total += c.total
    end

    total.round 2
  end
end
