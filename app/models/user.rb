class User < ActiveRecord::Base
  acts_as_voter
  acts_as_tagger
  acts_as_taggable
  acts_as_taggable_on :projects
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }, removable: true

  has_many :projectmembers
  has_many :projects,
    through: :projectmembers
  has_many :comments, inverse_of: :user

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :age
  validates_presence_of :state

  validates :first_name, format: { with: /\A[a-z]+\z/i }
  validates :last_name, format: { with: /\A[a-z]+\z/i }
  validates_numericality_of :age, greater_than: 0
  validates :state, format: { with: /\A[a-z]{2}\z/i }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
