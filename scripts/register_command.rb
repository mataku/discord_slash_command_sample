require 'net/http'
require 'json'

url = "https://discord.com/api/v8/applications/#{ENV['DISCORD_APPLICATION_ID']}/guilds/#{ENV['DISCORD_GUILD_ID']}/commands"

params = {
  name: 'echo',
  description: 'echo',
  options: [
    {
      name: 'text',
      description: 'text to display',
      type: 3, # string
      required: true
    }
  ]
}

header = {
  'Authorization' => "Bot #{ENV['DISCORD_BOT_TOKEN']}",
  'Content-Type' => 'application/json'
}

uri = URI.parse(url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Post.new(uri.path)
request.body = params.to_json
request.initialize_http_header(header)

request = http.request(request)

unless request.is_a? Net::HTTPSuccess
  raise StandardError, request.body
end
