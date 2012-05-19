# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


# escape_javascript(render(:partial => 'course', :collection => @courses))

# $('.category_link').click ->
#   txt = this.text;
#   id = this.id;
#   new_str = $("#json_string").val();
#   obj = JSON.parse(new_str);
#   item = {};
#   item[txt] = parseInt(id);
#   obj.unshift( item );
#   console.log(obj)
#   json_string = JSON.stringify(obj);
#   $("#json_string").val(new_str);


$('.category_link').bind 'ajax:complete',(xhr, data, status) ->
  $('#courses_div > div').remove('div');
  console.log(xhr);
  console.log(data);
  $('#courses_div').prepend(data.responseText);

$('.category_link').click (e) ->
  e.preventDefault();
