# 🏠 Airbnb Data Engineering Pipeline on AWS, Snowflake & dbt

## 📋 Overview

This project demonstrates an end-to-end modern data engineering pipeline built using **AWS, Snowflake, and dbt**. The pipeline ingests Airbnb booking, listing, and host data into Snowflake and transforms it through a Medallion Architecture (Bronze → Silver → Gold) to produce analytics-ready datasets.

Rather than focusing only on SQL transformations, this project emphasizes building reusable and production-friendly dbt components such as custom macros, incremental processing, dynamic SQL generation using Jinja, and Slowly Changing Dimensions (SCD Type 2) for historical tracking.

### Key Highlights

- Built a complete Bronze → Silver → Gold data pipeline using dbt.
- Implemented configurable incremental models supporting both daily loads and custom backfills.
- Created reusable custom dbt macros to eliminate repetitive SQL logic.
- Implemented SCD Type 2 dimensions using dbt snapshots.
- Built dynamic SQL using Jinja loops to reduce duplicate code.
- Organized models using a Medallion Architecture for maintainability and scalability.

---

# 🏗️ Architecture

```
CSV Files
    │
    ▼
AWS S3
    │
    ▼
Snowflake Staging
    │
    ▼
Bronze Layer
    │
    ▼
Silver Layer
    │
    ▼
Gold Layer
    │
    ├── One Big Table (OBT)
    ├── Fact Table
    └── Dimension Tables (Snapshots)
```

---

# 🛠️ Technology Stack

| Category | Technologies |
|-----------|--------------|
| Cloud Storage | AWS S3 |
| Data Warehouse | Snowflake |
| Transformation | dbt Core |
| Language | SQL, Jinja |
| Package Manager | uv |
| Version Control | Git & GitHub |
| Data Modeling | Medallion Architecture |
| Historical Tracking | dbt Snapshots (SCD Type 2) |

# 📊 Data Model

The project follows the **Medallion Architecture**, where each layer has a specific responsibility in transforming raw data into analytics-ready datasets.

## 🥉 Bronze Layer

The Bronze layer ingests raw data from the Snowflake staging schema with minimal transformations while preserving the source data.

Models:
- `bronze_bookings`
- `bronze_hosts`
- `bronze_listings`

**Features**
- Incremental loading
- Configurable lookback window
- Custom backfill support using `start_date` and `end_date`
- Reusable incremental filtering macro

---

## 🥈 Silver Layer

The Silver layer standardizes and enriches the Bronze data by applying business transformations and reusable macros.

Models:
- `silver_bookings`
- `silver_hosts`
- `silver_listings`

**Transformations**
- Booking amount calculations
- Host response rate categorization
- Price categorization
- String standardization
- Business rule implementation

---

## 🥇 Gold Layer

The Gold layer contains analytics-ready datasets designed for reporting and downstream consumption.

Models:
- `obt` (One Big Table)
- `fact`
- Ephemeral models
- Snapshot-based dimension tables

The OBT model combines bookings, listings, and hosts into a denormalized dataset using dynamic Jinja loops for maintainability.

---

## 📸 Slowly Changing Dimensions (SCD Type 2)

Historical changes are tracked using dbt snapshots.

Dimensions:
- `dim_bookings`
- `dim_hosts`
- `dim_listings`

This enables point-in-time analysis while preserving historical records.

---

# 📁 Project Structure

```text
AWS_DBT_SNOWFLAKE/
│
├── SourceData/
│   ├── bookings.csv
│   ├── hosts.csv
│   └── listings.csv
│
├── DDL/
│   ├── ddl.sql
│   └── resources.sql
│
└── aws_dbt_snowflake_project/
    │
    ├── models/
    │   ├── sources/
    │   │   └── sources.yml
    │   │
    │   ├── bronze/
    │   │   ├── bronze_bookings.sql
    │   │   ├── bronze_hosts.sql
    │   │   └── bronze_listings.sql
    │   │
    │   ├── silver/
    │   │   ├── silver_bookings.sql
    │   │   ├── silver_hosts.sql
    │   │   └── silver_listings.sql
    │   │
    │   └── gold/
    │       ├── obt.sql
    │       ├── fact.sql
    │       └── ephemeral/
    │           ├── bookings.sql
    │           ├── hosts.sql
    │           └── listings.sql
    │
    ├── snapshots/
    │   ├── dim_bookings.yml
    │   ├── dim_hosts.yml
    │   └── dim_listings.yml
    │
    ├── macros/
    │   ├── incremental_filter.sql
    │   ├── generate_schema_name.sql
    │   ├── multiply.sql
    │   └── tag.sql
    │
    ├── tests/
    │   └── source_bookings_tests.sql
    │
    ├── analyses/
    │
    ├── dbt_project.yml
    ├── packages.yml
    └── profiles.yml.example
```

### Folder Overview

| Folder | Purpose |
|---------|---------|
| **models/** | Bronze, Silver and Gold transformation models |
| **macros/** | Reusable Jinja macros used across multiple models |
| **snapshots/** | SCD Type 2 dimension tracking |
| **tests/** | Custom data quality tests |
| **analyses/** | Experimental SQL and Jinja examples |
| **sources/** | Source definitions for Snowflake staging tables |
| **DDL/** | Database and object creation scripts |
| **SourceData/** | Sample Airbnb source datasets |
