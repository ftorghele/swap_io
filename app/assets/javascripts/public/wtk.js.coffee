# NAV DROPDOWN
$('#nav-profile-dropdown').toggle ->
  $('ul#nav-select2').slideDown()
  $('#nav-profile-dropdown').css({'background-image': 'url(/assets/layout-header-arrowup.png)'})
, ->
  $('ul#nav-select2').slideUp()
  $('#nav-profile-dropdown').css({'background-image': 'url(/assets/layout-header-arrowdown.png)'})

# CATEGORY SELECT
$('.category_link').bind 'ajax:complete',(xhr, data, status) ->
  $(this).toggleClass('active')
  $('#courses_div > article').remove('article');
  $('#courses_div').prepend(data.responseText);

$('.category_link').click (e) ->
  e.preventDefault();

# FORM STEPS
$('.fieldset-buttons').css({'display': 'block'})
$(".step-two").css({'display': 'none'})
$('#form-nextstep').click ->
  $(".step-one").css({'display': 'none'})
  $(".step-two").css({'display': 'block'})
  $('html,body').animate({scrollTop: $('.step-two').offset().top-20},'slow');
$('#form-laststep').click ->
  $(".step-one").css({'display': 'block'})
  $(".step-two").css({'display': 'none'})
  $('html,body').animate({scrollTop: $('.step-one').offset().top-20},'slow');
$('#form-submit').click ->
  $('.fieldset-buttons').css({'display': 'none'})
  $(".step-one").css({'display': 'block'})
  $('html,body').animate({scrollTop: top},'slow');

# Spinner
$("#form-submit").click ->
  $("#container").css('visibility', 'hidden');
  $("#preview").css('visibility', 'hidden');
  $("body").css('background', 'white');
  $('html,body').animate({scrollTop: top},'slow');
  $("body").append("<div id='spinner-target' class='fullsize' style='position: absolute; top: 40px; background-color: white;'></div>");
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
