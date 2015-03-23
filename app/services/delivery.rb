class Delivery
  def self.next(now = Time.now)
    if now.friday?
      now.beginning_of_day
    else
      Chronic.parse('this friday', now: now).beginning_of_day
    end
  end

  def self.cutoff(now = Time.now)
    if now.wednesday?
      now.end_of_day
    else
      Chronic.parse('this wednesday', now: now).end_of_day
    end
  end

  def self.range(now = Time.now)
    date = self.next(now)
    (date.beginning_of_day - 7.days)..date.end_of_day
  end
end