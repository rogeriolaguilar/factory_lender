# Factory Lander

A small project to help a factoring lender. The lender uses invoices as collateral for loans.

## How it works

This project has a set of APIs to create and edit Clients and Invoices. A postman collection with the APIs can be found [here](Factory_Landing.postman_collection.json).

After creating a Client and an Invoice, it is possible to use the **Change Invoice status** API. Every Invoice starts with the *created* status. This status can change based on what is defined in the [Invoice::NEXT_STATUS_MAP](app/models/invoice.rb) constant.

When the Invoice status changes to *purchased*, a Purchase is generated. The Purchase amount is estimated based on the Invoice amount and the period between the *purchase* being created and the Invoice due date.

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
docker-compose up -d
rails s
```
