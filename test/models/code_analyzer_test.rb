require 'test_helper'
 
class CodeAnalyzerTest < ActiveSupport::TestCase
  test 'initializing CodeAnalyzer adds counting code to submitted code' do
    code_analyzer = CodeAnalyzer.new('x = 1')
    assert_equal "count = 0\nx = 1\ncount += 1\ncount", code_analyzer.code
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

  test '#results(each) - returns complete graph data' do
    code_analyzer = CodeAnalyzer.new("[*].each do |number|\nnumber\nend")
    assert_equal [{x: 100, y: 201}, {x: 500, y: 1001}, {x: 1000, y: 2001}, {x: 1500, y: 3001}, {x: 2000, y: 4001}, {x: 2500, y: 5001}, {x: 3000, y: 6001}], code_analyzer.results
  end

  test '#results(times) - returns complete graph data for integer' do
    code_analyzer = CodeAnalyzer.new("***.times do \n'orange'\nend")
    assert_equal [{x: 100, y: 201}, {x: 500, y: 1001}, {x: 1000, y: 2001}, {x: 1500, y: 3001}, {x: 2000, y: 4001}, {x: 2500, y: 5001}, {x: 3000, y: 6001}], code_analyzer.results
  end

  test '#results(times) - returns complete graph data for 2 seperated lines of code' do
    code_analyzer = CodeAnalyzer.new("***.times do \n'orange'\n'green'\nend")
    assert_equal [{x: 100, y: 301}, {x: 500, y: 1501}, {x: 1000, y: 3001}, {x: 1500, y: 4501}, {x: 2000, y: 6001}, {x: 2500, y: 7501}, {x: 3000, y: 9001}], code_analyzer.results
  end

  test '#results(times) - return complete graph data for nested loop' do
    code_analyzer = CodeAnalyzer.new("***.times do \n***.times do\n'orange'\nend\nend")
    assert_equal [{ x: 100, y: 20201 }, { x: 500, y: 501001 }, { x: 1000, y: 2002001 }, { x: 1500, y: 4503001 }, { x: 2000, y: 8004001 }, { x: 2500, y: 12505001 }, { x: 3000, y: 18006001 }], code_analyzer.results
  end

end