{% macro incremental_filter(column_name='created_at') -%}

  {%- set inception_date = var('inception_date', '2025-12-26') -%}
  {%- set start_date = var('start_date', none) -%}
  {%- set end_date = var('end_date', none) -%}
  {%- set lookback_days = var('lookback_days', 1) -%}

  {%- if start_date or end_date -%}

    where {{ column_name }} >= '{{ start_date if start_date else inception_date }}'
      and {{ column_name }} < {{ "'" ~ end_date ~ "'" if end_date else "current_date()" }}

  {%- elif is_incremental() -%}

    where {{ column_name }} >= dateadd(day, -{{ lookback_days }}, current_date())

  {%- else -%}

    where {{ column_name }} >= '{{ inception_date }}'
      and {{ column_name }} < current_date()

  {%- endif -%}

{%- endmacro %}