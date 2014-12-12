class ItauWebParser
  def parse_extrato(page_html)
    html = Nokogiri.parse(page_html)
    trans = html.css("#buscaPesquisaOnline tr").select {|tr| tr.css(".EXTlinhaPar, .EXTlinhaImpar").count > 0}
    final = trans.map {|tr| tr.css("td").select {|td| td.text.strip != "" }.map {|td| td.text.strip } }

    { transactions: final }
  end

  def parse_poupanca(page_html)
    html = Nokogiri.parse(page_html)
    trans = html.css("#TRNcontainer01 table table").select {|tr| tr.css(".EXTlinhaPar, .EXTlinhaImpar").count > 0}
    final = trans.map {|tr| tr.css("td")}

    {
      transactions: group_in(3, filter_non_blank(final[0])),
      balance: group_in(2, filter_non_blank(final[1])),
      total: group_in(2, filter_non_blank(final[2]))
    }
  end

  def parse_cartao_credito(page_html)
    html = Nokogiri.parse(page_html)
    trans = html.css("#TRNcontainer01 > table:nth-child(10) > tbody > tr:nth-child(1) > td:nth-child(4) table").select {|tr| tr.css(".TRNtitcampo_linha").count > 0}
    trans = trans.inject([]) { |buf, cur| buf << cur.css("tr") }
    trans.inject([]) { |buf, cur| buf << cur.map {|tr| tr.css("td").select {|td| td.text.strip != "" }.map {|td| td.text } } }
  end

  def group_in(batch, array)
    new_array = []

    i = 0
    current_array = []
    array.each do |object|
      current_array << object.text
      i += 1

      if i == batch
        i = 0
        new_array << current_array
        current_array = []
      end
    end

    new_array
  end

  def filter_non_blank(rows)
    rows.select do |td|
      if match = td.text.match(/[\w\,\.\ ]+/)
        match[0] != ""
      else
        false
      end
    end
  end
end
