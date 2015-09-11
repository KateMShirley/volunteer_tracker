class UsersModel < ActiveRecord::Base
  self.table_name = 'users'
  has_many :opps
end
