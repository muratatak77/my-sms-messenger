# My SMS Messenger – Backend

This is the backend API for the My SMS Messenger application, built with **Ruby on Rails 8**, **MongoDB (via Mongoid)**, and **Twilio** integration for sending SMS. Authentication is handled using **JWT**, and background jobs are processed using **Delayed Job** with Mongoid backend.

---

## 🔧 Requirements

* Ruby 3.x
* Rails \~> 8.0.2
* MongoDB (>= 5.x)
* Node.js & Yarn (for frontend dev)
* Redis (optional for caching or advanced queuing)

---

## ⚙️ Setup Instructions

### 1. Clone the repo

```bash
git clone https://github.com/muratatak77/my-sms-messenger.git
cd my-sms-messenger/backend
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Environment Variables

Create a `.env` file in the `backend/` directory with the following keys:

```env
JWT_SECRET=your_jwt_secret_key
TWILIO_ACCOUNT_SID=your_twilio_sid
TWILIO_AUTH_TOKEN=your_twilio_token
TWILIO_PHONE_NUMBER=your_twilio_number
MONGODB_URL=your_production_mongodb_uri
```

---

## 💾 MongoDB Configuration

Mongoid is used for database management.

Configuration files are located in:
`config/mongoid.yml`

You can use the following environments:

* `development`: connects to `localhost:27017/backend_development`
* `test`: connects to `localhost:27017/backend_test`
* `production`: uses `ENV['MONGODB_URL']`

---

## 🧪 Running Tests

Minitest is used for testing. Run tests with:

```bash
# Run controller tests
rails test test/controllers

# Run job tests
rails test test/jobs
```

Test files are located in `test/controllers/`, `test/jobs/`, and fixtures in `test/fixtures/`.

To reset test DB before each test, `database_cleaner-mongoid` is used.

---

## 🛰 Services

* **Twilio SMS API** – For sending messages
* **JWT** – For authentication
* **Delayed Job + Mongoid** – For background processing (`MessageSenderJob`)
* **Rack CORS** – Handles cross-origin requests from frontend (Angular)

---

## 🚀 Deployment

1. Set up the server with Ruby, MongoDB, and Node.js
2. Install the project and run:

```bash
bundle install
```

3. Make sure environment variables are set (`JWT_SECRET`, `MONGODB_URL`, etc.)
4. Start the server:

```bash
RAILS_ENV=production rails server
```

Or use a production server like **Puma + Nginx** or containerized deployment via **Docker**.