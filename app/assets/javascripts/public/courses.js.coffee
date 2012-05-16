# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


# escape_javascript(render(:partial => 'course', :collection => @courses))
$('.category_link').click ->
  txt = this.text
  #$("#json_string").val({txt: 3});
  new_str = $("#json_string").push( txt: 4 );
  alert( new_str );
  $("#json_string").val( new_str );

$('.category_link').bind 'ajax:complete',(xhr, data, status) ->
  $('#courses_div > div').remove('div');
  $('#courses_div').prepend(data.responseText);

$('.category_link').click (e) ->
  e.preventDefault();
