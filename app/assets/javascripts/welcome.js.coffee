# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Util
  @getData: (id, dataJson) ->
    try
      console.log id
      console.log dataJson
      $.ajax({
        type: "POST",
        url: "get/"+id,
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
          $(".p2_other>.data").text(data.setData.other)
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
      
      

$ ->
  dataJson = gon.datas if gon?
  $('a').on 'click', () ->
    Util.getData($(this).attr('value'), dataJson)

