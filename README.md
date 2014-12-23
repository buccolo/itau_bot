ItauBot [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/buccolo/itau_bot)
========

Faz scrape do seu extrato, poupança e cartão de crédito.

Bot pronto para ser deployado no heroku. Faz o scrape e posta o JSON para uma url.

Que falta faz uma API...

### Heroku Scheduler
```
bundle exec rake itau_bot:run
```

### Desenvolvimento
```
ITAU_BOT_AGENCIA=1234 ITAU_BOT_CONTA=1234-5 ITAU_BOT_NOME=BRUNO ITAU_BOT_SENHA=1234 ITAU_BOT_URL="http://seusite.com.br" foreman start bot
```

### Formato

Em desenvolvimento...
