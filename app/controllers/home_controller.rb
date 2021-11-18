class HomeController < ApplicationController

  def zipcode
    @xyz = params[:zipcode]
    if params[:zipcode] == ""
      @xyz = "Please enter a zipcode."
    elsif params[:zipcode]
      #run API
      require 'net/http'
      require 'json'
      @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @xyz +'&distance=0&API_KEY=4A682CF6-35B3-4DB2-9B9A-C182A7DE5804'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)

        #Check for empty return
      if @output.empty?
        @final_output = "Error"

      else
        @final_output = @output[0]['AQI']
      end

      if  @final_output == "Error"
        @api_color = "gray"

      elsif @final_output <= 50
        @api_color = "green"
        @api_message = "Air quality is good"

      elsif @final_output >= 51 && @final_output <= 100
        @api_color = "yellow"
        @api_message = "Air quality is ok"

      elsif @final_output >= 101 && @final_output <= 150
        @api_color = "orange"
        @api_message = ""

      elsif @final_output >= 151 && @final_output <= 200
        @api_color = "red"
        @api_message = ""

      elsif @final_output >= 201 && @final_output <= 300
        @api_color = "purple"
        @api_message = ""

      elsif @final_output >= 301 && @final_output <= 500
        @api_color = "maroon"
        @api_message = ""
      end
    end
  end

end
