## Discord slash command sample

with Ruby and sinatra

https://discord.com/developers/docs/interactions/slash-commands

### Command registration

[Guild command registration sample](https://github.com/mataku/discord_slash_command_sample/blob/develop/scripts/register_command.rb)

```shell
DISCORD_APPLICATION_ID="123" DISCORD_GUILD_ID="123" DISCORD_BOT_TOKEN="bot_token" bundle exec ruby script/register_command.rb
```

### Startup

Set up a server to handle events from Discord

```shell
bundle exec rackup config.ru -p PORT_NUMBER
```

