# Steven
---
*with a 'v'*  
  
General purpose Discord bot for morale improvement.

### Usage
---
1. Install ruby 2.4.1
2. Fork the repo
3. Clone the fork
4. Run `ruby start.rb` in the project root
5. Follow the instructions to configure Steven and create the environment files
 - [How to create a Discord bot and create an ID and token](https://github.com/reactiflux/discord-irc/wiki/Creating-a-discord-bot-&-getting-a-token)

### Features
---
#### Hooks
- User-specific interaction:
 - Follows owner-selected users and occasionally showers them with praise
- General interaction:
 - Listens for 'hello' and 'bye' and responds accordingly
 - Defends his honor against anyone who is a 'dum bitch'

#### Owner-only commands
Can only be performed by the user designated as `:owner_id` in config.yml, which is set in Steven's initialization
- User management:  
 - `!adduser [user_id]` adds a user to whitelisted users list
 - `!addaction [user_id] affirm` configures already tracked user to receieve occasional affirmation
 - `!savedata` dumps all user data into `user_data.yml`  

#### Contributing
---
Check out [CONTRIBUTING.md](https://github.com/laurenball/Steven/blob/master/CONTRIBUTING.md) for those sweet sweet deets
