# Site Mocks

venture_f0rth = DeliverySite.create! name: "Venturef0rth", promo_code: "f0rth",
                               street: "417 N. 8th St.", city: "Philadelphia", state: "PA", zip: "19123",
                               logo: File.open(Rails.root.join('public', 'seed', 'venturef0rth.png'))

penn_med = DeliverySite.create! name: "Penn Medicine", promo_code: "penn-rad",
                               street: "123 Market St.", city: "Philadelphia", state: "PA", zip: "19123",
                               logo: File.open(Rails.root.join('public', 'seed', 'penn.jpg'))

# admin account
admin = venture_f0rth.users.create! email: "admin@fitly.org", password: "passw0rd", 
                                    password_confirmation: "passw0rd", zipcode: "19123",
                                    role: :admin, active: true, locked: false,
                                    first: 'Fitly', last: 'Admin', adults: 2, children: 3

customer = Stripe::Customer.create(description: "Admin Test Account", email: admin.email, card: {
  number: "4242424242424242", exp_month: 1, exp_year: 1.year.from_now.year  
})

Billing.merge!(customer: customer, billing: admin.build_billing)

penn_med.users.create! email: 'ineligible@fitly.org', active: false, locked: true,
                       password: 'password1', password_confirmation: 'password1',
                       first: 'Not', last: 'Eligible', adults: 2, children: 3, zipcode: "19123"