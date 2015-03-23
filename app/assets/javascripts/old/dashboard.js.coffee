$ ->
  for week in ['last_week', 'current_week', 'next_week']
    for meal in ['dinners', 'lunches', 'desserts']
      window.setupSly "#{week}_#{meal}"