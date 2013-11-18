module FormHelper

  def tag_hours
    ret = ''
    (1..12).each do |x|
      ret << "<option>#{x}</option>"
    end
    ret
  end

  def tag_minutes
    ret = ''
    (0..11).each do |x|
      ret << "<option>#{x/2}#{(x%2)*5}</option>"
    end
    ret
  end
end