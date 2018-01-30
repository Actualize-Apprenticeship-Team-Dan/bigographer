require 'test_helper'
 
class CodeAnalyzerTest < ActiveSupport::TestCase
  test 'initializing CodeAnalyzer adds counting code to submitted code' do
    # skip
    code_analyzer = CodeAnalyzer.new('x = 1')
    assert_equal ["count = 0\nx = 1\ncount += 1\ncount"], code_analyzer.codes
  end

  test 'initializing CodeAnalyzer creates empty graph_data array' do
    # skip
    code_analyzer = CodeAnalyzer.new('x = 1')
    assert_equal [], code_analyzer.graph_data
  end

  test '#run_code - returning of evaluation of code' do
    # skip
    code_analyzer = CodeAnalyzer.new
    assert_equal 2, code_analyzer.run_code('1 + 1')
  end

  test '#run_code - return error message when evaluating code with runtime error' do
    # skip
    code_analyzer = CodeAnalyzer.new
    assert_equal "Error: Code doesn't run!", code_analyzer.run_code('x')
  end

  test '#results - returns complete graph data' do
    # skip
    code_analyzer = CodeAnalyzer.new("[*].each do |number|\nnumber\nend")
    assert_equal [[{x: 100, y: 201}, {x: 500, y: 1001}, {x: 1000, y: 2001}, {x: 1500, y: 3001}, {x: 2000, y: 4001}, {x: 2500, y: 5001}, {x: 3000, y: 6001}]], code_analyzer.results
  end

  test '#results - returns complete graph data with multiple inputs' do
    # skip
    code_analyzer = CodeAnalyzer.new("[*].each do |number|\nnumber\nend, [*].each do |number|\nnumber\n[*].each do |n|\nn\nend\nend")
    assert_equal [[{x: 100, y: 201}, {x: 500, y: 1001}, {x: 1000, y: 2001}, {x: 1500, y: 3001}, {x: 2000, y: 4001}, {x: 2500, y: 5001}, {x: 3000, y: 6001}], [{x: 100, y: 20301}, {x: 500, y: 501501}, {x: 1000, y: 2003001}, {x: 1500, y: 4504501}, {x: 2000, y: 8006001}, {x: 2500, y: 12507501}, {x: 3000, y: 18009001}]], code_analyzer.results
  end
end