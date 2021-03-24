if Rails.env.production?
  Rails.application.config.session_store :cookie_store, key: '_coach-app', domain: 'coacher-app.vercel.app'
else
  Rails.application.config.session_store :cookie_store, key: '_coach-app'
  Rails.application.config.api_only = false
end
