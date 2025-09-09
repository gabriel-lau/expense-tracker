# Expense-tracker

This is a simple expense tracker application built with Flutter for mobile, asp.net core and PostgreSQL. It allows users to add, edit, and delete expenses, as well as view a list of all expenses.

## Backend

The backend is built with asp.net core and uses PostgreSQL as the database.

### Setup with Docker

It is preferred to run the backend with Docker as it is already configured with a Dockerfile and docker-compose file. These are the steps to run the backend with Docker:

1. Make sure you have [Docker](https://www.docker.com/) installed on your machine.
2. Navigate to the `/backend` directory.

```bash
cd backend
```

1. Run the following command to build and start the backend (this starts both the asp.net core web api and PostgreSQL containers):

```bash
docker-compose up --build
```

4. The backend should now be running on `http://localhost`.

### Setup without Docker

If you prefer to run the backend without Docker, follow these steps:

1. Make sure you have [.NET 9 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/9.0) and [PostgreSQL](https://www.postgresql.org/download/) installed on your machine.
2. Create a PostgreSQL database with the name `expense_db` and update the connection string in `/backend/appsettings.Development.json`.

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Host=localhost;Port=5432;Database=expense_db;Username=(your_username);Password=(your_password)"
  },
  ...
}
```

3. [A] Create the database schema by running the following command in the `/backend` directory:

```bash
dotnet ef database update
```

3. [B] Alternatively, you can create the database schema manually by executing the SQL commands in `/backend/sql/init.sql` in your PostgreSQL database.
4. Navigate to the `/backend` directory and run the following command to start the backend:

```bash
dotnet run
```

5. The backend should now be running on `http://localhost:5160`.

### Endpoints

The endpoints are:

- `GET /api/expenses` - Get all expenses
- `POST /api/expenses` - Create a new expense
- `PUT /api/expenses/{id}` - Update an expense by id
- `DELETE /api/expenses/{id}` - Delete an expense by id

## Mobile App

The mobile app is built with Flutter for both Android and iOS.

### Setup

1. Make sure you have [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
2. Navigate to the `/mobile` directory.

```bash
cd mobile
```

3. Run the following command to get the dependencies:

```bash
flutter pub get
```

4. Update `USE_DOCKER` in the `lib/constants.dart` file to point to your backend URL:

```dart
const bool USE_DOCKER = false;
```

5. Run the app for your desired platform (Android or iOS):

```bash
flutter run
```
