module QuotesHelper
  def total_quotes(quotes)
    total = 0
    quotes.each { |q| total += q.total }
    total
  end
end
