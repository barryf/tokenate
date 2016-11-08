class Tokenate < Sinatra::Application

  configure do
    set :server, :puma
    use Rack::SSL unless settings.development?

    secret = ENV['COOKIE_SECRET'] || Random.new_seed.to_s
    use Rack::Session::Cookie, secret: secret, expire_after: 2_592_000
  end

  get '/' do
    erb :index
  end

  get '/auth' do
    session[:state] = Random.new_seed.to_s
    session[:token_endpoint] = params[:token_endpoint]
    session[:scope] = params[:scope]
    session[:me] = params[:me]

    qs = URI.encode_www_form({
      me: params[:me],
      client_id: base_url,
      state: session[:state],
      scope: session[:scope],
      redirect_uri: "#{base_url}auth/callback"
    })

    redirect "#{params[:authorization_endpoint]}?#{qs}"
  end

  get '/auth/callback' do
    response = HTTParty.post(
      session[:token_endpoint],
      body: {
        me: params[:me],
        code: params[:code],
        redirect_uri: "#{base_url}auth/callback",
        client_id: base_url,
        state: session[:state],
        scope: session[:scope]
      })
    response_hash = CGI.parse(response.parsed_response)
    @token = response_hash['access_token'].first
    @scope = session[:scope]
    erb :token
  end

  def base_url
    @base_url ||=
      "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}/"
  end

end
