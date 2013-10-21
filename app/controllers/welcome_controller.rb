class WelcomeController < ApplicationController

  SCALE = 1000
  MAPI_URL = "http://oasis.mogya.com/api/v0/search?"
  LAT = 35.57485
  LNG = 139.655821
  RANGE = 0.005
  @aiai = "aiai"

  def index
    require 'open-uri'
    require 'json'

    parsed=['']
    
    lat = "&lat="+LAT.to_s
    lng = "&lng="+LNG.to_s
    url = MAPI_URL+"n="+(LAT+RANGE).to_s+"&e="+(LNG+RANGE).to_s+"&s="+(LAT-RANGE).to_s+"&w="+(LNG-RANGE).to_s+lat+lng
    @url = url

    begin
      html = open(url).read
      json = JSON.parser.new(html)
      hash = json.parse()

    rescue
      @alert="URL missed..."
      
      respond_to do |format|
        format.html { render :action => "error"}
        format.iphone { render :action => "error"}
      end

      return
    end

    if hash.present?
      @parsed = hash['results']
      gon.datas = @parsed

      @titles = []
      distances = []
      @entry_ids = []
      @num = 0
      for result in @parsed
        @titles[@num] = result['title']
        @entry_ids[@num] = result['entry_id']
        distances[@num] = result['distance']
        @distance = km2m(distances)
        @num += 1;
      end
    end

    respond_to do |format|
      format.html { render :action => "index"}
      format.iphone { render :action => "index"}
    end
  end

  def get
    id = params[:id]
    datas = params[:datas]
    setData = nil

    datas.each do |data|
     # debugger
      if id == data[1]['entry_id']
        setData = data[1]
        break
      end
    end
    #debugger
    gon.datas = datas
    render json: { setData: setData, id: id }
  end

  # 画面表示用にkmをmに変換する
  private
  def km2m(distances)
    results = []
    distances.each do |dis|
      m = (dis*SCALE).to_i
      results.push(m)
    end

    return results
  end
end
