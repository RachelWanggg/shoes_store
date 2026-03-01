# Shoes Store

This is a Ruby on Rails application for managing an online shoes store. It supports product listings, shopping cart, orders, and admin management.

## Requirements
- Ruby 3.x
- Rails 8.1.1
- SQLite3 (default for development)

## Setup
1. Install dependencies:
   ```bash
   bundle install
   ```
2. Prepare the database:
   ```bash
   bin/rails db:prepare
   ```
3. Start the development server:
   ```bash
   bin/dev
   ```
   The app will run at http://localhost:3000

## Features
- Product catalog with images
- Shopping cart
- Order management
- User authentication (Devise)
- Admin dashboard

## Project Structure
- `app/models` - Data models
- `app/controllers` - Controllers
- `app/views` - HTML views
- `app/assets` - Images, stylesheets, JavaScript
- `db/migrate` - Database migrations
- `storage/` - Active Storage files (product images)

## Notes
- Product images are managed by Active Storage and stored in the `storage/` directory.
- Sensitive files (credentials, database, etc.) are excluded from version control via `.gitignore`.


