require_relative 'transaction_queue'
require_relative 'account'

class Teller
  def initialize(cash_slot)
    @cash_slot = cash_slot
  end

  def withdraw_from(account, amount)
    account.debit(amount)
    @cash_slot.dispense(amount)
  end
end

class CashSlot
  def contents
    @contents or raise("I'm empty!")
  end

  def dispense(amount)
    @contents = amount
  end
end

require 'sinatra'

set :account do
  fail 'account has not been set'
end

get '/balance' do
  account = settings.account
  %{
    <html>
      <body>
        <h1>your account balance:</h1>
        <p>$#{account.balance}</p>
      </body>
    </html>
  }
end

get '/' do
  %{
    <html>
      <body>
        <form action="/withdraw" method="post">
          <label for="amount">Amount</label>
          <p>
            <input type="radio" id="_10" name="amount" value="10">
            <label for="_10">10</label>
          </p>
          <p>
            <input type="radio" id="_20" name="amount" value="20">
            <label for="_20">20</label>
          </p>
          <p>
            <input type="radio" id="_50" name="amount" value="50">
            <label for="_50">50</label>
          </p>
          <p>
            <input type="radio" id="_100" name="amount" value="100">
            <label for="_100">100</label>
          </p>
          <p>
            <input type="radio" id="_200" name="amount" value="200">
            <label for="_200">200</label>
          </p>
          <button type="submit">Withdraw</button>
        </form>
      </body>
    </html>
  }
end

post '/withdraw' do
  set :cash_slot, CashSlot.new
  teller = Teller.new(settings.cash_slot)
  begin
    teller.withdraw_from(settings.account, params[:amount].to_i)
  rescue
    "account has insuficient funds"
  end
end

