ItauBot
========

Faz scrape do seu extrato, poupança e cartão de crédito.

Bot pronto para ser deployado no heroku. Faz o scrape e posta o JSON para uma url.

Que falta faz uma API...

### Heroku Config
```
$ heroku config
=== your-heroku-app Config Vars
BUILDPACK_URL:    https://github.com/ddollar/heroku-buildpack-multi.git
ITAU_BOT_AGENCIA: 1234
ITAU_BOT_CONTA:   01234-5
ITAU_BOT_NOME:    BRUNO
ITAU_BOT_SENHA:   1234
ITAU_BOT_URL:     http://requestb.in/1234
LD_LIBRARY_PATH:  /usr/local/lib:/usr/lib:/lib:/app/vendor/phantomjs/lib
PATH:             /usr/local/bin:/usr/bin:/bin:/app/vendor/phantomjs/bin
```

### Heroku Scheduler
```
bundle exec ruby itau_bot.rb
```

### Uso manual
```
heroku run bot
```
