class ShoutsController < ApplicationController

	def show
		@shout  = Shout.find(params[:id])
	end
	def create
		shout = current_user.shouts.create(shout_params)
		redirect_to root_path, redirect_options_for(shout)
	end
	def shout_params
		{content: content_from_params}
	end
	def content_from_params
		params[:content_type].new(content_params)
	end

	def content_params
		params.require(:shout).require(:content).permit!
	end
	def redirect_options_for(shout)
		if shout.persisted?
			{notice: "Shout succesfully created!"}
		else
			#debugger
			{alert: "could not shout!!"}
		end
	end
end