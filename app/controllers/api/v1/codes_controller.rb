class Api::V1::CodesController < ApplicationController
  def analyze
    code_analyzer = CodeAnalyzer.new(params[:codes])
    puts "*************"
    puts params[:codes]
    render json: {results: code_analyzer.results}
  end
end
