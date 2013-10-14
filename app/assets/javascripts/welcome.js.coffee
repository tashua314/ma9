# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Util
  @getData: (id) ->
    console.log id


$ ->
  $('a').on 'click', () ->
    Util.getData($(this).attr('value'))

