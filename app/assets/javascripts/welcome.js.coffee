# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

successCallback = (pos) ->
  console.log "start successCallback."
  latitude = pos.coords.latitude
  longitude = pos.coords.longitude
  console.log latitude + "/" + longitude
  $('input[name=lat]').val(latitude)
  $('input[name=lng]').val(longitude)
  $('.search_form').submit()


errorCallback = (err) ->
  console.log "getLocation err."
  console.log err.message
  $('.error_message').text("位置情報が取得できません。")


class Util
  @getDetail: (id, dataJson) ->
    try
      console.log id
      console.log dataJson
      $.ajax({
        type: "POST",
        url: "getDetail/"+id,
        success: (data) ->
          console.log data.id
          console.log data.setData
          $("#p2_header>h1").text(data.setData.title)
          $(".p2_address>.data").text(data.setData.address)
          $(".p2_tel>.data").text(data.setData.tel)
          $(".p2_wireless>.data").text(data.setData.wireless)
          $(".p2_category>.data").text(data.setData.category)
          $(".p2_url>.data").text(data.setData.url_pc)
          $(".p2_tag>.data").text(data.setData.tag)
          $(".p2_supply>.data").text(data.setData.power_supply)
          $(".p2_other>.data").html(data.setData.other)
          $(".p2_mo_url>.data").html('<a href="'+data.setData.mo_url+'">'+data.setData.mo_url+'</a>')
          console.log "ok!"
        error: (status, e) ->
          console.log status
          console.log e
        data: datas: dataJson
      });
    catch error
      console.log error
    finally
      console.log "end."


  @getLocation: ->
    nowLocation = new Array()
    console.log "start getLocation"
    try
      if (navigator.geolocation)
        console.log "navigator ok."
        #Geolocation APIを利用できる環境向けの処理
        geolocation = navigator.geolocation
        geolocation.getCurrentPosition successCallback, errorCallback
        console.log "ok"
      else
        #Geolocation APIを利用できない環境向けの処理
        console.log "ng"
    catch error
      console.log "error"
      console.log error.message
    finally
      console.log "end."



$ ->
  nowLocation = new Array()
  if gon?
    console.log "I have gon."
    dataJson = gon.datas
    if gon.latitude?
      nowLocation['latitude'] = gon.latitude
      nowLocation['longitude'] = gon.longitude

    console.log gon
    console.log "have you lat?: " + nowLocation['latitude']?
    Util.getLocation() if !nowLocation['latitude']?


  $('.list_area a').on 'click', () ->
    console.log "click "+ this
    Util.getDetail($(this).attr('value'), dataJson)

