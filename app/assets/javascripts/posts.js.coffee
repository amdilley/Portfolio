# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
fitTextareaHeight = (textarea) ->
  maxRows = 15
  avgCharWidth = 6.5 # approx width of each character based on font size
  charsPerLine = textarea.scrollWidth / avgCharWidth
  txt = textarea.value
  txtArr = txt.split('\n')
  rows = txtArr.length
  i = 0
  while i < txtArr.length
    rows += Math.ceil(txtArr[i].length / charsPerLine)
    i++
  textarea.rows = Math.min rows, maxRows
  return

$(document).ready ->
  $(window).on 'resize', ->
    $('textarea').each ->
      fitTextareaHeight this
      return

  $('textarea').each(->
    fitTextareaHeight this
    return
  ).on 'change keydown', ->
    fitTextareaHeight this
    return
  return
