# Financial Audit & Internal Control Framework (GoTech E-commerce)

## Project Overview
This project serves as a comprehensive **Data Audit and Internal Control Framework** designed for an e-commerce platform specializing in electronics (GoTech). Leveraging advanced relational database structures, the objective is to monitor operational data integrity, automate financial liquidations, and detect exceptions or revenue leakages that traditional accounting methods might overlook.

## Core Architecture
The database (`GoTech_Analytics`) implements a robust star-schema relational model consisting of four core operational tables linked via strictly enforced primary and foreign keys:
* **Clientes (Customers):** Geographic and identity tracking.
* **Productos (Products):** Inventory master data incorporating separate Cost and Retail price matrices for automated margin analysis.
* **Vendedores (Sales Reps):** Contractual commission tracking.
* **Ventas (Sales Ledger):** The transactional ledger bridging all entities.

## Implemented Audit Controls (SQL Queries)

### 1. Revenue & Margin Analysis
Automates the calculation of Net Margin per product line by cross-referencing quantity sold against the dynamic spread between retail prices and product costs. 

### 2. Margin Leakage Detection (Exception Reporting)
An internal control query designed to flag anomalies where items are sold at or below cost price. In an automated deployment, this serves as an early-warning system against pricing synchronization errors or unauthorized discounts.

### 3. Idle Customer Acquisition Cost (CAC) Control
Utilizes a `LEFT JOIN` exclusion pattern to isolate registered profiles with zero transaction history, enabling marketing teams to pinpoint dead leads and optimize resource allocation.

### 4. Automated Payroll & Commission Auditing
A multi-table aggregation query that processes raw sales volumes, calculates total revenue generated per salesperson, and applies dynamic contractual commission percentages to compute exact payroll liabilities.

## Tech Stack
* **Database Engine:** SQL Server (SSMS)
* **Language:** T-SQL (Transact-SQL)