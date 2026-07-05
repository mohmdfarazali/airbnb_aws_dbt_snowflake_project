{{ config(severity='warn') }}

select
  booking_id,
  sum(booking_amount) as total_booking_amount
from {{ source('staging', 'bookings') }}
group by booking_id
having total_booking_amount < 0