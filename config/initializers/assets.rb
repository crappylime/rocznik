# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile +=
  %w( phantom_js_bind_polyfill.js fallback/person.png pl.png gb.png remind_icon.png )
Rails.application.config.assets.precompile +=
  %w( disable-transitions-for-test-env.css storytime/storytime-logo-nav.png)

