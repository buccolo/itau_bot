require 'spec_helper'

describe ItauBalanceParser do
  it 'returns all the transactions in the right format' do
    transactions = subject.parse(itau_balance_html)

    expected_first_transaction = {
      :date => "2015-01-02",
      :memo => "RSHOP-ANTONIO LIS-02/01",
      :value => -4310,
    }

    expected_last_transaction = {
      date: "2015-01-19",
      memo: "RSHOP-NAZARENO RO-19/01",
      value: -7200
    }

    expect(transactions.count).to eq 63
    expect(transactions.first).to eq expected_first_transaction
    expect(transactions.last).to eq expected_last_transaction

    transactions.each do |transaction|
      expect(transaction[:date]).to be
      expect(transaction[:memo]).to be
      expect(transaction[:value] != 0).to be true
    end
  end
end
