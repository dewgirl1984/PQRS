class User < ActiveRecord::Base
  has_many :qrcodes, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_one :google, :class_name=>"GoogleToken", :dependent=> :destroy

end
