$('#nav-profile-dropdown').toggle ->
  $('ul#nav-select2').slideDown()
  $('#nav-profile-dropdown').css({'background-image': 'url(/assets/layout-header-arrowup.png)'})
, ->
  $('ul#nav-select2').slideUp()
  $('#nav-profile-dropdown').css({'background-image': 'url(/assets/layout-header-arrowdown.png)'})

$('.category_link').bind 'ajax:complete',(xhr, data, status) ->
  $(this).toggleClass('active')
  $('#courses_div > article').remove('article');
  $('#courses_div').prepend(data.responseText);

$('.category_link').click (e) ->
  e.preventDefault();
