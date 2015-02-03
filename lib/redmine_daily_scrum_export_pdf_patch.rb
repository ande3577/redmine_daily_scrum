module RedmineDailyScrumProjectPatch
  def self.included(base)
    unloadable
  end

  def daily_scrum_to_pdf(project, daily_scrums, post_scrum_actions, date)
    pdf = Redmine::Export::PDF::ITCPDF.new(current_language)
    pdf.set_title(project.to_s + ' - ' + l(:daily_scrum_title))
    pdf.alias_nb_pages
    pdf.footer_date = format_date(Date.today)
    pdf.add_page
    pdf.SetFontStyle('B',11)
    buf = project.to_s + ' - ' + l(:daily_scrum_title)
    pdf.RDMMultiCell(190, 5, buf)
    pdf.SetFontStyle('I',8)
    buf = localize date, :format => :long
    pdf.RDMMultiCell(190, 5, buf)
    pdf.SetFontStyle('B',11)
    pdf.RDMCell(190,5, l(:daily_scrum_team_members), "B")
    pdf.ln

    daily_scrums.each do |s|
      pdf.SetFontStyle('B', 9)
      buf = s.user.to_s
      pdf.RDMMultiCell(190, 5, buf)
      pdf.SetFontStyle('', 9)
      if s.empty?
        buf =  l(:label_no_data)
        pdf.RDMMultiCell(190, 5, buf)
      else
        pdf.SetFontStyle('I', 9)
        buf = l(:daily_scrum_what_i_did_yesterday)
        pdf.RDMMultiCell(190, 5, buf)
        pdf.SetFontStyle('', 9)
        write_daily_scrum_html_cell(pdf,  s.what_did_i_do_yesterday)

        pdf.SetFontStyle('I', 9)
        buf = l(:daily_scrum_what_am_i_doing_today)
        pdf.RDMMultiCell(190, 5, buf)
        pdf.SetFontStyle('', 9)
        write_daily_scrum_html_cell(pdf,  s.what_am_i_doing_today)

        pdf.SetFontStyle('I', 9)
        buf = l(:daily_scrum_whats_standing_in_my_way)
        pdf.RDMMultiCell(190, 5, buf)
        pdf.SetFontStyle('', 9)
        write_daily_scrum_html_cell(pdf,  s.what_is_standing_in_my_way)
      end

      if User.current.allowed_to?(:view_daily_scrum, @project)
        pdf.SetFontStyle('B', 9)
        pdf.RDMCell(190,5, l(:daily_scrum_post_scrum_actions), "B")
        pdf.ln
        pdf.SetFontStyle('', 8)
        if post_scrum_actions.nil? || post_scrum_actions.empty?
          buf = l(:label_no_data)
          pdf.RDMMultiCell(190, 5, buf)
        else
          write_daily_scrum_html_cell(pdf,  post_scrum_actions.actions)
        end
      end
    end

    pdf.output
  end   

  private
  def write_daily_scrum_html_cell(pdf, str)
    if Redmine::VERSION::MAJOR < 2 or Redmine::VERSION::MINOR < 6
      pdf.RDMwriteHTMLCell(0, 5, 10, 0, str, [])
    else
      pdf.RDMwriteHTMLCell(0, 5, 10, '', str, [])
    end
  end
end


Redmine::Export::PDF.send(:include, RedmineDailyScrumProjectPatch)
