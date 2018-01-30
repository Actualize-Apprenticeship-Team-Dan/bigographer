class CodeAnalyzer

  attr_reader :code, :graph_data
  
  def initialize(code='')
    @code = code
    add_counters_to_code!
    @graph_data = []
  end

  # The 'results' method is the brains behind the time complexity analysis.
  # It looks to see whether the code contains [*], in which case the user is indicating 
  # that they want to test multiple size arrays with the given algorithm.
  # The method then runs the submitted code with various size arrays, ranging from 100 up to 3000.
  # The data is saved as an array of x, y coordinates. x indicates the amount of data,
  # and y indicates the number of steps it takes for the code to actually run.

  def results
   
    ## Cannot run test with each loop within times loop and vice versa
    # [100, 500, 1000, 1500, 2000, 2500, 3000].each do |data|
    #   i = 0

    #   while i < @code.length do
    #     if @code.include? '[*]'
    #       @code.gsub("[*]", "#{(1..data).to_a}")
    #     end
    #     if @code.include? '***'
    #       @code.gsub("***", "#{(data)}")
    #     end
    #     i += 1
    #   end
    #     p @code
    #     @graph_data << {x: data, y: run_code(@code)}
    # end
    if @code.index("[*]")
      [100, 500, 1000, 1500, 2000, 2500, 3000].each do |data|
        @graph_data << {x: data, y: run_code(@code.gsub("[*]", "#{(1..data).to_a}"))}
      end
      get_o_notation
    elsif @code.index("***")
      [100, 500, 1000, 1500, 2000, 2500, 3000].each do |data|
        @graph_data << {x: data, y: run_code(@code.gsub("***", "#{(data)}"))}
      end
      get_o_notation
    end

    return @graph_data
  end


  # With the 'run_code' method, we attempt to run the code and handle errors if they arise. This doesn't properly handle syntax
  # errors, so will need some further work.

  def run_code(code)
    begin
      return eval(code)
    rescue
      return "Error: Code doesn't run!"
    end
  end

  def get_o_notation
    o = ""
    step1 = @graph_data[1][:y] - @graph_data[0][:y]
    step2 = @graph_data[2][:y] - @graph_data[1][:y]
    step3 = @graph_data[3][:y] - @graph_data[2][:y]
    if step3 == step2
      o = "o(n)"
    # elsif step2 * 2 == step3 && step2 == step1
    #   o = "o(log n)"
    # elsif step2 * 2 == step3 && step1 * 2 == step2
    #   o = "o(n)"
    # elsif step2 * 4 == step3 && step1 * 2 == step2
    #   o = "o(n log n)"
    # x_squared = (graph_data[1][:x])^2
    # x_cubed = (graph_data[1][:x])^3

    # elsif x_squared <= graph_data[1][:y] && graph_data[1][:y] <=
    # x_cubed #  == step3 && step1 * 4 == step2
      # o = "o(n^2)"
    x = (graph_data[1][:x])^2
    elsif (@graph_data[1][:x] * graph_data[1][:x]) <= graph_data[1][:y] && graph_data[1][:y] <=
    (graph_data[1][:x] * graph_data[1][:x] * graph_data[1][:x]) #  == step3 && step1 * 4 == step2
      o = "o(n^2)"
    elsif step2 * 4 == step3 && step1 * 8 == step2
      o = "o(n^3)"
    end
    o
  end

  private
  # The 'add_counters_to_code!' method implements our counting of the code's steps. We follow
  # a simplistic algorithm, and that is to set a 'count' variable before the code begins, and then
  # increment count after each line of code runs.


  def add_counters_to_code!
    new_code = "count = 0\n"
    @code.each_line do |line|
      new_code += "#{line}\n" 
      new_code += "count += 1\n" unless is_comment?(line)
    end
    new_code += "count"
    @code = new_code
  end

  # 'is_comment?' strips the lines of dead spaces in the beginning of the line, then checks if the line
  # starts wtih a '#'. If it does, it checks the next thingy to see if its '{' to know if the line is a
  # comment or interpulated code

  def is_comment?(line)
    line.strip!
    line.index('#') == 0 && line.index('{') != 1
  end

end