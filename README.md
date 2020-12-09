# Scaffold for social media app with Ruby on Rails

The last project of the Rails module where we're requested to finish building a social media app adding the friendship feature were a user can send a friend request to another users and accept or reject those friend requests. So we were in charge of implementing the has many friendships and belongs to user association features.

## Built With

- Ruby v2.7.0
- Ruby on Rails v5.2.4

## Live Demo

[live demo](https://guillain-jose-social-media-app.herokuapp.com/)

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.6.3
Rails: 5.2.3
Postgres: >=9.5

### Setup

Instal gems with:

```
bundle install
```

Run

```
yarn install
```

Setup database with:

```
   rails db:create
   rails db:migrate
```

### Github Actions

To make sure the linters' checks using Github Actions work properly, you should follow the next steps:

1. On your recently forked repo, enable the GitHub Actions in the Actions tab.
2. Create the `feature/branch` and push.
3. Start working on your milestone as usual.
4. Open a PR from the `feature/branch` when your work is done.

### Usage

Start server with:

```
    rails server
```

Open `http://localhost:3000/` in your browser.

### Run tests

Download and install google chrome if don't have it to run Capybara.
Capybara needs the web drivers to run system tests with browsers

``` 
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install ./google-chrome-stable_current_amd64.deb
	
```

``` 
  rspec --format documentation

```

### Deployment

Steps to deploy to Heroku run in the console the following commands:

```
  heroku login -i

  <login with your Heroku credentials>

  heroku create

  heroku rename <the name you want for your app>

  heroku run rails db:migrate

```
After the previous steps, make sure you add your database password to your Heroku environment variables with the key-value pairs being the key locate in config/database.yml and the value the password you set up.

## Authors

### Author

- 👤GitHub: [Jose Abel Ramirez](https://github.com/jose-Abel)
- Linkedin: [Jose Abel Ramirez Frontany](https://www.linkedin.com/in/jose-abel-ramirez-frontany-7674a842/)

### Author

- 👤GitHub: [Guillain Bisimwa](https://github.com/guillainbisimwa)
- Linkedin: [Guillain Bisimwa](https://www.linkedin.com/in/guillain-bisimwa-8a8b7a7b/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

A special thanks to the Ruby Team, the teams maintaining the gems for Rails and all gems used on this project, and a special acknowledgment and appreciation to Microverse for pushing us further to increase our knowledge and because of that we can consider ourselves now Rails Juniors :).
