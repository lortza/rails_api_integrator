require 'httparty'

class ReportsController < ApplicationController

  def show
    state = params[:state]
    city = params[:city]

    @report = Report.new(state, city)

    render jsonapi: @report, status: :ok
  end

end
