require 'test_helper'

class Api::V1::CodesControllerTest < ActionDispatch::IntegrationTest
  test "Submitting code should return http status code of 200" do
    post "/api/v1/code", params: {code: ""}
    assert_response 200
  end

  test "Submitting code should return a json response" do
    post "/api/v1/code", params: {code: ""}
    assert_equal response.content_type, 'application/json'
  end

  test "Submitting empty code should return json hash containing the results of an empty array" do
    post "/api/v1/code", params: {code: ""}
    data = JSON.parse(response.body)
    assert_equal data, {"results"=>[]}
  end

  test "Submitting actual code should return json hash containing the results of x, y coordinates" do
    post "/api/v1/code", params: {code: "[*].each do |number|\nnumber\nend"}
    data = JSON.parse(response.body)
    assert_equal data, {"results"=>[{"x"=>100, "y"=>201}, {"x"=>500, "y"=>1001}, {"x"=>1000, "y"=>2001}, {"x"=>1500, "y"=>3001}, {"x"=>2000, "y"=>4001}, {"x"=>2500, "y"=>5001}, {"x"=>3000, "y"=>6001}]}
  end

  
end
