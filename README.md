# 🎬 DVD Rental DBT Project

This project is a dbt implementation for the PostgreSQL DVD Rental sample database. It includes a layered architecture with staging, core, and mart models, comprehensive testing, and dashboard design plans.

---

## 🏗️ Project Structure

### Staging Layer (`stg_`)
- Cleans and standardizes raw source data.
- Example Models:
  - `stg_dvdrental__actor`
  - `stg_dvdrental__film`
  - `stg_dvdrental__customer`
  - `stg_dvdrental__payment`
  - `stg_dvdrental__rental`

#### Tests:
**Generic:**
- `not_null` on primary keys
- `unique` on IDs
- `accepted_values` on enums (e.g., `rating` in film)
- `relationships` between foreign keys

**Singular:**
- Check that no email addresses are uppercase.
- Ensure postal codes in the US have 5 digits.
- Assert that `rental_date < return_date`.
- Confirm that all payment amounts are ≥ 0.

---

### Core Layer (`dim_` and `fct_`)
- Business logic and enriched facts/dimensions.
- Example Models:
  - `dim_customer`
  - `dim_film`
  - `dim_actor`
  - `dim_date`
  - `fct_rentals`
  - `fct_payments`
  - `fct_returns`

#### Tests:
**Generic:**
- `not_null` and `unique` on keys
- `relationships` to staging models
- `accepted_values` on dimensions (e.g., country, category)

**Singular:**
- Verify correct film length buckets.
- Ensure customer full_name is not null.
- Validate email domains (must end with `.com`, `.net`, etc.).

---

### Mart Layer (`mart_`)
- Rollups and business KPIs.
- Example Models:
  - `mart_revenue_by_month`
  - `mart_customer_lifetime_value`
  - `mart_film_popularity`
  - `mart_staff_performance`
  - `mart_category_engagement`

#### Tests:
**Generic:**
- `not_null` on key metrics
- `unique` on aggregate groups
- `relationships` to dimensions

**Singular:**
- Revenue should not decrease month-over-month (for cumulative revenue).
- Top 10 films by revenue should match expectations.
- New customer counts should always be less than total customer counts.

---

## 📊 Dashboard Ideas

1. **Revenue Dashboard**
   - Monthly revenue trend
   - Revenue by country/category
   - KPIs: total revenue, average payment, active customers

2. **Film Performance Dashboard**
   - Top rented films
   - Rentals by rating
   - Rental trends over time

3. **Customer Insights Dashboard**
   - Funnel: customer rental journey
   - Top customers by lifetime value
   - Customer distribution by country

4. **Staff Performance Dashboard**
   - Monthly performance by staff
   - Top-performing staff

5. **Operational Efficiency Dashboard**
   - Rental return delays
   - Delay trends by category and customer

---

## ✅ dbt Features Practiced
- Jinja macros
- Incremental models
- Snapshots (SCD2)
- Seeds
- Source freshness
- Generic and singular dbt tests
- dbt-utils package (including date spine)

---

## 📦 Packages Used
- `dbt-utils`
- `dbt-expectations` (optional for advanced testing)

---

## 🚀 Project Goal
This project is designed to build a **production-grade dbt workflow** on a classic transactional dataset, with robust data quality checks and a full reporting layer that can power interactive dashboards.

---

Feel free to customize this README to match your specific repo structure or add contribution guidelines if you collaborate with others!

