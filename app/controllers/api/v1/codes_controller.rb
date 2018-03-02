class Api::V1::CodesController < ApplicationController
  def analyze
    code_analyzer = CodeAnalyzer.new(params[:codes])
    render json: {results: code_analyzer.results}
  end

  def save
    codes = params[:codes]
    url = Code.generate_url
    codes.each do |code|
      Code.create(text: code, url: url)
    end
    render json: url
  end

  def show
    @codes = Code.where(url: params[:url]).pluck(:text)

    render json: @codes
  end
end
