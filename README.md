# Dealership Auth Challenge
The purpose of this application is to be an e-commerce where dealerships can display and sell their vehicles, and people can find and buy these vehicles (this feature doesn't exist yet and we won't worry about it now). For this to be possible we need two types of users:
- Admin: owner of the application, responsible for maintaining the e-commerce, registering/editing new users and dealerships.
- Dealership: owner of a dealership who wants to use the e-commerce to expose/sell his vehicles.

## Task 1 - Create user registration
We want to create a page where we can create the application's users. There must be pages for creating/editing/listing users.
- Create a user registration page that must contain name, email, password and role (admin or dealership). All these fields are required.
- A dealership user must be associated with a dealership.
  - Ex: User John is an employee of the dealership X.

## Task 2 - Create sign in/sign out
We want to create a page where users can log in to the app. Once logged in, the user must have access to all pages of the application, otherwise it must redirect to the login page.
- Sign in page must have email and password to login
- All user pages must be authenticated
- All dealerships pages must be authenticated
- All vehicles pages, except for index (which must be opened), must be authenticated
- Index vehicles must be the root page
- Once the user is logged in, the pages should show the username and a link to log out
- We also want, when registering the vehicle, to associate it with the logged-in user's dealership

## Task 3 - Add authorization per page
We want to add some level of authorization so that once users are logged in they can't access pages they don't have authorization. This is a list of who can access each page:
- User: all pages must be accessed only by an admin user
- Dealerships: all pages must be accessed only by an admin user
- Vehicles:
  - the index page must be open (e-commerce)
  - the other pages must be accessed only by a dealership user
  - the index page should only show vehicles from the dealership associated with the logged in user

## Extra 1 - Add basic authorization
As we are still in the development phase, we don't want people without permission to access the app. For this we need to create a basic authorization on all our pages to prevent someone without permission from taking a look at them.
- Add basic authorization on all app pages

## Extra information
- Repository: https://gitlab.com/joao.mangilli/desafio-auth
- How to run
  - rvm install 3.1.3
  - bundle install
  - rake db:setup
  - rails s
