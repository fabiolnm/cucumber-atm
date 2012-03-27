Feature: Cash Withdrawal
  Scenario Outline: Successful withdrawal from an account in credit
    Given my account has been credited with $100
    When I withdraw $<amount>
    Then $<amount> should be dispensed
    And the balance of my account should be $<balance>
    Examples:
      | amount  | balance |
      |   10    |   90    |
      |   20    |   80    |
      |   50    |   50    |
      |   100   |    0    |

#  Scenario: User tries to withdraw more than their balance
#    Given my account has been credited with $100
#    When I withdraw $200
#    Then nothing should be dispensed
#    And I should be told that I have insufficient funds in my account

  Scenario: User checks the balance of an account in credit
    Given my account has been credited with $100
    When I check my balance
    Then I should see that my balance is $100

