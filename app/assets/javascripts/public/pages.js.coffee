# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

counter = 1.2;
timeout = 3;


moveHand = (i, j, k, l, target, fwd) -> 
  if i <= -195
    $("#hand").remove();

  if k > target
    fwd = false;

  if fwd 
    i += 0.4;
    k += 0.4;
    j -= 0.3;
    l -= 0.3;
  else 
    i -= 0.4;
    j += 0.3;

  $("#hand").css('left', j);
  $("#hand").css('top', i);
  $("#layout-logo").css('left', l);
  $("#layout-logo").css('top', k);
  callback = -> 
      moveHand(i , j, k, l, target, fwd); 

  setTimeout callback, timeout;


$(window).load ->
  lh = $("#layout-logo").height();
  lw = $("#layout-logo").width();
  eh = $("#egg").height();
  ew = $("#egg").width();
  factor = $("#layout-header").width() / 1161;

  if ($("#layout-header").width() == 1161)
    ""
  else
    $("#layout-logo-image").attr({"height": lh*factor, "width": lw*factor });
    $("#egg-image").attr({"height": eh*factor, "width": ew*factor });

  pl = $("#layout-logo").position();
  ph = $("#hand").position();
  pvl = $("#layout-logo").css("position", "absolute");
  pvh = $("#hand").css("position", "absolute");
  left_pos = (($(window).width()) / 2);
  target = ($("#layout-header").height()/2) - ($("#layout-logo-image").height()/2) + 10;
  moveHand(ph.top+5, left_pos+75, pl.top+7, left_pos, target, true);

  $("#egg").css('top', 3*factor);
  $("#egg").css('left', $("#layout-header").position().left + (18*factor));


fry = ->
  if ($("#audio").length>0)
    return;

  audio = $("<audio id='audio'></audio>");
  audio.attr('src':'/assets/Track1.ogg');
  audio.attr('volume':0.4);
  audio.attr('autoplay':'autoplay');
  $('body').append(audio);

# unFry = ->
#   $('#audio').remove();

$("#egg").hover ->
    fry();
    $("#egg-image").attr('src', '');
    $("#egg-image").attr('src', 'assets/layout-header-egg-animated.gif');
  , '' #->

    # callback = -> unfry();
    # setTimeout callback 2000

 #   unFry();
 #   $("#egg").attr('src', 'assets/layout-header-egg.png');
