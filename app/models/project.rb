class Project < ActiveRecord::Base
  has_many :users
  has_many :user, through: :projectmembers
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :completion_status
  validates_numericality_of :completion_status, greater_than_or_equal_to: 0, less_than_or_equal_to: 100
end
