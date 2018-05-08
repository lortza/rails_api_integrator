require 'httparty'

class ReportsController < ApplicationController

  def show
    state = params[:state]
    city = params[:city]

    @report = Report.new(state, city)

    render json: @report
    # render jsonapi: @report
  end

end
