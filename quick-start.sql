CREATE DATABASE demo;
ALTER DATABASE demo SET session_preload_libraries = 'anon';

CREATE TABLE people AS
SELECT  153478       AS id,
        'Sarah'      AS firstname,
        'Conor'      AS lastname,
        '0609110911' AS phone
;

SELECT * FROM people;

CREATE EXTENSION anon;
ALTER DATABASE demo SET anon.transparent_dynamic_masking TO true;

CREATE ROLE skynet LOGIN;

SECURITY LABEL FOR anon ON ROLE skynet IS 'MASKED';

GRANT pg_read_all_data to skynet;

SECURITY LABEL FOR anon ON COLUMN people.lastname
  IS 'MASKED WITH FUNCTION anon.dummy_last_name()';

SECURITY LABEL FOR anon ON COLUMN people.phone
  IS 'MASKED WITH FUNCTION anon.partial(phone,2,$$******$$,2)';