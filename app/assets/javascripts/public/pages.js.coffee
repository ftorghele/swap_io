# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#navbar-login').hover ->
  $('#navbar-login-drop').slideDown('slow');

$('#navbar-login, #navbar-login-drop').mouseleave ->
  if ($('#navbar-login-drop').hover)
  else
    $('#navbar-login-drop').slideUp('slow');