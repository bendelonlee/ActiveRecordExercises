# README

This README would normally document whatever steps are necessary to get the
application up and running.

### Ruby version

ruby 2.4.5p335 (2018-10-18 revision 65137) [x86_64-darwin18]


* System dependencies

* Configuration

* Database set up
App database is set up as expected:

`$ rails db:create`
`$ rails db:migrate`
`$ rails db:seed`

Extra prefix for the mock database:

`$ DB=school rails db:create`
`$ DB=school rails db:migrate`
`$ DB=school rails db:seed`
`$ DB=school rails db:test:prepare`


Because the some exercises are id specific, you can't run `$ DB=school rails db:seed` by itself.
Instead run `$ DB=school rails db:{drop,create,migrate,seed,test:prepare}`



for more information: https://github.com/ankane/multiverse


* Running the test suite

`$ bundle exec rspec`

* Credits

  - Database .png powered by https://dbdiagram.io/
  - Favicon credits:

  <a href="https://iconscout.com/icon/ruby-44" target="_blank">Ruby Icon</a> by <a href="https://iconscout.com/contributors/icon-mafia">Icon Mafia</a> on <a href="https://iconscout.com">Iconscout</a>

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
