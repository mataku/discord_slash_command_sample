require 'ed25519'
require 'json'
require 'sinatra/base'

class API < Sinatra::Base
  def initialize(app = nil)
    super()
    @verification_key ||= Ed25519::VerifyKey.new([ENV['DISCORD_PUBLIC_KEY']].pack('H*'))
  end

  post '/discord/events' do
    headers = request.env.select { |k, _| k.start_with?('HTTP_') }
    timestamp = headers['HTTP_X_SIGNATURE_TIMESTAMP']
    signature_hex = headers['HTTP_X_SIGNATURE_ED25519']
    signature = [signature_hex].pack('H*')

    request.body.rewind
    request_data = request.body.read

    # https://discord.com/developers/docs/interactions/slash-commands#security-and-authorization
    # If verification failed, respond with a 401 error code.
    @verification_key.verify(signature, timestamp + request_data)
    
    body = JSON.parse(request_data)
    type = body['type']
    content_type :json

    # https://discord.com/developers/docs/interactions/slash-commands#receiving-an-interaction
    if type == 1
      { type: 1 }.to_json
    else
      # Handle command
      
      # Return Interaction Response object
      # https://discord.com/developers/docs/interactions/slash-commands#responding-to-an-interaction
      # type:  https://discord.com/developers/docs/interactions/slash-commands#interaction-response-object-interaction-callback-type
      # data structure: https://discord.com/developers/docs/interactions/slash-commands#interaction-response-object-interaction-application-command-callback-data-structure
      command = body['data']['name']
      if command == 'echo'
        option = body['data']['options'].find { |option| option['name'] == 'text' }
        text = option['value']
        {
          type: 4,
          data: {
            tts: false,
            content: text,
            embeds: [],
            allowed_mentions: { parse: [] }
        }
      }.to_json
      end
    end
  rescue Ed25519::VerifyError => e
    status 401
  end
end
