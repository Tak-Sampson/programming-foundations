# number_validation.rb

def real_number(str) # e.g. -0.3 -.32 1. 0.980
  /^-?\d*\.?\d+$/.match(str) || /^-?\d+\.?\d*$/.match(str)
end

def sci_notation(str) # e.g. -0.234e5.  94e05.0 10e10
  /^-?\d*\.?\d+e-?\d+\.?0*$/.match(str)
end

def number?(str)
  real_number(str) || sci_notation(str)
end
