# Manage your own cloud deployments online

[![Build
Status](https://travis-ci.org/stanchino/sitefull-cloud-deploy.svg?branch=master)](https://travis-ci.org/stanchino/sitefull-cloud-deploy)
[![Code
Climate](https://codeclimate.com/github/stanchino/sitefull-cloud-deploy/badges/gpa.svg)](https://codeclimate.com/github/stanchino/sitefull-cloud-deploy)
[![Test
Coverage](https://codeclimate.com/github/stanchino/sitefull-cloud-deploy/badges/coverage.svg)](https://codeclimate.com/github/stanchino/sitefull-cloud-deploy/coverage)
[![Issue
Count](https://codeclimate.com/github/stanchino/sitefull-cloud-deploy/badges/issue_count.svg)](https://codeclimate.com/github/stanchino/sitefull-cloud-deploy)

A [Rails](http://rubyonrails.com) application for automating your cloud
deployments using
[Cloud-Init](https://cloudinit.readthedocs.org/en/latest/)

Contributing
============
This section is the first section in the readme because everyone who contributes code must follow the Passare way. Make sure you understand the process we used to make changes to our code base before even setting up your development environment.

Recommended Dev Box
-------------------

### When using a Mac:
 * Latest Xcode with command line tool installed
* [Hombrew](http://mxcl.github.com/homebrew/)
* [Janus](https://github.com/carlhuda/janus)
* [iTerm](http://www.iterm2.com/#/section/home)
* [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)

Prerequisites
-------------
 * [MySQL](http://dev.mysql.com/doc/refman/5.7/en/installing.html) database or equivalent ([MariaDB](https://downloads.mariadb.org/), [Percone](https://www.percona.com/software/mysql-database/percona-server), etc.)
 * [RVM](https://rvm.io) installed as described [here](https://rvm.io/install)
 * [PhantomJS](http://phantomjs.org/)
   [installed](http://phantomjs.org/download.html) to run the feature
tests

Project Set Up
-------------

 * Download the project code from [GitHub](https://github.com/stanchino/sitefull-cloud-templates)
```
# git clone git@github.com:stanchino/sitefull-cloud-templates.git
```
 * Install [Ruby](https://www.ruby-lang.org/)
```
# cd sitefull-cloud-templates
# rvm install ruby-2.3.0
```
 * Install [bundler](http://bundler.io/#getting-started)
```
# gem install bundler
```
 * Install [third party](#third-party) dependencies
```
# bundle install
```
 * Initialize the development and test databases
```
# rake db:create db:schema:load
# rake db:create db:test:prepare RAILS_ENV=test
```
 * **Optional**: Seed the database with sample data
```
# rake db:seed
```
 * Install the [foreman](http://ddollar.github.io/foreman/) Procfile-base manager
```
# gem install foreman
```
 * Start the server
```
# foreman start
```

Testing
-------
The following tools are used for testing the application:
  * [Rspec](http://rspec.info/) as the testing framework
  * [Capybara](http://jnicklas.github.io/capybara/) for features tests

To run all the tests execute
```
# rake spec
```

The tests are split into three groups: unit tests, integration tests and
feature tests. Each one can be executed using the following commands:
```
# rake spec:unit
# rake spec:integration
# rake spec:feature
``` 

The application use [simplecov](https://github.com/colszowka/simplecov)
to generate code coverage statistics. It is available in the `coverage/`
directory. The goal is to maintain the code coverage **for each** of the
*unit*, *integration* and *feature* test suites at **100%** so be
carefull when adding new features.

## Third Party Modules

The application uses the following languages to simplify our lives:
  * [Slim Template Engine](http://slim-lang.com/) for templates
  * [CoffeeScript](http://coffeescript.org/) that compiles to JavaScript
  * [Sass](http://sass-lang.com/) as the underlying CSS framework

And some thrid party tools which are useful for creating a good looking user experience:
  * [Bootstrap](http://getbootstrap.com/)
  * [FontAwesome](https://fortawesome.github.io/Font-Awesome/)
  * [jQuery](https://jquery.com/)

The full list of modules added to the `Gemfile` is:
  * [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner) Cleans up the database when running the specs
  * [bootstrap-sass](https://github.com/twbs/bootstrap-sass) Allows for
    integrating the [Bootstrap](http://getbootstrap.com) framework
  * [cancancan](https://github.com/CanCanCommunity/cancancan) A very
    good authorization module
  * [capybara](https://github.com/jnicklas/capybara) To write feature
    tests
  * [capybara-email](https://github.com/dockyard/capybara-email) To open email messages when running feature
    tests
  * [capybara-screenshot](https://github.com/mattheworiordan/capybara-screenshot) Creates screenshots when feature tests are failing
  * [codeclimate-test-reporter](https://github.com/codeclimate/ruby-test-reporter) Generates [CodeClimate](https://codeclimate.com/) reports for the code quality and test coverage
  * [devise](https://github.com/plataformatec/devise) For authenticating
    users
  * [dotenv-rails](https://github.com/bkeepers/dotenv) loads environment variables from the `.env` file on
    `development`
  * [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails) To simplify object creation
  * [faker](https://github.com/stympy/faker) Useful for generating
    random data especially when used in specs
  * [font-awesome-rails](https://github.com/bokmann/font-awesome-rails)
    Awesome icons
  * [jbuilder](https://github.com/rails/jbuilder) Building JSON
    responses in a more efficient way
  * [jquery-rails](https://github.com/rails/jquery-rails) Adds jQuery to
    the application
  * [letter_opener](https://github.com/ryanb/letter_opener) To avoid
    sending email messages when running in `development` mode
  * [mysql2](https://github.com/brianmario/mysql2) For establishing
    database connections
  * [poltergeist](https://github.com/teampoltergeist/poltergeist) Use Poltergeist for feature specs
  * [quiet_assets](https://github.com/evrone/quiet_assets) To skip
    logging assets and polluting the logs
  * [rspec-rails](https://github.com/rspec/rspec-rails) The testing
    framework
  * [rspec-collection_matchers](https://github.com/rspec/rspec-collection_matchers) Usefull for matching collections in your specs
  * [rspec-activemodel-mocks](https://github.com/rspec/rspec-activemodel-mocks) Allows for mocking ActiveModel objects in specs
  * [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
    Simplify writing tests big time as discussed on the official
[shoulda matchers](http://matchers.shoulda.io/) page
  * [simple_form](https://github.com/plataformatec/simple_form) For
    handling forms
  * [simplecov](https://github.com/colszowka/simplecov) Generates code
    coverage reports when running the specs
  * [slim](https://github.com/slim-template/slim) The template engine
  * [slim-rails](https://github.com/slim-template/slim-rails) Rails
    implementation of the [Slim](http://slim-lang.org) template engine
  * [unicorn](http://unicorn.bogomips.org/) To run the application
    server
