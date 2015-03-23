require 'spec_helper'

feature 'Sidekiq Admin' do
  scenario 'authenticated admins have access' do
    user = create :admin

    login user.email, user.password

    visit '/admin/sidekiq'
  end

  scenario 'non-admins are rejected' do
    expect{ visit '/admin/sidekiq' }.to raise_error ActionController::RoutingError
  end
end