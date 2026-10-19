module ApplicationHelper
  CURRENCY_SYMBOLS = { "EUR" => "€", "USD" => "$", "GBP" => "£", "CHF" => "CHF " }.freeze

  def money(cents, currency = "EUR")
    number_to_currency(cents.to_i / 100.0, unit: CURRENCY_SYMBOLS.fetch(currency, "#{currency} "))
  end
end
