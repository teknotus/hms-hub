class Notifier < ActiveRecord::Base
  has_many :notifications

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 7 }
  validates :timezone, :presence => true

end
