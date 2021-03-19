Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:4000/*'

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             credentials: true
  end

  # 本番環境用のオリジン設定
  allow do
    origins 'https://coacher-app.work'

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             credentials: true
  end
end
