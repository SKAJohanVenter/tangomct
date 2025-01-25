-- THIS IS NOT SUITABLE FOR PRODUCTION


-- Create a read only user to execute queries.
\c hdb

CREATE ROLE web_anon nologin;
GRANT usage ON SCHEMA public TO web_anon;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO web_anon ;

CREATE ROLE rest_user noinherit login password 'password';
GRANT web_anon to rest_user;

-- Add in the views to simplify queries

CREATE OR REPLACE VIEW view_att_array_devboolean AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devboolean AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devdouble AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devdouble AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devencoded AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devencoded AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devenum AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devenum AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devfloat AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devfloat AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devlong AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devlong AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devlong64 AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devlong64 AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devshort AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devshort AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devstate AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devstate AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devstring AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devstring AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devuchar AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devuchar AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devulong AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devulong AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devulong64 AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devulong64 AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_array_devushort AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_array_devushort AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devboolean AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devboolean AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devdouble AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devdouble AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devencoded AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devencoded AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devenum AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devenum AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devfloat AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devfloat AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devlong AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devlong AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devlong64 AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devlong64 AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devshort AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devshort AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devstate AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devstate AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devstring AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devstring AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devuchar AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devuchar AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devulong AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devulong AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devulong64 AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devulong64 AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_image_devushort AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_image_devushort AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devboolean AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devboolean AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devdouble AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devdouble AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devencoded AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devencoded AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devenum AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devenum AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devfloat AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devfloat AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devlong AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devlong AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devlong64 AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devlong64 AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devshort AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devshort AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devstate AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devstate AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devstring AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devstring AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devuchar AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devuchar AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devulong AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devulong AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devulong64 AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devulong64 AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id

CREATE OR REPLACE VIEW view_att_scalar_devushort AS
SELECT attr_type.*,
   att_conf.att_name,
   att_conf.cs_name,
   att_conf.domain,
   att_conf.family,
   att_conf.member,
   att_conf.name
    FROM att_scalar_devushort AS attr_type
    INNER JOIN att_conf ON
        attr_type.att_conf_id = att_conf.att_conf_id
