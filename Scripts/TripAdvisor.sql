CREATE SCHEMA tripadvisor;

CREATE DOMAIN gender CHAR(1)
CHECK (value IN ('F','M'));;

CREATE  TABLE tripadvisor.`dic$city types` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(10)  NOT NULL     
 );

CREATE  TABLE tripadvisor.`dic$countries` ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	fullname             VARCHAR(250)  NOT NULL     ,
	shortname            VARCHAR(50)  NOT NULL     
 );

CREATE  TABLE tripadvisor.`dic$regions` ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	fullname             VARCHAR(250)  NOT NULL     ,
	shortname            VARCHAR(100)  NOT NULL     ,
	`country id`         BIGINT  NOT NULL     
 );

CREATE  TABLE tripadvisor.`dic$roles` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(255)  NOT NULL     ,
	description          VARCHAR(2000)       ,
	active               TINYINT  NOT NULL DEFAULT (0)    
 );

CREATE  TABLE tripadvisor.`dic$sight categories` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(200)  NOT NULL     
 );

CREATE  TABLE tripadvisor.`dic$street types` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(10)  NOT NULL     
 );

CREATE  TABLE tripadvisor.`dic$tour statuses` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(100)  NOT NULL     ,
	active               TINYINT  NOT NULL DEFAULT (1)    
 );

CREATE  TABLE tripadvisor.`event types` ( 
	id                   INT  NOT NULL     PRIMARY KEY,
	name                 VARCHAR(300)       ,
	description          TEXT(0)  NOT NULL     ,
	`create date`        DATE  NOT NULL DEFAULT (CURRENT_DATE)    ,
	`is default`         BIT  NOT NULL DEFAULT (0)    
 );

CREATE  TABLE tripadvisor.`image extensions` ( 
	id                   INT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	extension            VARCHAR(4)  NOT NULL     ,
	description          VARCHAR(1000)       ,
	active               TINYINT  NOT NULL DEFAULT (1)    
 );

CREATE  TABLE tripadvisor.images ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	url                  VARCHAR(2000)  NOT NULL     ,
	description          TEXT(0)       ,
	`extension id`       INT  NOT NULL     
 );

CREATE  TABLE tripadvisor.tbl ( 
 );

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
	`create date`        DATE  NOT NULL DEFAULT (CURRENT_DATE)    ,
	`register date`      DATE       ,
	`reg confirmed`      TINYINT  NOT NULL DEFAULT (0)    
 );

CREATE  TABLE tripadvisor.вш ( 
 );

CREATE  TABLE tripadvisor.`dic$areas` ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	fullname             VARCHAR(250)  NOT NULL     ,
	shortname            VARCHAR(100)  NOT NULL     ,
	`region id`          BIGINT  NOT NULL     
 );

CREATE  TABLE tripadvisor.`dic$cities` ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(250)  NOT NULL     ,
	`type id`            INT  NOT NULL     ,
	`area id`            BIGINT  NOT NULL     
 );

CREATE  TABLE tripadvisor.`dic$street` ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(250)  NOT NULL     ,
	`type id`            INT  NOT NULL     ,
	`city id`            BIGINT  NOT NULL     
 );

CREATE  TABLE tripadvisor.events ( 
	id                   BIGINT  NOT NULL     PRIMARY KEY,
	event                VARCHAR(250)  NOT NULL     ,
	description          TEXT(0)  NOT NULL     ,
	`create date`        DATE  NOT NULL DEFAULT (CURRENT_DATE)    ,
	`owner id`           BIGINT  NOT NULL     ,
	`event date`         DATE  NOT NULL     ,
	`event type`         INT  NOT NULL     
 );

CREATE  TABLE tripadvisor.tours ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	`user id`            BIGINT  NOT NULL     ,
	tour_type            INT  NOT NULL     ,
	about                VARCHAR(1000)  NOT NULL     ,
	`start date`         DATE  NOT NULL     ,
	`end date`           DATE  NOT NULL     ,
	`departure location` VARCHAR(2000)  NOT NULL     ,
	`destination location` VARCHAR(2000)  NOT NULL     ,
	`status id`          INT  NOT NULL DEFAULT (0)    ,
	CONSTRAINT `unq tours status id` UNIQUE ( `status id` ) 
 );

CREATE  TABLE tripadvisor.`user details` ( 
	`user id`            BIGINT  NOT NULL     PRIMARY KEY,
	about                VARCHAR(4000)       ,
	address              VARCHAR(1000)       ,
	location             VARCHAR(500)       ,
	sex                  CHAR(1)       ,
	`birth date`         DATE       ,
	email                VARCHAR(200)  NOT NULL     ,
	`city id`            BIGINT       
 );

CREATE  TABLE tripadvisor.`user roles` ( 
	`user id`            BIGINT  NOT NULL     ,
	`role id`            INT  NOT NULL     ,
	CONSTRAINT `pk user role` PRIMARY KEY ( `user id`, `role id` )
 );

CREATE  TABLE tripadvisor.caterings ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	tour_id              BIGINT  NOT NULL     ,
	name                 VARCHAR(300)  NOT NULL     ,
	description          TEXT(0)       ,
	visit_date           DATE  NOT NULL DEFAULT (CURRENT_DATE)    ,
	rating               SMALLINT UNSIGNED NOT NULL DEFAULT (0)    ,
	price                DECIMAL       
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.comforts ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	tour_id              BIGINT  NOT NULL     ,
	name                 VARCHAR(500)  NOT NULL     ,
	price                DECIMAL       ,
	price_info           DECIMAL       ,
	info                 VARCHAR(4000)       ,
	url                  VARCHAR(500)       
 ) engine=InnoDB;

CREATE  TABLE tripadvisor.`event comments` ( 
	id                   BIGINT  NOT NULL     PRIMARY KEY,
	`event id`           BIGINT  NOT NULL     ,
	comment              VARCHAR(4000)  NOT NULL     ,
	`create date`        DATE  NOT NULL DEFAULT (CURRENT_DATE)    ,
	`owner id`           BIGINT  NOT NULL     ,
	`parent id`          BIGINT       
 );

CREATE  TABLE tripadvisor.`event location` ( 
	`event id`           BIGINT  NOT NULL     PRIMARY KEY,
	address              VARCHAR(250)       ,
	coordinates          BIT       ,
	detail               VARCHAR(2000)       
 );

CREATE  TABLE tripadvisor.`event members` ( 
	`event id`           BIGINT  NOT NULL     ,
	`user id`            BIGINT  NOT NULL     ,
	CONSTRAINT `pk event members` PRIMARY KEY ( `event id`, `user id` )
 );

CREATE  TABLE tripadvisor.sights ( 
	id                   BIGINT UNSIGNED NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	`category id`        INT  NOT NULL     ,
	name                 VARCHAR(500)  NOT NULL     ,
	location             VARCHAR(1000)       ,
	coordinates          JSON       ,
	`tour id`            BIGINT       ,
	description          TEXT(0)       ,
	price                DECIMAL       ,
	`price info`         VARCHAR(200)       ,
	url                  VARCHAR(1000)       
 );

CREATE  TABLE tripadvisor.`tour details` ( 
	`tour id`            BIGINT  NOT NULL     PRIMARY KEY,
	review               TEXT(0)       ,
	detail_info          VARCHAR(4000)       ,
	price                DECIMAL       ,
	coordinates          JSON       ,
	url                  VARCHAR(500)       
 );

CREATE  TABLE tripadvisor.`tour images` ( 
	`tour id`            BIGINT  NOT NULL     ,
	`image id`           BIGINT  NOT NULL     ,
	CONSTRAINT `pk tour images` PRIMARY KEY ( `tour id`, `image id` )
 );

CREATE  TABLE tripadvisor.catering_images ( 
	catering_id          BIGINT  NOT NULL     ,
	image_id             BIGINT  NOT NULL     ,
	CONSTRAINT pk_catering_images PRIMARY KEY ( catering_id, image_id )
 );

CREATE  TABLE tripadvisor.comfort_images ( 
	comfort_id           BIGINT  NOT NULL     ,
	`image id`           BIGINT  NOT NULL     ,
	CONSTRAINT pk_comfort_images PRIMARY KEY ( comfort_id, `image id` )
 );

CREATE  TABLE tripadvisor.`sight images` ( 
	`sight id`           BIGINT  NOT NULL     ,
	`image id`           BIGINT  NOT NULL     ,
	CONSTRAINT `pk sight images` PRIMARY KEY ( `sight id`, `image id` )
 );

ALTER TABLE tripadvisor.catering_images ADD CONSTRAINT fk_catering_images_caterings FOREIGN KEY ( catering_id ) REFERENCES tripadvisor.caterings( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.catering_images ADD CONSTRAINT fk_catering_images_images FOREIGN KEY ( image_id ) REFERENCES tripadvisor.images( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.caterings ADD CONSTRAINT fk_caterings_tours FOREIGN KEY ( tour_id ) REFERENCES tripadvisor.tours( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.comfort_images ADD CONSTRAINT fk_comfort_images_comforts FOREIGN KEY ( comfort_id ) REFERENCES tripadvisor.comforts( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.comfort_images ADD CONSTRAINT fk_comfort_images_images FOREIGN KEY ( `image id` ) REFERENCES tripadvisor.images( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.comforts ADD CONSTRAINT fk_comforts_tour_id FOREIGN KEY ( tour_id ) REFERENCES tripadvisor.tours( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$areas` ADD CONSTRAINT `fk dic$areas dic$regions` FOREIGN KEY ( `region id` ) REFERENCES tripadvisor.`dic$regions`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$cities` ADD CONSTRAINT `fk dic$cities dic$areas` FOREIGN KEY ( `area id` ) REFERENCES tripadvisor.`dic$areas`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$cities` ADD CONSTRAINT `fk dic$cities dic$city types` FOREIGN KEY ( `area id` ) REFERENCES tripadvisor.`dic$city types`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$regions` ADD CONSTRAINT `fk dic$regions dic$countries` FOREIGN KEY ( `country id` ) REFERENCES tripadvisor.`dic$countries`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$street` ADD CONSTRAINT `fk dic$street dic$cities` FOREIGN KEY ( `city id` ) REFERENCES tripadvisor.`dic$cities`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$street` ADD CONSTRAINT `fk dic$street dic$street types` FOREIGN KEY ( `city id` ) REFERENCES tripadvisor.`dic$street types`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`event comments` ADD CONSTRAINT `fk event comments event id` FOREIGN KEY ( `event id` ) REFERENCES tripadvisor.events( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`event comments` ADD CONSTRAINT `fk event comments owner id` FOREIGN KEY ( `owner id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`event location` ADD CONSTRAINT `fk event location event id` FOREIGN KEY ( `event id` ) REFERENCES tripadvisor.events( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`event members` ADD CONSTRAINT `fk event member id` FOREIGN KEY ( `user id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`event members` ADD CONSTRAINT `fk event members event` FOREIGN KEY ( `event id` ) REFERENCES tripadvisor.events( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.events ADD CONSTRAINT `fk topics user id` FOREIGN KEY ( `owner id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.events ADD CONSTRAINT `fk event type id` FOREIGN KEY ( `event type` ) REFERENCES tripadvisor.`event types`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.images ADD CONSTRAINT `fk images image extensions` FOREIGN KEY ( `extension id` ) REFERENCES tripadvisor.`image extensions`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`sight images` ADD CONSTRAINT `fk sight images images` FOREIGN KEY ( `image id` ) REFERENCES tripadvisor.images( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`sight images` ADD CONSTRAINT `fk sight images sight` FOREIGN KEY ( `sight id` ) REFERENCES tripadvisor.sights( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.sights ADD CONSTRAINT `fk sights tours` FOREIGN KEY ( `tour id` ) REFERENCES tripadvisor.tours( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.sights ADD CONSTRAINT `fk sights dic$sight categories` FOREIGN KEY ( `category id` ) REFERENCES tripadvisor.`dic$sight categories`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`tour details` ADD CONSTRAINT `fk tour details tours` FOREIGN KEY ( `tour id` ) REFERENCES tripadvisor.tours( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`tour images` ADD CONSTRAINT `fk tour images images` FOREIGN KEY ( `image id` ) REFERENCES tripadvisor.images( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`tour images` ADD CONSTRAINT `fk tour images tours` FOREIGN KEY ( `tour id` ) REFERENCES tripadvisor.tours( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.tours ADD CONSTRAINT `fk tours users` FOREIGN KEY ( `user id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.tours ADD CONSTRAINT `fk tours dic$tour statuses` FOREIGN KEY ( `status id` ) REFERENCES tripadvisor.`dic$tour statuses`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.tours ADD CONSTRAINT fk_tours_type_id FOREIGN KEY ( tour_type ) REFERENCES tripadvisor.tour_type( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`user details` ADD CONSTRAINT `fk user details users` FOREIGN KEY ( `user id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`user details` ADD CONSTRAINT `fk user details dic$cities` FOREIGN KEY ( `city id` ) REFERENCES tripadvisor.`dic$cities`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`user roles` ADD CONSTRAINT `fk user rights users` FOREIGN KEY ( `user id` ) REFERENCES tripadvisor.users( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`user roles` ADD CONSTRAINT `fk user right id` FOREIGN KEY ( `role id` ) REFERENCES tripadvisor.`dic$roles`( id ) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tripadvisor.`dic$city types` COMMENT 'Типы городов/населённых пунктов';

ALTER TABLE tripadvisor.`dic$city types` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор типа города/населённого пункта';

ALTER TABLE tripadvisor.`dic$city types` MODIFY name VARCHAR(10)  NOT NULL   COMMENT 'Тип';

ALTER TABLE tripadvisor.`dic$countries` COMMENT 'Справочник стран';

ALTER TABLE tripadvisor.`dic$countries` MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор страны';

ALTER TABLE tripadvisor.`dic$countries` MODIFY fullname VARCHAR(250)  NOT NULL   COMMENT 'Полное наименование страны';

ALTER TABLE tripadvisor.`dic$countries` MODIFY shortname VARCHAR(50)  NOT NULL   COMMENT 'Краткое наименование страны';

ALTER TABLE tripadvisor.`dic$regions` COMMENT 'Справочник регионов';

ALTER TABLE tripadvisor.`dic$regions` MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор региона';

ALTER TABLE tripadvisor.`dic$regions` MODIFY fullname VARCHAR(250)  NOT NULL   COMMENT 'Полное наименование региона';

ALTER TABLE tripadvisor.`dic$regions` MODIFY shortname VARCHAR(100)  NOT NULL   COMMENT 'Краткое наименовангие региона';

ALTER TABLE tripadvisor.`dic$regions` MODIFY `country id` BIGINT  NOT NULL   COMMENT 'Идентификатор страны';

ALTER TABLE tripadvisor.`dic$roles` COMMENT 'Справочник видов прав';

ALTER TABLE tripadvisor.`dic$roles` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор права';

ALTER TABLE tripadvisor.`dic$roles` MODIFY name VARCHAR(255)  NOT NULL   COMMENT 'Наименование права';

ALTER TABLE tripadvisor.`dic$roles` MODIFY description VARCHAR(2000)     COMMENT 'Описание права';

ALTER TABLE tripadvisor.`dic$roles` MODIFY active TINYINT  NOT NULL DEFAULT (0)  COMMENT 'Признак возможности использования права';

ALTER TABLE tripadvisor.`dic$sight categories` COMMENT 'Категории видов достопримечательностей';

ALTER TABLE tripadvisor.`dic$sight categories` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор категории';

ALTER TABLE tripadvisor.`dic$sight categories` MODIFY name VARCHAR(200)  NOT NULL   COMMENT 'Название категории';

ALTER TABLE tripadvisor.`dic$street types` COMMENT 'Типы улиц';

ALTER TABLE tripadvisor.`dic$street types` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор типа улицы';

ALTER TABLE tripadvisor.`dic$street types` MODIFY name VARCHAR(10)  NOT NULL   COMMENT 'Тип';

ALTER TABLE tripadvisor.`dic$tour statuses` COMMENT 'Справочник статусов для туров';

ALTER TABLE tripadvisor.`dic$tour statuses` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор статуса для тура';

ALTER TABLE tripadvisor.`dic$tour statuses` MODIFY name VARCHAR(100)  NOT NULL   COMMENT 'Тип статуса тура';

ALTER TABLE tripadvisor.`dic$tour statuses` MODIFY active TINYINT  NOT NULL DEFAULT (1)  COMMENT 'Признак активности (доступности)';

ALTER TABLE tripadvisor.`event types` COMMENT 'Справочник типов событий';

ALTER TABLE tripadvisor.`event types` MODIFY id INT  NOT NULL   COMMENT 'Идентификатор';

ALTER TABLE tripadvisor.`event types` MODIFY name VARCHAR(300)     COMMENT 'Наименование';

ALTER TABLE tripadvisor.`event types` MODIFY description TEXT(0)  NOT NULL   COMMENT 'Описание';

ALTER TABLE tripadvisor.`event types` MODIFY `create date` DATE  NOT NULL DEFAULT (CURRENT_DATE)  COMMENT 'Дата создания';

ALTER TABLE tripadvisor.`event types` MODIFY `is default` BIT  NOT NULL DEFAULT (0)  COMMENT 'Признак по умолчанию';

ALTER TABLE tripadvisor.`image extensions` COMMENT 'Форматы изображений';

ALTER TABLE tripadvisor.`image extensions` MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор формата';

ALTER TABLE tripadvisor.`image extensions` MODIFY extension VARCHAR(4)  NOT NULL   COMMENT 'Формат (расширение)';

ALTER TABLE tripadvisor.`image extensions` MODIFY description VARCHAR(1000)     COMMENT 'Описание формата';

ALTER TABLE tripadvisor.`image extensions` MODIFY active TINYINT  NOT NULL DEFAULT (1)  COMMENT 'Активное расширение';

ALTER TABLE tripadvisor.images COMMENT 'Таблица ссылок на изображения';

ALTER TABLE tripadvisor.images MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор ссылки на изображение';

ALTER TABLE tripadvisor.images MODIFY url VARCHAR(2000)  NOT NULL   COMMENT 'Ссылка на изображение';

ALTER TABLE tripadvisor.images MODIFY description TEXT(0)     COMMENT 'Описание изображения';

ALTER TABLE tripadvisor.images MODIFY `extension id` INT  NOT NULL   COMMENT 'Формат изображения';

ALTER TABLE tripadvisor.tour_type COMMENT 'Справочник типов туров';

ALTER TABLE tripadvisor.tour_type MODIFY id INT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор типа тура';

ALTER TABLE tripadvisor.tour_type MODIFY name VARCHAR(200)  NOT NULL   COMMENT 'Тип тура';

ALTER TABLE tripadvisor.tour_type MODIFY active TINYINT  NOT NULL DEFAULT (1)  COMMENT 'Доступен к выбору/активный';

ALTER TABLE tripadvisor.users COMMENT 'Таблица пользователей';

ALTER TABLE tripadvisor.users MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Уникальный идентификатор пользователя';

ALTER TABLE tripadvisor.users MODIFY login VARCHAR(250)  NOT NULL   COMMENT 'Логин пользователя';

ALTER TABLE tripadvisor.users MODIFY password VARCHAR(100)  NOT NULL   COMMENT 'Пароль пользователя';

ALTER TABLE tripadvisor.users MODIFY displayname VARCHAR(100)  NOT NULL   COMMENT 'Отображаемое имя на сайте';

ALTER TABLE tripadvisor.users MODIFY `create date` DATE  NOT NULL DEFAULT (CURRENT_DATE)  COMMENT 'Дата создания';

ALTER TABLE tripadvisor.users MODIFY `register date` DATE     COMMENT 'Дата регистрации пользователя';

ALTER TABLE tripadvisor.users MODIFY `reg confirmed` TINYINT  NOT NULL DEFAULT (0)  COMMENT 'Факт подтверждения регистрации';

ALTER TABLE tripadvisor.`dic$areas` COMMENT 'Справочник районов';

ALTER TABLE tripadvisor.`dic$areas` MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор района';

ALTER TABLE tripadvisor.`dic$areas` MODIFY fullname VARCHAR(250)  NOT NULL   COMMENT 'Полное наименование района';

ALTER TABLE tripadvisor.`dic$areas` MODIFY shortname VARCHAR(100)  NOT NULL   COMMENT 'Краткое наименовангие района';

ALTER TABLE tripadvisor.`dic$areas` MODIFY `region id` BIGINT  NOT NULL   COMMENT 'Идентификатор региона';

ALTER TABLE tripadvisor.`dic$cities` COMMENT 'Справочник городов';

ALTER TABLE tripadvisor.`dic$cities` MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор района';

ALTER TABLE tripadvisor.`dic$cities` MODIFY name VARCHAR(250)  NOT NULL   COMMENT 'Наименование города';

ALTER TABLE tripadvisor.`dic$cities` MODIFY `type id` INT  NOT NULL   COMMENT 'Тип города';

ALTER TABLE tripadvisor.`dic$cities` MODIFY `area id` BIGINT  NOT NULL   COMMENT 'Идентификатор района';

ALTER TABLE tripadvisor.`dic$street` COMMENT 'Справочник улиц';

ALTER TABLE tripadvisor.`dic$street` MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор улицы';

ALTER TABLE tripadvisor.`dic$street` MODIFY name VARCHAR(250)  NOT NULL   COMMENT 'Наименование улицы';

ALTER TABLE tripadvisor.`dic$street` MODIFY `type id` INT  NOT NULL   COMMENT 'Тип улицы';

ALTER TABLE tripadvisor.`dic$street` MODIFY `city id` BIGINT  NOT NULL   COMMENT 'Идентификатор города';

ALTER TABLE tripadvisor.events COMMENT 'Таблица событий';

ALTER TABLE tripadvisor.events MODIFY id BIGINT  NOT NULL   COMMENT 'Идентификатор';

ALTER TABLE tripadvisor.events MODIFY event VARCHAR(250)  NOT NULL   COMMENT 'Наименование события';

ALTER TABLE tripadvisor.events MODIFY description TEXT(0)  NOT NULL   COMMENT 'Содержанание';

ALTER TABLE tripadvisor.events MODIFY `create date` DATE  NOT NULL DEFAULT (CURRENT_DATE)  COMMENT 'Дата создания';

ALTER TABLE tripadvisor.events MODIFY `owner id` BIGINT  NOT NULL   COMMENT 'Владелец (кто создал)';

ALTER TABLE tripadvisor.events MODIFY `event date` DATE  NOT NULL   COMMENT 'Дата, на которую назначено событие';

ALTER TABLE tripadvisor.events MODIFY `event type` INT  NOT NULL   COMMENT 'Тип события';

ALTER TABLE tripadvisor.tours COMMENT 'Туры, путешествия, турне, экскурсии, гастроли, поездки';

ALTER TABLE tripadvisor.tours MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор тура';

ALTER TABLE tripadvisor.tours MODIFY `user id` BIGINT  NOT NULL   COMMENT 'Идентификатор пользователя (владельца)';

ALTER TABLE tripadvisor.tours MODIFY tour_type INT  NOT NULL   COMMENT 'Тип тура';

ALTER TABLE tripadvisor.tours MODIFY about VARCHAR(1000)  NOT NULL   COMMENT 'Кратко о туре';

ALTER TABLE tripadvisor.tours MODIFY `start date` DATE  NOT NULL   COMMENT 'Дата начала';

ALTER TABLE tripadvisor.tours MODIFY `end date` DATE  NOT NULL   COMMENT 'Дата окончания';

ALTER TABLE tripadvisor.tours MODIFY `departure location` VARCHAR(2000)  NOT NULL   COMMENT 'Точка отправления (адрес)';

ALTER TABLE tripadvisor.tours MODIFY `destination location` VARCHAR(2000)  NOT NULL   COMMENT 'Точка назначения (адрес)';

ALTER TABLE tripadvisor.tours MODIFY `status id` INT  NOT NULL DEFAULT (0)  COMMENT 'Идентификатор статус тура';

ALTER TABLE tripadvisor.`user details` COMMENT 'Таблица расширенной информации по пользователе';

ALTER TABLE tripadvisor.`user details` MODIFY `user id` BIGINT  NOT NULL   COMMENT 'Идентификатор пользователя';

ALTER TABLE tripadvisor.`user details` MODIFY about VARCHAR(4000)     COMMENT 'О себе';

ALTER TABLE tripadvisor.`user details` MODIFY address VARCHAR(1000)     COMMENT 'Адрес пользователя';

ALTER TABLE tripadvisor.`user details` MODIFY location VARCHAR(500)     COMMENT 'Месторасположение';

ALTER TABLE tripadvisor.`user details` MODIFY sex CHAR(1)     COMMENT 'Пол пользователя';

ALTER TABLE tripadvisor.`user details` MODIFY `birth date` DATE     COMMENT 'Дата рождения пользователя';

ALTER TABLE tripadvisor.`user details` MODIFY email VARCHAR(200)  NOT NULL   COMMENT 'Адрес электронной почты';

ALTER TABLE tripadvisor.`user details` MODIFY `city id` BIGINT     COMMENT 'Город проживания';

ALTER TABLE tripadvisor.`user roles` COMMENT 'Описание прав пользователей';

ALTER TABLE tripadvisor.`user roles` MODIFY `user id` BIGINT  NOT NULL   COMMENT 'Идентификатор пользователя';

ALTER TABLE tripadvisor.`user roles` MODIFY `role id` INT  NOT NULL   COMMENT 'Идентификатор права';

ALTER TABLE tripadvisor.caterings COMMENT 'Предпрития обещственного питания';

ALTER TABLE tripadvisor.caterings MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификтор общепита';

ALTER TABLE tripadvisor.caterings MODIFY tour_id BIGINT  NOT NULL   COMMENT 'Идентификатор тура';

ALTER TABLE tripadvisor.caterings MODIFY name VARCHAR(300)  NOT NULL   COMMENT 'Наименование общепита';

ALTER TABLE tripadvisor.caterings MODIFY description TEXT(0)     COMMENT 'Описание общепита';

ALTER TABLE tripadvisor.caterings MODIFY visit_date DATE  NOT NULL DEFAULT (CURRENT_DATE)  COMMENT 'Дата посещения';

ALTER TABLE tripadvisor.caterings MODIFY rating SMALLINT UNSIGNED NOT NULL DEFAULT (0)  COMMENT 'Рейтинг заведения';

ALTER TABLE tripadvisor.caterings MODIFY price DECIMAL     COMMENT 'Стоимость покушать';

ALTER TABLE tripadvisor.comforts COMMENT 'Информация о месте проживания/отдыха/ночлеге';

ALTER TABLE tripadvisor.comforts MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор места отдыха';

ALTER TABLE tripadvisor.comforts MODIFY tour_id BIGINT  NOT NULL   COMMENT 'Идентификатор тура/поездки';

ALTER TABLE tripadvisor.comforts MODIFY name VARCHAR(500)  NOT NULL   COMMENT 'Наименование места отдыха';

ALTER TABLE tripadvisor.comforts MODIFY price DECIMAL     COMMENT 'Цена за проижвание';

ALTER TABLE tripadvisor.comforts MODIFY price_info DECIMAL     COMMENT 'Распределение суммы оплаты';

ALTER TABLE tripadvisor.comforts MODIFY info VARCHAR(4000)     COMMENT 'Информация о месте проживания';

ALTER TABLE tripadvisor.comforts MODIFY url VARCHAR(500)     COMMENT 'Ссылка на сайт места проживания';

ALTER TABLE tripadvisor.`event comments` COMMENT 'Комментарии к событиям';

ALTER TABLE tripadvisor.`event comments` MODIFY id BIGINT  NOT NULL   COMMENT 'Идентификатор комментария';

ALTER TABLE tripadvisor.`event comments` MODIFY `event id` BIGINT  NOT NULL   COMMENT 'Идентификатор события';

ALTER TABLE tripadvisor.`event comments` MODIFY comment VARCHAR(4000)  NOT NULL   COMMENT 'Текст комментария';

ALTER TABLE tripadvisor.`event comments` MODIFY `create date` DATE  NOT NULL DEFAULT (CURRENT_DATE)  COMMENT 'Дата создания комментария';

ALTER TABLE tripadvisor.`event comments` MODIFY `owner id` BIGINT  NOT NULL   COMMENT 'Автор комментария';

ALTER TABLE tripadvisor.`event comments` MODIFY `parent id` BIGINT     COMMENT 'Идентификатор предыдущего комментария (только для ответов на комментарий) для построения дерева';

ALTER TABLE tripadvisor.`event location` COMMENT 'Местонахождение события';

ALTER TABLE tripadvisor.`event location` MODIFY `event id` BIGINT  NOT NULL   COMMENT 'Идентификатор события';

ALTER TABLE tripadvisor.`event location` MODIFY address VARCHAR(250)     COMMENT 'Адрес события';

ALTER TABLE tripadvisor.`event location` MODIFY coordinates BIT     COMMENT 'Координаты широты и долготы';

ALTER TABLE tripadvisor.`event location` MODIFY detail VARCHAR(2000)     COMMENT 'Дополнительная информация о локации';

ALTER TABLE tripadvisor.`event members` COMMENT 'Участники события';

ALTER TABLE tripadvisor.`event members` MODIFY `event id` BIGINT  NOT NULL   COMMENT 'Событие';

ALTER TABLE tripadvisor.`event members` MODIFY `user id` BIGINT  NOT NULL   COMMENT 'Участник';

ALTER TABLE tripadvisor.sights COMMENT 'Достопримечательности';

ALTER TABLE tripadvisor.sights MODIFY id BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT COMMENT 'Идентификатор достопримечательности';

ALTER TABLE tripadvisor.sights MODIFY `category id` INT  NOT NULL   COMMENT 'Тип категории достопримечательности';

ALTER TABLE tripadvisor.sights MODIFY name VARCHAR(500)  NOT NULL   COMMENT 'Наименование';

ALTER TABLE tripadvisor.sights MODIFY location VARCHAR(1000)     COMMENT 'Месторасположение';

ALTER TABLE tripadvisor.sights MODIFY coordinates JSON     COMMENT 'Координаты';

ALTER TABLE tripadvisor.sights MODIFY `tour id` BIGINT     COMMENT 'Идентификатор тура';

ALTER TABLE tripadvisor.sights MODIFY description TEXT(0)     COMMENT 'Описание достопримечательности';

ALTER TABLE tripadvisor.sights MODIFY price DECIMAL     COMMENT 'Цена посещения';

ALTER TABLE tripadvisor.sights MODIFY `price info` VARCHAR(200)     COMMENT 'Информация о том, как расчитывается цена';

ALTER TABLE tripadvisor.sights MODIFY url VARCHAR(1000)     COMMENT 'Адрес сайта о достопримечательности';

ALTER TABLE tripadvisor.`tour details` COMMENT 'Таблица доп.информации о турах';

ALTER TABLE tripadvisor.`tour details` MODIFY `tour id` BIGINT  NOT NULL   COMMENT 'Идентификатор тура';

ALTER TABLE tripadvisor.`tour details` MODIFY review TEXT(0)     COMMENT 'Отзыв автора о туре';

ALTER TABLE tripadvisor.`tour details` MODIFY detail_info VARCHAR(4000)     COMMENT 'Дополнительная информация о туре';

ALTER TABLE tripadvisor.`tour details` MODIFY price DECIMAL     COMMENT 'Цена за тур';

ALTER TABLE tripadvisor.`tour details` MODIFY coordinates JSON     COMMENT 'Координаты места';

ALTER TABLE tripadvisor.`tour details` MODIFY url VARCHAR(500)     COMMENT 'Ссылка на информационный сайт';

ALTER TABLE tripadvisor.`tour images` COMMENT 'Изображения в рамках тура';

ALTER TABLE tripadvisor.`tour images` MODIFY `tour id` BIGINT  NOT NULL   COMMENT 'Идентификатор тура';

ALTER TABLE tripadvisor.`tour images` MODIFY `image id` BIGINT  NOT NULL   COMMENT 'Идентификатор изображения';

ALTER TABLE tripadvisor.catering_images COMMENT 'Изображения в рамках общепита';

ALTER TABLE tripadvisor.catering_images MODIFY catering_id BIGINT  NOT NULL   COMMENT 'Идентификатор обещпита';

ALTER TABLE tripadvisor.catering_images MODIFY image_id BIGINT  NOT NULL   COMMENT 'Идентификатор изображения';

ALTER TABLE tripadvisor.comfort_images COMMENT 'Изображения в рамках ночлега';

ALTER TABLE tripadvisor.comfort_images MODIFY comfort_id BIGINT  NOT NULL   COMMENT 'Идентификатор ночлега';

ALTER TABLE tripadvisor.comfort_images MODIFY `image id` BIGINT  NOT NULL   COMMENT 'Идентификатор изображения';

ALTER TABLE tripadvisor.`sight images` COMMENT 'Изображения в рамках тура';

ALTER TABLE tripadvisor.`sight images` MODIFY `sight id` BIGINT  NOT NULL   COMMENT 'Идентификатор достопримечательности';

ALTER TABLE tripadvisor.`sight images` MODIFY `image id` BIGINT  NOT NULL   COMMENT 'Идентификатор изображения';

