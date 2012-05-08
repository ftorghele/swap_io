$('#hand_wrapper').animate( top: '+=324', rotate: '-=20',
  step: (now,fx)->
    $(this).css('-webkit-transform','rotate('+(now+20)+'deg)');
    $(this).css('-moz-transform','rotate('+(now+20)+'deg)');
    $(this).css('transform','rotate('+(now+20)+'deg)');
  complete: ->
    $('#hand, #hand_overlay').animate( top: '-=324' ,
      duration: 1000, 'linear')
  duration: 2000, 'linear')


unFry = ->
  $('#audio').remove();
  $("#egg-image").attr('src', 'assets/landingpage/layout-header-egg.png');


fry = ->
  if ($("#audio").length>0)
    return;


  callback = -> unFry();
  setTimeout callback 2000;

  audio = $("<audio id='audio'></audio>");
  audio.attr('src':'/assets/Track1.ogg');
  audio.attr('volume':0.4);
  audio.attr('autoplay':'autoplay');
  $('body').append(audio);


$("#egg").hover ->
    fry();
    $("#egg-typo").css('backgroundPosition', '0 -73px');
    $("#egg-image").attr('src', '');
    $("#egg-image").attr('src', 'assets/landingpage/layout-header-egg-animated.gif');

