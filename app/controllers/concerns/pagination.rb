module Pagination

  # Public: handles creating pagination arguments
  #
  # from     - Optional Hash to pull pagination parameters from
  #            :page     - the page number to start paginating from
  #            :per_page - the per_page of records to return per page
  #
  # page     - Optional page Number to fallback to, defaults to 0
  # per_page - Optional per_page Number to fallback to, defaults to 0
  #
  def pagination(from: nil, page: 1, per_page: 10)
    arguments = from || params
    # create the pagination arguments
    {
      page: arguments.fetch(:page, page).to_i,
      per_page: arguments.fetch(:per_page, per_page).to_i
    }
  end
end