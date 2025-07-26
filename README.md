# 📱 My SMS Messenger

**My SMS Messenger** is a full-stack messaging application that allows users to securely send SMS messages using Twilio. The project is built with:

- **Frontend**: Angular 20
- **Backend**: Ruby on Rails 8 with MongoDB (via Mongoid)

It includes JWT-based authentication, background job processing with Delayed Job, and a responsive user interface.

---

## 🌍 Live Demo

Try the live demo here:  
👉 [https://my-sms-frontend-20250726-5fd4f63e944b.herokuapp.com/](https://my-sms-frontend-20250726-5fd4f63e944b.herokuapp.com/)

### 🔐 Demo User Accounts

| Username | Password |
|----------|----------|
| admin    | admin    |
| demo     | demo     |

You can log in with either account and try sending messages.

> ⚠️ **Note:** This is a demo environment. Messages are simulated and may not be delivered to real numbers.

✅ All messages are sent only to the Twilio-provided phone number: `18777804236`.

---

## 🗂 Project Structure

```

my-sms-messenger/
├── backend/     # Ruby on Rails 8 API with Mongoid and Twilio integration
├── frontend/    # Angular 20 Single Page Application (SPA)
└── .gitignore   # Shared ignore file for both apps

````

---

## 🛠 Backend – Ruby on Rails 8 (with Mongoid)

### Features

- JWT Authentication  
- Twilio integration for sending SMS  
- MongoDB via Mongoid  
- Delayed Job for background SMS processing  
- CORS support for Angular frontend  

### Setup

```bash
cd backend
bundle install
cp .env.example .env  # Set JWT_SECRET, TWILIO credentials, MONGODB_URL
rails db:mongoid:create_indexes
````

To start the backend server:

```bash
rails server
```

### Running Tests

```bash
rails test test/controllers
rails test test/jobs
```

---

## 🌐 Frontend – Angular 20

### Features

* User login and JWT token handling
* Compose and send messages
* Polling for message delivery status
* Real-time feedback and form validation
* Production-ready build system

### Development

```bash
cd frontend
npm install
ng serve
```

Visit: `http://localhost:4200`

### Production Build

```bash
ng build --configuration=production
```

Build output will be located at: `dist/frontend/browser/`

You can host this output on platforms like Netlify, Firebase, Vercel, S3, or any static file server.

---

## ✅ Environment Variables (Backend)

Create a `.env` file inside the `backend/` directory with:

```env
JWT_SECRET=your_secret_key
TWILIO_ACCOUNT_SID=your_twilio_sid
TWILIO_AUTH_TOKEN=your_twilio_token
TWILIO_PHONE_NUMBER=+1234567890
MONGODB_URL=mongodb+srv://...
```

---

## 🧪 Technologies Used

* Ruby on Rails 8
* Angular 20
* MongoDB (Mongoid)
* Twilio API
* JWT Authentication
* Delayed Job (Mongoid adapter)
* Minitest
* Rack CORS

---

## 📦 Deployment Steps

1. Build the frontend with `ng build --configuration=production`
2. Serve the frontend using a static server or Express
3. Deploy the backend to your preferred platform (e.g., Heroku, Render, DigitalOcean)
4. Set production environment variables
5. Ensure CORS configuration in `config/initializers/cors.rb` allows frontend origin



Let me know if you'd like a version that includes Docker setup or Heroku buildpack instructions as well.
```
