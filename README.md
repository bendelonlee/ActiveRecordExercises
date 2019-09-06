# README

This README would normally document whatever steps are necessary to get the
application up and running.

### Ruby version

ruby 2.4.5p335 (2018-10-18 revision 65137) [x86_64-darwin18]

# Database set up

Databases are Postgresql. The multiverse gem is used so that the main app is in a separate database from the one the user runs queries on.

To set up app databases run:

```
rails db:{create,migrate,seed,test:prepare}
```

`test:prepare` is necessary because of the way rspec and multiverse interact.

You'll also need to set up the 'school' database, the one that the user runs queries on:

`$ DB=school rails db:{create,migrate,seed,test:prepare}`

Because the some exercises are id specific, you can't run `$ DB=school rails db:seed` by itself.
Instead run `$ DB=school rails db:{drop,create,migrate,seed,test:prepare}`

for more information on the multiverse gem: https://github.com/ankane/multiverse

* Running the test suite

`$ bundle exec rspec`

* Credits

  - Database .png powered by https://dbdiagram.io/
  - Favicon credits:

  <a href="https://iconscout.com/icon/ruby-44" target="_blank">Ruby Icon</a> by <a href="https://iconscout.com/contributors/icon-mafia">Icon Mafia</a> on <a href="https://iconscout.com">Iconscout</a>

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
