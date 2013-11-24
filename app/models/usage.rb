class Usage < ActiveRecord::Base
  establish_connection "usage_#{Rails.env}"
end
