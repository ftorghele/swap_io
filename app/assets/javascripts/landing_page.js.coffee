$('#the_dot').css({opacity: 0.0 });

preload = (images) ->
  $(images).each ->
    $('<img/>')[0].src = this

$(window).load ->

  preload(['assets/landingpage/layout-header-egg-animated.gif',
           'assets/landingpage/layout-header-urban-animated.gif',
           'assets/landingpage/layout-header-light-animation.gif']);

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
  audio.attr('src':'/assets/'+track+'.mp3');
  audio.attr('volume':0.4);
  audio.attr('autoplay':'autoplay');
  $('body').append(audio);

noNoise = (track) ->
  $("#"+track+"").remove(); 

$("#egg").hover ->
    if ($("#audio_egg").length>0)
      return;
    $("#egg").css({'background': 'url(assets/landingpage/layout-header-egg-animated.gif)', 'backgroundRepeat': 'no-repeat'});
    makeNoise("audio_egg");
    $("#egg_typo").css('backgroundPosition', '0 -73px');
    $("#egg").delay(2500).queue ->
      $("#egg").css({'background': 'url(assets/landingpage/layout-header-egg.png)', 'backgroundRepeat': 'no-repeat' });
      noNoise("audio_egg");
      $(this).dequeue();
  , -> 
    $("#egg_typo").css('backgroundPosition', '0 0');


$("#urban").hover ->
    if ($("#audio_urban").length>0)
      return;
    $("#urban_typo").css('backgroundPosition', '0 -98px');
    $("#urban").css({'background': 'url(assets/landingpage/layout-header-urban-animated.gif)', 'backgroundRepeat': 'no-repeat' });
    makeNoise("audio_urban");
    $("#urban").delay(2500).queue ->
      $("#urban").css({'background': 'url(assets/landingpage/layout-header-urban.png)' , 'backgroundRepeat': 'no-repeat'});
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
    $("#light").css({'background': 'url(assets/landingpage/layout-header-light-animation.gif)', 'backgroundRepeat': 'no-repeat' });
    makeNoise("audio_light");
    $("#light").delay(2500).queue ->
      $("#light").css({'background': 'url(assets/landingpage/layout-header-light.png)', 'backgroundRepeat': 'no-repeat'});
      noNoise("audio_light");
      $(this).dequeue();
  , -> 
    ""


dance = (counter)->
  $("#robo_shoe").css('backgroundPosition', '0 -69px');
  $('#robo_shoe').animate( top: '-=24', rotate: '-=30',
    step: (now,fx)->
        $(this).css('-webkit-transform','rotate('+(now+10)+'deg)');
        $(this).css('-moz-transform','rotate('+(now+10)+'deg)');
        $(this).css('transform','rotate('+(now+10)+'deg)');
    complete: ->
      $("#robo_shoe").css('backgroundPosition', '0 0');
      $('#robo_shoe').animate( top: '+=24' , rotate: '+=30',
        step: (now,fx)->
          $(this).css('-webkit-transform','rotate('+(now-10)+'deg)');
          $(this).css('-moz-transform','rotate('+(now-10)+'deg)');
          $(this).css('transform','rotate('+(now-10)+'deg)');
        complete: ->
          counter -= 1
          if (counter == 0)
            return;
          dance(counter-1)
        duration: 200, 'linear')
    duration: 200, 'linear')


$("#robo_dance").hover ->
    if ($("#audio_robo").length>0)
      return;
    $("#robo_dance").css('backgroundPosition', '0 -65px');
    dance(5);
    makeNoise("audio_robo");
    $("#robo_dance").delay(2500).queue ->
      $("#robo_shoe").css('backgroundPosition', '0 0');
      noNoise("audio_robo");
      $(this).dequeue();
  , ->
    $("#robo_dance").css('backgroundPosition', '0 0');


swing = (counter)->
  makeNoise("audio_faultier");
  $('#faultier').animate( rotate: '+=30',
    step: (now,fx)->
        $(this).css('-webkit-transform','rotate('+(now+10)+'deg)');
        $(this).css('-moz-transform','rotate('+(now+10)+'deg)');
        $(this).css('transform','rotate('+(now+10)+'deg)');
    complete: ->
      $('#faultier').animate( rotate: '-=30',
        step: (now,fx)->
          $(this).css('-webkit-transform','rotate('+(now-5)+'deg)');
          $(this).css('-moz-transform','rotate('+(now-5)+'deg)');
          $(this).css('transform','rotate('+(now-5)+'deg)');
        duration: 2000, 'linear')
        makeNoise("audio_faultier");
    duration: 2000, 'linear')

$("#faultier").hover ->
  if ($("#audio_faultier").length>0)
    return;
  swing();
