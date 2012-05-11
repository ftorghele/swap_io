
rotate = (that, deg)->
  $(that).css('-webkit-transform','rotate('+deg+'deg)');
  $(that).css('-moz-transform','rotate('+deg+'deg)');
  $(that).css('transform','rotate('+deg+'deg)');
  $(that).css('-ms-transform','rotate('+deg+'deg)');
  

preload_images = (images) ->
  $(images).each ->
    $('<img/>')[0].src = this

$('#hallo_content').countdown({until: new Date(2012, 5, 4), compact: true, layout: '<div>{dn}</div> : {hnn} : {mnn} : {snn}'});

$(window).load ->

  if $('#msg').children().length > 0
    $('html,body').animate({scrollTop: $('#msg').offset().top-20},'slow');

  preload_images(['assets/landingpage/layout-header-egg-animated.gif',
                  'assets/landingpage/layout-header-urban-animated.gif',
                  'assets/landingpage/layout-header-light-animation.gif']);

  $('#hand_wrapper').animate( top: '+=394', rotate: '-=20',
    step: (now,fx)->
      rotate(this, now+20);
    complete: ->
      $('#hand, #hand_overlay').animate( top: '-=394' ,
        duration: 1200, 'linear')
    duration: 2000, 'linear')

makeNoise = (track) ->
  audio = $("<audio id="+track+"></audio>");
  source1 = $("<source src=/assets/landingpage/"+track+".mp3 />");
  source2 = $("<source src=/assets/landingpage/"+track+".ogg />");
  audio.attr('volume':0.4);
  audio.attr('autoplay':'autoplay');
  audio.append(source1);
  audio.append(source2);
  $('body').append(audio);

noNoise = (track) ->
  $("#"+track+"").remove(); 

$("#egg").hover ->
    $("#egg_typo").css('backgroundPosition', '0 -73px');
    if ($("#audio_egg").length>0)
      return;
    $("#egg").css({'background': 'url(assets/landingpage/layout-header-egg-animated.gif)', 'backgroundRepeat': 'no-repeat'});
    makeNoise("audio_egg");
    $("#egg").delay(2500).queue ->
      $("#egg").css({'background': 'url(assets/landingpage/layout-header-egg.png)', 'backgroundRepeat': 'no-repeat' });
      noNoise("audio_egg");
      $(this).dequeue();
  , -> 
    $("#egg_typo").css('backgroundPosition', '0 0');


$("#urban").hover ->
    $("#urban_typo").css('backgroundPosition', '0 -98px');
    if ($("#audio_urban").length>0)
      return;
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
    $("#fb_sign").delay(1500).queue ->
      $("#fb_sign").css('backgroundPosition', '0 0');
      noNoise("audio_fb");
      $(this).dequeue();
  , ->
    ""


popup = (cssId, t, l)->
  $('#'+cssId+'').animate( top: t, left: l,
    complete: ->
      ""
    duration: 200, 'linear')


$("#wir").hover ->
    if ($("#audio_team").length>0)
      return;
    $("#wir").css('backgroundPosition', '0 -82px');
    $("#face_1").delay(350).queue ->
      popup("face_1", '+=40', '+=30');
      $(this).dequeue();
    $("#face_2").delay(500).queue ->
      popup("face_2",  '-=26', '+=38');
      $(this).dequeue();
    $("#face_3").delay(1000).queue ->
      popup("face_3", '-=40', '-=30');
      $(this).dequeue();
    $("#face_4").delay(1200).queue ->
      popup("face_4", '+=30', '-=38');
      $(this).dequeue();
    makeNoise("audio_team");
    $("#wir").delay(2500).queue ->
      $("#face_1").delay(10).queue ->
        popup("face_1", '-=40', '-=30');
        $(this).dequeue();
      $("#face_2").delay(10).queue ->
        popup("face_2",  '+=26', '-=38');
        $(this).dequeue();
      $("#face_3").delay(10).queue ->
        popup("face_3", '+=40', '+=30');
        $(this).dequeue();
      $("#face_4").delay(10).queue ->
        popup("face_4", '-=30', '+=38');
        $(this).dequeue();
      noNoise("audio_team");
      $(this).dequeue();
  , -> 
    $("#wir").css('backgroundPosition', '0 0');


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
      rotate(this, now+10);
    complete: ->
      $("#robo_shoe").css('backgroundPosition', '0 0');
      $('#robo_shoe').animate( top: '+=24' , rotate: '+=30',
        step: (now,fx)->
          rotate(this, now-10);
        complete: ->
          counter -= 1
          if (counter == 0)
            return;
          dance(counter-1)
        duration: 200, 'linear')
    duration: 200, 'linear')


$("#robo_wrapper").hover ->
    $("#robo_dance").css('backgroundPosition', '0 -65px');
    if ($("#audio_robo").length>0)
      return;
    dance(5);
    makeNoise("audio_robo");
    $("#robo_wrapper").delay(2500).queue ->
      $("#robo_shoe").css('backgroundPosition', '0 0');
      noNoise("audio_robo");
      $(this).dequeue();
  , ->
    $("#robo_dance").css('backgroundPosition', '0 0');


swing = (counter)->
  makeNoise("audio_faultier");
  $('#faultier').animate( rotate: '+=50',
    step: (now,fx)->
      rotate(this, now+10);
    complete: ->
      $('#faultier').animate( rotate: '-=50',
        step: (now,fx)->
          rotate(this, now-5);
        duration: 800, 'linear')
      noNoise("audio_faultier");
    duration: 800, 'linear')


$("#faultier").hover ->
  if ($("#audio_faultier").length>0)
    return;
  swing();


$("#the_dot").hover ->
  if ($("#audio_comma").length>0)
    return;
  makeNoise("audio_comma");
  $(this).animate( rotate: '+=720',
    step: (now,fx)->
        rotate(this, now+30);
    complete: ->
      noNoise("audio_comma");
    duration: 1500, 'linear')
