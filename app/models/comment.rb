class Comment < ActiveRecord::Base
  belongs_to :project, inverse_of: :project
  belongs_to :user, inverse_of: :comments
  validates_presence_of :body
end
