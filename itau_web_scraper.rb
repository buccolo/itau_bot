class ItauWebScraper
  include Capybara::DSL

  attr_reader :parser

  def initialize
    page.driver.headers = { 'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36" }
    visit "/"

    @payload = {}
    @parser = ItauWebParser.new
    @credentials = ItauWebCredentials.from_env
  end

  def login
    puts "-----> Login"

    fill_in "campo_agencia", with: @credentials.agencia
    fill_in "campo_conta", with: @credentials.conta
    click_on "Acessar"

    click_on @credentials.nome

    puts "-----> Password"
    @credentials.senha.chars.each do |char|
      find(".TextoTecladoVar img[title*='#{char}']").click
    end

    find("img[alt='Continuar']").click

    @logged_in = true
  end

  def extrato
    login unless @logged_in
    puts "-----> Extrato"

    click_on "Home"
    click_on "ver extrato"
    select "ltimos 90 dias", from: "periodoExtrato"
    sleep 5 # required for this ^

    @payload.merge!({ balance: parser.parse_extrato(page.html) })
  end

  def poupanca
    login unless @logged_in
    puts "-----> Poupança"

    click_on "Poupança"
    click_on "30 dias"
    find("#poupanca1").click
    click_on "CONTINUAR"

    @payload.merge!({ savings: parser.parse_poupanca(page.html) })
  end

  def cartao_credito
    login unless @logged_in
    puts "-----> Cartão de Crédito"

    click_on "Cartões"
    click_on "Fatura"

    find("img[src*='aba_nfatura_atual']").click
    current_statement = parser.parse_cartao_credito(page.html)

    find("img[src*='aba_nfatura_proxima']").click
    next_statement = parser.parse_cartao_credito(page.html)

    @payload.merge!({
      credit_card: {
        current_statement: current_statement,
        next_statement: next_statement
      }
    })
  end

  def scrape
    extrato
    poupanca
    cartao_credito
  end
end
