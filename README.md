# Steven [![Build Status](https://travis-ci.org/laurenball/Steven.svg?branch=develop)](https://travis-ci.org/github/laurenball/Steven)
---
*with a 'v'*  

Discord bot for morale improvement.
### Usage
---
1. Install ruby 2.6.0
2. Fork the repo
3. Clone the fork
4. Use [bundler](https://bundler.io/) to install dependencies with `bundle install`
5. Create a Discord bot and enter tokens in `.env` (reference `data/example.env` for required fields)
 - [How to create a Discord bot and create an ID and token](https://github.com/reactiflux/discord-irc/wiki/Creating-a-discord-bot-&-getting-a-token)
6. Run `ruby start.rb` in the project root
7. Follow the provided link to invite Steven to your server

### Features
---
#### Hooks
- User-specific interaction:
  - Follows owner-selected users and occasionally showers them with praise
- General interaction:
  - Listens for 'hello' and 'bye' and responds accordingly
  - Listens for Users mention

#### Owner-only commands
Can only be performed by the user designated as `:owner_id` in config.yml, which is set in Steven's initialization
- User management:  
  - `!addaction affirm [user_id]` tracks user to receive occasional affirmation
  - `!addaction haze [user_id]` configures already tracked user to receive lighthearted hazing
  - `!savedata` dumps all user data into `user_data.yml`  
  - `!help` general help on the bot
  - `!display` displays user info and current configuration
  - `!removeaction [user_id]` removes given user (Owner only action)

#### Contributing
---
Check out [CONTRIBUTING.md](https://github.com/laurenball/Steven/blob/master/CONTRIBUTING.md) for those sweet sweet deets
