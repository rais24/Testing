module StoresHelper
  def website_bpo_credentials store
    "#{store.store_website}<br />ID: #{store.store_email}<br />Password: #{store.store_password}".html_safe
  end
end
