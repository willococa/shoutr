module ShoutHelper
	def avatar(user)
		email_digest = Digest::MD5.hexdigest(user.email)
		gravatar_url ="//www.gravatar.com/avatar/#{email_digest}"
		image_tag(gravatar_url)
	end
	def like_button(shout)
		if current_user.liked?(shout)
			button_to "Unlike", unlike_shout_path(shout), method: :delete  
		else
			button_to("Like", like_shout_path(shout) , method:  :post)
		end
	end
end