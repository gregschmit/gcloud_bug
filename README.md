# GCloud Build Fail Demo

This is like a "Hello World" rails app. You should have RVM installed. To setup,
just `cd` into this directory to have RVM build the gemset (install ruby-2.6.5
if you need to), and then run `bundle install`.

Deploy with `./deploy_to_google_cloud.sh`.

Notice that the cloud build fails. To make it succeed, comment out the last line
in `Gemfile` (active scaffold), and then run `bundle install` again to update
the `Gemfile.lock`, and then deploy. It will succeed. The cloud builder
apparently has some kind of permission problem when installing gems from git
repositories.
