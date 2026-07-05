{{ config(materialized='incremental') }}

select
  booking_id,
  listing_id,
  booking_date,
  nights_booked,
  booking_amount,
  cleaning_fee,
  service_fee,
  booking_status,
  created_at
from {{ source('staging', 'bookings') }}

{{ incremental_filter() }}