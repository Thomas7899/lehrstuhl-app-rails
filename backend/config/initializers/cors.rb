Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Erlaubte Origins: Lokal + Vercel Production
    origins(
      'http://localhost:5173',                    # Vue Dev Server
      'http://localhost:4173',                    # Vue Preview
      'https://lehrstuhl-frontend.vercel.app',    # Vercel (anpassen nach Deployment!)
      /https:\/\/.*\.vercel\.app/                 # Alle Vercel Preview Deployments
    )
    
    resource '*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options],
      expose: ['Authorization'],
      credentials: true
  end
end
