class ItauWebCredentials < Struct.new(:agencia, :conta, :nome, :senha)
  def self.from_env
    new(ENV['ITAU_BOT_AGENCIA'],
        ENV['ITAU_BOT_CONTA'],
        ENV['ITAU_BOT_NOME'],
        ENV['ITAU_BOT_SENHA'])
  end
end

