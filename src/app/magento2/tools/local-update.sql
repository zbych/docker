UPDATE core_config_data
  SET value = 'http://{{ .Env.PROJECT }}.local/'
  WHERE path LIKE 'web/%/base_url' AND scope = 'default' AND scope_id = '0';

UPDATE core_config_data
  SET value = '{{ .Env.PROJECT }}.local'
  WHERE path = 'web/cookie/cookie_domain' AND scope = 'default' AND scope_id = '0';

UPDATE core_config_data
  SET value = '1'
  WHERE path IN ('web/secure/use_in_frontend', 'web/secure/use_in_adminhtml')

UPDATE core_config_data
  SET value = '31536000'
  WHERE path = 'admin/security/session_lifetime';

UPDATE core_config_data
  SET value = '0'
  WHERE path IN (
    'dev/js/merge_files',
    'dev/js/minify_files',
    'dev/css/merge_css_files',
    'google/analytics/active',
    'web/secure/use_in_frontend',
    'web/secure/use_in_adminhtml'
  );

DELETE FROM core_config_data
  WHERE path IN (
    'web/unsecure/base_media_url',
    'web/secure/base_media_url',
    'web/unsecure/base_static_url',
    'web/secure/base_static_url',
    'web/unsecure/base_link_url',
    'google/analytics/account'
  );

UPDATE customer_entity
  SET email = CONCAT(REPLACE(email, '@', '-'), '@example.com')
  WHERE email NOT IN ('{{ .Env.APP_USER_EMAIL }}');

UPDATE customer_grid_flat
  SET email = CONCAT(REPLACE(email, '@', '-'), '@example.com')
  WHERE email NOT IN ('{{ .Env.APP_USER_EMAIL }}');

UPDATE newsletter_subscriber
  SET subscriber_email = CONCAT(REPLACE(subscriber_email, '@', '-'), '@example.com')
  WHERE subscriber_email NOT IN ('{{ .Env.APP_USER_EMAIL }}');

UPDATE sales_order
  SET customer_email = CONCAT(REPLACE(customer_email, '@', '-'), '@example.com')
  WHERE customer_email NOT IN ('{{ .Env.APP_USER_EMAIL }}');

UPDATE sales_order_address
  SET email = CONCAT(REPLACE(email, '@', '-'), '@example.com')
  WHERE email NOT IN ('{{ .Env.APP_USER_EMAIL }}');

UPDATE sales_order_grid
  SET customer_email = CONCAT(REPLACE(customer_email, '@', '-'), '@example.com')
  WHERE customer_email NOT IN ('{{ .Env.APP_USER_EMAIL }}');

UPDATE sales_invoice_grid
  SET customer_email = CONCAT(REPLACE(customer_email, '@', '-'), '@example.com')
  WHERE customer_email NOT IN ('{{ .Env.APP_USER_EMAIL }}');

UPDATE sales_shipment_grid
  SET customer_email = CONCAT(REPLACE(customer_email, '@', '-'), '@example.com')
  WHERE customer_email NOT IN ('{{ .Env.APP_USER_EMAIL }}');

UPDATE quote
  SET customer_email = CONCAT(REPLACE(customer_email, '@', '-'), '@example.com')
  WHERE customer_email NOT IN ('{{ .Env.APP_USER_EMAIL }}');

UPDATE quote_address
  SET email = CONCAT(REPLACE(email, '@', '-'), '@example.com')
  WHERE email NOT IN ('{{ .Env.APP_USER_EMAIL }}');

TRUNCATE TABLE `customer_log`;
TRUNCATE TABLE `customer_visitor`;
TRUNCATE TABLE `cron_schedule`;
TRUNCATE TABLE `persistent_session`;
TRUNCATE TABLE `session`;