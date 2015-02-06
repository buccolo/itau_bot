# ItauBot 
Extraia suas informações financeiras das garras do Itaú!

Você roda o bot com seus dados de acesso, ele extrai as informações de extrato, poupança e envia essas informações para uma URL.

## Uso

### Configurações

| Variavel            | Descrição |
| --------------------|---------------| 
| `ITAU_BOT_AGENCIA`    | Número da agência | 
| `ITAU_BOT_CONTA`      | Número da conta e digito, com hífen | 
| `ITAU_BOT_NOME`       | Nome que aparece antes de digitar senha eletrônica |
| `ITAU_BOT_SENHA`      | Senha eletrônica |
| `ITAU_BOT_URL`        | URL para qual o ItauBot mandará as informações |

### Rodando o ItauBot

```bash
export ITAU_BOT_AGENCIA="1234" 
export ITAU_BOT_CONTA="1234-5" 
export ITAU_BOT_NOME="BRUNO" 
export ITAU_BOT_SENHA="123456" 
export ITAU_BOT_URL="http://site.com.br/path" 

git clone git@github.com:buccolo/itau_bot.git
cd itau_bot/
bundle install
bundle exec rake itau_bot:run
```

### Lendo o output do ItauBot

Por razões de performance, os dados do ItauBot trafegam em format Base64 de uma compressão Zlib de um JSON:
```ruby
require 'base64'
require 'zlib'

itau_bot_response = JSON.parse(
  Zlib::Inflate.inflate(
    Base64.decode64(
      request.raw_post
    )
  )
)

return unless itau_bot_response[:success] # o bot pode falhar 

itau_bot_response[:balance].each do |transactions|
  ## faça algo incrível aqui
end

itau_bot_response[:savings].each do |transactions|
  ## faça algo incrível aqui
end
```

## Porque postar para uma URL?
Estou fazendo o [Grana.io](https://grana.io), um serviço pra gerenciar minhas finanças automagicamente. Quer ser [beta tester?](mailto:bruno.buccolo+grana@gmail.com?subject=BETA&body=seu@email.com)
![](http://cl.ly/image/3w2v1i1M463a/687474703a2f2f636c2e6c792f696d6167652f30713069336c33673235326e2f53637265656e25323053686f74253230323031352d30322d3035253230617425323031312e35302e3036253230504d2e706e67.png)

## Cuidado: Heroku e servidores fora do Brasil
Minha conta foi [bloqueada (408X)](http://www.reclameaqui.com.br/3034313/banco-itau-s-a/conta-bloqueada-codigo-408/) quando comecei a usar o ItauBot no Heroku. Presumo que qualquer servidor fora do país gere o mesmo problema. Para atualizar minhas finanças agora rodo apenas do meu próprio notebook em casa.

## LICENSE

The MIT License

Copyright (c) 2010-2015 Bruno de Campos Buccolo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
