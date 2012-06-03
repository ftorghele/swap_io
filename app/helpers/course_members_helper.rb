module CourseMembersHelper

  def course_member_acceptance
    case @course_member.accepted
    when 2
      '<p id="acceptance-pending">Anfrage versendet</p>'
    when 1
      '<p id="acceptance-true">Anfrage angenommen</p>'
    else
      '<p id="acceptance-false">Anfrage abgelehnt</p>'
    end
  end
end
