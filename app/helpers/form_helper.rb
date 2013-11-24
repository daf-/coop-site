module FormHelper

  def tag_hours(time)
    ret = ''
    (1..12).each do |x|
      if time && (x == time.localtime.strftime("%l").to_i)
        ret << "<option selected>#{x}</option>"
      else
        ret << "<option>#{x}</option>"
      end
    end
    ret
  end

  def tag_minutes(time)
    ret = ''
    (0..11).each do |x|
      min = "#{x/2}#{(x%2)*5}"
      if time && (min.to_i == time.localtime.strftime("%M").to_i)
        ret << "<option selected>#{min}</option>"
      else
        ret << "<option>#{min}</option>"
      end
    end
    ret
  end

  def am_pm(time)
    ret = ''
    if time && (time.localtime.strftime("%p") == 'AM')
      ret = "<option selected>AM</option><option>PM</option>"
    else
      ret = "<option>AM</option><option selected>PM</option>"
    end
  end
end