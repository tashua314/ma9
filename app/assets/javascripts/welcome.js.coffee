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
          $("#p2_other").append(JSON.stringify(data.setData)+"::"+data.id)
          $("#p2_mo_url").append(gon.datas)
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
  dataJson = gon.datas
  $('a').on 'click', () ->
    Util.getData($(this).attr('value'), dataJson)

