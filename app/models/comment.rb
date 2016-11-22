class Comment < ApplicationRecord
	# 欄位名稱可以用簡單點 因為一般程式碼會變成 @comment.comment_text
	# 可能都不如@comment.content之類來得好

	# 缺少驗證
	validates_presence_of :comment_text
	belongs_to :event
	belongs_to :user
end

