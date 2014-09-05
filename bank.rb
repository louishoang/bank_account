require 'pry'
require 'csv'

class Account
  attr_reader :name
  attr_accessor :starting_balance, :transactions, :list_of_transactions

  def initialize(name, starting_balance, transactions)
    @name = name
    @starting_balance = starting_balance.to_f
    @transactions = transactions
    @list_of_transactions = []
  end

  def current_balance
    balance = starting_balance.to_f
    trans_data.each do |tran|
      balance += tran[:amount].to_f
    end
    balance.to_f
  end

  def trans_data
    list_of_transactions = []
    transactions.each do |transaction|
      if transaction[:account] == name
        list_of_transactions << transaction
      end
    end
    list_of_transactions
  end

  def summary
    summaries = []
    trans_data.each do |tran|
      summaries << Transaction.new(tran).summary
    end
    summaries
  end
end

class Transaction
  attr_accessor :date, :amount, :description

  def initialize(transaction)
    @date = transaction[:date]
    @amount = transaction[:amount].to_f
    @description = transaction[:description]
  end

  def deposit?
    amount.to_i > 0
  end

  def type
    deposit? ? "DEPOSIT" : "WITHDRAWAL"
  end

  def summary
    "#{date}\t$#{amount.to_f.abs} --- #{type}\t#{description}"
  end
end

accounts = []

CSV.foreach('balances.csv', headers: true, header_converters: :symbol) do |row|
  accounts << row
end

bank_data = []

CSV.foreach('bank_data.csv', headers: true, header_converters: :symbol) do |row|
  bank_data << row
end

accounts.each do |account|
  current_account = Account.new(account[0], account[1], bank_data)
  puts "\n==== #{current_account.name} ===="
  puts "Starting balance: #{current_account.starting_balance}"
  puts "Ending balance: #{current_account.current_balance}\n\n"
  puts current_account.summary
end
