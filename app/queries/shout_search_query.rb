class ShoutSearchQuery
	def initialize(term:)
		@term  = term
	end

	def to_relation
		matching_shouts_for_text_shouts.
			or(matching_shouts_for_photo_shouts)
	end
	private
	attr_reader :term	
	def matching_shouts_for_text_shouts
		# before we where doing an sql like this
		# Shout.joins("LEFT JOIN text_shouts ON content_type = 'TextShout' AND content_id = text_shouts.id").
		# 	where("text_shouts.body LIKE ?", "%#{term}%")		
		# but once added the matching_shouts_for_photo_shouts method the query stops working 
		# because this join cant be used in both "or" sides, as both don-t match in their join statements
		# and they have to for an or query, so the code is changed as to below for both  queries to match 
		Shout.where(content_type: "TextShout", content_id: matching_text_shouts.select(:id))
	end
	def matching_text_shouts
		TextShout.where("body LIKE ?", "%#{term}%")
	end
	def matching_shouts_for_photo_shouts
		Shout.where(content_type: "PhotoShout", content_id: matching_photo_shouts.select(:id))
	end

	def matching_photo_shouts
		PhotoShout.joins(:image_blob).where("active_storage_blobs.filename LIKE ?", "%#{term}%")
		# PhotoShout.where(ActiveStorage::Blob.arel_table["filename"].matches("%#{term}%")).to_sql
	end
end