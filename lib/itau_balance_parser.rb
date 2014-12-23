require 'active_support/all'

class ItauBalanceParser
  def parse(page_html)
    html = Nokogiri.parse(page_html)
    trans = html.css("#buscaPesquisaOnline tr").select {|tr| tr.css(".EXTlinhaPar, .EXTlinhaImpar").count > 0}
    table_cells = trans.map {|tr| tr.css("td").select do |td|
      text = td.text.strip
      text != "" && text != " D" && text != " C"
    end.map {|td| td.text.strip } }

    format_transactions(table_cells).reject {|transaction| blacklisted? transaction[:memo]}
  end

  def format_transactions(transactions)
    transactions.map do |transaction|
      {
        date: parse_date(transaction[0]),
        memo: parse_memo(transaction[1]),
        value: parse_value(transaction)
      }
    end
  end

  def parse_memo(text)
    ActiveSupport::Inflector.transliterate(text, "").strip
  end

  def parse_value(transaction)
    value = transaction[2].gsub(/[\.,]/, "").to_i
    value = -value if transaction.last == "-"
    value
  end

  def parse_date(text)
    day, month = text.split("/")

    "#{year(month)}-#{month}-#{day}"
  end

  def year(month)
    "2014" # fix this in 2015 :)
  end

  def blacklisted?(memo)
    [
      "(-) SALDO A LIBERAR",
      "SALDO FINAL DISPONIVEL",
      "SDO",
      "SDO CTA/APL AUTOMATICAS",
      "S A L D O",
      "SALDO DO DIA",
      "REND PAGO APLIC AUT APR",
      "SALDO ANTERIOR"
    ].include? memo
  end
end
