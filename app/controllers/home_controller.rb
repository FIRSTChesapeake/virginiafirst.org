class HomeController < ApplicationController
  def events
    @upcoming_events = Event.upcoming
  end

  def faq
  end

  def index
    @upcoming_events = Event.upcoming
  end

  def mentor
  end

  def volunteer
    @roles = Volunteer::Role.limit(5).order("RANDOM()")
  end
end
