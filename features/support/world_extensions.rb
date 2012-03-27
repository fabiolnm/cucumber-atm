module MyAccount
  class UserInterface
    include Capybara::DSL
    include Capybara::RSpecMatchers

    def withdraw_from(account, amount)
      Sinatra::Application.account = account
      visit '/'
      choose amount.to_s
      click_button 'Withdraw'
    end

    def warns_account_has_insuficient_funds
      page.should have_content('account has insuficient funds')
    end

    def check_balance(account)
      Sinatra::Application.account = account
      visit '/balance'
      find('h1').should have_content('your account balance:')
    end

    def shows_account_balance(balance)
      find('p').should have_content("$#{balance}")
    end
  end

  def my_account
    @my_account ||= Account.create!(:number => "test", :balance => 0)
  end

  def cash_slot
    Sinatra::Application.cash_slot
  end

  def teller
    @teller ||= UserInterface.new
  end
end

World(MyAccount)

