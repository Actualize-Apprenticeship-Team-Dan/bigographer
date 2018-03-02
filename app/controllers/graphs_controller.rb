class GraphsController < ApplicationController

  def index
    @code = Code.find_by(url: params[:url])
  end

end
