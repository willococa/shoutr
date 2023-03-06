class LikesController < ApplicationController
	def create
		current_user.like(shout)
		redirect_to root_path
	end

	def destroy
		current_user.unlike(shout)
		redirect_to root_path
	end
	private

	def shout
		#if in this point we had used a nested_route
		# this line would've been written @_shout ||= Shout.find(params[:shout_id])
		#and the url will look like /shout/:id/like
		#insted of /shout/:shout_id/likes
		@_shout ||= Shout.find(params[:id])
	end


end