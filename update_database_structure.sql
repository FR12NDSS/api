-- 1. เพิ่มคอลัมน์ใหม่ในตาราง games
ALTER TABLE games
ADD COLUMN provider VARCHAR(100) NOT NULL AFTER name,
ADD COLUMN type VARCHAR(50) NOT NULL AFTER provider,
ADD COLUMN thumbnail TEXT AFTER type,
ADD COLUMN release_date DATE DEFAULT NULL AFTER thumbnail,
ADD COLUMN is_active BOOLEAN DEFAULT TRUE AFTER release_date;

-- 2. เพิ่มตาราง game_providers สำหรับจัดการค่ายเกม
CREATE TABLE IF NOT EXISTS game_providers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  website VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. เพิ่มตาราง game_categories สำหรับจัดการประเภทเกม
CREATE TABLE IF NOT EXISTS game_categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

-- 4. เชื่อมโยงตาราง games กับ providers และ categories
ALTER TABLE games
ADD COLUMN provider_id INT,
ADD COLUMN category_id INT,
ADD FOREIGN KEY (provider_id) REFERENCES game_providers(id),
ADD FOREIGN KEY (category_id) REFERENCES game_categories(id);

-- 5. เพิ่มตัวอย่างข้อมูลในตาราง game_providers
INSERT INTO game_providers (name, description, website) VALUES
('PGSoft', 'Pocket Games Soft ผู้ให้บริการเกมมือถือยอดนิยม', 'https://www.pgsoft.com'),
('Pragmatic Play', 'ผู้ให้บริการสล็อตและคาสิโนสด', 'https://www.pragmaticplay.com'),
('Joker Gaming', 'ค่ายเกมยอดนิยมของคนไทย', 'https://joker-gaming.net');

-- 6. เพิ่มตัวอย่างข้อมูลในตาราง game_categories
INSERT INTO game_categories (name) VALUES
('Slot'),
('Table Game'),
('Fishing'),
('Arcade');