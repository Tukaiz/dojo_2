require "rubygems" 
require "benchmark" 
require "inline"  

class FactorialTest   

  def factorial_ruby(n)     
    result =1     
    n.downto(2){|x| result *= x}     
    result   
  end    

  inline do |builder|   
  builder.c "     
    long factorial_c(int max){       
      int i=max, result=1;       
      while(i >= 2){result *= i--;};         
        return result;     
    }"   
  end 
end   

t = FactorialTest.new()  

Benchmark.bm do |x|   
  x.report(":factorial_ruby"){ t.factorial_ruby(50000) }   
  x.report(":factorial_c"){ t.factorial_c(50000) } 
end 

