module ApplicationHelper

  require 'open-uri'



  def url(buffer)
    buffer = URI::encode(buffer.downcase)
    buffer = buffer.gsub('+', 'plus')
    buffer = buffer.gsub('%C3%B6', 'oe')

    return buffer
  end

end
