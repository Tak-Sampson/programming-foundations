# ask for two numbers, then ask for an operation (add, subtract, multiply, divide)
# then prints the result to the screen

def to_i_or_f(num_str)
  if num_str.to_f == num_str.to_i 
    num_str.to_i 
  else
    num_str.to_f 
  end
end

def whitelist_array(message,arr)
  Kernel.puts(message)
  input = Kernel.gets().chomp()
  unless arr.include?(input)
    Kernel.puts("=> Invalid entry. Please try again.")
    input_whitelist(message,arr)
  end
  input
end

def whitelist_realnum(message)
  Kernel.puts(message)
  input = Kernel.gets().chomp
  unless (input == input.to_f.to_s) || (input == input.to_i.to_s) # string must be "#{integer or float}"
    Kernel.puts("=> Not a real number. Please try again.")
    whitelist_realnum(message)
  end
  input 
end


Kernel.puts("Welcome to Calculator!")

num1 = whitelist_realnum("What's the first number?")
num2 = whitelist_realnum("What's the second number?")

Kernel.puts("The first number is #{num1}")
Kernel.puts("The second number is #{num2}")

if to_i_or_f(num2) != 0
  operation = whitelist_array("What operation would you like to perform? 
    a) add  s) subtract  m) multiply  d) divide", ['a','s','m','d'])
else
  operation = whitelist_array("What operation would you like to perform? 
    a) add  s) subtract  m) multiply", ['a','s','m'])
end

def answer(result)
  Kernel.puts("The answer is #{result.to_s}")
end

case operation
when 'a'
  answer(to_i_or_f(num1.to_f + num2.to_f))
when 's'
  answer(to_i_or_f(num1.to_f - num2.to_f))
when 'm'
  answer(to_i_or_f(num1.to_f * num2.to_f))
else # 'd' <-- must be due to whitelist_array
  answer(to_i_or_f(num1.to_f / num2.to_f))
end

