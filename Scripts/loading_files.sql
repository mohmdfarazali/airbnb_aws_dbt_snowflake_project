-- Create CSV file format
create file format if not exists csv_format
  type = csv
  field_delimiter = ','
  skip_header = 1
  error_on_column_count_mismatch = false;

-- Create external stage
create or replace stage snowstage
  url = '<your-s3-bucket-url>'
  file_format = csv_format;

-- Load bookings
copy into bookings
from @snowstage
files = ('bookings.csv')
credentials = (
  aws_key_id = '<your-access-key-id>'
  aws_secret_key = '<your-secret-access-key>'
);

-- Load listings
copy into listings
from @snowstage
files = ('listings.csv')
credentials = (
  aws_key_id = '<your-access-key-id>'
  aws_secret_key = '<your-secret-access-key>'
);

-- Load hosts
copy into hosts
from @snowstage
files = ('hosts.csv')
credentials = (
  aws_key_id = '<your-access-key-id>'
  aws_secret_key = '<your-secret-access-key>'
);