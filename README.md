# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Ruby version

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

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
