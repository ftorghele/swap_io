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
$("fieldset:nth-child(3)").css({'display': 'none'})
$('#form-nextstep').click ->
  $("fieldset:nth-child(2)").css({'display': 'none'})
  $("fieldset:nth-child(3)").css({'display': 'block'})
$('#form-laststep').click ->
  $("fieldset:nth-child(2)").css({'display': 'block'})
  $("fieldset:nth-child(3)").css({'display': 'none'})
$('#form-submit').click ->
  $('.fieldset-buttons').css({'display': 'none'})
  $("fieldset:nth-child(2)").css({'display': 'block'})
