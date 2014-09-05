require 'pry'
require 'csv'

class Account
  attr_accessor :name, :starting_balance

  def initialize(name, starting_balance)
    @name = name
    @starting_balance = starting_balance
  end

  def summary #pass in (transaction)
    "Date - Amount - Type - Description"
  end
end

class Transaction
  attr_accessor :date, :amount, :description

  def initialize(date, amount, description)
    @date = date
    @amount = amount
    @description = description
  end

  def summary
    "#{date} - #{amount} - type - #{description}"
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
  account = Account.new(account[0], account[1],)
  puts account.name
  puts account.starting_balance
  puts account.summary ## pass in (transaction)
end






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
