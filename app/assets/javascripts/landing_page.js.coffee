$('#hand_wrapper').animate( top: '+=324', rotate: '-=20',
  step: (now,fx)->
    $(this).css('-webkit-transform','rotate('+(now+20)+'deg)');
    $(this).css('-moz-transform','rotate('+(now+20)+'deg)');
    $(this).css('transform','rotate('+(now+20)+'deg)');
  complete: ->
    $('#hand, #hand_overlay').animate( top: '-=324' ,
      duration: 1000, 'linear')
  duration: 2000, 'linear')





#
#counter = 1.2;
#timeout = 3;
#
#
#moveHand = (i, j, k, l, target, fwd) ->
#  if i <= -195
#    $("#hand").remove();
#
#  if k > target
#    fwd = false;
#
#  if fwd
#    i += 0.4;
#    k += 0.4;
#    j -= 0.3;
#    l -= 0.3;
#  else
#    i -= 0.4;
#    j += 0.3;
#
#  $("#hand").css('left', j);
#  $("#hand").css('top', i);
#  $("#layout-logo").css('left', l);
#  $("#layout-logo").css('top', k);
#  callback = ->
#      moveHand(i , j, k, l, target, fwd);
#
#  setTimeout callback, timeout;
#
#
#$(window).load ->
#  lh = $("#layout-logo").height();
#  lw = $("#layout-logo").width();
#  eh = $("#egg").height();
#  ew = $("#egg").width();
#  factor = $("#layout-header").width() / 1161;
#
#  if ($("#layout-header").width() == 1161)
#    ""
# else
#   $("#layout-logo-image").attr({"height": lh*factor, "width": lw*factor });

#
#  $("#egg").css('top', 3*factor);
#  $("#egg").css('left', $("#layout-header").position().left + (18*factor));
#
#
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