class DashboardsController < ApplicationController
	def show
		@timeline = Timeline.new(
			current_user.followed_user_ids + current_user.id )
	end
end