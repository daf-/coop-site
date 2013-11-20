module TimeHelper

  def weekFromToday
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    ret = []
    today = Date.today.wday
    index = 0
    while index < 7
      ret << days[(today + index) % 7]
      index = index + 1
    end
    ret
  end

  def days
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  end

  def calendarTime(datetime)
    datetime.to_time.strftime "%l:%M %p"
  end

  def time_from_select(hour, min, ampm)
    Time.parse(hour+':'+min+ampm).utc
  end
end