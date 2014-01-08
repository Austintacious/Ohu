class Project < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable
  has_many :projectmembers
  has_many :users, through: :projectmembers, inverse_of: :projects
  has_many :comments
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :completion_status
  validates_numericality_of :completion_status, greater_than_or_equal_to: 0, less_than_or_equal_to: 100
end
