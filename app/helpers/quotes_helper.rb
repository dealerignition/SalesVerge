module QuotesHelper
  def total_quotes(quotes)
    total = 0
    quotes.each { |e| total += e.total }
    total
  end

  def get_samples
    Sample.where("id IN (?)", @quote.customer.sample_checkouts.pluck(:sample_id)
                ).uniq.select("id, name, dealer_sample_id")
  end

  def autofill(samples = get_samples)
    autofill = samples.collect { |s| s.name }
    autofill += samples.collect { |s| s.dealer_sample_id }
  end
end
