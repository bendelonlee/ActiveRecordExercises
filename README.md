# README
### Description
Active Record Exercises is a series of exercises designed to help people learning ActiveRecord, the ORM for Rails.  Users can attempt to complete exercises by running their ActiveRecord queries against our mock database. If stuck they can peek, though they won't be able to 'complete' the exercises for 24 hours. Encouraging users to come back a day later is intended to help them memorize and master ActiveRecord's particular syntax.

### Ruby version

ruby 2.4.5p335 (2018-10-18 revision 65137) [x86_64-darwin18]

# Contribution

Is there an essential feature of ActiveRecord we've missed?
Are you an ActiveRecord buff who'd like to concoct a challenging query?

Submit these and other pull requests and issues here:

https://github.com/bendelonlee/ActiveRecordExercises

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
