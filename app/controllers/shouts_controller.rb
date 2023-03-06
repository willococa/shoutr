class ShoutsController < ApplicationController

	def show
		@shout  = Shout.find(params[:id])
	end
	def create
		shout = current_user.shouts.create(shout_params)
		redirect_to root_path, redirect_options_for(shout)
	end
	def shout_params
		params.require(:shout).permit(:body)
	end
	def redirect_options_for(shout)
		if shout.persisted?
			{notice: "Shout succesfully created!"}
		else
			{alert: "could not shout!!"}
		end
	end
end