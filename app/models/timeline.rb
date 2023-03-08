class Timeline
	def initialize(users)
		@users = users 	
	end

	def shouts
		Shout.where(user_id: users).
  			order(created_at: :desc)#this removes the default_scope {order(created_at: :desc)} in shouts model
	end

	private
	attr_reader :users
end