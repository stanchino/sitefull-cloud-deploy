module ProviderDecorators
  class Google
    def options
      { client_id: ENV['GOOGLE_CLIENT_ID'], client_secret: ENV['GOOGLE_CLIENT_SECRET'] }
    end
  end
end
