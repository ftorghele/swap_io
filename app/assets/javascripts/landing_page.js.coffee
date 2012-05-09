$('#the_dot').css({opacity: 0.0 });

$(window).load ->
  $('#hand_wrapper').animate( top: '+=324', rotate: '-=20',
    step: (now,fx)->
      $(this).css('-webkit-transform','rotate('+(now+20)+'deg)');
      $(this).css('-moz-transform','rotate('+(now+20)+'deg)');
      $(this).css('transform','rotate('+(now+20)+'deg)');
    complete: ->
      $('#hand, #hand_overlay').animate( top: '-=324' ,
        complete: ->
          $('#the_dot').css({opacity: 1.0 });
        duration: 1000, 'linear')
    duration: 2000, 'linear')

makeNoise = (track) ->
  audio = $("<audio id=''+track''></audio>");
  audio.attr('src':'/assets/'+track+'.ogg');
  audio.attr('volume':0.4);
  audio.attr('autoplay':'autoplay');
  $('body').append(audio);

noNoise = (track) ->
  $("#"+track+"").remove(); 

$("#egg").hover ->
    if ($("#audio_egg").length>0)
      return;
    $("#egg_image").attr('src', 'assets/landingpage/layout-header-egg-animated.gif');
    makeNoise("audio_egg");
    $("#egg_typo").css('backgroundPosition', '0 -73px');
    $("#egg_image").delay(2500).queue ->
      $("#egg_image").attr('src', 'assets/landingpage/layout-header-egg.png');
      noNoise("audio_egg");
      $(this).dequeue();
  , -> 
    $("#egg_typo").css('backgroundPosition', '0 0');


$("#urban").hover ->
    if ($("#audio_urban").length>0)
      return;
    $("#urban_typo").css('backgroundPosition', '0 -98px');
    $("#urban_image").attr('src', 'assets/landingpage/layout-header-urban-animated.gif');
    makeNoise("audio_urban");
    $("#urban_image").delay(2500).queue ->
      $("#urban_image").attr('src', 'assets/landingpage/layout-header-urban.png');
      noNoise("audio_urban");
      $(this).dequeue();
  , ->
    $("#urban_typo").css('backgroundPosition', '0 0');
    

$("#fb_sign").hover ->
    if ($("#audio_fb").length>0)
      return;
    $("#fb_sign").css('backgroundPosition', '0 -37px');
    makeNoise("audio_fb");
    $("#fb_sign").delay(2500).queue ->
      $("#fb_sign").css('backgroundPosition', '0 0');
      noNoise("audio_fb");
      $(this).dequeue();
  , ->
    ""


$("#wir").hover ->
    if ($("#audio_wir").length>0)
      return;
    $("#wir").css('backgroundPosition', '0 -82px');
    makeNoise("audio_wir");
    $("#wir").delay(2500).queue ->
      $("#wir").css('backgroundPosition', '0 0');
      noNoise("audio_wir");
      $(this).dequeue();
  , -> 
    ""

$("#light").hover ->
    if ($("#audio_light").length>0)
      return;
    $("#light").attr('src', 'assets/landingpage/layout-header-light-animated.gif');
    makeNoise("audio_light");
    $("#light").delay(2500).queue ->
      $("#light").css('backgroundPosition', '0 0');
      noNoise("audio_light");
      $(this).dequeue();
  , -> 
    $("#light").attr('src', 'assets/landingpage/layout-header-light.png');


#dance = (time)->
#  if(time <= 0)
#    return;
#  $("#robo_shoe").css('backgroundPosition', '0 -69px');
#  $("#robo_dance").delay(500).queue ->
#    $("#robo_shoe").css('backgroundPosition', '0 0');
#    $(this).dequeue();
#    time = time - 1
#    dance(time);

down = true;

dance = ->
  $('#robo_shoe').animate( top: '-=24', rotate: '-=30',
    step: (now,fx)->
      if(down)
        $(this).css('-webkit-transform','rotate('+(now+10)+'deg)');
        $(this).css('-moz-transform','rotate('+(now+10)+'deg)');
        $(this).css('transform','rotate('+(now+10)+'deg)');
      else
        $(this).css('-webkit-transform','rotate('+(now-10)+'deg)');
        $(this).css('-moz-transform','rotate('+(now-10)+'deg)');
        $(this).css('transform','rotate('+(now-10)+'deg)');
    complete: ->
      $('#robo_shoe').animate( top: '+=24' , rotate: '+=30',
        complete: ->
          ""
        duration: 200, 'linear')
    duration: 200, 'linear')


$("#robo_dance").hover ->
    if ($("#audio_robo").length>0)
      return;
    $("#robo_typo").css('backgroundPosition', '0 -65px');
   # $("#robo_shoe").css('backgroundPosition', '0 -69px');
    dance();
    makeNoise("audio_robo");
    $("#robo_dance").delay(2500).queue ->
      $("#robo_shoe").css('backgroundPosition', '0 0');
      noNoise("audio_robo");
      $(this).dequeue();
  , ->
    $("#robo_typo").css('backgroundPosition', '0 0');
