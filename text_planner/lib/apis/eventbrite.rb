require 'HTTParty'
  
class EventBriteApi
  def eventbrite
    HTTParty.get()