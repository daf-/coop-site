class User < ActiveRecord::Base
  has_many :swap_requests
	validates_uniqueness_of :email

	def coopName
		if self.coop_id
			Coop.find(self.coop_id).name
		end
	end

	def coopName=(name)
    @coop = Coop.find_or_create_by name: name
    self.coop_id = @coop.id
  end
end
