require 'pry'
require 'csv'

class Account
  attr_reader :name
  attr_accessor :starting_balance, :transactions, :list_of_transactions

  def initialize(name, starting_balance)
    @name = name
    @starting_balance = starting_balance.to_f
    @transactions = []
  end

  def current_balance
    balance = starting_balance.to_f
    transactions.each do |tran|
      balance += tran.amount.to_f
    end
    balance.to_f
  end

  def summary
    summaries = []
    transactions.each do |tran|
      summaries << tran.summary
    end
    summaries
  end

  def self.load_from_csv(csv)
    accounts = []
    CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
      accounts << new(row[0], row[1])
    end
    accounts
  end
end

class Transaction
  attr_accessor :account, :date, :amount, :description

  def initialize(attributes)
    @account = attributes[:account]
    @date = attributes[:date]
    @amount = attributes[:amount].to_f
    @description = attributes[:description]
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

accounts = Account.load_from_csv('balances.csv')

CSV.foreach('bank_data.csv', headers: true, header_converters: :symbol) do |row|
  transaction = Transaction.new(row)
  account = accounts.find { |a| a.name == transaction.account }
  account.transactions << transaction
end

accounts.each do |account|
  # current_account = Account.new(account[0], account[1], bank_data)
  puts "\n==== #{account.name} ===="
  puts "Starting balance: #{account.starting_balance}"
  puts "Ending balance: #{account.current_balance}\n\n"
  puts account.summary
end
