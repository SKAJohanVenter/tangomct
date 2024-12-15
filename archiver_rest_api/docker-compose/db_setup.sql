-- Create a read only user to execute queries.
-- THIS IS NOT SUITABLE FOR PRODUCTION
\c hdb

CREATE ROLE web_anon nologin;
GRANT usage ON SCHEMA public TO web_anon;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO web_anon ;

CREATE ROLE rest_user noinherit login password 'password';
GRANT web_anon to rest_user;