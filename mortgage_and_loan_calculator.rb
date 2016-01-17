# mortgage_and_loan_calculator.rb
# takes loan amount, APR, and loan duration as input
# calculates the monthly interest rate and loan duration in months
# outputs payment amount

require_relative 'number_validation'

def prompt(message)
  Kernel.puts("=> #{message}")
end

Kernel.puts('Welcome to Mortgage and Loan Payment Calculator!')
loop do
  prompt("Enter your name:")
  name = Kernel.gets().chomp()
  unless name.empty?
    prompt("Hi #{name}!")
    break
  end
  prompt("must enter a valid name")
end

loop do # main loop
  monthly_payment = 0

  loop do
    loan = whitelist_positive_num("Please indicate the loan amount (US$)")
    loan_amt = (loan.to_f * 100).to_i / 100.0
    apr_percent = whitelist_positive_num("Please indicate the Annual Percentage Rate (APR); e.g. 4.3 for 4.3%")
    loan_duration = whitelist_pos_int("Please indicate, in years, the loan duration.")
    loan_years = loan_duration.to_i
    info = <<-MSG
    Your information:
      Loan in the amount of $#{format('%02.2f', loan_amt)}(US) at #{apr_percent}% APR for #{loan_years} years.

      Is this information correct?  y) yes  (press any other key for 'no')
    MSG
    Kernel.puts(info)
    confirmation = Kernel.gets().chomp()
    if confirmation.downcase == 'y'
      apr = apr_percent.to_f / 100.0
      monthly_interest = apr / 12.0
      loan_months = loan_years * 12

      monthly_payment = (loan_amt * monthly_interest *
                        (1 + monthly_interest)**loan_months) /
                        ((1 + monthly_interest)**loan_months - 1)
      break
    end
    prompt("Okay. Let's try again.")
  end

  prompt("Your monthly payment is: $#{format('%02.2f', monthly_payment)}")
  prompt("Would you like to perform another calculation?  y) yes  (press any other key for 'no')")
  response = Kernel.gets().chomp().downcase
  break unless response == 'y'
end

prompt("Thank you for using Mortgage and Loan Payment Calculator!")
