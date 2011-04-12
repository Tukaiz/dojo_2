require "rubygems"
require "benchmark"

class FactorialTest
  class << self
    def factorial_4819(n)
      n == 0 ? 1 : n * self.factorial_4819(n - 1)
    end
    
    def factorial_6912(n)
      case n
      when 0..1
        n
      else
        n * self.factorial_6912(n-1)
      end
    end
  
    def factorial_4923(n)
      if n <= 1
        1
      else
        n * factorial_4923(n - 1)
      end
    end
  end

  def factorial_4837(n)
    result =1
    n.downto(2){|x| result *= x}
    result
  end

  def factorial_6918(n)
    result = n
    if n > 0
      while n > 1 do
        result = result * (n-1)
        n = n-1
      end
    elsif n == 0
      result = 1
    else
      result = result.to_s
      result += " is not a valid integer"
    end
    result
  end

  def factorial_4922(n)
    result = 1
    n.downto(1) { |i|
     result *= i
    }
    result
  end

  def factorial_4924(n=nil)
    if n.kind_of?(Fixnum) and n >= 0
      return 1 if n == 0
      r=1
      (1..n).each{ |n| r = r*n }
      r
    else
      raise ArgumentError, "Wrong argument - Positive Integer Required"
    end
  end

  def factorial_4820(n)
    case
      when n < 0
        "undefined"
      when n == 0
        0
      else
        i, val = 1, 1
        while i <= n
          val = val * i
          i += 1
        end
      val
    end
  end

  def factorial_6917(n) # factorial_6917(5)
    # Set initial values of count and product
    count, product = 0, 1

    # Run the following block <n> times
    n.times do
      # Increment count by 1
      count += 1
      # Multiply current value of product by the value of count and set as new value of variable
      product *= count
    end
    # Once the block has run <n> times return product
    product # => 120
  end

  def factorial_4923_consise(n)
    (1..n).reduce(1, :*)
  end

  def factorial_4962_a(n)
    # my not very human readable solution
    x=1
    (1..n).step(1).map{|y| x = x * y}.last
  end
  
  def factorial_4962_b(n)
    # my other solution
    range = 1..n
    array = []
    range.each do |number|
      array << number
    end
    array.reverse!
    eval array.join(" * ")
  end 
end

class Integer
  def factor_me_2917
    return 1 if self == 0
    raise StandardError, "Number must be positive" if self < 0
    (1..self).inject{|num,next_num| num * next_num }
   end
end

t = FactorialTest.new()

Benchmark.bm do |x|
  puts "Round One Limited do to system memory allocated per process when calling recursivly"
  x.report(":factorial_4923"){ FactorialTest.factorial_4923(6584) }
  x.report(":factorial_4819"){ FactorialTest.factorial_4819(6584) }
  x.report(":factorial_6912"){ FactorialTest.factorial_6912(6584) }

  x.report(":factorial_4837"){ t.factorial_4837(6584) }
  x.report(":factorial_6918"){ t.factorial_6918(6584) }
  x.report(":factorial_4922"){ t.factorial_4922(6584) }
  x.report(":factorial_4924"){ t.factorial_4924(6584) }
  x.report(":factorial_4962_a"){ t.factorial_4962_a(6584) }
  x.report(":factorial_4962_b"){ t.factorial_4962_b(6584) }
  x.report(":factorial_4820"){ t.factorial_4820(6584) }
  x.report(":factorial_6917"){ t.factorial_6917(6584) }
  x.report(":factorial_4923_consise"){ t.factorial_4923_consise(6584) }
  x.report(":factor_me_2917"){ 6584.factor_me_2917 }

  puts "Round Two Factorial of 40000!"

  x.report(":factorial_4837"){ t.factorial_4837(40000) }
  x.report(":factorial_6918"){ t.factorial_6918(40000) }
  x.report(":factorial_4922"){ t.factorial_4922(40000) }
  x.report(":factorial_4924"){ t.factorial_4924(40000) }
  x.report(":factorial_4962_a"){ t.factorial_4962_a(40000) }
  # x.report(":factorial_4962_b"){ t.factorial_4962_b(40000) }
  x.report(":factorial_4820"){ t.factorial_4820(40000) }
  x.report(":factorial_6917"){ t.factorial_6917(40000) }
  x.report(":factorial_4923_consise"){ t.factorial_4923_consise(40000) }
  x.report(":factor_me_2917"){ 40000.factor_me_2917 }
end

