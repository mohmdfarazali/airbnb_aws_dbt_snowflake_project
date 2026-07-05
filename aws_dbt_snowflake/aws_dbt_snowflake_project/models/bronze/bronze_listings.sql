{{ config(materialized='incremental') }}

select
  listing_id,
  host_id,
  property_type,
  room_type,
  city,
  country,
  accommodates,
  bedrooms,
  bathrooms,
  price_per_night,
  created_at
from {{ source('staging', 'listings') }}

{{ incremental_filter() }}
