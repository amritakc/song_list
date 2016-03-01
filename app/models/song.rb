class Song < ActiveRecord::Base
  has_many :faves
  has_many :users, through: :faves
  validates :title, :artist, length: {minimum: 2}

end
