ItauBot [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/buccolo/itau_bot)
========

Faz scrape do seu extrato, poupança e cartão de crédito.

Bot pronto para ser deployado no heroku. Faz o scrape e posta o JSON para uma url.

Que falta faz uma API...

### Heroku Scheduler
```
bundle exec ruby itau_bot.rb
```

### Uso manual
```
heroku run bot
```

### Formato

```json
{
    "balance": {
        "transactions": [
            [
                "24/04",
                "SALDO ANTERIOR",
                "176,04"
            ],
            [
                "25/04",
                "RSHOP-SANTA PIZZ-24/04",
                "1234",
                "18,53",
                "-"
            ],
            [
                "16/05",
                "INT PAG TIT 175208399131",
                "4175",
                "91,47",
                "-"
            ]
        ]
    },
    "savings": {
        "transactions": [
            [
                "16 ",
                "  SALDO ANTERIOR ",
                " 2.000,22  "
            ],
            [
                "30 ",
                "  TBI 1234.1234-1 ",
                " 2.000,00- "
            ],
            [
                "30 ",
                "  REMUNER BASICA-ANIV.28 ",
                " 0,20  "
            ]
        ],
        "balance": [
            [
                " 01",
                " 500,00  detalhar "
            ],
            [
                " 28",
                " 500,00  detalhar "
            ]
        ],
        "total": [
            [
                "( )SALDO PARCIAL C/P ",
                " 1.000,00  "
            ],
            [
                "(: )SDO DISP. LIQ. ",
                " 1.000,00  "
            ]
        ]
    },
    "credit_card": {
        "current_statement": [
            [
                [
                    "Movimentações"
                ],
                [
                    "DATA",
                    "MOVIMENTAÇÃO",
                    "VALOR EM R$"
                ],
                [
                    "01/07",
                    "PAGAMENTO EFETUADO ",
                    "-191,63"
                ],
                [
                    "21/07",
                    "CR DIFERENCA COTACAO U$ ",
                    "-2,51"
                ],
                [
                    "Total de créditos efetuados",
                    "-194,14"
                ],
                [
                    "Total de débitos efetuados",
                    "0,00"
                ]
            ],
            [
                [
                    "Lançamentos nacionais"
                ],
                [
                    "JOAO DA SILVA (1234)"
                ],
                [
                    "DATA",
                    "MOVIMENTAÇÃO",
                    "VALOR EM R$"
                ],
                [
                    "25/06",
                    "NETFLIX.COM ",
                    "16,90"
                ],
                [
                    "Crédito do cartão final (1234)",
                    "0,00"
                ],
                [
                    "Débito do cartão final (1234)",
                    "16,90"
                ]
            ],
            [
                [
                    "Lançamentos nacionais"
                ],
                [
                    "JOAO DA SILVA (1235)"
                ],
                [
                    "DATA",
                    "MOVIMENTAÇÃO",
                    "VALOR EM R$"
                ],
                [
                    "02/04",
                    "SHOPTIME.COM 04/12 ",
                    "33,25"
                ],
                [
                    "Crédito do cartão final (1235)",
                    "0,00"
                ],
                [
                    "Débito do cartão final (1235)",
                    "33,25"
                ]
            ],
            [
                [
                    "Lançamentos nacionais"
                ],
                [
                    "JOAO DA SILVA (1235)"
                ],
                [
                    "DATA",
                    "MOVIMENTAÇÃO",
                    "VALOR EM R$"
                ],
                [
                    "24/06",
                    "NESTLE BRASIL ",
                    "31,59"
                ],
                [
                    "09/07",
                    "PAYPAL DO BRASIL ",
                    "29,90"
                ],
                [
                    "11/07",
                    "EVENTIOZ*rubyconf bras ",
                    "350,00"
                ],
                [
                    "Crédito do cartão final (1235)",
                    "0,00"
                ],
                [
                    "Débito do cartão final (1235)",
                    "492,78"
                ]
            ],
            [
                [
                    "Lançamentos internacionais"
                ],
                [
                    "JOAO DA SILVA (1235)"
                ],
                [
                    "DATA",
                    "MOVIMENTAÇÃO",
                    "VALOR EM R$"
                ],
                [
                    "25/06",
                    "GH *GITHUB.COM 5XIB ",
                    "16,22"
                ]
            ],
            [
                [
                    "Crédito cartão final (1235) em R$",
                    "0,00"
                ],
                [
                    "Total retiradas exterior em R$",
                    "0,00"
                ],
                [
                    "Total transações inter. em R$",
                    "65,37"
                ],
                [
                    "Repasse de IOF em R$",
                    "4,21"
                ],
                [
                    "Total dos lançamentos inter. em R$",
                    "69,58"
                ],
                [
                    "Dólar de conversão",
                    "2,32"
                ]
            ]
        ],
        "next_statement": [
            [
                [
                    "Compras parceladas - próximas faturas"
                ],
                [
                    "MÊS",
                    "VALOR EM R$"
                ],
                [
                    "Outubro",
                    "33,25"
                ],
                [
                    "Novembro",
                    "33,25"
                ],
                [
                    "Dezembro",
                    "33,25"
                ],
                [
                    "Demais faturas",
                    "133,00"
                ],
                [
                    "Total para próximas faturas",
                    "232,75"
                ]
            ]
        ]
    },
    "success": true
}
```
