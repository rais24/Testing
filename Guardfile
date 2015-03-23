# A sample Guardfile
# More info at https://github.com/guard/guard#readme

interactor :off

guard 'bundler' do
  watch('Gemfile')
end

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(scss|coffee|haml)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
end

guard 'rspec', zeus: true, bundler: false do
  # uses the .rspec file
  # --colour --fail-fast --format documentation --tag ~slow

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                               { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.slim)$})                     { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})      { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/features/#{m[1]}_spec.rb"] }
  watch(%r{^app/workers/(.+)\.rb$})                       { |m| "spec/workers/#{m[1]}_spec.rb" }
  watch(%r{^lib/routing/(.+)\.rb$})                       { |m| "spec/lib/routing/#{m[1]}_spec.rb" }
  watch(%r{^app/models/concerns/(.+)\.rb$})               { "spec/models" }
  watch(%r{^app/controllers/concerns/(.+)\.rb$})          { "spec/controllers" }
  watch(%r{^app/services/(.+)\.rb$})                      { |m| "spec/services/#{m[1]}_spec.rb" }
  watch(%r{^spec/factories/(.+)\.rb$})                    { |m| "spec/models/#{m[1]}_spec.rb" }
  watch('config/routes.rb')                               { "spec/routing" }
  watch('app/controllers/application_controller.rb')      { "spec/controllers" }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/features/#{m[1]}_spec.rb" }
end