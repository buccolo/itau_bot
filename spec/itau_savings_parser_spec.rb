require 'spec_helper'

describe ItauSavingsParser do
  it 'returns all the transactions in the right format' do
    transactions = subject.parse(itau_savings_html)

    expected_first_transaction = {
      date: "2014-11-27",
      memo: "TBI 1234.54321-1",
      value: -150000
    }

    expected_last_transaction = {
      date: "2014-12-24",
      memo: "TBI 1111.22222-7",
      value: -150000
    }

    expect(transactions.count).to eq 25
    expect(transactions.first).to eq expected_first_transaction
    expect(transactions.last).to eq expected_last_transaction

    transactions.each do |transaction|
      expect(transaction[:date]).to be
      expect(transaction[:memo]).to be
      expect(transaction[:value] != 0).to be true
    end
  end
end
