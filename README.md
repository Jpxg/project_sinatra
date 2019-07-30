# The gossip project

> Ruby / Sinatra app - LS

Execute `$ shotgun` to run a server for the App

See inline comments in the code to get app documentation

The gossip project is a platform where you can post and edit gossips, and comment each of them.

### credits

Loïc STEINMETZ

## MVC architecture

### Models

> from lib/

**Gossip**

- \# author => string
- \# content => string
- \# initialize
- \# save
- \# update
- :: all => array
- :: find => array
- :: delete_at

**Comment**

- \# gossip_id => string
- \# author => string
- \# content => string
- \# save
- :: all_for_gossip => array
- :: delete_at

### Controler

> from lib/

**Rooting :**

- / => index
- /gossips/new => new_gossip - to create a gossip
- /gossip/new (post) => create a gossip
- /gossips/:id => show.erb - show the gossip
- /gossips/:id/edit => to edit a gossip
- /gossips/:id/edit (post) => edit a gosip
- /gossips/:id/delete => delete the gossip
- /gossips/:id/update => update the gossip
- /gossips/:id/comment => add a comment

### Views

> from lib/views/

- index
- new_gossip
- show
- edit

### Database

> from db/

CSV files : 

- Gossip
- Comment

## Gemfile

```
ruby '2.5.1'
source 'https://rubygems.org'
gem 'pry'
gem 'rubocop'
gem 'shotgun'
gem 'sinatra'
```