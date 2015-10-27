class MembersController < ApplicationController

	def create
		event = Event.find(params[:event_id])
		event.members << currennt_user
		redirect_to event
	end

	def destroy
		Member.where(event_id: params[:event_id], user_id: currennt_user)
		redirect_to Event.find(params[event_id])
	end

end
