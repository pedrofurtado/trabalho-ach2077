# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.precompile += %w(*.png)


Rails.application.config.assets.precompile += %w(@fortawesome/fontawesome-free/webfonts/*.eot @fortawesome/fontawesome-free/webfonts/*.svg @fortawesome/fontawesome-free/webfonts/*.ttf @fortawesome/fontawesome-free/webfonts/*.woff @fortawesome/fontawesome-free/webfonts/*.woff2)
Rails.application.config.assets.precompile += %w(bootstrap/dist/fonts/*.eot bootstrap/dist/fonts/*.svg bootstrap/dist/fonts/*.ttf bootstrap/dist/fonts/*.woff bootstrap/dist/fonts/*.woff2)
