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
$("fieldset.step:nth-child(3)").css({'display': 'none'})
$('#form-nextstep').click ->
  $("fieldset.step:nth-child(2)").css({'display': 'none'})
  $("fieldset.step:nth-child(3)").css({'display': 'block'})
  $('html,body').animate({scrollTop: $('fieldset.step:nth-child(3)').offset().top-20},'slow');
$('#form-laststep').click ->
  $("fieldset.step:nth-child(2)").css({'display': 'block'})
  $("fieldset.step:nth-child(3)").css({'display': 'none'})
  $('html,body').animate({scrollTop: $('fieldset.step:nth-child(2)').offset().top-20},'slow');
$('#form-submit').click ->
  $('.fieldset-buttons').css({'display': 'none'})
  $("fieldset.step:nth-child(2)").css({'display': 'block'})
  $('html,body').animate({scrollTop: $('fieldset.step:nth-child(2)').offset().top-20},'slow');
