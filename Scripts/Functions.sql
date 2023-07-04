DELIMITER $$

DROP FUNCTION IF EXISTS get_roles;
CREATE FUNCTION get_roles() RETURNS JSON
    DETERMINISTIC
    BEGIN
    DECLARE data JSON;

    SELECT JSON_ARRAYAGG(JSON_OBJECT(
        'id', dr.id,
        'name', dr.name,
        'description', dr.description,
        'active', dr.active
    )) JSON
    INTO data
    FROM tripadvisor.dic$roles dr;
    
    IF data IS NULL OR JSON_LENGTH(data) = 0 THEN
        SET data = JSON_ARRAY(); -- Set a default empty JSON array
    END IF;

    RETURN data;
    END$$

DELIMITER ;

DELIMITER $$

DROP FUNCTION IF EXISTS get_user_by_id;
CREATE FUNCTION get_user_by_id(user_id BIGINT UNSIGNED) RETURNS JSON
    DETERMINISTIC
    BEGIN
    DECLARE data JSON;

    SELECT JSON_OBJECT(
        'id', us.id,
        'login', us.login,
        'displayname', us.displayname,
        'create_date', us.create_date,
        'reg_confirmed', us.reg_confirmed,
        'about', usd.about,
        'address', usd.address,
        'about', usd.about,
        'coordinates', usd.coordinates,
        'sex', usd.sex,
        'birth_date', usd.birth_date,
        'email', usd.email,
        'city', cty.name
    ) JSON
    INTO data
    FROM tripadvisor.users us
    INNER JOIN tripadvisor.user_details usd on usd.user_id=us.id
    LEFT JOIN tripadvisor.dic$cities cty on usd.city_id = cty.id
    WHERE us.id = user_id;
    
    IF data IS NULL OR JSON_LENGTH(data) = 0 THEN
        SET data = JSON_OBJECT(); -- Set a default empty JSON object
    END IF;

    RETURN data;
    END$$

DELIMITER ;

DELIMITER $$

DROP FUNCTION IF EXISTS get_users;
CREATE FUNCTION get_users(noffset INT UNSIGNED, nrows INT UNSIGNED) RETURNS JSON
    DETERMINISTIC
    BEGIN
    DECLARE data JSON;

    SELECT JSON_ARRAYAGG(JSON_OBJECT(
        'id', us.id,
        'login', us.login,
        'displayname', us.displayname,
        'create_date', us.create_date,
        'reg_confirmed', us.reg_confirmed,
        'about', usd.about,
        'address', usd.address,
        'about', usd.about,
        'coordinates', usd.coordinates,
        'sex', usd.sex,
        'birth_date', usd.birth_date,
        'email', usd.email,
        'city', cty.name
    )) JSON
    INTO data
    FROM (SELECT id,login,displayname,create_date,reg_confirmed FROM tripadvisor.users ORDER BY ID ASC LIMIT nrows OFFSET noffset) us 
    INNER JOIN tripadvisor.user_details usd on usd.user_id=us.id
    LEFT JOIN tripadvisor.dic$cities cty on usd.city_id = cty.id;
    
    IF data IS NULL OR JSON_LENGTH(data) = 0 THEN
        SET data = JSON_ARRAY(); -- Set a default empty JSON array
    END IF;

    RETURN data;
    END$$

DELIMITER ;

DELIMITER $$

DROP FUNCTION IF EXISTS get_user_role;
CREATE FUNCTION get_user_role(user_id BIGINT UNSIGNED) RETURNS JSON
    DETERMINISTIC
    BEGIN
    DECLARE data JSON;

    SELECT JSON_OBJECT(
        'id', us.id,
        'role', dr.name,
        'active', dr.active
    ) JSON
    INTO data
    FROM tripadvisor.users us 
    LEFT JOIN tripadvisor.user_roles ur on ur.user_id=us.id
    LEFT JOIN tripadvisor.dic$roles dr on ur.role_id=dr.id
    WHERE us.id = user_id;
    
    IF data IS NULL OR JSON_LENGTH(data) = 0 THEN
        SET data = JSON_OBJECT(); -- Set a default empty JSON object
    END IF;

    RETURN data;
    END$$

DELIMITER ;

DELIMITER $$

DROP FUNCTION IF EXISTS add_role;
CREATE FUNCTION add_role(inputJson TEXT)
RETURNS JSON
BEGIN
    DECLARE id INT UNSIGNED; -- Role id
    DECLARE error_code INT;
    DECLARE error_message VARCHAR(1000);
    DECLARE v_name VARCHAR(255);
    DECLARE v_description VARCHAR(2000);
    DECLARE v_active TINYINT;
    DECLARE outputJson JSON;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
      GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
    
	  SET error_code = -1;
	  SET error_message = @p2;
	  SET outputJson = JSON_OBJECT('id', id, 'error', JSON_OBJECT('code',error_code,'message',error_message));
      RETURN outputJson;
	END;
    
    SET error_code = 0;
    SET error_message = NULL;
    
    -- Parse the input JSON
    SET v_name = TRIM(JSON_VALUE(inputJson->'$.name', '$'));
    SET v_description = TRIM(JSON_VALUE(inputJson->'$.description', '$'));
    SET v_active = TRIM(JSON_VALUE(inputJson->'$.active', '$'));
    
    IF LENGTH(v_name) = 0 THEN
        SET error_code = -2;
        SET error_message = 'Name is empty';
    END IF;
    
    IF v_name is NULL THEN
        SET error_code = -3;
        SET error_message = 'Name is null';
    END IF;
    
    IF LENGTH(v_description) = 0 THEN
        SET error_code = -4;
        SET error_message = 'Description is empty';
    END IF;
    
    IF v_description is NULL THEN
        SET error_code = -5;
        SET error_message = 'Description is null';
    END IF;
    
    IF error_code < 0 THEN
        SET outputJson = JSON_OBJECT('id', id, 'error', JSON_OBJECT('code',error_code,'message',error_message));
		RETURN outputJson;
    END IF;
    
    -- Insert into dic$roles table
    INSERT INTO tripadvisor.dic$roles (name,description,active) VALUES (v_name,v_description,v_active);
    SET id = LAST_INSERT_ID();
    
    -- Build the output JSON
    SET outputJson = JSON_OBJECT('id', id, 'error', JSON_OBJECT('code',error_code,'message',error_message));
    
    RETURN outputJson;
END$$

DELIMITER ;

DELIMITER $$

DROP FUNCTION IF EXISTS add_user;
CREATE FUNCTION add_user(inputJson TEXT)
RETURNS JSON
BEGIN
    DECLARE id BIGINT UNSIGNED; -- User id
    DECLARE error_code INT;
    DECLARE error_message VARCHAR(1000);
    DECLARE v_role_id INT UNSIGNED;
    DECLARE v_login VARCHAR(250);
    DECLARE v_password VARCHAR(100);
    DECLARE v_displayname VARCHAR(100);
    DECLARE v_register_date DATE;
    DECLARE v_about VARCHAR(4000);
    DECLARE v_address VARCHAR(1000);
    DECLARE v_coordinates VARCHAR(500);
    DECLARE v_sex CHAR(1);
    DECLARE v_birth_date DATE;
    DECLARE v_email VARCHAR(200);
    DECLARE v_city_id BIGINT UNSIGNED;
    DECLARE v_city_id_check BIGINT UNSIGNED;
    DECLARE outputJson JSON;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
      GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
    
	  SET error_code = -1;
	  SET error_message = @p2;
	  SET outputJson = JSON_OBJECT('id', id, 'error', JSON_OBJECT('code',error_code,'message',error_message));
      RETURN outputJson;
	END;
    
    SET error_code = 0;
    SET error_message = NULL;
    
    -- Parse the input JSON
    SET v_login = TRIM(JSON_VALUE(inputJson->'$.login', '$'));
    SET v_password = TRIM(JSON_VALUE(inputJson->'$.password', '$'));
    SET v_displayname = TRIM(JSON_VALUE(inputJson->'$.displayname', '$'));
    SET v_register_date = TRIM(JSON_VALUE(inputJson->'$.register_date', '$'));
    SET v_about = JSON_VALUE(inputJson->'$.about', '$');
    SET v_address = TRIM(JSON_VALUE(inputJson->'$.address', '$'));
    SET v_coordinates = TRIM(JSON_VALUE(inputJson->'$.coordinates', '$'));
    SET v_sex = TRIM(JSON_VALUE(inputJson->'$.sex', '$'));
    SET v_birth_date = TRIM(JSON_VALUE(inputJson->'$.birth_date', '$'));
    SET v_email = TRIM(JSON_VALUE(inputJson->'$.email', '$'));
    SET v_city_id = TRIM(JSON_VALUE(inputJson->'$.city_id', '$'));
    SET v_role_id = TRIM(JSON_VALUE(inputJson->'$.role_id', '$'));
    
    IF LENGTH(v_login) = 0 THEN
		SET error_code = -2;
        SET error_message = 'Login is empty';   
    END IF;
    
    IF v_login is NULL THEN
        SET error_code = -3;
        SET error_message = 'Login is null';
    END IF;
    
    IF LENGTH(v_password) = 0 THEN
        SET error_code = -4;
        SET error_message = 'Password is empty';
    END IF;
    
    IF v_password is NULL THEN
        SET error_code = -5;
        SET error_message = 'Password is null';
    END IF;
    
    IF LENGTH(v_displayname) = 0 THEN
        SET error_code = -6;
        SET error_message = 'Displayname is empty';
    END IF;
    
    IF v_displayname is NULL THEN
        SET error_code = -7;
        SET error_message = 'Displayname is null';
    END IF;
    
    IF v_city_id is not NULL THEN
		SELECT dc.id INTO v_city_id_check FROM tripadvisor.dic$cities dc WHERE dc.id = v_city_id;
        
		IF v_city_id_check is NULL THEN
		  SET error_code = -8;
		  SET error_message = 'Incorrect city identifier provided';		  
		END IF;
    END IF;
    
    IF LENGTH(v_role_id) = 0 THEN
        SET error_code = -9;
        SET error_message = 'User role is empty';
    END IF;
    
    IF v_role_id is NULL THEN
        SET error_code = -10;
        SET error_message = 'User role is null';
    END IF;
    
    IF error_code < 0 THEN
        SET outputJson = JSON_OBJECT('id', id, 'error', JSON_OBJECT('code',error_code,'message',error_message));
		RETURN outputJson;
    END IF;
    
    -- Insert into users table
    INSERT INTO tripadvisor.users (login,password,displayname,register_date) VALUES (v_login,v_password,v_displayname,v_register_date);
    SET id = LAST_INSERT_ID();
    
    -- Insert into user_details table
    INSERT INTO tripadvisor.user_details (user_id,about,address,coordinates,sex,birth_date,email,city_id) VALUES (id,v_about,v_address,v_coordinates,v_sex,v_birth_date,v_email,v_city_id);
    
    -- Insert into user_roles table
    INSERT INTO tripadvisor.user_roles (user_id,role_id) VALUES (id,v_role_id);
    
    -- Build the output JSON
    SET outputJson = JSON_OBJECT('id', id, 'error', JSON_OBJECT('code',error_code,'message',error_message));
    
    RETURN outputJson;
END$$

DELIMITER ;