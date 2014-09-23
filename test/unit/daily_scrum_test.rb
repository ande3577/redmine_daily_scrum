require File.expand_path('../../test_helper', __FILE__)

class DailyScrumTest < ActiveSupport::TestCase
  fixtures :projects, :members, :member_roles, :roles, :users


  def test_create
    daily_scrum = DailyScrum.new(:user => user, :project => project, :date => Date.today)
    assert daily_scrum.save()
    daily_scrum.reload()
    assert_not_equal nil, daily_scrum.updated_at
  end

  def test_date_must_be_unique
    date = Date.today
    DailyScrum.new(:user => user, :project => project, :date => date).save()
    assert DailyScrum.new(:user => user, :project => Project.active.second, :date => date).save()
    assert DailyScrum.new(:user => User.active.second, :project => project, :date => date).save()
    assert !DailyScrum.new(:user => user, :project => project, :date => date).save()
  end

  def test_delete_project
    daily_scrum = DailyScrum.create!(:user => user, :project => project, :date => Date.today)
    assert_difference('DailyScrum.count', difference = -1) do 
      project.destroy
    end
  end

  def test_delete_user
    daily_scrum = DailyScrum.create!(:user => user, :project => project, :date => Date.today)
    assert_difference('DailyScrum.count', difference = -1) do 
      user.destroy
    end
  end

  private
  def user
    User.active.first
  end

  def project
    Project.active.first
  end
end
