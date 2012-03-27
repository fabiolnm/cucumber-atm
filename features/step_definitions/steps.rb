Given /^my account has been credited with (#{MONEY})$/ do |amount|
  my_account.credit(amount)
  eventually { my_account.reload.balance.should eq(amount) }
end

When /^I withdraw (#{MONEY})/ do |amount|
  teller.withdraw_from(my_account, amount)
end

Then /^(#{MONEY}) should be dispensed$/ do |amount|
  cash_slot.contents.should == amount
end

Then /^the balance of my account should be (#{MONEY})$/ do |amount|
  eventually { my_account.reload.balance.should eq(amount) }
end

Then /^nothing should be dispensed$/ do
  expect { cash_slot.contents }.to raise_error(RuntimeError, /I'm empty!/)
end

Then /^I should be told that I have insufficient funds in my account$/ do
  teller.warns_account_has_insuficient_funds
end

When /^I check my balance$/ do
  teller.check_balance(my_account)
end

Then /^I should see that my balance is (#{MONEY})$/ do |balance|
  teller.shows_account_balance(balance)
end

