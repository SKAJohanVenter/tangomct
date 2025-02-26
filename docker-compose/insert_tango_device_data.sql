\c hdb

-- Data for att_conf_type

INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('14','DEV_ENUM','29') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('13','DEV_ENCODED','28') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('12','DEV_ULONG64','24') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('11','DEV_LONG64','23') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('10','DEV_UCHAR','22') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('9','DEV_STATE','19') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('8','DEV_STRING','8') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('7','DEV_ULONG','7') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('6','DEV_USHORT','6') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('5','DEV_DOUBLE','5') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('4','DEV_FLOAT','4') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('3','DEV_LONG','3') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('2','DEV_SHORT','2') ON CONFLICT (att_conf_type_id) DO NOTHING;
INSERT INTO att_conf_type (att_conf_type_id,type,type_num) VALUES ('1','DEV_BOOLEAN','1') ON CONFLICT (att_conf_type_id) DO NOTHING;


-- Data for att_conf_format (limited to 1000 rows)
INSERT INTO att_conf_format (att_conf_format_id,format,format_num) VALUES ('3','IMAGE','2') ON CONFLICT (att_conf_format_id) DO NOTHING;
INSERT INTO att_conf_format (att_conf_format_id,format,format_num) VALUES ('2','SPECTRUM','1') ON CONFLICT (att_conf_format_id) DO NOTHING;
INSERT INTO att_conf_format (att_conf_format_id,format,format_num) VALUES ('1','SCALAR','0') ON CONFLICT (att_conf_format_id) DO NOTHING;

-- Data for att_conf_write (limited to 1000 rows)
INSERT INTO att_conf_write (att_conf_write_id,write,write_num) VALUES ('4','READ_WRITE','3') ON CONFLICT (att_conf_write_id) DO NOTHING;
INSERT INTO att_conf_write (att_conf_write_id,write,write_num) VALUES ('3','WRITE','2') ON CONFLICT (att_conf_write_id) DO NOTHING;
INSERT INTO att_conf_write (att_conf_write_id,write,write_num) VALUES ('2','READ_WITH_WRITE','1') ON CONFLICT (att_conf_write_id) DO NOTHING;
INSERT INTO att_conf_write (att_conf_write_id,write,write_num) VALUES ('1','READ','0') ON CONFLICT (att_conf_write_id) DO NOTHING;

-- Data for att_conf

INSERT INTO att_conf (att_conf_id,att_name,att_conf_type_id,att_conf_format_id,att_conf_write_id,table_name,cs_name,domain,family,member,name,ttl,hide) VALUES ('116','tango://databaseds:10000/sys/tg_test/1/short_scalar_ro','2','1','1','att_scalar_devshort','databaseds:10000','sys','tg_test','1','short_scalar_ro','0','f') ON CONFLICT (att_conf_id) DO NOTHING;
INSERT INTO att_conf (att_conf_id,att_name,att_conf_type_id,att_conf_format_id,att_conf_write_id,table_name,cs_name,domain,family,member,name,ttl,hide) VALUES ('147','tango://databaseds:10000/sys/tg_test/1/double_scalar','5','1','4','att_scalar_devdouble','databaseds:10000','sys','tg_test','1','double_scalar','0','f') ON CONFLICT (att_conf_id) DO NOTHING;
INSERT INTO att_conf (att_conf_id,att_name,att_conf_type_id,att_conf_format_id,att_conf_write_id,table_name,cs_name,domain,family,member,name,ttl,hide) VALUES ('146','tango://databaseds:10000/sys/tg_test/1/float_scalar','4','1','4','att_scalar_devfloat','databaseds:10000','sys','tg_test','1','float_scalar','0','f') ON CONFLICT (att_conf_id) DO NOTHING;
INSERT INTO att_conf (att_conf_id,att_name,att_conf_type_id,att_conf_format_id,att_conf_write_id,table_name,cs_name,domain,family,member,name,ttl,hide) VALUES ('117','tango://databaseds:10000/sys/tg_test/1/double_image','5','3','4','att_image_devdouble','databaseds:10000','sys','tg_test','1','double_image','0','f') ON CONFLICT (att_conf_id) DO NOTHING;

-- Data for att_error_desc (limited to 1000 rows)
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('14','Read value for attribute healthState has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('13','Read value for attribute actStaticOffsetValueXel has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('12','Read value for attribute dscState has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('11','Read value for attribute achievedTargetLock has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('10','Read value for attribute indexerPosition has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('9','Read value for attribute desiredPointingAz has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('8','Read value for attribute desiredPointingEl has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('7','Read value for attribute actStaticOffsetValueEl has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('6','Read value for attribute operatingMode has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('5','Read value for attribute powerState has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('4','Read value for attribute pointingState has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('3','Read value for attribute achievedPointing has not been updated') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('2','Talon Board is OFF') ON CONFLICT (att_error_desc_id) DO NOTHING;
INSERT INTO att_error_desc (att_error_desc_id,error_desc) VALUES ('1','Event channel is not responding anymore') ON CONFLICT (att_error_desc_id) DO NOTHING;

-- Data for devshort
INSERT INTO att_scalar_devshort 
 (att_conf_id,data_time,value_r,value_w,quality,details,att_error_desc_id)
SELECT 
    '116',
    NOW() - INTERVAL '1 month' + (random() * INTERVAL '1 month'),
    floor(random() * 100),
    NULL,'0',NULL,NULL
FROM generate_series(1, 10000) ON CONFLICT (att_conf_id,data_time) DO NOTHING;

-- Data for devdouble
INSERT INTO att_scalar_devdouble 
 (att_conf_id,data_time,value_r,value_w,quality,details,att_error_desc_id)
SELECT 
    '147',
    NOW() - INTERVAL '1 month' + (random() * INTERVAL '1 month'),
    floor(random() * 1000),
    NULL,'0',NULL,NULL
FROM generate_series(1, 10000) ON CONFLICT (att_conf_id,data_time) DO NOTHING;

-- Data for devfloat
INSERT INTO att_scalar_devfloat 
 (att_conf_id,data_time,value_r,value_w,quality,details,att_error_desc_id)
SELECT 
    '146',
    NOW() - INTERVAL '1 month' + (random() * INTERVAL '1 month'),
    random() * 1000,
    NULL,'0',NULL,NULL
FROM generate_series(1, 10000) ON CONFLICT (att_conf_id,data_time) DO NOTHING;

