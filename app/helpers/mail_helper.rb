module MailHelper
  FROM = "The Fitly Family <contact@fitly.org>"
  SERVICE = 'service@fitly.org'

  include SocialMedia::UrlHelpers
  include Nutrition::References::UrlHelpers

  CELL_PADDING  = 10
  CORNER_WIDTH  = 20
  CORNER_HEIGHT = 20
  FULL_WIDTH    = 600
  WIDTH = FULL_WIDTH - (2 * CELL_PADDING)

  def corner_width
    px(CORNER_WIDTH)
  end

  def corner_height
    px(CORNER_HEIGHT)
  end

  def filler_width
    px(WIDTH - (2 * CORNER_WIDTH))
  end

  def filler_height
    corner_height
  end

  def full_width
    px(FULL_WIDTH)
  end

  def width
    px(WIDTH)
  end

  def cellpadding
    px(CELL_PADDING)
  end

  private
    def px(value)
      "#{value}px"
    end
end