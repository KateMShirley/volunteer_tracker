class OppsModel < ActiveRecord::Base
  self.table_name = 'opps'
  belongs_to :user
end
