Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://www.devcamp.space'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end

  allow do
    origins 'https://devcamp.space'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end

  allow do
    origins(/\Ahttps?:\/\/([a-zA-Z\d-]+\.){0,}localhost:\d*\/?\z/)
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end

  allow do
    origins do |origin|
      ClientDomain.all.pluck(:url).include?(origin)
    end
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end

  allow do
    origins(/https?:\/\/[\S]+/)
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end
