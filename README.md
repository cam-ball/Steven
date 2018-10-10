# Steven
---
*with a 'v'*  

General purpose Discord bot for morale improvement.

### Usage
---
1. Install ruby 2.4.1
2. Fork the repo
3. Clone the fork
4. Use [bundler](https://bundler.io/) to install dependencies with `bundler install`
5. Run `ruby start.rb` in the project root
6. Follow the instructions to configure Steven and create the environment files
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
 - `!addaction affirm [user_id]` tracks user to receive occasional affirmation
 - `!addaction haze [user_id]` configures already tracked user to receive lighthearted hazing
 - `!savedata` dumps all user data into `user_data.yml`  

#### Contributing
---
Check out [CONTRIBUTING.md](https://github.com/laurenball/Steven/blob/master/CONTRIBUTING.md) for those sw33t sw33t d33ts
