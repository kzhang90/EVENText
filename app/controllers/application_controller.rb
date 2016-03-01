class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # around_filter :user_time_zone, :if => :current_user

  def index
    @user = current_user
    # @bookmarks = @user.bookmarks
  end

  def after_sign_in_path_for(resource)
    edit_user_registration_path(resource)
  end

  def search_apis
    start_date = params[:start_date].to_s
    end_date = params[:end_date].to_s
    keyword = params[:keyword].to_s
    city = params[:city].to_s

    response = JSON.parse RestClient.get('https://www.eventbriteapi.com/v3/events/search?q='+
      keyword+'&sort_by=best&venue.city='+city+'&start_date.range_start='+
      start_date+'T00:00:00Z&start_date.range_end='+end_date+'T00:00:00Z',
      authorization: ENV['EVENTBRITE']
    )
    @events = response["events"]
    @bookmarks = @events.map { |event|
      if event["description"]["text"] && event["name"]["text"]
        Bookmark.new(
          title: event["name"]["text"],
          image: event["logo"].nil? ? "" : event["logo"]["url"],
          description: event["description"]["text"].match(/^.*?[\.!\?](\s|$)/).to_s.gsub("\n"," "),
          time: event["start"]["local"].split("T")[0] + " " + event["start"]["local"].split("T")[1],
          url: event["url"])
      end
    }

    @st = @bookmarks.map do |f|
      if !f.nil?
        {
          "title" => f.title,
          "image" => f.image,
          "description" => f.description,
          "location" => params[:city],
          "time" => f.time,
          "url" => f.url
        }
      end
    end
    @st = @st - [nil]

    render :json => @st
  end
# take js controller is sending and js is transposing json to html
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :avatar, :password, :current_password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password)}
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :avatar, :password, :password_confirmation) }
  end

  # def user_time_zone(&block)
  #   Time.use_zone(current_user.time_zone, &block)
  # end

end
