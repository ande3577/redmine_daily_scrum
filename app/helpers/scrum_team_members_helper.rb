module ScrumTeamMembersHelper
  def render_users_for_new_scrum_members(project)
    principals = project.available_scrum_members
    s = content_tag('div', principals_check_box_tags('membership[user_ids][]', principals), :id => 'principals')
  end
end
