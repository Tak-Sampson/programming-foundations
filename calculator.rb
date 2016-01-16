# ask for two numbers, then ask for an operation (add, subtract, multiply, divide)
# then prints the result to the screen

def prompt(message)
  Kernel.puts("=> #{message}")
end

def to_i_or_f(num)
  if num == num.to_i
    num.to_i
  else
    num
  end
end

def whitelist_array(message, arr)
  input = ''
  loop do
    prompt(message)
    input = Kernel.gets().chomp
    if !arr.include?(input)
      prompt("Invalid entry. Please try again.")
    else break
    end
  end
  input
end

def whitelist_realnum(message)
  input = ''
  loop do
    prompt(message)
    input = Kernel.gets().chomp
    if (input != input.to_f.to_s) && (input != input.to_i.to_s) # string must be "#{integer or float}"
      prompt("Not a real number. Please try again.")
    else break
    end
  end
  input
end

def operation_to_message(op)
  case op
  when 'a'
    'Adding'
  when 's'
    'Subtracting'
  when 'm'
    'Multiplying'
  when 'd'
    'Dividing'
  end
end

Kernel.puts("Welcome to Calculator!")
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
  num1 = whitelist_realnum("What's the first number?")
  num2 = whitelist_realnum("What's the second number?")

  Kernel.puts("The first number is #{num1}")
  Kernel.puts("The second number is #{num2}")

  operator_prompt = <<-MSG
    What operation would you like to perform?
    a) add
    s) subtract
    m) multiply
    d) divide
  MSG

  divide_by_zero_prompt = <<-MSG
    What operation would you like to perform?
    a) add
    s) subtract
    m) multiply
  MSG

  if num2.to_f != 0
    operation = whitelist_array(operator_prompt, %w(a s m d))
  else
    operation = whitelist_array(divide_by_zero_prompt, %w(a s m))
  end

  prompt("#{operation_to_message(operation)} the two numbers...")

  result = case operation
           when 'a'
             to_i_or_f(num1.to_f + num2.to_f)
           when 's'
             to_i_or_f(num1.to_f - num2.to_f)
           when 'm'
             to_i_or_f(num1.to_f * num2.to_f)
           when 'd'
             to_i_or_f(num1.to_f / num2.to_f)
           end

  prompt("The answer is #{result}")

  prompt("Do you wish to perform another calculation? (press y to calculate again)")
  answer = Kernel.gets().chomp
  break unless answer.downcase == 'y'
end
prompt("Thank you for using Calculator!")
