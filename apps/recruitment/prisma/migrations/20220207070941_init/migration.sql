-- CreateTable
CREATE TABLE `additional_jobs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `job_id` INTEGER UNSIGNED NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(100) NOT NULL,
    `additional_job_types_id` INTEGER UNSIGNED NOT NULL,

    INDEX `additional_job_types_id`(`additional_job_types_id`),
    INDEX `job_id`(`job_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `admin_modules` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `parent_id` INTEGER NULL,
    `name` VARCHAR(500) NOT NULL,
    `url` VARCHAR(100) NOT NULL,
    `icon` VARCHAR(200) NOT NULL,
    `slug` VARCHAR(200) NOT NULL,
    `is_menu` INTEGER NOT NULL,
    `parent_order` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `applicant_to_job` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `applicant_id` INTEGER UNSIGNED NOT NULL,
    `job_id` INTEGER UNSIGNED NOT NULL,
    `created` DATETIME(0) NOT NULL,

    INDEX `applicant_id`(`applicant_id`),
    INDEX `job_id`(`job_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `applicants` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `ga_user_id` INTEGER NOT NULL,
    `created` DATETIME(0) NOT NULL,
    `opt_in` INTEGER NULL DEFAULT 0,
    `modified` DATETIME(0) NOT NULL,
    `modified_by` INTEGER NOT NULL,
    `name` VARCHAR(100) NULL,
    `email` VARCHAR(100) NULL,
    `phone` VARCHAR(100) NULL,
    `cv` VARCHAR(200) NULL,
    `Fname` VARCHAR(100) NULL,
    `Mname` VARCHAR(100) NULL,
    `Lname` VARCHAR(100) NULL,
    `address` VARCHAR(100) NULL,
    `number` VARCHAR(100) NULL,
    `number_addition` VARCHAR(100) NULL,
    `zipcode` VARCHAR(100) NULL,
    `city` VARCHAR(100) NULL,
    `motivatiebrief` VARCHAR(200) NULL,
    `candidate_redirection_url` TEXT NULL,
    `ats_id` VARCHAR(100) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `applications` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `ats_id` VARCHAR(100) NULL,
    `applicant_id` INTEGER UNSIGNED NOT NULL,
    `job_id` INTEGER UNSIGNED NULL,
    `created` DATETIME(0) NOT NULL,
    `modified` DATETIME(0) NOT NULL,
    `modified_by` INTEGER NOT NULL,
    `progress` INTEGER NOT NULL,
    `status` VARCHAR(100) NOT NULL,
    `status_update` INTEGER NOT NULL DEFAULT 0,
    `rating` INTEGER NOT NULL,
    `rating_update` INTEGER NOT NULL DEFAULT 0,
    `source` VARCHAR(500) NOT NULL,
    `lead_id_deprecated` VARCHAR(100) NOT NULL,
    `lead_ad_id` VARCHAR(500) NOT NULL,
    `initial_status` VARCHAR(100) NOT NULL,
    `campaign_id` INTEGER UNSIGNED NULL,
    `custom_campaign_id` INTEGER NULL,
    `jobs_on_facebook_id` INTEGER NULL,
    `deleted_job` BOOLEAN NOT NULL DEFAULT false,

    INDEX `applicant_id`(`applicant_id`),
    INDEX `job_id`(`job_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ats` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `ats_name` VARCHAR(5) NOT NULL,
    `ats_url` VARCHAR(500) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ats_attributes_matcher` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `attribute_id` INTEGER UNSIGNED NOT NULL,
    `property_accessor` VARCHAR(500) NOT NULL,

    INDEX `attribute_id`(`attribute_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ats_log` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `created` DATETIME(0) NOT NULL,
    `command` VARCHAR(100) NOT NULL,
    `param_1` VARCHAR(100) NULL,
    `param_2` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ats_recruiter_attributes_matcher` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `attribute_id` INTEGER UNSIGNED NOT NULL,
    `property_accessor` VARCHAR(500) NOT NULL,

    INDEX `attribute_id`(`attribute_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ats_status_conversion` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `our_status` VARCHAR(500) NOT NULL,
    `ats_status` VARCHAR(500) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute_to_job` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `attribute_id` INTEGER UNSIGNED NOT NULL,
    `attribute_value_id` INTEGER UNSIGNED NOT NULL,
    `job_id` INTEGER UNSIGNED NOT NULL,

    INDEX `attribute_id`(`attribute_id`),
    INDEX `attribute_value_id`(`attribute_value_id`),
    INDEX `job_id`(`job_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campaigns` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `language` VARCHAR(20) NULL,
    `created_at` DATETIME(0) NULL,
    `created_by` INTEGER NOT NULL,
    `pub_date` DATETIME(0) NOT NULL,
    `pub_end_date` DATETIME(0) NULL,
    `source` VARCHAR(100) NOT NULL,
    `medium` VARCHAR(20) NOT NULL,
    `feed_type` VARCHAR(20) NOT NULL,
    `active` INTEGER NOT NULL DEFAULT 1,
    `boost` INTEGER NOT NULL DEFAULT 0,
    `weekly_refresh` INTEGER NULL,
    `title` VARCHAR(100) NOT NULL,
    `filters` TEXT NOT NULL,
    `last_build_date` DATETIME(0) NULL,
    `status` INTEGER NULL,
    `destination` INTEGER NULL,
    `type` INTEGER NULL,
    `campaign_logo` VARCHAR(100) NULL,
    `additional_jobs` INTEGER NULL DEFAULT 0,
    `slug` VARCHAR(500) NULL,
    `contract` INTEGER NOT NULL DEFAULT 0,
    `alternative_filters` TEXT NULL,
    `updated_at` DATETIME(0) NULL DEFAULT ('2020-01-13 15:32:53'),
    `last_synchronization` DATETIME(0) NULL,
    `centralized_slug` VARCHAR(100) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `content` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `page_id` INTEGER NOT NULL,
    `language` VARCHAR(20) NOT NULL,
    `hide` INTEGER NOT NULL DEFAULT 0,
    `page_title` VARCHAR(200) NOT NULL,
    `slug` VARCHAR(100) NOT NULL,
    `meta_description` VARCHAR(200) NULL,
    `main_title` VARCHAR(500) NULL,
    `specs` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `custom_campaigns` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_campaign_name` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(100) NOT NULL,
    `general_tracking_script` VARCHAR(5000) NULL,
    `created_on` DATETIME(6) NOT NULL,
    `first_apply_script` VARCHAR(5000) NULL,
    `active` INTEGER NOT NULL,
    `second_apply_script` VARCHAR(5000) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `custom_campaigns_detail` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_campaigns_id` INTEGER UNSIGNED NOT NULL,
    `userid` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `first_name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(100) NOT NULL,
    `job_id` INTEGER NOT NULL,
    `job_title` VARCHAR(100) NOT NULL,
    `created_on` DATETIME(6) NOT NULL,
    `applicant_id` INTEGER UNSIGNED NOT NULL,
    `application_id` INTEGER NULL,

    INDEX `fk_applicant_id_bio3`(`applicant_id`),
    INDEX `fk_custom_campaigns_id_bio3`(`custom_campaigns_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `datalayers` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `template_id` INTEGER NOT NULL,
    `datalayer` MEDIUMTEXT NOT NULL,
    `event` VARCHAR(100) NOT NULL,
    `labels` TEXT NOT NULL,

    INDEX `template_id`(`template_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `design_categories` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` INTEGER UNSIGNED NULL,
    `title` VARCHAR(500) NOT NULL,
    `type` INTEGER NOT NULL,
    `html_class` VARCHAR(500) NULL,
    `dom_node` VARCHAR(500) NULL,
    `css_values` TINYINT NULL DEFAULT 1,
    `order` INTEGER NULL DEFAULT 0,
    `theme_id` INTEGER UNSIGNED NULL,

    INDEX `parent_id`(`parent_id`),
    INDEX `theme_id`(`theme_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `design_options` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `option_name` VARCHAR(100) NOT NULL,
    `option_value` VARCHAR(100) NOT NULL,
    `title` VARCHAR(500) NULL,
    `category_id` INTEGER UNSIGNED NOT NULL,
    `type` VARCHAR(250) NULL,
    `description` VARCHAR(1000) NULL,
    `order` INTEGER NULL DEFAULT 0,
    `rules` VARCHAR(5000) NULL,

    INDEX `category_id`(`category_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `element_content` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `element_id` INTEGER UNSIGNED NULL,
    `language` VARCHAR(20) NOT NULL,
    `hide` INTEGER NOT NULL DEFAULT 0,
    `specs` TEXT NULL,

    INDEX `element_id`(`element_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `element_datalayer` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `element_template_version_id` INTEGER UNSIGNED NOT NULL,
    `datalayers` MEDIUMTEXT NULL,

    INDEX `element_template_version_id`(`element_template_version_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `element_template_versions` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `element_template_id` INTEGER UNSIGNED NULL,
    `title` VARCHAR(1000) NULL,
    `component_name` VARCHAR(255) NULL,
    `specs` TEXT NULL,
    `element_specs` TEXT NULL,
    `controller_edit_action` VARCHAR(255) NULL,
    `theme_id` INTEGER UNSIGNED NULL,
    `preview` INTEGER NULL DEFAULT 1,

    INDEX `element_template_id`(`element_template_id`),
    INDEX `theme_id`(`theme_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `element_templates` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `description` TEXT NOT NULL,
    `constant_title` VARCHAR(1000) NULL,
    `alias` TINYINT NULL DEFAULT 1,
    `dynamic` TINYINT NULL DEFAULT 0,
    `injectable` TINYINT NULL DEFAULT 0,
    `hidden` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `element_to_pages` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `element_id` INTEGER UNSIGNED NOT NULL,
    `page_id` INTEGER UNSIGNED NOT NULL,
    `position` INTEGER NOT NULL,
    `order` INTEGER NOT NULL DEFAULT 0,
    `dependant` BOOLEAN NULL DEFAULT false,

    INDEX `element_id`(`element_id`),
    INDEX `page_id`(`page_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `elements` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `element_template_version_id` INTEGER UNSIGNED NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `default` BOOLEAN NULL DEFAULT false,
    `created_at` DATETIME(0) NULL,
    `created_by` INTEGER UNSIGNED NULL,
    `modified_by` INTEGER UNSIGNED NULL,
    `status` INTEGER NULL,
    `pub_date` DATETIME(0) NULL,
    `pub_end_date` DATETIME(0) NULL,
    `order` INTEGER NULL,
    `page_id` INTEGER UNSIGNED NULL,
    `constant_title` VARCHAR(255) NULL,
    `specs` TEXT NULL,
    `margin_top` VARCHAR(100) NULL DEFAULT '0rem',
    `margin_bottom` VARCHAR(100) NULL DEFAULT '0rem',
    `padding_top` VARCHAR(500) NOT NULL DEFAULT '0rem',
    `padding_bottom` VARCHAR(500) NOT NULL DEFAULT '0rem',

    INDEX `created_by`(`created_by`),
    INDEX `element_template_version_id`(`element_template_version_id`),
    INDEX `page_id`(`page_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `email_template_contents` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `email_template_id` INTEGER UNSIGNED NOT NULL,
    `language` VARCHAR(3) NOT NULL,
    `email_subject` VARCHAR(100) NOT NULL,
    `email_body` VARCHAR(10000) NOT NULL,

    INDEX `email_template_id`(`email_template_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `email_templates` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `recipient_data_label` VARCHAR(100) NOT NULL,
    `cc_data_label` VARCHAR(100) NOT NULL,
    `bcc_data_label` VARCHAR(100) NOT NULL,
    `template_order` INTEGER NOT NULL,
    `category` VARCHAR(500) NOT NULL,
    `category_order` INTEGER NOT NULL,
    `description` VARCHAR(500) NOT NULL,
    `constant_title` VARCHAR(500) NULL,
    `entity_name` VARCHAR(500) NULL,
    `status` INTEGER NULL DEFAULT 1,
    `privileges` INTEGER NULL DEFAULT 2,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `facebook_app_access_token` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `token` VARCHAR(500) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `facebook_jobs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `fb_id` VARCHAR(20) NULL,
    `fb_external_id` VARCHAR(1000) NULL,
    `job_content_id` INTEGER UNSIGNED NULL,
    `job_additional_id` INTEGER UNSIGNED NULL,
    `errors` TEXT NULL,
    `job_status` VARCHAR(500) NULL,
    `platform_review_status` VARCHAR(200) NULL,
    `review_rejection_reasons` VARCHAR(1000) NULL,
    `db_status` VARCHAR(200) NULL,
    `published_at` DATE NULL,

    INDEX `job_additional_id`(`job_additional_id`),
    INDEX `job_content_id`(`job_content_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `facebook_lead_ads_campaign` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `lead_ad_import_method` VARCHAR(100) NULL,
    `import_containing` VARCHAR(100) NULL,
    `status` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_ad_budget` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_default` INTEGER NOT NULL DEFAULT 0,
    `job_content_id` INTEGER UNSIGNED NULL,
    `job_attribute_value_id` INTEGER UNSIGNED NULL,
    `bid_amount` DECIMAL(10, 2) NULL,
    `daily_budget` DECIMAL(10, 2) NULL,
    `max_budget` DECIMAL(10, 2) NULL,

    INDEX `job_attribute_value_id`(`job_attribute_value_id`),
    INDEX `job_content_id`(`job_content_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_ad_sets` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `fb_ad_set_id` VARCHAR(20) NULL,
    `fb_campaign_id` INTEGER UNSIGNED NULL,
    `targeting_id` INTEGER UNSIGNED NULL,
    `name` VARCHAR(100) NOT NULL,
    `start_time` DATETIME(0) NULL,
    `end_time` DATETIME(0) NULL,
    `booston_budget_id` INTEGER UNSIGNED NULL,
    `booston_ad_id` INTEGER UNSIGNED NULL,
    `status` VARCHAR(100) NULL,

    INDEX `booston_ad_id`(`booston_ad_id`),
    INDEX `booston_budget_id`(`booston_budget_id`),
    INDEX `fb_campaign_id`(`fb_campaign_id`),
    INDEX `targeting_id`(`targeting_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_ad_template` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_default` INTEGER NOT NULL DEFAULT 0,
    `job_content_id` INTEGER UNSIGNED NULL,
    `job_attribute_value_id` INTEGER UNSIGNED NULL,
    `image` TEXT NOT NULL,
    `image_hash` TEXT NOT NULL,
    `message` TEXT NOT NULL,
    `link` TEXT NOT NULL,
    `caption` TEXT NOT NULL,
    `ad_description` TEXT NOT NULL,
    `video` VARCHAR(1000) NULL,
    `media_type` VARCHAR(2) NOT NULL DEFAULT '1',

    INDEX `job_attribute_value_id`(`job_attribute_value_id`),
    INDEX `job_content_id`(`job_content_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_ads` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `published` INTEGER NOT NULL DEFAULT 0,
    `fb_ad_creative_id` VARCHAR(20) NULL,
    `fb_ad_id` VARCHAR(20) NULL,
    `page_id` VARCHAR(50) NULL,
    `lead_gen_id` VARCHAR(20) NULL,
    `booston_ad_set_id` INTEGER UNSIGNED NULL,
    `booston_template_id` INTEGER UNSIGNED NULL,
    `job_content_id` INTEGER UNSIGNED NULL,
    `copy_nr` INTEGER NULL,

    INDEX `booston_ad_set_id`(`booston_ad_set_id`),
    INDEX `booston_template_id`(`booston_template_id`),
    INDEX `job_content_id`(`job_content_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_campaigns` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `fb_campaign_id` VARCHAR(20) NULL,
    `fb_ad_account_id` VARCHAR(20) NULL,
    `name` VARCHAR(100) NOT NULL,
    `objective` VARCHAR(100) NOT NULL,
    `status` VARCHAR(100) NOT NULL,
    `budget_type` INTEGER NULL,
    `budget` DECIMAL(10, 2) NULL,
    `bid_strategy` VARCHAR(50) NULL,
    `last_sync_date` DATETIME(0) NULL,
    `countries` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_cities` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `targeting_id` INTEGER UNSIGNED NULL,
    `city_id` VARCHAR(20) NULL,
    `name` VARCHAR(100) NULL,

    INDEX `targeting_id`(`targeting_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_cost_performance_report` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `fb_ad_set_id` INTEGER UNSIGNED NULL,
    `leads` INTEGER UNSIGNED NOT NULL,
    `conversion_rate` VARCHAR(100) NOT NULL,
    `reach` INTEGER UNSIGNED NOT NULL,
    `views` INTEGER UNSIGNED NOT NULL,
    `cost` DECIMAL(10, 2) NOT NULL,
    `cost_per_lead` DECIMAL(10, 2) NOT NULL,
    `cpm` DECIMAL(10, 2) NOT NULL,
    `ctr` DECIMAL(10, 2) NOT NULL,
    `frequency` DECIMAL(10, 2) NOT NULL,
    `currency` VARCHAR(100) NOT NULL,
    `engagement_rate` VARCHAR(100) NOT NULL,
    `quality_ranking` VARCHAR(100) NOT NULL,
    `date_start` DATE NOT NULL,
    `date_stop` DATE NOT NULL,
    `created_at` DATE NOT NULL,
    `api_ad_set_id` VARCHAR(20) NULL,
    `fb_margin` VARCHAR(100) NULL,

    INDEX `fb_ad_set_id`(`fb_ad_set_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_countries` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `targeting_id` INTEGER UNSIGNED NULL,
    `country_id` VARCHAR(20) NOT NULL,
    `name` VARCHAR(100) NOT NULL,

    INDEX `targeting_id`(`targeting_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_interests` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `targeting_id` INTEGER UNSIGNED NULL,
    `interest_id` VARCHAR(20) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `type` VARCHAR(100) NULL,
    `refinement` INTEGER NULL DEFAULT 0,
    `exclusion` INTEGER NULL DEFAULT 0,
    `category` VARCHAR(500) NULL,

    INDEX `targeting_id`(`targeting_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_jobgroup_attribute` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `attribute_id` INTEGER UNSIGNED NULL,

    INDEX `attribute_id`(`attribute_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_leadgen` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `question_heading` TEXT NOT NULL,
    `heading` TEXT NOT NULL,
    `description` TEXT NOT NULL,
    `policy_text` TEXT NOT NULL,
    `policy_url` TEXT NOT NULL,
    `thankyou_heading` TEXT NOT NULL,
    `thankyou_text` TEXT NOT NULL,
    `thankyou_button_text` TEXT NOT NULL,
    `thankyou_destination` INTEGER NULL,
    `is_default` INTEGER NULL DEFAULT 0,
    `language` VARCHAR(100) NULL,
    `layout` VARCHAR(100) NULL,
    `questions` TEXT NOT NULL,
    `job_attribute_value_id` INTEGER UNSIGNED NULL,
    `job_content_id` INTEGER UNSIGNED NULL,
    `visibility` INTEGER NOT NULL DEFAULT 0,

    INDEX `job_attribute_value_id`(`job_attribute_value_id`),
    INDEX `job_content_id`(`job_content_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_margin` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `margin` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_page` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `fb_id` VARCHAR(20) NOT NULL,
    `access_token` VARCHAR(500) NOT NULL,
    `name` VARCHAR(2000) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_regions` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `targeting_id` INTEGER UNSIGNED NULL,
    `region_id` VARCHAR(20) NULL,
    `name` VARCHAR(100) NULL,

    INDEX `targeting_id`(`targeting_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fb_targeting` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_default` INTEGER NOT NULL DEFAULT 0,
    `job_content_id` INTEGER UNSIGNED NULL,
    `job_attribute_value_id` INTEGER UNSIGNED NULL,
    `geo_type` INTEGER NOT NULL DEFAULT 1,
    `country` VARCHAR(5) NOT NULL,
    `radius` INTEGER NOT NULL,
    `network_type` INTEGER NULL DEFAULT 0,
    `additional_cities` INTEGER NULL DEFAULT 0,

    INDEX `job_attribute_value_id`(`job_attribute_value_id`),
    INDEX `job_content_id`(`job_content_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ga_users` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `created` DATETIME(0) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `gds_iframes` (
    `iframe_id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `iframe_title` VARCHAR(500) NOT NULL,
    `iframe_content` VARCHAR(500) NOT NULL,
    `report_id` INTEGER NOT NULL,
    `created` DATETIME(0) NOT NULL,
    `created_by` INTEGER NOT NULL,
    `modified` DATETIME(0) NOT NULL,
    `modified_by` INTEGER NOT NULL,

    PRIMARY KEY (`iframe_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `general_options` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `option_name` VARCHAR(500) NOT NULL,
    `option_value` VARCHAR(5000) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `google_for_jobs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `template_id` INTEGER NOT NULL,
    `script` VARCHAR(5000) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `google_for_jobs_attribute_values` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `google_for_jobs_attribute_id` INTEGER UNSIGNED NOT NULL,
    `name` VARCHAR(500) NOT NULL,

    INDEX `google_for_jobs_attribute_id`(`google_for_jobs_attribute_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `google_for_jobs_attributes` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `title` VARCHAR(500) NOT NULL,
    `type` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `gtm` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `head_gtm` MEDIUMTEXT NOT NULL,
    `body_gtm` MEDIUMTEXT NOT NULL,
    `footer_gtm` MEDIUMTEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_attribute_titles` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `attribute_id` INTEGER UNSIGNED NOT NULL,
    `language` VARCHAR(5) NOT NULL,
    `title` VARCHAR(100) NOT NULL,

    INDEX `attribute_id`(`attribute_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_attribute_value_titles` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `attribute_value_id` INTEGER UNSIGNED NOT NULL,
    `language` VARCHAR(5) NOT NULL,
    `title` VARCHAR(1000) NULL,

    INDEX `attribute_value_id`(`attribute_value_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_attribute_values` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `attribute_id` INTEGER UNSIGNED NOT NULL,
    `order` INTEGER NOT NULL,
    `name` VARCHAR(1000) NULL,
    `image` VARCHAR(500) NULL,
    `automatic_order` INTEGER NOT NULL,
    `google_for_jobs_value_id` INTEGER UNSIGNED NULL,
    `jobs_on_facebook_value_id` INTEGER UNSIGNED NULL,
    `node_id` INTEGER NULL,

    INDEX `attribute_id`(`attribute_id`),
    INDEX `google_for_jobs_value_id`(`google_for_jobs_value_id`),
    INDEX `jobs_on_facebook_value_id`(`jobs_on_facebook_value_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_attributes` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `active` INTEGER NOT NULL DEFAULT 0,
    `title` VARCHAR(100) NOT NULL,
    `var` VARCHAR(100) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `type` VARCHAR(100) NOT NULL,
    `fixed_type` INTEGER NULL DEFAULT 1,
    `required` INTEGER NULL DEFAULT 0,
    `text_search` INTEGER NOT NULL DEFAULT 0,
    `advanced_search` INTEGER NOT NULL DEFAULT 0,
    `job_alert` INTEGER NOT NULL DEFAULT 0,
    `search_rank` INTEGER NOT NULL,
    `icon` VARCHAR(20) NOT NULL,
    `pub_job_detail` INTEGER NOT NULL DEFAULT 0,
    `pub_job_box` INTEGER NOT NULL DEFAULT 0,
    `pub_job_alert` INTEGER NOT NULL DEFAULT 0,
    `max_char` INTEGER NULL DEFAULT 1000,
    `autopopulate_by_ats` INTEGER NOT NULL,
    `manage_locale_separately` INTEGER NOT NULL DEFAULT 1,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_content` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `job_id` INTEGER UNSIGNED NOT NULL,
    `language` VARCHAR(20) NOT NULL,
    `hide` INTEGER NULL DEFAULT 0,
    `modified` DATETIME(0) NULL,
    `modified_by` INTEGER UNSIGNED NOT NULL,
    `slug` VARCHAR(100) NOT NULL,
    `page_title` VARCHAR(100) NOT NULL,
    `meta_description` VARCHAR(200) NULL,
    `title` VARCHAR(100) NOT NULL,
    `zipcode` VARCHAR(100) NULL,
    `region` VARCHAR(100) NULL,
    `salary_min` VARCHAR(60) NULL,
    `salary_max` VARCHAR(60) NULL,
    `img` VARCHAR(500) NULL,
    `video` VARCHAR(500) NULL,
    `address` VARCHAR(100) NULL,
    `city` VARCHAR(100) NULL,
    `txt_1` TEXT NULL,
    `txt_2` TEXT NULL,
    `txt_3` TEXT NULL,
    `txt_4` TEXT NULL,
    `txt_5` TEXT NULL,
    `txt_6` TEXT NULL,
    `txt_7` TEXT NULL,
    `txt_8` TEXT NULL,
    `usp_1` TEXT NULL,
    `usp_2` TEXT NULL,
    `redirect` VARCHAR(10000) NULL,
    `ats_publication_id` VARCHAR(100) NULL,

    INDEX `modified_by`(`modified_by`),
    INDEX `page_id`(`job_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jobalerts` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `active` INTEGER NOT NULL DEFAULT 1,
    `email` VARCHAR(100) NOT NULL,
    `frequency` INTEGER NOT NULL,
    `opt_in` INTEGER NOT NULL,
    `created` DATETIME(0) NOT NULL,
    `last_email` DATETIME(0) NOT NULL,
    `filters` TEXT NOT NULL,
    `token` VARCHAR(128) NOT NULL,
    `element_content_id` INTEGER UNSIGNED NULL,
    `language` VARCHAR(3) NULL DEFAULT 'nl',

    INDEX `element_content_id`(`element_content_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jobs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `created` DATETIME(0) NULL,
    `created_by` INTEGER UNSIGNED NOT NULL,
    `level` INTEGER NULL,
    `recruiter_id` INTEGER UNSIGNED NOT NULL,
    `active` INTEGER NOT NULL DEFAULT 1,
    `boost` INTEGER NOT NULL DEFAULT 0,
    `ats_id` VARCHAR(100) NULL,
    `main_page_color` VARCHAR(500) NULL DEFAULT '[[main_page_color]]',
    `secondary_page_color` VARCHAR(500) NULL DEFAULT '[[secondary_page_color]]',
    `data_layer` VARCHAR(1000) NULL,
    `pub_date` DATETIME(0) NULL,
    `pub_end_date` DATETIME(0) NULL,
    `updatedAt` DATETIME(0) NULL,

    INDEX `created_by`(`created_by`),
    INDEX `recruiter_id`(`recruiter_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jobs_on_facebook` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `boost` INTEGER NOT NULL,
    `status` INTEGER NOT NULL,
    `language` VARCHAR(20) NOT NULL,
    `filters` TEXT NULL,
    `created_at` DATETIME(0) NOT NULL,
    `created_by` INTEGER NOT NULL,
    `updated_at` DATETIME(0) NULL,
    `jobs_feed_id` VARCHAR(500) NULL,
    `pub_date` DATE NULL,
    `pub_end_date` DATE NULL,
    `additional_jobs` INTEGER NULL DEFAULT 0,
    `last_synchronization` DATETIME(0) NULL,
    `last_synchronization_check` DATETIME(0) NULL,
    `facebook_setup` BOOLEAN NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jobs_on_facebook_attribute_values` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `jobs_on_facebook_attribute_id` INTEGER UNSIGNED NOT NULL,
    `name` VARCHAR(500) NOT NULL,

    INDEX `jobs_on_facebook_attribute_id`(`jobs_on_facebook_attribute_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jobs_on_facebook_attributes` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `title` VARCHAR(500) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jobs_on_facebook_logs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `jobs` INTEGER NOT NULL,
    `applications` INTEGER NOT NULL,
    `created_at` DATE NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `labels` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `index` VARCHAR(100) NULL,
    `label_nl` VARCHAR(100) NULL,
    `label_en` VARCHAR(100) NOT NULL,
    `label_hu` VARCHAR(100) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `languages` (
    `code` VARCHAR(5) NOT NULL,
    `language` VARCHAR(100) NOT NULL,
    `is_default` INTEGER NOT NULL,

    PRIMARY KEY (`code`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `lead_details` (
    `id` VARCHAR(100) NOT NULL,
    `lead_id` VARCHAR(100) NOT NULL,
    `created_time` DATETIME(6) NOT NULL,
    `field_data` VARCHAR(500) NOT NULL,

    INDEX `lead_details_ibfk_1`(`lead_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `leads` (
    `id` VARCHAR(100) NOT NULL,
    `name` VARCHAR(500) NOT NULL,
    `export_url` VARCHAR(500) NOT NULL,
    `status` VARCHAR(100) NOT NULL,
    `created_time` DATETIME(6) NOT NULL,
    `job_id` INTEGER NOT NULL,
    `recruiter_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `locations` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `created` DATETIME(0) NULL,
    `created_by` INTEGER NULL,
    `modified` DATETIME(0) NULL,
    `modified_by` INTEGER NULL,
    `title` VARCHAR(100) NULL,
    `body` TEXT NULL,
    `slug` VARCHAR(100) NULL,
    `address` VARCHAR(100) NULL,
    `zipcode` VARCHAR(100) NULL,
    `city` VARCHAR(100) NULL,
    `phone` VARCHAR(100) NULL,
    `email` VARCHAR(100) NULL,
    `img` VARCHAR(100) NULL,
    `short_description` TEXT NULL,
    `country` VARCHAR(200) NULL,
    `main` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `log` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `created` DATETIME(0) NOT NULL,
    `url` VARCHAR(200) NOT NULL,
    `ga_user_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mailinglist` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `created` DATETIME(0) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `active` INTEGER NOT NULL DEFAULT 1,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `menuitem_content` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `menuitem_id` INTEGER UNSIGNED NOT NULL,
    `language` VARCHAR(20) NOT NULL,
    `modified` DATETIME(0) NOT NULL,
    `modified_by` INTEGER UNSIGNED NULL,
    `title` VARCHAR(5000) NOT NULL,
    `url` VARCHAR(5000) NOT NULL,
    `description` VARCHAR(500) NOT NULL,

    INDEX `menuitem_id`(`menuitem_id`),
    INDEX `modified_by`(`modified_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `menuitems` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` INTEGER NOT NULL,
    `page_id` INTEGER UNSIGNED NULL,
    `parent_id` INTEGER UNSIGNED NULL,
    `order` INTEGER NOT NULL DEFAULT 0,
    `icon_class` VARCHAR(5000) NULL,
    `icon_url` VARCHAR(6000) NULL,
    `icon_type` INTEGER NULL DEFAULT 0,

    INDEX `page_id`(`page_id`),
    INDEX `parent_id`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `migrations` (
    `version` BIGINT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pages` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `template_version_id` INTEGER UNSIGNED NULL,
    `created` DATETIME(0) NOT NULL,
    `created_by` INTEGER NOT NULL,
    `level` INTEGER NOT NULL,
    `default` INTEGER NOT NULL DEFAULT 0,
    `status` INTEGER NOT NULL DEFAULT 0,
    `pub_date` DATETIME(0) NOT NULL,
    `pub_end_date` DATETIME(0) NULL,
    `main_page_color` VARCHAR(500) NULL DEFAULT '[[main_page_color]]',
    `secondary_page_color` VARCHAR(500) NULL DEFAULT '[[secondary_page_color]]',
    `data_layer` VARCHAR(1000) NULL,
    `modified` DATETIME(0) NULL,
    `modified_by` INTEGER NULL,
    `order` INTEGER NULL,
    `boost` INTEGER NULL DEFAULT 0,
    `location_id` INTEGER NULL,
    `layout` SMALLINT NOT NULL DEFAULT 0,
    `constant_title` VARCHAR(300) NULL,
    `abstract_page` BOOLEAN NULL DEFAULT false,
    `data_layer_customized` BOOLEAN NULL DEFAULT false,
    `specs` TEXT NULL,

    INDEX `template_version_id`(`template_version_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pc_data` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `postcode` VARCHAR(500) NULL,
    `residence` TINYTEXT NULL,
    `latitude` DOUBLE NULL,
    `longitude` DOUBLE NULL,
    `kind` TINYTEXT NULL,
    `geo_point` point NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `recruiter_attribute_titles` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `recruiter_attributes_id` INTEGER UNSIGNED NOT NULL,
    `language` VARCHAR(5) NOT NULL,
    `title` VARCHAR(100) NOT NULL,

    INDEX `recruiter_attributes_id`(`recruiter_attributes_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `recruiter_attribute_value_titles` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `recruiter_attribute_value_id` INTEGER UNSIGNED NOT NULL,
    `language` VARCHAR(5) NOT NULL,
    `title` VARCHAR(100) NOT NULL,

    INDEX `recruiter_attribute_value_id`(`recruiter_attribute_value_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `recruiter_attribute_values` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `recruiter_attributes_id` INTEGER UNSIGNED NOT NULL,
    `order` INTEGER NOT NULL,
    `name` VARCHAR(1000) NOT NULL,
    `image` VARCHAR(500) NOT NULL,
    `automatic_order` INTEGER NOT NULL,
    `google_for_jobs_value_id` INTEGER UNSIGNED NULL,
    `jobs_on_facebook_value_id` INTEGER UNSIGNED NULL,

    INDEX `google_for_jobs_value_id`(`google_for_jobs_value_id`),
    INDEX `jobs_on_facebook_value_id`(`jobs_on_facebook_value_id`),
    INDEX `recruiter_attributes_id`(`recruiter_attributes_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `recruiter_attributes` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `active` INTEGER NOT NULL DEFAULT 0,
    `title` VARCHAR(100) NOT NULL,
    `var` VARCHAR(100) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `type` VARCHAR(100) NOT NULL,
    `required` INTEGER NOT NULL DEFAULT 0,
    `text_search` INTEGER NOT NULL DEFAULT 0,
    `advanced_search` INTEGER NOT NULL DEFAULT 0,
    `job_alert` INTEGER NOT NULL DEFAULT 0,
    `search_rank` INTEGER NOT NULL,
    `icon` VARCHAR(20) NOT NULL,
    `pub_job_detail` INTEGER NOT NULL DEFAULT 0,
    `pub_job_box` INTEGER NOT NULL DEFAULT 0,
    `pub_recruiter_detail` INTEGER NOT NULL DEFAULT 0,
    `pub_recruiter_box` INTEGER NOT NULL DEFAULT 0,
    `max_char` INTEGER NOT NULL DEFAULT 1000,
    `autopopulate_by_ats` INTEGER NOT NULL DEFAULT 0,
    `manage_locale_separately` INTEGER NOT NULL DEFAULT 1,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `recruiter_content` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `recruiter_id` INTEGER UNSIGNED NOT NULL,
    `location_id` INTEGER UNSIGNED NOT NULL,
    `hide` INTEGER NOT NULL DEFAULT 0,
    `language` VARCHAR(5) NULL,
    `page_title` VARCHAR(100) NULL,
    `meta_description` VARCHAR(200) NULL,
    `name` VARCHAR(100) NULL,
    `slug` VARCHAR(100) NULL,
    `email` VARCHAR(100) NULL,
    `function` VARCHAR(100) NULL,
    `description` VARCHAR(100) NULL,
    `body` TEXT NULL,
    `phone` VARCHAR(100) NULL,
    `mobile` VARCHAR(100) NULL,
    `linkedin` VARCHAR(100) NULL,
    `twitter` VARCHAR(100) NULL,
    `instagram` VARCHAR(100) NULL,
    `facebook` VARCHAR(100) NULL,
    `portrait` VARCHAR(100) NULL,
    `img` VARCHAR(100) NULL,
    `img_2` VARCHAR(100) NULL,
    `img_3` VARCHAR(100) NULL,
    `img_4` VARCHAR(100) NULL,
    `video` VARCHAR(100) NULL,

    INDEX `location_id`(`location_id`),
    INDEX `recruiter_id`(`recruiter_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `recruiters` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `order` INTEGER NULL,
    `created` DATETIME(0) NOT NULL,
    `created_by` INTEGER NOT NULL,
    `modified` DATETIME(0) NOT NULL,
    `modified_by` INTEGER NOT NULL,
    `active` INTEGER NULL DEFAULT 0,
    `set_by_ats` INTEGER NULL DEFAULT 0,
    `boost` INTEGER NULL DEFAULT 0,
    `recruiter_ats_id` VARCHAR(100) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `redirects` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `type301` INTEGER NOT NULL DEFAULT 1,
    `old_url` VARCHAR(200) NOT NULL,
    `new_url` VARCHAR(200) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reports` (
    `report_id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `canvas_width` VARCHAR(11) NOT NULL,
    `canvas_height` VARCHAR(11) NOT NULL,
    `auto_slide` INTEGER NOT NULL,
    `slide_speed` INTEGER NOT NULL,
    `created` DATETIME(0) NOT NULL,
    `created_by` INTEGER NOT NULL,
    `modified` DATETIME(0) NOT NULL,
    `modified_by` INTEGER NOT NULL,

    PRIMARY KEY (`report_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `system_fonts` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(300) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `template_versions` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `template_id` INTEGER NOT NULL,
    `title` VARCHAR(1000) NOT NULL,
    `outside_controller_action` VARCHAR(250) NULL,
    `file_name` VARCHAR(250) NULL,
    `specs` TEXT NULL,
    `dom` TEXT NULL,
    `element_specs` TEXT NULL,

    INDEX `template_id`(`template_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `templates` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `description` TEXT NOT NULL,
    `alias` INTEGER NOT NULL DEFAULT 0,
    `constant_title` VARCHAR(1000) NULL,

    UNIQUE INDEX `constant_title`(`constant_title`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `testimonial_targeting_groups` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `testimonial_id` INTEGER NOT NULL,
    `function_group_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_permissions` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `admin_modules_id` INTEGER NOT NULL,
    `user_role_id` INTEGER NOT NULL,
    `visible` INTEGER NOT NULL,
    `active` INTEGER NOT NULL,
    `read_rights` INTEGER NOT NULL,
    `create_rights` INTEGER NOT NULL,
    `edit_rights` INTEGER NOT NULL,
    `delete_rights` INTEGER NOT NULL,

    INDEX `admin_modules_id`(`admin_modules_id`),
    INDEX `user_role_id`(`user_role_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_role` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `role` VARCHAR(100) NOT NULL,
    `default_page_id` INTEGER NOT NULL,

    INDEX `default_page_id`(`default_page_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_to_page` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `page_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `password` VARCHAR(128) NOT NULL,
    `img` VARCHAR(100) NOT NULL,
    `level` INTEGER NOT NULL,
    `function` VARCHAR(500) NOT NULL,
    `created` DATETIME(0) NOT NULL,
    `modified` DATETIME(0) NOT NULL,
    `token` VARCHAR(128) NOT NULL,
    `ga` VARCHAR(100) NOT NULL,
    `fb_page_token` VARCHAR(500) NOT NULL,
    `show_open_applications` INTEGER NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users_recruiters` (
    `user_id` INTEGER UNSIGNED NOT NULL,
    `recruiter_id` INTEGER UNSIGNED NOT NULL,

    INDEX `fk_recruiter_id`(`recruiter_id`),
    PRIMARY KEY (`user_id`, `recruiter_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `theme` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `additional_job_types` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `category` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` INTEGER UNSIGNED NULL,
    `name` VARCHAR(255) NULL,
    `constant_title` VARCHAR(255) NULL,
    `image` VARCHAR(5000) NULL,
    `order` VARCHAR(255) NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `parent_id`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `category_translation` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id` INTEGER UNSIGNED NULL,
    `language` VARCHAR(100) NULL,
    `title` VARCHAR(255) NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `category_id`(`category_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `additional_jobs` ADD CONSTRAINT `additional_jobs_ibfk_2` FOREIGN KEY (`additional_job_types_id`) REFERENCES `additional_job_types`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `additional_jobs` ADD CONSTRAINT `additional_jobs_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `applicant_to_job` ADD CONSTRAINT `applicant_to_job_ibfk_2` FOREIGN KEY (`applicant_id`) REFERENCES `applicants`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `applicant_to_job` ADD CONSTRAINT `applicant_to_job_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `applications` ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicants`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `applications` ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `jobs`(`id`) ON DELETE SET NULL ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ats_attributes_matcher` ADD CONSTRAINT `ats_attributes_matcher_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `job_attributes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ats_recruiter_attributes_matcher` ADD CONSTRAINT `ats_recruiter_attributes_matcher_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `recruiter_attributes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `attribute_to_job` ADD CONSTRAINT `attribute_to_job_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `job_attributes`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `attribute_to_job` ADD CONSTRAINT `attribute_to_job_ibfk_3` FOREIGN KEY (`attribute_value_id`) REFERENCES `job_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `attribute_to_job` ADD CONSTRAINT `attribute_to_job_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `custom_campaigns_detail` ADD CONSTRAINT `fk_applicant_id_bio3` FOREIGN KEY (`applicant_id`) REFERENCES `applicants`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `custom_campaigns_detail` ADD CONSTRAINT `fk_custom_campaigns_id_bio3` FOREIGN KEY (`custom_campaigns_id`) REFERENCES `custom_campaigns`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `datalayers` ADD CONSTRAINT `datalayers_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `templates`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `design_categories` ADD CONSTRAINT `design_categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `design_categories`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `design_categories` ADD CONSTRAINT `design_categories_ibfk_2` FOREIGN KEY (`theme_id`) REFERENCES `theme`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `design_options` ADD CONSTRAINT `design_options_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `design_categories`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `element_content` ADD CONSTRAINT `element_content_ibfk_1` FOREIGN KEY (`element_id`) REFERENCES `elements`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `element_datalayer` ADD CONSTRAINT `element_datalayer_ibfk_1` FOREIGN KEY (`element_template_version_id`) REFERENCES `element_template_versions`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `element_template_versions` ADD CONSTRAINT `element_template_versions_ibfk_1` FOREIGN KEY (`element_template_id`) REFERENCES `element_templates`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `element_template_versions` ADD CONSTRAINT `element_template_versions_ibfk_2` FOREIGN KEY (`theme_id`) REFERENCES `theme`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `element_to_pages` ADD CONSTRAINT `element_to_pages_ibfk_1` FOREIGN KEY (`element_id`) REFERENCES `elements`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `element_to_pages` ADD CONSTRAINT `element_to_pages_ibfk_2` FOREIGN KEY (`page_id`) REFERENCES `pages`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `elements` ADD CONSTRAINT `elements_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `elements` ADD CONSTRAINT `elements_ibfk_1` FOREIGN KEY (`element_template_version_id`) REFERENCES `element_template_versions`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `elements` ADD CONSTRAINT `elements_ibfk_3` FOREIGN KEY (`page_id`) REFERENCES `pages`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `email_template_contents` ADD CONSTRAINT `email_template_contents_ibfk_1` FOREIGN KEY (`email_template_id`) REFERENCES `email_templates`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `facebook_jobs` ADD CONSTRAINT `facebook_jobs_ibfk_2` FOREIGN KEY (`job_additional_id`) REFERENCES `additional_jobs`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `facebook_jobs` ADD CONSTRAINT `facebook_jobs_ibfk_1` FOREIGN KEY (`job_content_id`) REFERENCES `job_content`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ad_budget` ADD CONSTRAINT `fb_ad_budget_ibfk_1` FOREIGN KEY (`job_attribute_value_id`) REFERENCES `job_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ad_budget` ADD CONSTRAINT `fb_ad_budget_ibfk_2` FOREIGN KEY (`job_content_id`) REFERENCES `job_content`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ad_sets` ADD CONSTRAINT `fb_ad_sets_ibfk_4` FOREIGN KEY (`booston_ad_id`) REFERENCES `fb_ads`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ad_sets` ADD CONSTRAINT `fb_ad_sets_ibfk_3` FOREIGN KEY (`booston_budget_id`) REFERENCES `fb_ad_budget`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ad_sets` ADD CONSTRAINT `fb_ad_sets_ibfk_1` FOREIGN KEY (`fb_campaign_id`) REFERENCES `fb_campaigns`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ad_sets` ADD CONSTRAINT `fb_ad_sets_ibfk_2` FOREIGN KEY (`targeting_id`) REFERENCES `fb_targeting`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ad_template` ADD CONSTRAINT `fb_ad_template_ibfk_1` FOREIGN KEY (`job_attribute_value_id`) REFERENCES `job_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ad_template` ADD CONSTRAINT `fb_ad_template_ibfk_2` FOREIGN KEY (`job_content_id`) REFERENCES `job_content`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ads` ADD CONSTRAINT `fb_ads_ibfk_1` FOREIGN KEY (`booston_ad_set_id`) REFERENCES `fb_ad_sets`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ads` ADD CONSTRAINT `fb_ads_ibfk_2` FOREIGN KEY (`booston_template_id`) REFERENCES `fb_ad_template`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_ads` ADD CONSTRAINT `fb_ads_ibfk_3` FOREIGN KEY (`job_content_id`) REFERENCES `job_content`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_cities` ADD CONSTRAINT `fb_cities_ibfk_1` FOREIGN KEY (`targeting_id`) REFERENCES `fb_targeting`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_countries` ADD CONSTRAINT `fb_countries_ibfk_1` FOREIGN KEY (`targeting_id`) REFERENCES `fb_targeting`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_interests` ADD CONSTRAINT `fb_interests_ibfk_1` FOREIGN KEY (`targeting_id`) REFERENCES `fb_targeting`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_jobgroup_attribute` ADD CONSTRAINT `fb_jobgroup_attribute_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `job_attributes`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_leadgen` ADD CONSTRAINT `fb_leadgen_ibfk_1` FOREIGN KEY (`job_attribute_value_id`) REFERENCES `job_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_leadgen` ADD CONSTRAINT `fb_leadgen_ibfk_2` FOREIGN KEY (`job_content_id`) REFERENCES `job_content`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_regions` ADD CONSTRAINT `fb_regions_ibfk_1` FOREIGN KEY (`targeting_id`) REFERENCES `fb_targeting`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_targeting` ADD CONSTRAINT `fb_targeting_ibfk_2` FOREIGN KEY (`job_attribute_value_id`) REFERENCES `job_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `fb_targeting` ADD CONSTRAINT `fb_targeting_ibfk_1` FOREIGN KEY (`job_content_id`) REFERENCES `job_content`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `google_for_jobs_attribute_values` ADD CONSTRAINT `google_for_jobs_attribute_values_ibfk_1` FOREIGN KEY (`google_for_jobs_attribute_id`) REFERENCES `google_for_jobs_attributes`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `job_attribute_titles` ADD CONSTRAINT `job_attribute_titles_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `job_attributes`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `job_attribute_value_titles` ADD CONSTRAINT `job_attribute_value_titles_ibfk_1` FOREIGN KEY (`attribute_value_id`) REFERENCES `job_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `job_attribute_values` ADD CONSTRAINT `job_attribute_values_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `job_attributes`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `job_attribute_values` ADD CONSTRAINT `job_attribute_values_ibfk_2` FOREIGN KEY (`google_for_jobs_value_id`) REFERENCES `google_for_jobs_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `job_attribute_values` ADD CONSTRAINT `job_attribute_values_ibfk_3` FOREIGN KEY (`jobs_on_facebook_value_id`) REFERENCES `jobs_on_facebook_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `job_content` ADD CONSTRAINT `job_content_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `job_content` ADD CONSTRAINT `job_content_ibfk_2` FOREIGN KEY (`modified_by`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `jobalerts` ADD CONSTRAINT `jobalerts_ibfk_1` FOREIGN KEY (`element_content_id`) REFERENCES `element_content`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `jobs` ADD CONSTRAINT `jobs_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `jobs` ADD CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`recruiter_id`) REFERENCES `recruiters`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `jobs_on_facebook_attribute_values` ADD CONSTRAINT `jobs_on_facebook_attribute_values_ibfk_1` FOREIGN KEY (`jobs_on_facebook_attribute_id`) REFERENCES `jobs_on_facebook_attributes`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `lead_details` ADD CONSTRAINT `lead_details_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `leads`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `menuitem_content` ADD CONSTRAINT `menuitem_content_ibfk_1` FOREIGN KEY (`menuitem_id`) REFERENCES `menuitems`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `menuitem_content` ADD CONSTRAINT `menuitem_content_ibfk_2` FOREIGN KEY (`modified_by`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `menuitems` ADD CONSTRAINT `menuitems_ibfk_2` FOREIGN KEY (`page_id`) REFERENCES `pages`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `menuitems` ADD CONSTRAINT `menuitems_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `menuitems`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `pages` ADD CONSTRAINT `pages_ibfk_1` FOREIGN KEY (`template_version_id`) REFERENCES `template_versions`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `recruiter_attribute_titles` ADD CONSTRAINT `recruiter_attribute_titles_ibfk_1` FOREIGN KEY (`recruiter_attributes_id`) REFERENCES `recruiter_attributes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `recruiter_attribute_value_titles` ADD CONSTRAINT `recruiter_attribute_value_titles_ibfk_1` FOREIGN KEY (`recruiter_attribute_value_id`) REFERENCES `recruiter_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `recruiter_attribute_values` ADD CONSTRAINT `recruiter_attribute_values_ibfk_3` FOREIGN KEY (`google_for_jobs_value_id`) REFERENCES `google_for_jobs_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `recruiter_attribute_values` ADD CONSTRAINT `recruiter_attribute_values_ibfk_2` FOREIGN KEY (`jobs_on_facebook_value_id`) REFERENCES `jobs_on_facebook_attribute_values`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `recruiter_attribute_values` ADD CONSTRAINT `recruiter_attribute_values_ibfk_1` FOREIGN KEY (`recruiter_attributes_id`) REFERENCES `recruiter_attributes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `recruiter_content` ADD CONSTRAINT `recruiter_content_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `recruiter_content` ADD CONSTRAINT `recruiter_content_ibfk_1` FOREIGN KEY (`recruiter_id`) REFERENCES `recruiters`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `template_versions` ADD CONSTRAINT `template_versions_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `templates`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `user_permissions` ADD CONSTRAINT `user_permissions_ibfk_1` FOREIGN KEY (`admin_modules_id`) REFERENCES `admin_modules`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `user_permissions` ADD CONSTRAINT `user_permissions_ibfk_2` FOREIGN KEY (`user_role_id`) REFERENCES `user_role`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `user_role` ADD CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`default_page_id`) REFERENCES `admin_modules`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `users_recruiters` ADD CONSTRAINT `fk_recruiter_id` FOREIGN KEY (`recruiter_id`) REFERENCES `recruiters`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `users_recruiters` ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `category` ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `category`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `category_translation` ADD CONSTRAINT `category_translation_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category`(`id`) ON DELETE CASCADE ON UPDATE RESTRICT;
