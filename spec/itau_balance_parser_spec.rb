require 'spec_helper'

describe ItauBalanceParser do
  it 'returns all the transactions in the right format' do
    transactions = subject.parse(itau_balance_html)

    expected_first_transaction = {
      date: "2014-09-24",
      memo: "RSHOP-SANTA  PIZZ-23/09",
      value: -3206
    }

    expected_last_transaction = {
      date: "2015-01-02",
      memo: "TBI .-1/500",
      value: 100000
    }

    expect(transactions.count).to eq 241
    expect(transactions.first).to eq expected_first_transaction
    expect(transactions.last).to eq expected_last_transaction

    transactions.each do |transaction|
      expect(transaction[:date]).to be
      expect(transaction[:memo]).to be
      expect(transaction[:value] != 0).to be true
    end
  end
end
