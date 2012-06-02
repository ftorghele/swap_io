# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

if ($(".user-conversation-message-unread").length > 0)
  $('html,body').animate({scrollTop: $('.user-conversation-message-unread:first').offset().top-20},'slow');
else
  $('html,body').animate({scrollTop: $('.user-conversation-message-read:last').offset().top-20},'slow');
