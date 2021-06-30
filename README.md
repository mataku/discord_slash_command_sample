# Discord slash command handler sample

with Ruby and sinatra

## Command registration

[Guild command registration sample](/scripts/register_command.rb)

```shell
DISCORD_APPLICATION_ID="123" DISCORD_GUILD_ID="123" DISCORD_BOT_TOKEN="bot_token" bundle exec ruby script/register_command.rb
```

## Startup

Set up a server to handle events from Discord. [bot.rb](/bot.rb) is handling the `POST /discord/events` endpoint, returning a response to the command `/echo`.

```shell
bundle exec rackup config.ru -p PORT_NUMBER
```

## Register your endpoint to app

Go to https://discord.com/developers/applications/{your_app_id}/information

![](/static/interactions_endpoint_url.png)

### Demo

Here is `/echo` outputs.

![](/static/command_sample.gif)
