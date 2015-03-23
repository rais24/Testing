require 'chronic'

class Upcoming
  
  def initialize(now = Time.now)
    @now = now
  end

  def delivery
    Chronic.parse 'Thursday 5:00 PM', now: @now
  end

  def billing
    Chronic.parse 'Tuesday 12:00 AM', now: @now
  end
end