require 'test_helper'
 
class CodeAnalyzerTest < ActiveSupport::TestCase
  test 'initializing CodeAnalyzer adds counting code to submitted code' do
    code_analyzer = CodeAnalyzer.new('x = 1')
    assert_equal ["count = 0\nx = 1\ncount += 1\ncount"], code_analyzer.codes
  end

  test 'initializing CodeAnalyzer creates empty graph_data array' do
    code_analyzer = CodeAnalyzer.new('x = 1')
    assert_equal [], code_analyzer.graph_data
  end

  test '#run_code - returning of evaluation of code' do
    code_analyzer = CodeAnalyzer.new
    assert_equal 2, code_analyzer.run_code('1 + 1')
  end

  test '#run_code - return error message when evaluating code with runtime error' do
    code_analyzer = CodeAnalyzer.new
    assert_equal "Error: Code doesn't run!", code_analyzer.run_code('x')
  end

  test '#add_counters_to_code - ignores single comment' do
    code_analyzer = CodeAnalyzer.new("#Comment")
    refute_includes code_analyzer.codes[0], "count += 1"
  end

  test '#add_counters_to_code - ignores comments after code' do
    code_analyzer = CodeAnalyzer.new("x+1 #Comment")
    assert_includes code_analyzer.codes[0], 'count += 1'
  end

  test '#add_counters_to_code - accounts for multiple lines of code' do
    code_analyzer = CodeAnalyzer.new("y+1\n#Comments\nx+1 #Comment")
    assert_equal code_analyzer.codes[0].scan(/(count \+= 1)/).count, 2
  end

  test '#add_counters_to_code - accounts for multiple lines of code with space before comment' do
    code_analyzer = CodeAnalyzer.new("y+1\n #Comments\nx+1 #Comment")
    assert_equal code_analyzer.codes[0].scan(/(count \+= 1)/).count, 2
  end

  test '#add_counters_to_code - includes interpulated comment' do
    code_analyzer = CodeAnalyzer.new('#{interpulated word}')
    assert_includes code_analyzer.codes[0], 'count += 1'
  end

  test '#results - returns complete graph data' do
    code_analyzer = CodeAnalyzer.new("[*].each do |number|\nnumber\nend")
    assert_equal [[{x: 100, y: 201}, {x: 500, y: 1001}, {x: 1000, y: 2001}, {x: 1500, y: 3001}, {x: 2000, y: 4001}, {x: 2500, y: 5001}, {x: 3000, y: 6001}]], code_analyzer.results
  end

  test '#results - returns complete graph data with two inputs' do
    code_analyzer = CodeAnalyzer.new("[*].each do |number|\nnumber\nend, [*].each do |number|\nnumber\n\nend")
    assert_equal [[{x: 100, y: 201}, {x: 500, y: 1001}, {x: 1000, y: 2001}, {x: 1500, y: 3001}, {x: 2000, y: 4001}, {x: 2500, y: 5001}, {x: 3000, y: 6001}], [{x: 100, y: 301}, {x: 500, y: 1501}, {x: 1000, y: 3001}, {x: 1500, y: 4501}, {x: 2000, y: 6001}, {x: 2500, y: 7501}, {x: 3000, y: 9001}]], code_analyzer.results
  end

  test '#results - returns complete graph data with multiple inputs' do
    code_analyzer = CodeAnalyzer.new("[*].each do |number|\nnumber\nend, [*].each do |number|\nnumber\n\nend, [*].each do |number|\nnumber\n\n\nend")
    assert_equal [[{x: 100, y: 201}, {x: 500, y: 1001}, {x: 1000, y: 2001}, {x: 1500, y: 3001}, {x: 2000, y: 4001}, {x: 2500, y: 5001}, {x: 3000, y: 6001}], [{x: 100, y: 301}, {x: 500, y: 1501}, {x: 1000, y: 3001}, {x: 1500, y: 4501}, {x: 2000, y: 6001}, {x: 2500, y: 7501}, {x: 3000, y: 9001}], [{x: 100, y: 401}, {x: 500, y: 2001}, {x: 1000, y: 4001}, {x: 1500, y: 6001}, {x: 2000, y: 8001}, {x: 2500, y: 10001}, {x: 3000, y: 12001}]], code_analyzer.results
  end

  test '#results(times) - returns complete graph data for integer' do
    code_analyzer = CodeAnalyzer.new("***.times do \n'orange'\nend")
    assert_equal [[{x: 100, y: 201}, {x: 500, y: 1001}, {x: 1000, y: 2001}, {x: 1500, y: 3001}, {x: 2000, y: 4001}, {x: 2500, y: 5001}, {x: 3000, y: 6001}]], code_analyzer.results
  end

  test '#results(times) - returns complete graph data for 2 seperated lines of code' do
    code_analyzer = CodeAnalyzer.new("***.times do \n'orange'\n'green'\nend")
    assert_equal [[{x: 100, y: 301}, {x: 500, y: 1501}, {x: 1000, y: 3001}, {x: 1500, y: 4501}, {x: 2000, y: 6001}, {x: 2500, y: 7501}, {x: 3000, y: 9001}]], code_analyzer.results
  end

  test '#results(times) - return complete graph data for nested loop' do
    code_analyzer = CodeAnalyzer.new("***.times do \n***.times do\n'orange'\nend\nend")
    assert_equal [[{ x: 100, y: 20201 }, { x: 500, y: 501001 }, { x: 1000, y: 2002001 }, { x: 1500, y: 4503001 }, { x: 2000, y: 8004001 }, { x: 2500, y: 12505001 }, { x: 3000, y: 18006001 }]], code_analyzer.results
  end

  test '#codes - takes puts out of code input' do
    code_analyzer = CodeAnalyzer.new("sum = 0\n[*].each do |number|\nsum += number\nputs 'hello'\nend")
    refute_includes code_analyzer.codes[0], 'puts '
  end

  test '#codes - takes p statement out of code input' do
    code_analyzer = CodeAnalyzer.new("sum = 0\n[*].each do |number|\n  p \"dogs\"\nend")
    refute_includes code_analyzer.codes[0], 'p '
  end

  test '#codes - takes print statement out of code input' do
    code_analyzer = CodeAnalyzer.new("sum = 0\n[*].each do |number|\n  print \"dogs\"\nend")
    refute_includes code_analyzer.codes[0], 'print '
  end
end
