# number_validation.rb

# Methods determine whether user input strings convert to user's 'expected' number
# when fed to Kernel.to_f()  NOTE: this does not require user input characters to match
# those of a valid float, only that it properly converts under .to_f
#   e.g.    1.3e0.0         => SyntaxError: unexpected fraction part after numeric literal
#           "1.3e0.0".to_f  => 1.3
#------------------------------------------------------------------------------------------

def real_number(str) # e.g. -0.3 -.32 1. 0.980
  /^-?\d*\.?\d+$/.match(str) || /^-?\d+\.?\d*$/.match(str)
end

def sci_notation(str) # e.g. -0.234e+5  94e05 10e-10
  /^-?\d*\.?\d+e-?\d+\.?0*$/.match(str) || /^-?\d*\.?\d+e+?\d+\.?0*$/.match(str)
end

def number?(str)
  real_number(str) || sci_notation(str)
end

def pos_real_number(str) # e.g. 0.3 .32 1. 0.980
  /^\d*\.?\d+$/.match(str) || /^\d+\.?\d*$/.match(str)
end

def pos_sci_notation(str) # e.g. 0.234e5.  94e05.0 10e-10
  /^\d*\.?\d+e-?\d+\.?0*$/.match(str)
end

def pos_number?(str)
  pos_real_number(str) || pos_sci_notation(str)
end

def neg_real_number(str) # e.g. -0.3 -.32 -1. -0.980
  /^-\d*\.?\d+$/.match(str) || /^-\d+\.?\d*$/.match(str)
end

def neg_sci_notation(str) # e.g. -0.234e5.  -94e05.0 -10e-10
  /^-\d*\.?\d+e-?\d+\.?0*$/.match(str)
end

def neg_number?(str)
  neg_real_number(str) || neg_sci_notation(str)
end

def whole_number(str)
  real_number(str) && (str.to_i == str.to_f)
end

def sci_integer(str)
  sci_notation(str) && (str.to_f.to_i == str.to_f)
end

def integer?(str)
  whole_number(str) || sci_integer(str)
end

def pos_int?(str)
  integer?(str) && pos_number?(str)
end

def neg_int?(str)
  integer?(str) && neg_number?(str)
end

# User input loop methods

def whitelist_realnum(message)
  input = ''
  loop do
    Kernel.puts("=> #{message}")
    input = Kernel.gets().chomp
    if number?(input) then break
    else
      Kernel.puts("=> Not a real number. Please try again")
    end
  end
  input
end

def whitelist_positive_num(message)
  input = ''
  loop do
    Kernel.puts("=> #{message}")
    input = Kernel.gets().chomp
    if pos_number?(input) then break
    else
      Kernel.puts("=> Not a positive number. Please try again")
    end
  end
  input
end

def whitelist_negative_num(message)
  input = ''
  loop do
    Kernel.puts("=> #{message}")
    input = Kernel.gets().chomp
    if neg_number?(input) then break
    else
      Kernel.puts("=> Not a negative number. Please try again")
    end
  end
  input
end

def whitelist_integer(message)
  input = ''
  loop do
    Kernel.puts("=> #{message}")
    input = Kernel.gets().chomp
    if integer?(input) then break
    else
      Kernel.puts("=> Not an integer. Please try again")
    end
  end
  input
end

def whitelist_pos_int(message)
  input = ''
  loop do
    Kernel.puts("=> #{message}")
    input = Kernel.gets().chomp
    if pos_int?(input) then break
    else
      Kernel.puts("=> Not a positive integer. Please try again")
    end
  end
  input
end

def whitelist_neg_int(message)
  input = ''
  loop do
    Kernel.puts("=> #{message}")
    input = Kernel.gets().chomp
    if neg_int?(input) then break
    else
      Kernel.puts("=> Not a negative integer. Please try again")
    end
  end
  input
end
