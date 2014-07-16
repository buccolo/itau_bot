class ItauWebParser
  def parse_extrato(page_html)
    html = Nokogiri.parse(page_html)
    trans = html.css("#buscaPesquisaOnline tr").select {|tr| tr.css(".EXTlinhaPar, .EXTlinhaImpar").count > 0}
    trans.map {|tr| tr.css("td").select {|td| td.text.strip != "" }.map {|td| td.text } }
  end

  def parse_poupanca(page_html)
    html = Nokogiri.parse(page_html)
    trans = html.css("#TRNcontainer01 table table").select {|tr| tr.css(".EXTlinhaPar, .EXTlinhaImpar").count > 0}
    trans.map {|tr| tr.css("td").select {|td| td.text.strip != "" }.map {|td| td.text } }
  end

  def parse_cartao_credito(page_html)
    html = Nokogiri.parse(page_html)
    trans = html.css("#TRNcontainer01 > table:nth-child(10) > tbody > tr:nth-child(1) > td:nth-child(4) table").select {|tr| tr.css(".TRNtitcampo_linha").count > 0}
    trans = trans.inject([]) { |buf, cur| buf << cur.css("tr") }
    trans.inject([]) { |buf, cur| buf << cur.map {|tr| tr.css("td").select {|td| td.text.strip != "" }.map {|td| td.text } } }
  end
end
