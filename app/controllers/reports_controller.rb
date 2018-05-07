require 'httparty'

class ReportsController < ApplicationController
  def index
  end

  def show
    state = params[:state]
    city = params[:city]

    @report = Report.new(state, city)

    render json: @report
  end


  private

  def city_params
  end
end
