# Contacts Importer

Simple Ruby On Rails app that allows custom mapping and importing of contacts through CSV files into the database.

## TODOS

- Navigation: Rightnow there's minimal UI due to I focused on backend only, so u need to browse the different routes to nav the app, check for `rake routes` to browse the available routes.
- Styling: Add bootstrap library to add some decent styling to the UI.
- User Authentication: Add user authentication so every user can import and manage his own contacts.
- Add FactoryBot to test suit
- Validations: Still missing most of the validators, right now only the name attribute has proper tests and validations
- Implement Docker

## The stack of the project is:

- Ruby On Rails 6.1.3
- Ruby 3.0.1
- SQLite3
- Redis
- Sidekiq
- Google Bucket for the storage of the imported CSVs

## Local set up instructions

1. Clone the github repository
2. Run `bundle install`
3. Install and run Redis (use `redis-server /usr/local/etc/redis.conf` if using Mac and installed it with Brew)
4. Run sidekiq `bundle exec sidekiq -C ./config/sidekiq.yml`
5. Ask for the master key to decrypt the credentials for Google Bucket stored at `config/credentials.yml.enc`
6. Run server `rails s`
