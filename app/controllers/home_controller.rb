class HomeController < ApplicationController
  def index
    @upcoming_events = Event.upcoming
  end
end
