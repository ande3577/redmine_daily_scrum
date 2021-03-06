module DailyScrumsHelper
  def display_scrum_answer(scrum_answer)
    "<p>#{textilizable(scrum_answer)}</p>".html_safe()
  end

  def display_scrum_field(tag, label, scrum)
    parameter_name = build_parameter_name(tag, scrum)
    scrum_field = "<p>"  + label_tag(parameter_name, label)
    scrum_field += text_area_tag(parameter_name, content=scrum.read_attribute(tag))
    scrum_field.html_safe()
  end

  private
  def build_parameter_name(tag, scrum)
    "daily_scrums[#{scrum.user.id}][#{tag}]"
  end
end
