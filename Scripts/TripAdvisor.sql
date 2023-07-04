DROP DATABASE IF EXISTS tripadvisor;

CREATE DATABASE tripadvisor;

CREATE  TABLE tripadvisor.`dic$city_types` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(10)  NOT NULL     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`dic$countries` ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	fullname             VARCHAR(250)  NOT NULL     ,
	shortname            VARCHAR(50)  NOT NULL     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`dic$regions` ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	fullname             VARCHAR(250)  NOT NULL     ,
	shortname            VARCHAR(100)  NOT NULL     ,
	`country_id`         BIGINT UNSIGNED NOT NULL     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`dic$roles` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(255)  NOT NULL     ,
	description          VARCHAR(2000)       ,
	active               TINYINT  NOT NULL DEFAULT (0)    
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`dic$sight_categories` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(200)  NOT NULL     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`dic$street_types` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(10)  NOT NULL     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`dic$tour_statuses` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(100)  NOT NULL     ,
	active               TINYINT  NOT NULL DEFAULT (1)    
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`event_types` ( 
	id                   INT  UNSIGNED NOT NULL     PRIMARY KEY,
	name                 VARCHAR(300)       ,
	description          TEXT(0)  NOT NULL     ,
	`create_date`        DATE  NOT NULL DEFAULT (CURRENT_DATE)    ,
	`is_default`         BIT  NOT NULL DEFAULT (0)    
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`image_extensions` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	extension            VARCHAR(4)  NOT NULL     ,
	description          VARCHAR(1000)       ,
	active               TINYINT  NOT NULL DEFAULT (1)    
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.images ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	url                  VARCHAR(2000)  NOT NULL     ,
	description          TEXT(0)       ,
	`extension_id`       INT UNSIGNED NOT NULL     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.tour_type ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(200)  NOT NULL     ,
	active               TINYINT  NOT NULL DEFAULT (1)    
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.users ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	login                VARCHAR(250)  NOT NULL     ,
	password             VARCHAR(100)  NOT NULL     ,
	displayname          VARCHAR(100)  NOT NULL     ,
	`create_date`        DATE  NOT NULL DEFAULT (CURRENT_DATE)    ,
	`register_date`      DATE       ,
	`reg_confirmed`      TINYINT  NOT NULL DEFAULT (0)    
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`dic$areas` ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	fullname             VARCHAR(250)  NOT NULL     ,
	shortname            VARCHAR(100)  NOT NULL     ,
	`region_id`          BIGINT UNSIGNED NOT NULL     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`dic$cities` ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(250)  NOT NULL     ,
	`type_id`            INT UNSIGNED NOT NULL     ,
	`area_id`            BIGINT UNSIGNED NOT NULL     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`dic$street` ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(250)  NOT NULL     ,
	`type_id`            INT UNSIGNED NOT NULL     ,
	`city_id`            BIGINT UNSIGNED NOT NULL     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.events ( 
	id                   BIGINT UNSIGNED NOT NULL     PRIMARY KEY,
	event                VARCHAR(250)  NOT NULL     ,
	description          TEXT(0)  NOT NULL     ,
	`create_date`        DATE  NOT NULL DEFAULT (CURRENT_DATE)    ,
	`owner_id`           BIGINT UNSIGNED NOT NULL     ,
	`event_date`         DATE  NOT NULL     ,
	`event_type`         INT UNSIGNED NOT NULL     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.tours ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	`user_id`            BIGINT UNSIGNED NOT NULL     ,
	tour_type            INT UNSIGNED NOT NULL     ,
	about                VARCHAR(1000)  NOT NULL     ,
	`start_date`         DATE  NOT NULL     ,
	`end_date`           DATE  NOT NULL     ,
	`departure_location` VARCHAR(2000)  NOT NULL     ,
	`destination_location` VARCHAR(2000)  NOT NULL     ,
	`status_id`          INT UNSIGNED NOT NULL DEFAULT (0)
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`user_details` ( 
	`user_id`            BIGINT UNSIGNED NOT NULL     PRIMARY KEY,
	about                VARCHAR(4000)       ,
	address              VARCHAR(1000)       ,
	coordinates          JSON       ,
	sex                  CHAR(1)       ,
	`birth_date`         DATE       ,
	email                VARCHAR(200)  NOT NULL     ,
	`city_id`            BIGINT UNSIGNED      
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`user_roles` ( 
	`user_id`            BIGINT UNSIGNED NOT NULL     ,
	`role_id`            INT UNSIGNED NOT NULL     ,
	CONSTRAINT `pk_user_role` PRIMARY KEY ( `user_id`, `role_id` )
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.caterings ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	tour_id              BIGINT UNSIGNED NOT NULL     ,
	name                 VARCHAR(300)  NOT NULL     ,
	description          TEXT(0)       ,
	visit_date           DATE  NOT NULL DEFAULT (CURRENT_DATE)    ,
	rating               SMALLINT UNSIGNED NOT NULL DEFAULT (0)    ,
	price                DECIMAL       
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.comforts ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	tour_id              BIGINT UNSIGNED NOT NULL     ,
	name                 VARCHAR(500)  NOT NULL     ,
	price                DECIMAL       ,
	price_info           DECIMAL       ,
	info                 VARCHAR(4000)       ,
	url                  VARCHAR(500)       
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`event_comments` ( 
	id                   BIGINT UNSIGNED NOT NULL     PRIMARY KEY,
	`event_id`           BIGINT UNSIGNED NOT NULL     ,
	comment              VARCHAR(4000)  NOT NULL     ,
	`create_date`        DATE  NOT NULL DEFAULT (CURRENT_DATE)    ,
	`owner_id`           BIGINT UNSIGNED NOT NULL     ,
	`parent_id`          BIGINT UNSIGNED     
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`event_location` ( 
	`event_id`           BIGINT UNSIGNED NOT NULL     PRIMARY KEY,
	address              VARCHAR(250)       ,
	coordinates          BIT       ,
	detail               VARCHAR(2000)       
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`event_members` ( 
	`event_id`           BIGINT UNSIGNED NOT NULL     ,
	`user_id`            BIGINT UNSIGNED NOT NULL     ,
	CONSTRAINT `pk_event_members` PRIMARY KEY ( `event_id`, `user_id` )
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.sights ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	`category_id`        INT  UNSIGNED NOT NULL     ,
	name                 VARCHAR(500)  NOT NULL     ,
	location             VARCHAR(1000)       ,
	coordinates          JSON       ,
	`tour_id`            BIGINT UNSIGNED      ,
	description          TEXT(0)       ,
	price                DECIMAL       ,
	`price_info`         VARCHAR(200)       ,
	url                  VARCHAR(1000)       
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`tour_details` ( 
	`tour_id`            BIGINT UNSIGNED NOT NULL     PRIMARY KEY,
	review               TEXT(0)       ,
	detail_info          VARCHAR(4000)       ,
	price                DECIMAL       ,
	coordinates          JSON       ,
	url                  VARCHAR(500)       
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`tour_images` ( 
	`tour_id`            BIGINT UNSIGNED NOT NULL     ,
	`image_id`           BIGINT UNSIGNED NOT NULL     ,
	CONSTRAINT `pk_tour_images` PRIMARY KEY ( `tour_id`, `image_id` )
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.catering_images ( 
	catering_id          BIGINT UNSIGNED NOT NULL     ,
	image_id             BIGINT UNSIGNED NOT NULL     ,
	CONSTRAINT pk_catering_images PRIMARY KEY ( catering_id, image_id )
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.comfort_images ( 
	comfort_id           BIGINT UNSIGNED NOT NULL     ,
	`image_id`           BIGINT UNSIGNED NOT NULL     ,
	CONSTRAINT pk_comfort_images PRIMARY KEY ( comfort_id, `image_id` )
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`sight_images` ( 
	`sight_id`           BIGINT UNSIGNED NOT NULL     ,
	`image_id`           BIGINT UNSIGNED NOT NULL     ,
	CONSTRAINT `pk_sight_images` PRIMARY KEY ( `sight_id`, `image_id` )
 ) engine=InnoDB;

ALTER TABLE tripadvisor.catering_images ADD CONSTRAINT fk_catering_images_caterings FOREIGN KEY ( catering_id ) REFERENCES tripadvisor.caterings( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.catering_images ADD CONSTRAINT fk_catering_images_images FOREIGN KEY ( image_id ) REFERENCES tripadvisor.images( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.caterings ADD CONSTRAINT fk_caterings_tours FOREIGN KEY ( tour_id ) REFERENCES tripadvisor.tours( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.comfort_images ADD CONSTRAINT fk_comfort_images_comforts FOREIGN KEY ( comfort_id ) REFERENCES tripadvisor.comforts( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.comfort_images ADD CONSTRAINT fk_comfort_images_images FOREIGN KEY ( `image_id` ) REFERENCES tripadvisor.images( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.comforts ADD CONSTRAINT fk_comforts_tour_id FOREIGN KEY ( tour_id ) REFERENCES tripadvisor.tours( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$areas` ADD CONSTRAINT `fk_dic$areas_dic$regions` FOREIGN KEY ( `region_id` ) REFERENCES tripadvisor.`dic$regions`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$cities` ADD CONSTRAINT `fk_dic$cities_dic$areas` FOREIGN KEY ( `area_id` ) REFERENCES tripadvisor.`dic$areas`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$cities` ADD CONSTRAINT `fk_dic$cities_dic$city_types` FOREIGN KEY ( `type_id` ) REFERENCES tripadvisor.`dic$city_types`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$regions` ADD CONSTRAINT `fk_dic$regions_dic$countries` FOREIGN KEY ( `country_id` ) REFERENCES tripadvisor.`dic$countries`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$street` ADD CONSTRAINT `fk_dic$street_dic$cities` FOREIGN KEY ( `city_id` ) REFERENCES tripadvisor.`dic$cities`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$street` ADD CONSTRAINT `fk_dic$street_dic$street_types` FOREIGN KEY ( `type_id` ) REFERENCES tripadvisor.`dic$street_types`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`event_comments` ADD CONSTRAINT `fk_event_comments_event_id` FOREIGN KEY ( `event_id` ) REFERENCES tripadvisor.events( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`event_comments` ADD CONSTRAINT `fk_event_comments_owner_id` FOREIGN KEY ( `owner_id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`event_location` ADD CONSTRAINT `fk_event_location_event_id` FOREIGN KEY ( `event_id` ) REFERENCES tripadvisor.events( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`event_members` ADD CONSTRAINT `fk_event member_id` FOREIGN KEY ( `user_id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`event_members` ADD CONSTRAINT `fk_event_members_event` FOREIGN KEY ( `event_id` ) REFERENCES tripadvisor.events( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.events ADD CONSTRAINT `fk_topics user_id` FOREIGN KEY ( `owner_id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.events ADD CONSTRAINT `fk_event_type_id` FOREIGN KEY ( `event_type` ) REFERENCES tripadvisor.`event_types`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.images ADD CONSTRAINT `fk_images image_extensions` FOREIGN KEY ( `extension_id` ) REFERENCES tripadvisor.`image_extensions`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`sight_images` ADD CONSTRAINT `fk_sight_images_images` FOREIGN KEY ( `image_id` ) REFERENCES tripadvisor.images( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`sight_images` ADD CONSTRAINT `fk_sight_images_sight` FOREIGN KEY ( `sight_id` ) REFERENCES tripadvisor.sights( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.sights ADD CONSTRAINT `fk_sights_tours` FOREIGN KEY ( `tour_id` ) REFERENCES tripadvisor.tours( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.sights ADD CONSTRAINT `fk_sights_dic$sight_categories` FOREIGN KEY ( `category_id` ) REFERENCES tripadvisor.`dic$sight_categories`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`tour_details` ADD CONSTRAINT `fk_tour_details_tours` FOREIGN KEY ( `tour_id` ) REFERENCES tripadvisor.tours( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`tour_images` ADD CONSTRAINT `fk_tour_images_images` FOREIGN KEY ( `image_id` ) REFERENCES tripadvisor.images( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`tour_images` ADD CONSTRAINT `fk_tour_images_tours` FOREIGN KEY ( `tour_id` ) REFERENCES tripadvisor.tours( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.tours ADD CONSTRAINT `fk_tours_users` FOREIGN KEY ( `user_id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.tours ADD CONSTRAINT `fk_tours_dic$tour_statuses` FOREIGN KEY ( `status_id` ) REFERENCES tripadvisor.`dic$tour_statuses`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.tours ADD CONSTRAINT fk_tours_type_id FOREIGN KEY ( tour_type ) REFERENCES tripadvisor.tour_type( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`user_details` ADD CONSTRAINT `fk_user_details_users` FOREIGN KEY ( `user_id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`user_details` ADD CONSTRAINT `fk_user_details_dic$cities` FOREIGN KEY ( `city_id` ) REFERENCES tripadvisor.`dic$cities`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`user_roles` ADD CONSTRAINT `fk_user_rights_users` FOREIGN KEY ( `user_id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`user_roles` ADD CONSTRAINT `fk_user_right_id` FOREIGN KEY ( `role_id` ) REFERENCES tripadvisor.`dic$roles`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$city_types` COMMENT 'Типы городов/населённых пунктов';

ALTER TABLE tripadvisor.`dic$city_types` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор типа города/населённого пункта';

ALTER TABLE tripadvisor.`dic$city_types` MODIFY name VARCHAR(10)  NOT NULL   COMMENT 'Тип';

ALTER TABLE tripadvisor.`dic$countries` COMMENT 'Справочник стран';

ALTER TABLE tripadvisor.`dic$countries` MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор страны';

ALTER TABLE tripadvisor.`dic$countries` MODIFY fullname VARCHAR(250)  NOT NULL   COMMENT 'Полное наименование страны';

ALTER TABLE tripadvisor.`dic$countries` MODIFY shortname VARCHAR(50)  NOT NULL   COMMENT 'Краткое наименование страны';

ALTER TABLE tripadvisor.`dic$regions` COMMENT 'Справочник регионов';

ALTER TABLE tripadvisor.`dic$regions` MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор региона';

ALTER TABLE tripadvisor.`dic$regions` MODIFY fullname VARCHAR(250)  NOT NULL   COMMENT 'Полное наименование региона';

ALTER TABLE tripadvisor.`dic$regions` MODIFY shortname VARCHAR(100)  NOT NULL   COMMENT 'Краткое наименовангие региона';

ALTER TABLE tripadvisor.`dic$regions` MODIFY `country_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор страны';

ALTER TABLE tripadvisor.`dic$roles` COMMENT 'Справочник видов прав';

ALTER TABLE tripadvisor.`dic$roles` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор права';

ALTER TABLE tripadvisor.`dic$roles` MODIFY name VARCHAR(255)  NOT NULL   COMMENT 'Наименование права';

ALTER TABLE tripadvisor.`dic$roles` MODIFY description VARCHAR(2000)     COMMENT 'Описание права';

ALTER TABLE tripadvisor.`dic$roles` MODIFY active TINYINT  NOT NULL DEFAULT (0)  COMMENT 'Признак возможности использования права';

ALTER TABLE tripadvisor.`dic$sight_categories` COMMENT 'Категории видов достопримечательностей';

ALTER TABLE tripadvisor.`dic$sight_categories` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор категории';

ALTER TABLE tripadvisor.`dic$sight_categories` MODIFY name VARCHAR(200)  NOT NULL   COMMENT 'Название категории';

ALTER TABLE tripadvisor.`dic$street_types` COMMENT 'Типы улиц';

ALTER TABLE tripadvisor.`dic$street_types` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор типа улицы';

ALTER TABLE tripadvisor.`dic$street_types` MODIFY name VARCHAR(10)  NOT NULL   COMMENT 'Тип';

ALTER TABLE tripadvisor.`dic$tour_statuses` COMMENT 'Справочник статусов для туров';

ALTER TABLE tripadvisor.`dic$tour_statuses` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор статуса для тура';

ALTER TABLE tripadvisor.`dic$tour_statuses` MODIFY name VARCHAR(100)  NOT NULL   COMMENT 'Тип статуса тура';

ALTER TABLE tripadvisor.`dic$tour_statuses` MODIFY active TINYINT  NOT NULL DEFAULT (1)  COMMENT 'Признак активности (доступности)';

ALTER TABLE tripadvisor.`event_types` COMMENT 'Справочник типов событий';

ALTER TABLE tripadvisor.`event_types` MODIFY id INT UNSIGNED NOT NULL   COMMENT 'Идентификатор';

ALTER TABLE tripadvisor.`event_types` MODIFY name VARCHAR(300)     COMMENT 'Наименование';

ALTER TABLE tripadvisor.`event_types` MODIFY description TEXT(0)  NOT NULL   COMMENT 'Описание';

ALTER TABLE tripadvisor.`event_types` MODIFY `create_date` DATE  NOT NULL DEFAULT (CURRENT_DATE)  COMMENT 'Дата создания';

ALTER TABLE tripadvisor.`event_types` MODIFY `is_default` BIT  NOT NULL DEFAULT (0)  COMMENT 'Признак по умолчанию';

ALTER TABLE tripadvisor.`image_extensions` COMMENT 'Форматы изображений';

ALTER TABLE tripadvisor.`image_extensions` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор формата';

ALTER TABLE tripadvisor.`image_extensions` MODIFY extension VARCHAR(4)  NOT NULL   COMMENT 'Формат (расширение)';

ALTER TABLE tripadvisor.`image_extensions` MODIFY description VARCHAR(1000)     COMMENT 'Описание формата';

ALTER TABLE tripadvisor.`image_extensions` MODIFY active TINYINT  NOT NULL DEFAULT (1)  COMMENT 'Активное расширение';

ALTER TABLE tripadvisor.images COMMENT 'Таблица ссылок на изображения';

ALTER TABLE tripadvisor.images MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор ссылки на изображение';

ALTER TABLE tripadvisor.images MODIFY url VARCHAR(2000)  NOT NULL   COMMENT 'Ссылка на изображение';

ALTER TABLE tripadvisor.images MODIFY description TEXT(0)     COMMENT 'Описание изображения';

ALTER TABLE tripadvisor.images MODIFY `extension_id` INT UNSIGNED NOT NULL   COMMENT 'Формат изображения';

ALTER TABLE tripadvisor.tour_type COMMENT 'Справочник типов туров';

ALTER TABLE tripadvisor.tour_type MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор типа тура';

ALTER TABLE tripadvisor.tour_type MODIFY name VARCHAR(200)  NOT NULL   COMMENT 'Тип тура';

ALTER TABLE tripadvisor.tour_type MODIFY active TINYINT  NOT NULL DEFAULT (1)  COMMENT 'Доступен к выбору/активный';

ALTER TABLE tripadvisor.users COMMENT 'Таблица пользователей';

ALTER TABLE tripadvisor.users MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Уникальный идентификатор пользователя';

ALTER TABLE tripadvisor.users MODIFY login VARCHAR(250)  NOT NULL   COMMENT 'Логин пользователя';

ALTER TABLE tripadvisor.users MODIFY password VARCHAR(100)  NOT NULL   COMMENT 'Пароль пользователя';

ALTER TABLE tripadvisor.users MODIFY displayname VARCHAR(100)  NOT NULL   COMMENT 'Отображаемое имя на сайте';

ALTER TABLE tripadvisor.users MODIFY `create_date` DATE  NOT NULL DEFAULT (CURRENT_DATE)  COMMENT 'Дата создания';

ALTER TABLE tripadvisor.users MODIFY `register_date` DATE     COMMENT 'Дата регистрации пользователя';

ALTER TABLE tripadvisor.users MODIFY `reg_confirmed` TINYINT  NOT NULL DEFAULT (0)  COMMENT 'Факт подтверждения регистрации';

ALTER TABLE tripadvisor.`dic$areas` COMMENT 'Справочник районов';

ALTER TABLE tripadvisor.`dic$areas` MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор района';

ALTER TABLE tripadvisor.`dic$areas` MODIFY fullname VARCHAR(250)  NOT NULL   COMMENT 'Полное наименование района';

ALTER TABLE tripadvisor.`dic$areas` MODIFY shortname VARCHAR(100)  NOT NULL   COMMENT 'Краткое наименовангие района';

ALTER TABLE tripadvisor.`dic$areas` MODIFY `region_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор региона';

ALTER TABLE tripadvisor.`dic$cities` COMMENT 'Справочник городов';

ALTER TABLE tripadvisor.`dic$cities` MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор района';

ALTER TABLE tripadvisor.`dic$cities` MODIFY name VARCHAR(250)  NOT NULL   COMMENT 'Наименование города';

ALTER TABLE tripadvisor.`dic$cities` MODIFY `type_id` INT UNSIGNED NOT NULL   COMMENT 'Тип города';

ALTER TABLE tripadvisor.`dic$cities` MODIFY `area_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор района';

ALTER TABLE tripadvisor.`dic$street` COMMENT 'Справочник улиц';

ALTER TABLE tripadvisor.`dic$street` MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор улицы';

ALTER TABLE tripadvisor.`dic$street` MODIFY name VARCHAR(250)  NOT NULL   COMMENT 'Наименование улицы';

ALTER TABLE tripadvisor.`dic$street` MODIFY `type_id` INT UNSIGNED NOT NULL   COMMENT 'Тип улицы';

ALTER TABLE tripadvisor.`dic$street` MODIFY `city_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор города';

ALTER TABLE tripadvisor.events COMMENT 'Таблица событий';

ALTER TABLE tripadvisor.events MODIFY id BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор';

ALTER TABLE tripadvisor.events MODIFY event VARCHAR(250)  NOT NULL   COMMENT 'Наименование события';

ALTER TABLE tripadvisor.events MODIFY description TEXT(0)  NOT NULL   COMMENT 'Содержанание';

ALTER TABLE tripadvisor.events MODIFY `create_date` DATE  NOT NULL DEFAULT (CURRENT_DATE)  COMMENT 'Дата создания';

ALTER TABLE tripadvisor.events MODIFY `owner_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Владелец (кто создал)';

ALTER TABLE tripadvisor.events MODIFY `event_date` DATE  NOT NULL   COMMENT 'Дата, на которую назначено событие';

ALTER TABLE tripadvisor.events MODIFY `event_type` INT UNSIGNED NOT NULL   COMMENT 'Тип события';

ALTER TABLE tripadvisor.tours COMMENT 'Туры, путешествия, турне, экскурсии, гастроли, поездки';

ALTER TABLE tripadvisor.tours MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор тура';

ALTER TABLE tripadvisor.tours MODIFY `user_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор пользователя (владельца)';

ALTER TABLE tripadvisor.tours MODIFY tour_type INT UNSIGNED NOT NULL   COMMENT 'Тип тура';

ALTER TABLE tripadvisor.tours MODIFY about VARCHAR(1000)  NOT NULL   COMMENT 'Кратко о туре';

ALTER TABLE tripadvisor.tours MODIFY `start_date` DATE  NOT NULL   COMMENT 'Дата начала';

ALTER TABLE tripadvisor.tours MODIFY `end_date` DATE  NOT NULL   COMMENT 'Дата окончания';

ALTER TABLE tripadvisor.tours MODIFY `departure_location` VARCHAR(2000)  NOT NULL   COMMENT 'Точка отправления (адрес)';

ALTER TABLE tripadvisor.tours MODIFY `destination_location` VARCHAR(2000)  NOT NULL   COMMENT 'Точка назначения (адрес)';

ALTER TABLE tripadvisor.tours MODIFY `status_id` INT UNSIGNED NOT NULL DEFAULT (0)  COMMENT 'Идентификатор статус тура';

ALTER TABLE tripadvisor.`user_details` COMMENT 'Таблица расширенной информации по пользователе';

ALTER TABLE tripadvisor.`user_details` MODIFY `user_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор пользователя';

ALTER TABLE tripadvisor.`user_details` MODIFY about VARCHAR(4000)     COMMENT 'О себе';

ALTER TABLE tripadvisor.`user_details` MODIFY address VARCHAR(1000)     COMMENT 'Адрес пользователя';

ALTER TABLE tripadvisor.`user_details` MODIFY coordinates JSON     COMMENT 'Месторасположение';

ALTER TABLE tripadvisor.`user_details` MODIFY sex CHAR(1)     COMMENT 'Пол пользователя';

ALTER TABLE tripadvisor.`user_details` MODIFY `birth_date` DATE     COMMENT 'Дата рождения пользователя';

ALTER TABLE tripadvisor.`user_details` MODIFY email VARCHAR(200)  NOT NULL   COMMENT 'Адрес электронной почты';

ALTER TABLE tripadvisor.`user_details` MODIFY `city_id` BIGINT UNSIGNED    COMMENT 'Город проживания';

ALTER TABLE tripadvisor.`user_roles` COMMENT 'Описание прав пользователей';

ALTER TABLE tripadvisor.`user_roles` MODIFY `user_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор пользователя';

ALTER TABLE tripadvisor.`user_roles` MODIFY `role_id` INT UNSIGNED NOT NULL   COMMENT 'Идентификатор права';

ALTER TABLE tripadvisor.caterings COMMENT 'Предпрития обещственного питания';

ALTER TABLE tripadvisor.caterings MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификтор общепита';

ALTER TABLE tripadvisor.caterings MODIFY tour_id BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор тура';

ALTER TABLE tripadvisor.caterings MODIFY name VARCHAR(300)  NOT NULL   COMMENT 'Наименование общепита';

ALTER TABLE tripadvisor.caterings MODIFY description TEXT(0)     COMMENT 'Описание общепита';

ALTER TABLE tripadvisor.caterings MODIFY visit_date DATE  NOT NULL DEFAULT (CURRENT_DATE)  COMMENT 'Дата посещения';

ALTER TABLE tripadvisor.caterings MODIFY rating SMALLINT UNSIGNED NOT NULL DEFAULT (0)  COMMENT 'Рейтинг заведения';

ALTER TABLE tripadvisor.caterings MODIFY price DECIMAL     COMMENT 'Стоимость покушать';

ALTER TABLE tripadvisor.comforts COMMENT 'Информация о месте проживания/отдыха/ночлеге';

ALTER TABLE tripadvisor.comforts MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор места отдыха';

ALTER TABLE tripadvisor.comforts MODIFY tour_id BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор тура/поездки';

ALTER TABLE tripadvisor.comforts MODIFY name VARCHAR(500)  NOT NULL   COMMENT 'Наименование места отдыха';

ALTER TABLE tripadvisor.comforts MODIFY price DECIMAL     COMMENT 'Цена за проижвание';

ALTER TABLE tripadvisor.comforts MODIFY price_info DECIMAL     COMMENT 'Распределение суммы оплаты';

ALTER TABLE tripadvisor.comforts MODIFY info VARCHAR(4000)     COMMENT 'Информация о месте проживания';

ALTER TABLE tripadvisor.comforts MODIFY url VARCHAR(500)     COMMENT 'Ссылка на сайт места проживания';

ALTER TABLE tripadvisor.`event_comments` COMMENT 'Комментарии к событиям';

ALTER TABLE tripadvisor.`event_comments` MODIFY id BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор комментария';

ALTER TABLE tripadvisor.`event_comments` MODIFY `event_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор события';

ALTER TABLE tripadvisor.`event_comments` MODIFY comment VARCHAR(4000)  NOT NULL   COMMENT 'Текст комментария';

ALTER TABLE tripadvisor.`event_comments` MODIFY `create_date` DATE  NOT NULL DEFAULT (CURRENT_DATE)  COMMENT 'Дата создания комментария';

ALTER TABLE tripadvisor.`event_comments` MODIFY `owner_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Автор комментария';

ALTER TABLE tripadvisor.`event_comments` MODIFY `parent_id` BIGINT UNSIGNED    COMMENT 'Идентификатор предыдущего комментария (только для ответов на комментарий) для построения дерева';

ALTER TABLE tripadvisor.`event_location` COMMENT 'Местонахождение события';

ALTER TABLE tripadvisor.`event_location` MODIFY `event_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор события';

ALTER TABLE tripadvisor.`event_location` MODIFY address VARCHAR(250)     COMMENT 'Адрес события';

ALTER TABLE tripadvisor.`event_location` MODIFY coordinates BIT     COMMENT 'Координаты широты и долготы';

ALTER TABLE tripadvisor.`event_location` MODIFY detail VARCHAR(2000)     COMMENT 'Дополнительная информация о локации';

ALTER TABLE tripadvisor.`event_members` COMMENT 'Участники события';

ALTER TABLE tripadvisor.`event_members` MODIFY `event_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Событие';

ALTER TABLE tripadvisor.`event_members` MODIFY `user_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Участник';

ALTER TABLE tripadvisor.sights COMMENT 'Достопримечательности';

ALTER TABLE tripadvisor.sights MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор достопримечательности';

ALTER TABLE tripadvisor.sights MODIFY `category_id` INT UNSIGNED NOT NULL   COMMENT 'Тип категории достопримечательности';

ALTER TABLE tripadvisor.sights MODIFY name VARCHAR(500)  NOT NULL   COMMENT 'Наименование';

ALTER TABLE tripadvisor.sights MODIFY location VARCHAR(1000)     COMMENT 'Месторасположение';

ALTER TABLE tripadvisor.sights MODIFY coordinates JSON     COMMENT 'Координаты';

ALTER TABLE tripadvisor.sights MODIFY `tour_id` BIGINT UNSIGNED    COMMENT 'Идентификатор тура';

ALTER TABLE tripadvisor.sights MODIFY description TEXT(0)     COMMENT 'Описание достопримечательности';

ALTER TABLE tripadvisor.sights MODIFY price DECIMAL     COMMENT 'Цена посещения';

ALTER TABLE tripadvisor.sights MODIFY `price_info` VARCHAR(200)     COMMENT 'Информация о том, как расчитывается цена';

ALTER TABLE tripadvisor.sights MODIFY url VARCHAR(1000)     COMMENT 'Адрес сайта о достопримечательности';

ALTER TABLE tripadvisor.`tour_details` COMMENT 'Таблица доп.информации о турах';

ALTER TABLE tripadvisor.`tour_details` MODIFY `tour_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор тура';

ALTER TABLE tripadvisor.`tour_details` MODIFY review TEXT(0)     COMMENT 'Отзыв автора о туре';

ALTER TABLE tripadvisor.`tour_details` MODIFY detail_info VARCHAR(4000)     COMMENT 'Дополнительная информация о туре';

ALTER TABLE tripadvisor.`tour_details` MODIFY price DECIMAL     COMMENT 'Цена за тур';

ALTER TABLE tripadvisor.`tour_details` MODIFY coordinates JSON     COMMENT 'Координаты места';

ALTER TABLE tripadvisor.`tour_details` MODIFY url VARCHAR(500)     COMMENT 'Ссылка на информационный сайт';

ALTER TABLE tripadvisor.`tour_images` COMMENT 'Изображения в рамках тура';

ALTER TABLE tripadvisor.`tour_images` MODIFY `tour_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор тура';

ALTER TABLE tripadvisor.`tour_images` MODIFY `image_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор изображения';

ALTER TABLE tripadvisor.catering_images COMMENT 'Изображения в рамках общепита';

ALTER TABLE tripadvisor.catering_images MODIFY catering_id BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор обещпита';

ALTER TABLE tripadvisor.catering_images MODIFY image_id BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор изображения';

ALTER TABLE tripadvisor.comfort_images COMMENT 'Изображения в рамках ночлега';

ALTER TABLE tripadvisor.comfort_images MODIFY comfort_id BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор ночлега';

ALTER TABLE tripadvisor.comfort_images MODIFY `image_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор изображения';

ALTER TABLE tripadvisor.`sight_images` COMMENT 'Изображения в рамках тура';

ALTER TABLE tripadvisor.`sight_images` MODIFY `sight_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор достопримечательности';

ALTER TABLE tripadvisor.`sight_images` MODIFY `image_id` BIGINT UNSIGNED NOT NULL   COMMENT 'Идентификатор изображения';

