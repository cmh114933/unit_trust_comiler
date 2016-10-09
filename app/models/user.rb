class User < ActiveRecord::Base
  include Clearance::User
  has_many :unit_trusts

end
