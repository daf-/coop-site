class SwapRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :shift

  def niceDate
    if self.date
      self.date.strftime("%B %-d")
    end
  end
end
