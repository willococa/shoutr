class Timeline

	def initialize(users, scope = Shout ) 
		@users = users
		@scope = scope 	
	end
	# next are 2 ways of doing the same thing in order to be...
	# ..to :automatically load a partial when this class object is rendered in a view
	# include ActiveModel::Conversion
	# or...
	def to_partial_path
		"timelines/timeline"
	end

	def shouts
		scope.where(user_id: users).
  			order(created_at: :desc)#this removes the default_scope {order(created_at: :desc)} in shouts model
	end

	private
	attr_reader :users
	attr_reader :scope
end