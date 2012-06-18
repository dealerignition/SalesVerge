require 'scrapy'

class ScrapyJob
  def self.run
    companies = Company.where("scraping_configured = true and (last_scrape is null or (date_part('day', age(now(), last_scrape)) > run_every_x_days))")

    companies.each do |company|
      scrape(company)
    end
  end

  def self.scrape(company)
    puts "Scraping for #{company.name}"
    company.currently_scraping = true
    company.save

    options = [{:type=>"#{company.description_type}",:name=>"Description",:location=>"#{company.description_location}"},
               {:type=>"#{company.name_type}",:name=>"Name",:location=>"#{company.name_location}"},
               {:type=>"#{company.price_type}",:name=>"Price",:location=>"#{company.price_location}"},
               {:type=>"#{company.product_number_type}",:name=>"Skew",:location=>"#{company.product_number_location}"}]

    @success = nil
    @scraper = Scrapy::Crawler.new(company.website, options)
    begin
      @scraper.crawl
      while not @scraper.crawling_complete?
        sleep(30)
      end
      products = @scraper.retrieve_products
      @scraper.cleanup
      
      Sample.where(["company_id = ? and creator = 'System'", company.id]).destroy_all
      
      products.each do |product|
        sample = Sample.new
        sample.dealer_sample_id = product[:Skew]
        sample.name = product[:Name]
        sample.creator = 'System'
        sample.sample_type = company.something
        sample.created_at = DateTime::now
        sample.updated_at = DateTime::now
        sample.price = product[:Price].to_f
        sample.url = product[:page_url]
        sample.description = product[:Description]
        sample.company_id = company.id
        sample.save
      end
      
      @success = true
    rescue Exception => e
      @success = false
      puts "#{e.message}"
    ensure
      company = Company.find(company.id)
      company.last_scrape = DateTime::now if @success
      company.currently_scraping = false
      company.save
    end
  end
end
