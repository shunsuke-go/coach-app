if Rails.env.production?
  Rails.application.config.session_store :cookie_store, key: '_coach-app', domain: 'coacher-app.work'
else
  Rails.application.config.session_store :cookie_store, key: '_coach-app', domain: 'localhost:4000'
end
