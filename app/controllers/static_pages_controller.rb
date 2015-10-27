class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def help
  end

  def maper
      @events = Event.all
  if params[:search]
    @events = Event.search(params[:search]).order("created_at DESC")
  else
    @events = Event.all.order('created_at DESC')
  end
  
  	@hash = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      marker.infowindow gmaps4rails_infowindow(event)     
  	end
  end

  private


  def gmaps4rails_infowindow(event)
   location_link = view_context.link_to "More", event_path(event)
      "<h1>#{event.title}</h1><br/>
       <h3>#{event.address_schort}</h3><br/>
       <p>#{location_link}</p>
      "
    end
end
