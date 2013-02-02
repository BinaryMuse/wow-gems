WoW Gem Finder
==============

This is a web-based tool to find gems in World of Warcraft that match certain criteria. The gem data is provided by the [Community Platform API](http://blizzard.github.com/api-wow-docs/).

Running
-------

(These instructions are for UNIX-like operating systems.)

  1. Ensure you have [Node.js](http://nodejs.org) installed
  2. Install the package dependencies: `npm install`
  3. Start development mode by running: `./scripts/development.sh`
  4. Open `http://localhost:8000/index.html` in your browser

`scripts/development.sh` runs, in addition to the built-in web server, `scripts/compile.sh`, which watches the CoffeeScript files in `app/coffee` and compiles them to JavaScript in `app/js`; `app/index.html` includes these compiled JavaScript files to run the application. If you change a `.coffee` file in `app/coffee`, be sure development mode or `compile.sh` is running so it will recompile the CoffeeScript.

Editing
-------

`app/coffee` contains all the CoffeeScript source for the application. The gem filter itself is defined in `services.coffee`. `app.coffee` defines the routes for the application, and `partials/main.htm` contains the view for the `IndexController` route (the main part of the app).

Don't forget to have `./scripts/development.sh` running to compile the CoffeeScript to JavaScript as you make changes.
