# 🚌 Bus Management System (Relational Database Project)

![ER Diagram](img/er_diagram.png)

## 📌 Overview

This project is a **relational database system for managing a public transportation network**, developed as part of a university coursework.

It models real-world entities such as passengers, buses, drivers, routes, trips, and smart card systems, focusing on **data integrity, automation, and advanced SQL features**.

Bu proje, üniversite dersi kapsamında geliştirilmiş **toplu taşıma yönetim sistemi veritabanı uygulamasıdır**.
Gerçek hayat senaryosu üzerinden yolcu, otobüs, şoför, hat ve kart sistemlerini modellemektedir.

---

## 🎯 Objectives

* Design a **normalized relational database schema**
* Implement **real-world transportation logic**
* Apply advanced SQL concepts:

  * Triggers
  * Functions
  * Views
  * Cascading constraints

---

## 🧠 System Features

### 👥 Passenger & Card Management

* Passenger information storage
* Multiple card types:

  * Normal, Student, Disabled, 65+, Government
* Balance tracking and updates

### 💳 Smart Card System

* Transaction-based card usage
* Automatic balance deduction via **Trigger**
* Card activity tracking

### 🚌 Transportation Management

* Bus and capacity management
* Driver assignments
* Route and stop mapping
* Trip tracking system

### 🔔 Notification System

* Passenger feedback & complaints
* Categorized as:

  * Driver-related
  * Stop-related
  * General issues
* Aggregated reporting using **View**

---

## 🧩 Advanced SQL Components

### ⚡ Trigger

**`kart_bakiye_guncelle`**

* Automatically updates card balance after a successful transaction
* Ensures real-time consistency

---

### 🧮 Function

**`sofor_otobus_kazanc_hesapla`**

* Calculates total earnings of a driver for a specific bus
* Uses aggregate SQL operations

---

### 📊 View

**`v_bildirim_raporu`**

* Provides a unified report of all notifications
* Categorizes complaints dynamically

---

### 🔗 CASCADE Constraints

* Implemented on foreign keys to maintain **referential integrity**
* Automatically propagates updates across related tables

---

## 🗄 Database Schema

### Main Tables

* `yolcu`, `kart`, `bakiye`
* `otobus`, `sofor`
* `hat`, `durak`
* `yolculuk`, `kart_islem`
* `bildirim`

### Relationship Tables

* `yolculuk_yolcu`
* `sofor_otobus`
* `hat_durak`

### Subtype Tables

* `ogrenci`
* `engelli`
* `yas_65_uzeri`
* `memur`

---

## ⚙️ Technologies Used

* PostgreSQL
* SQL (DDL, DML)
* PL/pgSQL
* Relational Database Design

---

## ▶️ Getting Started

### 1. Clone Repository

```bash
git clone https://github.com/H-ERDEM/bus-management-system.git
```

### 2. Create Database

```sql
CREATE DATABASE bus_management;
```

### 3. Run SQL Script

```sql
-- Run the provided SQL file
```

---

## 💻 Example Queries

```sql
-- List passengers
SELECT * FROM yolcu;

-- View notification report
SELECT * FROM v_bildirim_raporu;

-- Calculate driver earnings
SELECT sofor_otobus_kazanc_hesapla(1, '44M123');
```

---

## 📈 Future Improvements

* Web interface (React / ASP.NET / Django)
* REST API integration
* Real-time tracking system
* Dashboard for analytics and reporting

---

## 👩‍💻 Developer

**Hayrunnisa Büşra Erdem**
Computer Engineering Student

---

## 📌 Notes

* This project focuses on **database design and backend logic**, not UI.
* Designed to simulate a **real-world transportation system** using SQL.

---
