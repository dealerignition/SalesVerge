module EstimatesHelper
  def total_estimates(estimates)
    total = 0
    estimates.each { |e| total += e.total }
    total
  end
end
