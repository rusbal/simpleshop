# Simple Shop

This is a blank Rails 6 application based on Ruby 2.7.1
This has a docker-compose setup to initialize postgresql DB and Redis servers for your development.
You can add more gems to assist you with your development but not allowed to change the versions of the current library.

## Agenda of the Task

The scenario is that you are required to create an api server for an ecommerce application.
If you want to create a web-app instead, please use react components in your implementation with tailwind css using webpacker.

About the users:

- Customers - Basic users who can signup and login with email and password. Note: Users can only access the application after they have activated their account via activation_token after the sign_up stage.
- Admins - These users are responsible to add/edit/delete regions, add/edit/delete products and their stock, read the orders. Admins are not allowed to sign_up but are manually added via console. So no need to integrate registrations for admin.
- Users can be both customers and admins.

About the store:

- Regions - This application should be flexible to allow creation of stores in different regions. E.g. Thailand, Singapore, etc. each with their own currency setup. Admins are allowed to add/edit/delete regions. Region should contain a title, country details, currency details, tax details.
- Products - Each region has their own set of products. Products can be anything - tshirt, pants, mugs, watches, etc. WITHOUT any variations like sizes, colors, etc. Admins are able to add/edit/delete the products. Products should have a title, description, image(fake urls should be okay), price, sku and stock number.
- Stocks - Each product has a specific amount of stock available to them. Customers should not be allowed to order items beyond the available stock number. Admins are the only ones allowed to edit the stock number.
- Orders - Customers are allowed to place order for selected products. Remember customers are required to enter basic ordering details such as their name, shipping address, and summary of the order.
- Payment - Once the order is made, a payment should be made to confirm the order and make it available for delivery. For now you do not need to implement any payment gateway but will be required to fake this step. You can create a task that is triggered 1 minute after the order creating that randomly updates the state of the order to be successfully paid or unsuccessfully paid. And the user is informed about the status of their order.
- Note - Remember that you are creating an api server for ecommerce platform, so keep in mind what kind of information will be required by the client customer application and also the information required by the admin side.
- Mailing - for mail server to send activation email, you can use sendgrid's free version to implement it.

## Requirements

- REST API or GRAPHQL endpoints to satisfy the criterias above
- Seed data for the application in development mode
- Implement JWT authentication for sign_in steps
- Submit a postman collection along with code implementation via email
- Provide proper documentations or notes about any extra libraries or complex integrations done in the application
- OPTIONAL (BONUS) Rspec or cucumber tests for the implementations above
- Please upload your code to a repository and add emails suhas@morphos.is, pawel@morphos.is, and win@morphos.is access to that repo.
