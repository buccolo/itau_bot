require 'active_support/all'

class ItauBalanceParser
  def parse(page_html)
    html = Nokogiri.parse(page_html)
    trans = html.css("#buscaPesquisaOnline tr").select {|tr| tr.css(".EXTlinhaPar, .EXTlinhaImpar").count > 0}
    table_cells = trans.map {|tr| tr.css("td").select do |td|
      text = td.text.strip
      text != "" && text != " D" && text != " C"
    end.map {|td| td.text.strip } }

    fix_year_leaps(format_transactions(table_cells).reject {|transaction| blacklisted? transaction[:memo]})
  end

  def fix_year_leaps(transactions)
    last_year = (DateTime.now - 1.year).year.to_s
    current_year = DateTime.now.year.to_s

    current_month = DateTime.parse(transactions.last[:date]).month
    transactions.reverse.each do |tx|
      if (tx_month = DateTime.parse(tx[:date]).month) <= current_month
        current_month = tx_month
      else
        tx[:date].gsub! current_year, last_year
      end
    end.reverse
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

    "#{DateTime.now.year}-#{month}-#{day}"
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
      "SALDO ANTERIOR",
      "TRANSFERENCIA SALDO"
    ].include? memo
  end
end
