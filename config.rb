require 'zurb-foundation'

page 'robots.txt', layout: false
page 'humans.txt', layout: false

set :css_dir, 'stylesheets'
set :images_dir, 'images'
set :js_dir, 'javascripts'

activate :livereload

compass_config do |config|
  config.output_style = :compact
end

configure :build do
  require 'middleman-smusher'
  activate :minify_javascript
  activate :relative_assets
  activate :smusher
  activate :directory_indexes
end
