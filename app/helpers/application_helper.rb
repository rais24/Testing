module ApplicationHelper
  def user_action
    if current_user.guest?
      "Login"
    else
      "Logout"
    end
  end

  def user_action_path
    if current_user.guest?
      login_path
    else
      logout_path
    end
  end

  def header_link_to(text, url, opts = {})
    content_tag :li, class: active_if_current(url) do
      link_to text, url, opts
    end
  end

  def active_if_current(path)
    request.fullpath.include?(path) ? "active" : ""
  end

  def html_class
    browser = Browser.new(ua: request.user_agent)
    (6..10).map { |v| "ie#{v}" if browser.send("ie#{v}?".to_sym) }.join(" ").strip
  end

  def sortable(klass, column, title = nil)
    title ||= column.titleize
    sorted_column = sort_column(klass)
    direction = "asc"
    css_class = if column == sorted_column
                  "current #{sort_direction}"
                  if sort_direction == "asc"
                    direction = "desc"
                  end
                end

    link_to title, params.merge(sort: column, direction: direction, page: nil), class: css_class
  end

  def tracking?
    Rails.env.production?
  end

  def grid_of_partial(partial, collection = [], columns = 1)
    html = ActiveSupport::SafeBuffer.new

    spans = collection.map do |to_render|
      content_tag :div, class: "span#{12 / columns}" do
        render partial: partial, object: to_render
      end
    end

    spans.each_slice(columns) do |row|
      html << content_tag(:div, row.join.html_safe, class: 'row-fluid')
    end

    html.to_s
  end

  def delivery_time zone
    opts = ""
    zone.valid_times.split(", ").each do |time|
      opts << "<option>#{time}</option>"
    end
    opts.html_safe
  end

  def us_states
      [
        ['Alabama', 'AL'],
        ['Alaska', 'AK'],
        ['Arizona', 'AZ'],
        ['Arkansas', 'AR'],
        ['California', 'CA'],
        ['Colorado', 'CO'],
        ['Connecticut', 'CT'],
        ['Delaware', 'DE'],
        ['District of Columbia', 'DC'],
        ['Florida', 'FL'],
        ['Georgia', 'GA'],
        ['Hawaii', 'HI'],
        ['Idaho', 'ID'],
        ['Illinois', 'IL'],
        ['Indiana', 'IN'],
        ['Iowa', 'IA'],
        ['Kansas', 'KS'],
        ['Kentucky', 'KY'],
        ['Louisiana', 'LA'],
        ['Maine', 'ME'],
        ['Maryland', 'MD'],
        ['Massachusetts', 'MA'],
        ['Michigan', 'MI'],
        ['Minnesota', 'MN'],
        ['Mississippi', 'MS'],
        ['Missouri', 'MO'],
        ['Montana', 'MT'],
        ['Nebraska', 'NE'],
        ['Nevada', 'NV'],
        ['New Hampshire', 'NH'],
        ['New Jersey', 'NJ'],
        ['New Mexico', 'NM'],
        ['New York', 'NY'],
        ['North Carolina', 'NC'],
        ['North Dakota', 'ND'],
        ['Ohio', 'OH'],
        ['Oklahoma', 'OK'],
        ['Oregon', 'OR'],
        ['Pennsylvania', 'PA'],
        ['Puerto Rico', 'PR'],
        ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'],
        ['South Dakota', 'SD'],
        ['Tennessee', 'TN'],
        ['Texas', 'TX'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY']
      ]
  end
end
