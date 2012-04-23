module QuotesHelper
  def total_quotes(quotes)
    total = 0
    quotes.each { |e| total += e.total }
    total
  end
end
