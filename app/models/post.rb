class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user

  default_scope { order('created_at DESC') }
end
