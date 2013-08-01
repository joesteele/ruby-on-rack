# Ruby on Rack

## A super simple MVC web app built with Rack

This is a Rack demo app to show how quickly you can take the simple concepts of Rack and build upon them to create something more powerful.

This demo was created as part of a Rack talk I gave on [July 18, 2013](http://www.meetup.com/tampa-rb/events/125327762/) for the local Ruby meetup group, [Tampa Ruby Brigade](http://www.meetup.com/tampa-rb). The slides that went with the talk live at [joesteele/rack-talk](https://github.com/joesteele/ruby-on-rack).

## Demo Progression

To see the different stages of progression, checkout tags `mvc-1` through `mvc-4` to go from the initial super simple Rack example to the final example, which is represented in the master branch.

## About the Demo

The app is a super simple example of authenticating via GitHub OAuth and showing the user's profile. The basic goals of the app don't change between tags, but we start with a super simple Rack example and build upon Rack concepts to end up with a miniature Rails-inspired MVC framework using just Rack (well except for the [erubis](https://github.com/genki/erubis) and [omniauth-github](https://github.com/intridea/omniauth-github) gems :P)

### Some features built and demonstrated along the way

- Rack middleware
- Mounted Rack apps
- Static assets
- OAuth authentication
- User sessions
- Template rendering
- Routing

## Running the Demo

In order to run the demo, you'll need to [register an application with GitHub here](https://github.com/settings/applications/).

Once you have registered, you'll need to copy `Client Id` and `Client Secret` for your newly registered application an put them in a `.env` file in the root folder of your demo app. The keys for the values used in the .env file should be `GITHUB_KEY` and `GITHUB_SECRET` like so:

#### .env
```
GITHUB_KEY=<Your Client Id>
GITHUB_SECRET=<Your Client Secret>
```

From there, `bundle install` the gems and `rackup` to start the server.
