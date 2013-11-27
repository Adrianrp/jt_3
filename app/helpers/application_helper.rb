module ApplicationHelper

	def currency_kr (item)
    number_to_currency(item, unit: " kr", separator: ",", delimiter: "", format: "%n %u")
  end

	 # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Jespers Torvekøkken"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
