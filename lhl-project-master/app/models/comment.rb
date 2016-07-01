class Comment < ActiveRecord::Base
	belongs_to :users
	belongs_to :post
	def char_count()
		puts self.content.length
	end
end