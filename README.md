# Factory Lander

A small project to help a factoring lender. The lender uses invoices as collateral for loans.
So when the borrower is paid, he pays the lender back. Some fees will be charged for the loan.

Fees are accrued from the purchase date until the invoice is closed based on a percentage of the invoice amount.

## Initialization

* Ruby version
3.1.0

* System dependencies
Docker and docker-compose

* Install dependencies
```
bundle install
```

* Database creation
```
docker-compose up
````

* Database initialization
```
rails db:prepare
rails db:migrate
```


* Run the test suite

```
bundle exec rspec
```

* Run the linter
```
rubocop
````

* Start application
```
bundle install
docker-compose up -d
rails s
```
