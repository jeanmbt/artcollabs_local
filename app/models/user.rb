class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :interests #You can also configure multiple tag types per model

  has_one_attached :avatar
  has_many_attached :photos
  has_many :links, dependent: :destroy

  has_many :collaborations, dependent: :destroy
  has_many :projects, dependent: :destroy

  def collaborator?
    # if current user is a collaborator for this project return true
  end
end
