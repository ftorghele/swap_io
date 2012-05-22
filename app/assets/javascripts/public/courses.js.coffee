# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('.category_link').bind 'ajax:complete',(xhr, data, status) ->
  $(this).toggleClass('active')
  $('#courses_div > article').remove('article');
  $('#courses_div').prepend(data.responseText);

$('.category_link').click (e) ->
  e.preventDefault();


$(".fancyimg a").fancybox
  openEffect: "fade"
  closeEffect: "fade"
  nextEffect: "fade"
  prevEffect: "fade"
  padding: 0
  loop: false
  helpers:
    title:
      type: "outside"
    overlay:
      opacity: 0.8
      css:
        "background-color": "#777"
        opacity: "0.7"
