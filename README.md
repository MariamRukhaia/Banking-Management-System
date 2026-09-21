# 🏦 Banking Management System

A full-stack client-server banking application built with **Java, MySQL, TCP sockets, and Swing**, supporting secure authentication, account management, money transfers, transaction history, and concurrent client connections.

The system separates the graphical client, application server, and relational database into distinct layers, simulating the architecture of a networked banking platform.

---

<h2 align="center">🎥 Application Demo</h2>

<p align="center">
  <strong>See the banking system in action — authentication, account management, deposits, withdrawals, transfers, and transaction history.</strong>
</p>

<h3 align="center">
  <a href="[YOUR_DEMO_LINK](https://drive.google.com/drive/search?q=.mov)">
    ▶️ WATCH THE DEMO
  </a>
</h3>

---

## ✨ Features

### 🔐 Authentication

- User registration and login
- Password hashing using **BCrypt**
- Unique username validation
- Session-based user identification
- Prepared SQL statements for database queries

### 💳 Account Management

- View accounts associated with the authenticated user
- Display current account balances
- Support shared accounts
- Validate account ownership before performing operations

### 💰 Banking Operations

Users can perform core banking transactions including:

- **Deposit** funds into an account
- **Withdraw** funds with balance validation
- **Transfer** money between users and accounts
- Prevent invalid or negative transaction amounts
- Prevent withdrawals and transfers that exceed available funds

### 🔄 Transaction Processing

Transfers are executed using database transactions to preserve consistency.

The server:

1. Validates the sender and recipient accounts
2. Verifies sufficient funds
3. Withdraws funds from the sender
4. Deposits funds into the recipient account
5. Commits the transaction only after successful completion
6. Rolls back unsuccessful transfers

Critical banking operations are synchronized on the server to coordinate concurrent requests.

### 📜 Transaction History

The application maintains transaction records for:

- Deposits
- Withdrawals
- Transfers
- Transaction amounts
- Sender and recipient accounts
- Timestamps

Users can view their transaction history directly through the application and export it to a local text file.

### ✍️ Transfer Signature

Money transfers include an interactive **Swing-based signature panel**, allowing users to draw a signature before submitting a transfer.

---

## 🏗️ System Architecture

```text
┌─────────────────────────────┐
│         Java Client         │
│                             │
│  Swing GUI                  │
│  Authentication             │
│  Account Management         │
│  Transaction Interface      │
└──────────────┬──────────────┘
               │
               │ TCP Socket
               │ Port 5190
               ▼
┌─────────────────────────────┐
│         Java Server         │
│                             │
│  Multi-client Processing    │
│  Business Logic             │
│  BCrypt Authentication      │
│  Transaction Validation     │
└──────────────┬──────────────┘
               │
               │ JDBC
               ▼
┌─────────────────────────────┐
│        MySQL Database       │
│                             │
│  Users                      │
│  Accounts                   │
│  Transactions               │
│  Stored Procedures          │
└─────────────────────────────┘
```

The client communicates with the server through **TCP sockets**, while the server communicates with MySQL through **JDBC**.

Each incoming client connection is processed independently by the server, allowing multiple clients to interact with the banking system.

---

## 🧠 How It Works

### Client

`Client.java` provides the graphical interface using **Java Swing**.

The client handles:

- Login and account creation
- Account visualization
- Deposit and withdrawal requests
- User-to-user transfers
- Signature input
- Transaction-history display
- Transaction export

Requests are transmitted to the server through a TCP socket connection.

### Server

`Server.java` contains the application's server-side logic.

The server:

- Listens for client connections on port `5190`
- Processes multiple client connections
- Authenticates users
- Communicates with MySQL
- Validates account ownership
- Processes deposits and withdrawals
- Executes transactional money transfers
- Records transaction history

### Database

The MySQL database stores the application's persistent data and provides stored procedures used by the server for banking operations.

---

## 🔒 Security & Data Integrity

Several mechanisms are used to improve authentication security and transaction integrity:

- **BCrypt password hashing** rather than storing plaintext passwords
- **Prepared statements** for parameterized database queries
- Server-side account ownership validation
- Balance validation before withdrawals and transfers
- Database transactions for atomic money transfers
- Rollback behavior when a transfer cannot be completed

> This project is an educational banking-system implementation and is not intended for production financial use.

---

## 🛠️ Tech Stack

### Application

`Java` `Java Swing` `TCP Sockets` `Multithreading`

### Database

`MySQL` `JDBC` `SQL` `Stored Procedures`

### Security

`BCrypt` `Prepared Statements`

### Build & Dependency Management

`Maven`

---

## 📂 Project Structure

```text
Banking-Management-System/
│
├── database/
│   └── bank_database.sql
│
├── src/
│   ├── Client.java
│   └── Server.java
│
├── .gitignore
├── pom.xml
└── README.md
```

---

## 🚀 Running Locally

### Prerequisites

Make sure you have installed:

- Java 17+
- Maven
- MySQL

### 1. Clone the repository

```bash
git clone <repository-url>
cd Banking-Management-System
```

### 2. Set up the database

Create a MySQL database and import:

```text
database/bank_database.sql
```

The application expects a local MySQL database named:

```text
bank
```

### 3. Configure MySQL

The current development configuration connects to:

```text
jdbc:mysql://localhost:3306/bank
```

Update the database username and password in `Server.java` if your local MySQL configuration differs.

### 4. Install dependencies and compile

```bash
mvn compile
```

Maven automatically installs the required dependencies, including:

- MySQL Connector/J
- jBCrypt

### 5. Start the server

Run `Server.java` first.

The server listens on:

```text
localhost:5190
```

### 6. Start the client

Run `Client.java`.

The Swing application will open and connect to the local banking server.

---

## 📌 Key Concepts Demonstrated

This project demonstrates practical implementation of:

- Client-server architecture
- TCP socket programming
- Concurrent client processing
- Relational database integration
- JDBC
- SQL stored procedures
- Database transactions
- Password hashing
- Authentication
- GUI development with Java Swing
- Transaction validation and rollback
- Maven dependency management

---

## 👩‍💻 Authors

**Mariam Rukhaia**  
**Neel Dahake**
