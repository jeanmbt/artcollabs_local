class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :links, :interests #You can also configure multiple tag types per model
  
end
