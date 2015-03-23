require 'spec_helper'

describe 'Order to Excel', type: :feature do
  it 'should download an excel file' do
    admin = create :admin, first: 'first', last: 'last'
    order = create :order, user: admin
    timestamp = order.scheduled_for.strftime('%m-%d-%Y')

    visit order_path(order, as: admin)

    click_link 'Export to XLS'

    expect(page.response_headers['Content-Transfer-Encoding']).to eq 'binary'
    expect(page.response_headers['Content-Type']).to eq 'application/vnd.ms-excel; charset=utf-8;'
    expect(page.response_headers['Content-Disposition']).to eq "attachment; filename='#{timestamp}_first-last.xls'"
    expect(page.source.length).to be > 0
  end
end