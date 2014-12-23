require 'spec_helper'

describe ItauBalanceParser do
  it 'returns all the transactions in the right format' do
    transactions = subject.parse(itau_balance_html)

    expected_first_transaction = {
      date: "2014-09-24",
      memo: "RSHOP-SANTA  PIZZ-23/09",
      value: -3206
    }

    expect(transactions.count).to eq 241
    expect(transactions.first).to eq expected_first_transaction
  end
end
