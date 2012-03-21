class User < ActiveRecord::Base
  has_many :qrcodes, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_one :google, :class_name=>"GoogleToken", :dependent=> :destroy
	
	def name
		"#{first_name} #{last_name}"
	end

	def to_s
		"id:'#{id}',uuid:'#{uuid}',email:'#{email}',created_at:'#{created_at}',updated_at:'#{updated_at}',first_name:'#{first_name}',last_name:'#{last_name}'"
	end
end
