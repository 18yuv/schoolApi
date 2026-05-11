-- Create the database
CREATE DATABASE IF NOT EXISTS school_management
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE school_management;

-- Create the schools table
CREATE TABLE IF NOT EXISTS schools (
  id          INT            NOT NULL AUTO_INCREMENT,
  name        VARCHAR(255)   NOT NULL,
  address     VARCHAR(500)   NOT NULL,
  latitude    FLOAT(10, 6)   NOT NULL,
  longitude   FLOAT(10, 6)   NOT NULL,
  created_at  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  INDEX idx_name      (name),
  INDEX idx_location  (latitude, longitude)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- samples
INSERT INTO schools (name, address, latitude, longitude) VALUES
  ('Delhi Public School',       'Mathura Road, New Delhi, Delhi 110003',           28.5562, 77.2410),
  ('St. Xavier High School',    'Park Street, Kolkata, West Bengal 700016',        22.5514, 88.3536),
  ('Ryan International School', 'Sector 40, Gurugram, Haryana 122003',             28.4595, 77.0266),
  ('Kendriya Vidyalaya No. 1',  'IIT Campus, Hauz Khas, New Delhi 110016',        28.5459, 77.1926),
  ('The Cathedral School',      'Fort Area, Mumbai, Maharashtra 400001',           18.9322, 72.8347),
  ('Mayo College',              'Mayo Link Road, Ajmer, Rajasthan 305001',         26.4499, 74.6399),
  ('Doon School',               'Mall Road, Dehradun, Uttarakhand 248001',         30.3165, 78.0322),
  ('Agra Public School',        'Sanjay Place, Agra, Uttar Pradesh 282002',        27.1767, 78.0081),
  ('City Montessori School',    'Mahanagar, Lucknow, Uttar Pradesh 226006',        26.8467, 80.9462),
  ('Bishops School',            'Camp, Pune, Maharashtra 411001',                  18.5204, 73.8567);