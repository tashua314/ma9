class WelcomeController < ApplicationController

  MAPI_URL = "http://oasis.mogya.com/api/v0/search?"
  LAT = 35.57485
  LNG = 139.655821
  RANGE = 0.005

  def index
    require 'open-uri'
    require 'json'

    parsed=['']
    
    url = MAPI_URL+"n="+(LAT+RANGE).to_s+"&e="+(LNG+RANGE).to_s+"&s="+(LAT-RANGE).to_s+"&w="+(LNG-RANGE).to_s

    begin
      @html = open(url).read
      json = JSON.parser.new(@html)
      hash = json.parse()

    rescue
      @alert="URL missed..."
      return
    end
  end
end
