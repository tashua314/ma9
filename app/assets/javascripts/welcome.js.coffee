# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Util
  @getData: (id) ->
    console.log id
    $.ajax({
      type: "POST",
      url: "get/"+id,
      success: (data) ->
        $("#data").text(data.test+"::"+data.id)
      error: (status, e) ->
        alert (status.to_s);
        alert (e);
    });


$ ->
  $('a').on 'click', () ->
    Util.getData($(this).attr('value'))

