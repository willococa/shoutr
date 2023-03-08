class UsersController < Clearance::UsersController
	def show
		@user = User.find_by(username: params[:id])
		@timeline = Timeline.new([@user])
	end

	def new
		@user =  User.new
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end
end
