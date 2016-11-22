class User < ApplicationRecord
  # what's this?
  # has_many :questions , ->{ where(["created_at > ?", Time.now - 7.day]).order("id DESC") },  :dependent => :destroy
  # has_many :comments , ->{ where(["created_at > ?", Time.now - 7.day]).order("id DESC") }, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events
  has_many :comments
end
