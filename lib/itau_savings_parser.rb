class ItauSavingsParser
  def parse(page_html)
    html = Nokogiri.parse(page_html)
    rows = html.css("#TRNcontainer01 > table > tbody > tr:nth-child(4) > td > table tr").map(&:text)

    rows.map(&method(:clean)).map(&method(:format)).reject {|tx| blacklisted? tx[:memo] }
  end

  private
  def format(row)
    {
      date: parse_date(row[0]),
      memo: row[1],
      value: parse_value(row[2])
    }
  end

  def clean(row)
    row.split(/[\n\t]/).map {|text| transliterate(text).strip }.reject {|f| f.empty?}
  end

  def transliterate(text)
    ActiveSupport::Inflector.transliterate(text, "").strip
  end

  def blacklisted?(memo)
    final = [
      "S A L D O",
      "SALDO ANTERIOR",
      "TRANSF SALDO BASE DIA 01"
    ]

    # TRANSF SALDO BASE DIA 01 -> 31
    30.times { final << final.last.next }

    final.include? memo
  end

  def parse_value(text)
    negative = (text.last == "-")

    value = text.gsub(/[\.,]/, "").to_i
    value = -value if negative
    value
  end

  def parse_date(text)
    date = DateTime.now - 1.month
    date = date.change(day: text.to_i)

    if @last_date && (@last_date.day > date.day)
      date = date + 1.month
    else
      @last_date = date
    end

    "#{date.year}-#{date.month}-#{date.day}"
  end

  def last_month
    (DateTime.now - 1.month).month
  end
end
