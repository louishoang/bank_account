require 'pry'
require 'csv'

class Account
  attr_accessor :name, :starting_balance, :transactions

  def initialize(name, starting_balance, transactions)
    @name = name
    @starting_balance = starting_balance
    @transactions = transactions


  end

  def trans_data
    list_of_transactions = []
    transactions.each do |tran|

      if tran[:account] == name
        list_of_transactions << tran
      end
    end
    list_of_transactions
  end

  def current_balance
    starting_balance
  end

  def summary #pass in (transaction)

    "Date - Amount - Type - Description"

  end
end

class Transaction
  attr_accessor :date, :amount, :description

  def initialize(transaction)
    @date = transaction[:date]
    @amount = transaction[:amount]
    @description = transaction[:description]
  end

  def deposit?
    amount.to_i > 0
  end

  def type
    deposit? ? "Deposit" : "Withdrawal"
  end

  def summary
    "#{date} - #{amount.to_i.abs} - #{type} - #{description}"
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
  account = Account.new(account[0], account[1], bank_data)
  puts "==== #{account.name} ===="
  puts "Starting balance: #{account.starting_balance}"
  puts "Ending balance: #{account.current_balance}"
  puts account.summary ## pass in (transaction)
end


abc = Transaction.new(bank_data[0])

puts abc.summary

  #   Account.starting_balance(account)
  #   Account.ending_balance(account)
  #   Account.transaction(account)
  # end


  # " ==== Purchasing Account ===="
  # "Starting Balance: $201.94"
  # "Ending Balance:   $637.09 \n\n"

  # "$29.99   WITHDRAWAL  09/12/2013 - Amazon.com"
  # "$500.33  DEPOSIT     09/14/2013 - Sales Deposit"
  # "$35.19   WITHDRAWAL  09/15/2013 - Staples.com"
  # "========"


# ==== Business Checking ====
# Starting Balance: $594.19
# Ending Balance:   $923.94

# $60.19   WITHDRAWAL  09/12/2013 - Pizza Pizza
# $400.20  WITHDRAWAL  09/14/2013 - Payroll
# $790.14  DEPOSIT     09/15/2013 - Sales Deposit
# ========



# def balance
  #   accounts = []
  #   CSV.foreach('balances.csv', headers: true, header_converters: :symbol) do |row|
  #     accounts << row
  #   end
  #   accounts
  # end
