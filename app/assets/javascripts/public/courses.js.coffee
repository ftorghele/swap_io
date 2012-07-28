# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# max 3 categories clickable
$('[id^=checkbox_cat-]').click ->

  num_checked = 0
  $('[id^=checkbox_cat-]').each ->
    if $(this).is(":checked")
      num_checked++

  if num_checked >= 3
    $('[id^=checkbox_cat-]').each ->
      if $(this).is(":not(:checked)")
        $(this).prop('disabled', true)
  else
    $('[id^=checkbox_cat-]').each ->
      $(this).prop('disabled', false)

  if num_checked == 4
    $(this).prop('checked', false)


# fancybox
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


$("#form-submit").click ->
  $('#container').add("<div id='spinner-target' class='fullsize' style='position: absolute;'></div>");
  opts = {
    lines: 13,
    length: 12,
    width: 8,
    radius: 20,
    rotate: 0,
    color: '#000',
    speed: 1, 
    trail: 60, 
    shadow: false,
    hwaccel: false,
    className: 'spinner',
    zIndex: 2e9,
    top: 'auto', 
    left: 'auto'
  };
  target = document.getElementById('spinner-target');
  spinner = new Spinner(opts).spin(target);
