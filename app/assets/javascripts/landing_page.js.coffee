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
  $("#egg_image").attr('src', 'assets/landingpage/layout-header-egg.png');

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
    $("#egg_typo").css('backgroundPosition', '0 -73px');
    $("#egg_image").attr('src', 'assets/landingpage/layout-header-egg-animated.gif');
  , -> 
    $("#egg_typo").css('backgroundPosition', '0 0');

$("#urban").hover ->
    $("#urban_typo").css('backgroundPosition', '0 -97px');
    $("#urban_image").attr('src', 'assets/landingpage/layout-header-urban-animated.gif');
  , -> 
    $("#urban_typo").css('backgroundPosition', '0 0');
    $("#urban_image").attr('src', 'assets/landingpage/layout-header-urban.png');

$("#fb").hover ->
    $("#fb").css('backgroundPosition', '0 -37px');
  , -> 
    $("#fb").css('backgroundPosition', '0 0');

$("#wir").hover ->
    $("#wir").css('backgroundPosition', '0 -82px');
  , -> 
    $("#wir").css('backgroundPosition', '0 0');

$("#light").hover ->
    $("#light").prepend('<img src="/assets/landingpage/layout-header-light-animation.gif" />');
  , -> 
    $("#light").children(":first").remove();

$("#robo_dance").hover ->
    $("#robo_typo").css('backgroundPosition', '0 -65px');
    $("#robo_shoe").css('backgroundPosition', '0 -69px');
  , -> 
    $("#robo_typo").css('backgroundPosition', '0 0');
    $("#robo_shoe").css('backgroundPosition', '0 0');
