class Volunteer::EmailBlastController < Volunteer::BaseController
  before_filter :authenticate_user!
  layout 'event'

  def show
    @event = Event.find params[:event_id]

    authorize! :read, @event

    query = Profile.includes([:user, {:volunteer_registrations => [:event, :assignments => {:position => :role}]}]).
        where({events: {id: @event.id}})
    query = query.where(volunteer_roles: {key_position: key_volunteer?}) unless key_volunteer?.nil?
    query = query.where(volunteer_roles: {id: params[:roles]}) if params[:roles].present?

    @recipients = query.map { |profile| "#{profile.full_name} <#{profile.email}>" }
  end

  private

  def key_volunteer?
    params[:key_volunteer] ||= "everyone"
    params[:key_volunteer] == "everyone" ? nil : params[:key_volunteer]
  end
end
