class CodeAnalyzer

  attr_reader :codes, :graph_data
  
  def initialize(codes = nil)
    if codes
      @codes = codes.split(',')
      add_counters_to_code!
      @graph_data = []
    end
  end

  # The 'results' method is the brains behind the time complexity analysis.
  # It looks to see whether the code contains [*], in which case the user is indicating 
  # that they want to test multiple size arrays with the given algorithm.
  # The method then runs the submitted code with various size arrays, ranging from 100 up to 3000.
  # The data is saved as an array of x, y coordinates. x indicates the amount of data,
  # and y indicates the number of steps it takes for the code to actually run.

  def results
    if @codes
      @codes.each do |code|
        graph_data = []
        if code.index("[*]")
          [100, 500, 1000, 1500, 2000, 2500, 3000].each do |data|
            graph_data << {x: data, y: run_code(code.gsub("[*]", "#{(1..data).to_a}"))}
          end
        elsif code.index("***")
          [100, 500, 1000, 1500, 2000, 2500, 3000].each do |data|
            graph_data << {x: data, y: run_code(code.gsub("***", "#{(data)}"))}
          end
        end
        @graph_data << graph_data
      end
      return @graph_data
    else
      return []
    end
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

  private
  # The 'add_counters_to_code!' method implements our counting of the code's steps. We follow
  # a simplistic algorithm, and that is to set a 'count' variable before the code begins, and then
  # increment count after each line of code runs.

  def add_counters_to_code!
    temp_codes = []
    if @codes
      @codes.each do |code|
        new_code = "count = 0\n"
        code.each_line do |line|
          line = remove_prints(line)
          new_code += "#{line}\n"
          new_code += "count += 1\n" unless is_comment?(line)
        end
        new_code += "count"
        temp_codes << new_code
      end
      @codes = temp_codes
    end
  end

  # 'is_comment?' strips the lines of dead spaces in the beginning of the line, then checks if the line
  # starts wtih a '#'. If it does, it checks the next thingy to see if its '{' to know if the line is a
  # comment or interpulated code

  def is_comment?(line)
    line.strip!
    line.index('#') == 0 && line.index('{') != 1
  end

  def remove_prints(line)
    line.strip!
    line = line.gsub("puts ", "")
    line = line.gsub("p ", "")
    line = line.gsub("print ", "")
  end

end
