class Project < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable
  has_attached_file :resource1, removable: true
  has_attached_file :resource2, removable: true
  has_attached_file :resource3, removable: true
  has_attached_file :resource4, removable: true
  has_attached_file :resource5, removable: true
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  has_many :projectmembers
  has_many :users,
    through: :projectmembers
  has_many :comments
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :completion_status
  validates_numericality_of :completion_status, greater_than_or_equal_to: 0, less_than_or_equal_to: 100

  def self.search(search)
    if search
      Project.includes(:tags).where('tags.name ILIKE ? OR projects.title ILIKE ?',"%#{search}%", "%#{search}%").references(:tags)
    else
      scoped
    end
  end

end
