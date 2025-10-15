-- Agriculture Chatbot Database Schema
-- Create database
CREATE DATABASE IF NOT EXISTS agri_chatbot CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE agri_chatbot;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(100),
    email VARCHAR(255),
    phone VARCHAR(20),
    location VARCHAR(255),
    farm_type VARCHAR(100),
    farm_size_acres DECIMAL(10, 2),
    experience_years INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_user_id (user_id),
    INDEX idx_email (email)
);

-- Chat messages table
CREATE TABLE IF NOT EXISTS chat_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    message_type ENUM('user', 'assistant') NOT NULL,
    topic_category VARCHAR(100),
    confidence_score DECIMAL(3, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_user_id (user_id),
    INDEX idx_message_type (message_type),
    INDEX idx_created_at (created_at),
    INDEX idx_topic_category (topic_category),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Agricultural topics/categories table
CREATE TABLE IF NOT EXISTS agriculture_topics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    topic_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    parent_topic_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_parent_topic (parent_topic_id),
    FOREIGN KEY (parent_topic_id) REFERENCES agriculture_topics(id) ON DELETE CASCADE
);

-- Crop information table
CREATE TABLE IF NOT EXISTS crops (
    id INT AUTO_INCREMENT PRIMARY KEY,
    crop_name VARCHAR(100) NOT NULL UNIQUE,
    scientific_name VARCHAR(150),
    crop_type VARCHAR(50),
    growing_season VARCHAR(50),
    water_requirements VARCHAR(50),
    soil_type_preference TEXT,
    climate_requirements TEXT,
    average_yield_per_acre DECIMAL(8, 2),
    harvest_time_days INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_crop_name (crop_name),
    INDEX idx_crop_type (crop_type),
    INDEX idx_growing_season (growing_season)
);

-- Pest and disease information table
CREATE TABLE IF NOT EXISTS pests_diseases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type ENUM('pest', 'disease', 'weed') NOT NULL,
    scientific_name VARCHAR(150),
    affected_crops TEXT,
    symptoms TEXT,
    prevention_methods TEXT,
    treatment_methods TEXT,
    severity_level ENUM('low', 'medium', 'high', 'critical') DEFAULT 'medium',
    seasonal_occurrence VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_type (type),
    INDEX idx_severity (severity_level)
);

-- Weather data table (for historical data and analytics)
CREATE TABLE IF NOT EXISTS weather_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    temperature_max DECIMAL(5, 2),
    temperature_min DECIMAL(5, 2),
    humidity DECIMAL(5, 2),
    rainfall DECIMAL(6, 2),
    wind_speed DECIMAL(5, 2),
    uv_index DECIMAL(3, 1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_location_date (location, date),
    INDEX idx_date (date)
);

-- User feedback table
CREATE TABLE IF NOT EXISTS user_feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    message_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    feedback_text TEXT,
    feedback_type ENUM('helpful', 'not_helpful', 'incorrect', 'suggestion') DEFAULT 'helpful',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_user_id (user_id),
    INDEX idx_message_id (message_id),
    INDEX idx_rating (rating),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (message_id) REFERENCES chat_messages(id) ON DELETE CASCADE
);

-- Agricultural best practices table
CREATE TABLE IF NOT EXISTS best_practices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    description TEXT,
    detailed_steps TEXT,
    applicable_crops TEXT,
    season VARCHAR(50),
    difficulty_level ENUM('beginner', 'intermediate', 'advanced') DEFAULT 'beginner',
    estimated_cost DECIMAL(10, 2),
    expected_benefits TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_season (season),
    INDEX idx_difficulty (difficulty_level)
);

-- Insert some initial data

-- Sample agriculture topics
INSERT INTO agriculture_topics (topic_name, description, parent_topic_id) VALUES
('Crop Management', 'General crop management practices and techniques', NULL),
('Pest Control', 'Pest identification, prevention, and control methods', NULL),
('Soil Health', 'Soil testing, fertilization, and improvement techniques', NULL),
('Weather & Climate', 'Weather patterns, climate adaptation, and seasonal planning', NULL),
('Equipment & Technology', 'Agricultural equipment, tools, and modern farming technology', NULL),
('Sustainable Farming', 'Organic farming, permaculture, and sustainable practices', NULL),
('Irrigation', 'Water management and irrigation systems', 1),
('Fertilization', 'Nutrient management and fertilizer application', 1),
('Harvesting', 'Harvesting techniques and post-harvest handling', 1),
('Organic Pest Control', 'Natural and organic pest control methods', 2),
('Integrated Pest Management', 'IPM strategies and implementation', 2);

-- Sample crops
INSERT INTO crops (crop_name, scientific_name, crop_type, growing_season, water_requirements, soil_type_preference, harvest_time_days) VALUES
('Rice', 'Oryza sativa', 'Cereal', 'Kharif', 'High', 'Clay loam, well-drained', 120),
('Wheat', 'Triticum aestivum', 'Cereal', 'Rabi', 'Medium', 'Loamy soil, well-drained', 110),
('Corn/Maize', 'Zea mays', 'Cereal', 'Kharif', 'Medium-High', 'Well-drained loamy soil', 90),
('Tomato', 'Solanum lycopersicum', 'Vegetable', 'Year-round', 'Medium', 'Well-drained, fertile soil', 80),
('Potato', 'Solanum tuberosum', 'Vegetable', 'Rabi', 'Medium', 'Sandy loam, well-drained', 90),
('Cotton', 'Gossypium', 'Cash Crop', 'Kharif', 'Medium', 'Black cotton soil', 180),
('Sugarcane', 'Saccharum officinarum', 'Cash Crop', 'Year-round', 'High', 'Fertile, well-drained soil', 365);

-- Sample pests and diseases
INSERT INTO pests_diseases (name, type, scientific_name, affected_crops, symptoms, severity_level) VALUES
('Aphids', 'pest', 'Aphidoidea', 'Most vegetables and crops', 'Yellowing leaves, stunted growth, honeydew secretion', 'medium'),
('Late Blight', 'disease', 'Phytophthora infestans', 'Potato, Tomato', 'Dark lesions on leaves, white fungal growth', 'high'),
('Stem Borer', 'pest', 'Scirpophaga incertulas', 'Rice, Sugarcane', 'Dead hearts, white ears, tunnel holes', 'high'),
('Powdery Mildew', 'disease', 'Erysiphales', 'Various crops', 'White powdery coating on leaves', 'medium'),
('Cutworm', 'pest', 'Noctuidae', 'Seedlings, young plants', 'Cut stems at soil level, damaged seedlings', 'medium');

-- Sample best practices
INSERT INTO best_practices (title, category, description, applicable_crops, season, difficulty_level) VALUES
('Crop Rotation', 'Crop Management', 'Systematic rotation of different crops to maintain soil health', 'All crops', 'Year-round', 'intermediate'),
('Drip Irrigation Setup', 'Water Management', 'Efficient water delivery system for precise irrigation', 'Vegetables, Fruits', 'Year-round', 'intermediate'),
('Companion Planting', 'Sustainable Farming', 'Growing complementary plants together for mutual benefit', 'Vegetables', 'Growing season', 'beginner'),
('Soil Testing Protocol', 'Soil Health', 'Regular soil analysis for optimal nutrient management', 'All crops', 'Before planting', 'beginner'),
('Integrated Pest Management', 'Pest Control', 'Holistic approach to pest control using multiple strategies', 'All crops', 'Year-round', 'advanced');