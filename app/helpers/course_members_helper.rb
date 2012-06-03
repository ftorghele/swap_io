module CourseMembersHelper

  def course_member_acceptance
    case @course_member.accepted
    when 2
      '<span id="acceptance-pending" class="acceptance-button"></span><div class="right acceptance-txt">Anfrage versendet</div>'
    when 1
      '<span id="acceptance-true"class="acceptance-button"></span><div class="right acceptance-txt">Anfrage angenommen</div>'
    else
      '<span id="acceptance-false"class="acceptance-button"></span><div class="right acceptance-txt">Anfrage abgelehnt</div>'
    end
  end
end
