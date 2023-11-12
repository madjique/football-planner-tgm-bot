### Requirements
```ruby >= 2.6```

```bundle (bundler)```

# Getting Started

Put this variables in your `.env` file
```bash
FMP_BOT_TOKEN=YOUR_BOT_TOKEN
GROUP_CHAT_ID=YOUR_GROUP_ID
ADMINS=['username1','username2']
```

### Install requirements
```bash
bundle
```

#### launch the boy locally
```bash
ruby runner.rb
```

#### Using Docker 

```bash
docker run -e FMP_BOT_TOKEN=YOUR_BOT_TOKEN --name football-planner-tgm-bot football-planner-tgm-bot
```

All set ✅


# Customize your Bot for your own telegram group channel

in ```runner.rb```

```ruby
group_chat_id = # Put your group channel id
admin_list = ['johndoe','coffiCodjia'] # Put your admin's usernames
```

* You can also rewrite the strings to your prefered language

### Commands
* ```/hello``` - Say Hello 
* ```/showlist``` - Show the list
* ```/addme``` - Add me to the game list
* ```/cancelme``` - Delete me from game list
* ```/confirm``` - Confirm pending player by himself 
* ```/beginmatch``` - Reset the list (admin)
* ```/players``` - Show all players who joined at least one game (admin)
* ```/open_registrations``` - Open the list (admin)
* ```/close_registrations``` - Close the list (admin)
* ```/load_players``` - Load players into a game (admin) ... beta
* ```/next_pending``` - Forward to next in waiting list manually (admin)
* ```/cancel_pending``` - Cancel pending player manually (admin)
* ```/log``` - log into console (admin)

