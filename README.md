# Makers BnB #

## Description ##

Makers BnB is a group project piece to create a web application that allows users to log in and list or rent properties.

## Technologies ##

jQuery, Sinatra, Ruby, PG, PostgreSQL, HTML, CSS, Bootstrap

## Instructions for Use

1. Clone the repository

`git clone https://github.com/melissasedgwick/makers-bnb.git`

2. Navigate into the repository

`cd makers-bnb`

3. Run the application

`rackup`

4. Access the program from `localhost:9292`

5. Set up the databases using the instructions below


## Setting Up Databases ##

1. Open psql from command line

`psql`

2. Create bnb database

`CREATE DATABASE bnb`

3. Create test bnb database

`CREATE DATABASE bnb_test`

4. Follow instructions in db/migrations to set up tables in each database. (Use \\c bnb and \\c bnb_test to set up tables in each database.)

## Testing

To run tests:

`rspec`


## Specification ##

Headline specifications:
* Any signed-up user can list a new space.
* Users can list multiple spaces.
* Users should be able to name their space, provide a short description of the space, and a price per night.
* Users should be able to offer a range of dates where their space is available.
* Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
* Nights for which a space has already been booked should not be available for users to book that space.
* Until a user has confirmed a booking request, that space can still be booked for that night.

## User Stories ##

1.
```
As a user
So I can use the website
I'd like to be able to sign up for an account
```
2.
```
As a user
So I can list properties
I'd like to be able to list spaces for rent
```
3.
```
As a user
When listing a space
I'd like to to specify name, description and price per night
```
4.
```
As a user
So that people can book my space
I'd like to specify when it is available
```
5.
```
As a user
So I can hire a space
I'd like to request the space for the night I want it
```
6.
```
As a user
So I can rent my space
I'd like to be able to approve user requests
```
7.
```
As a user
So that a space is not double booked
I would like to prevent the space being requested when it has already been booked
```
8.
```
As a user
If a space has been requested but not confirmed,
I would like to be able to request it too.
```

## Minimum Viable Product ##

By Tuesday:

`A functioning web application where users can register an account and list properties to rent, which are stored in a database.`

By Friday:

`All user stories completed.`

## Stand Ups and Retro Schedule ##

Daily:

`Stand Up @ 10am`

`Retro @ 4pm`

## Pairing Patterns ##

Tuesday AM `(Lucas/Aimee, Mel/Prash)`

Tuesday PM `(Lucas/Mel, Aimee/Prash)`

Wednesday AM `(Mel/Aimee, Lucas/Prash)`

Wednesday PM `(Lucas/Aimee, Mel/Prash)`

Thursday AM `(Lucas/Mel, Aimee/Prash)`

Thursday PM `(Mel/Aimee, Lucas/Prash)`

## CRC Cards ##
![user-card](public/user-card.png)
![property-card](public/property-card.png)

## Database Plan ##
![database-plan](public/database-plan.png)

## MVC Plan ##
![mvc-plan](public/mvc-plan.png)
