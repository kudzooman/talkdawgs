class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  mount_uploader :images, PostUploader

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 10 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
