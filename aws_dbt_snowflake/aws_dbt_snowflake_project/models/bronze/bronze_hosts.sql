{{ config(materialized='incremental') }}

select
  host_id,
  host_name,
  host_since,
  is_superhost,
  response_rate,
  created_at
from {{ source('staging', 'hosts') }}

{{ incremental_filter() }}