class Project < ActiveRecord::Base
  has_many :projectmembers
  has_many :users, through: :projectmembers, inverse_of: :projects
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :completion_status
  validates_numericality_of :completion_status, greater_than_or_equal_to: 0, less_than_or_equal_to: 100
  acts_as_votable
end
