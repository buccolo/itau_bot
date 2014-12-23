module Helpers
  def itau_balance_html
    File.read(File.expand_path("../../fixtures/itau_balance.html", __FILE__))
  end
end
