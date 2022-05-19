# Recipe app

> The Recipe app keeps track of all the users' recipes, ingredients, and inventory. It allows users to save ingredients, keep track of what they have, create recipes, and generate a shopping list based on what they have and what is missing from a recipe. Also, since sharing recipes is an important part of cooking the app allows users to make them public so anyone can access them.

### Preview

![screenshot](app/assets/images/recipe-demo.gif)


# How to build the Recipe app
The end result should follow the following data model (this is an Entity Relationship Diagram that you are already familiar with):

> ![](https://github.com/microverseinc/curriculum-rails/blob/main/recipe-app/images/recipe_app_erd.png)

## Built With

- Ruby on Rails
- Bootstrap
- JQuery
- Ruby
- Bubocop
- Gems
  - Rspec
  - Capybara
  - FactoryBot
  - Selenium-webdriver
  - Bcrypt
  - Letter-opener
  - Faker
  - cancancan
  - Devise


## Getting Started

**To get a local copy up and running follow these simple example steps.**

### Prerequisites
- Ruby should be installed on your machine
- Install Ruby on Rails and PostgresQL

### Setup
```
git clone https://github.com/clintonjosephs/recipe-app.git
cd recipe-app
```
### Install
```
bundle install
```

### Play with the code
```
rails c
```

### Populate the db with dummy data
```
rake db:migrate
rake db:seed
```

### Run linters
```
rubocop -A
```

### Start the application
```
rails s
```

### Tests
```
rspec spec (run all tests)
rspec spec/name_of_folder/name_of_file.rb (run specific tests)
```
### Authors

## 👤 Clinton Mbonu

- GitHub: [@clintonjosephs](https://github.com/clintonjosephs)
- Twitter: [@clintonmbonu2](https://twitter.com/clintonmbonu2)
- LinkedIn: [clintonjosephs](https://www.linkedin.com/in/clintonjosephs/)


## 👤 Mwape Samuel

- GitHub: [@mwapsam](https://github.com/Mwapsam)
- Twitter: [@mwapesamuel4](https://twitter.com/mwapesamuel4)
- LinkedIn: [mwapsam](https://www.linkedin.com/in/mwapsam/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Many thanks to Microverse

## 📝 License

This project is [MIT](./MIT.md) licensed.