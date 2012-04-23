$('#hand_wrapper').animate( top: '+=324', rotate: '-=20',
  step: (now,fx)->
    $(this).css('-webkit-transform','rotate('+(now+20)+'deg)');
    $(this).css('-moz-transform','rotate('+(now+20)+'deg)');
    $(this).css('transform','rotate('+(now+20)+'deg)');
  complete: ->
    $('#hand, #hand_overlay').animate( top: '-=324' ,
      duration: 1000, 'linear')
  duration: 2000, 'linear')








#fry = ->
#  if ($("#audio").length>0)
#    return;
#
#  audio = $("<audio id='audio'></audio>");
#  audio.attr('src':'/assets/Track1.ogg');
#  audio.attr('volume':0.4);
#  audio.attr('autoplay':'autoplay');
#  $('body').append(audio);
#
## unFry = ->
##   $('#audio').remove();
#
#$("#egg").hover ->
#    fry();
#    $("#egg-image").attr('src', '');
#    $("#egg-image").attr('src', 'assets/layout-header-egg-animated.gif');
#  , '' #->
#
#    # callback = -> unfry();
#    # setTimeout callback 2000
#
# #   unFry();
# #   $("#egg").attr('src', 'assets/layout-header-egg.png');
##