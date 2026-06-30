-- ============================================================
-- Social App - MEGA Demo Seed Data (Sri Lanka Themed)
-- Database: PostgreSQL
-- Password for ALL users: password123
-- BCrypt hash: $2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG
--
-- DEMO HERO ACCOUNTS:
--   User 1 - Ashan Pathirana   ashan@demo.com   (main demo account)
--   User 2 - Nimasha Fernando  nimasha@demo.com  (second demo account)
--
-- FEATURE COVERAGE:
--   Feed - friends feed + discover tab, rich posts
--   Profile - bio, join date, post list, friend count
--   Friend system - accepted, pending (incoming + outgoing), rejected
--   Likes - many posts liked, including hero user posts
--   Comments - active threads on hero posts
--   Search - varied names + post keywords
--   Notifications - likes, comments, friend requests, friend accepted
-- ============================================================

-- ============================================================
-- CLEAN SLATE
-- ============================================================
TRUNCATE TABLE notifications   RESTART IDENTITY CASCADE;
TRUNCATE TABLE likes           RESTART IDENTITY CASCADE;
TRUNCATE TABLE comments        RESTART IDENTITY CASCADE;
TRUNCATE TABLE friend_requests RESTART IDENTITY CASCADE;
TRUNCATE TABLE friendships     RESTART IDENTITY CASCADE;
TRUNCATE TABLE posts           RESTART IDENTITY CASCADE;
TRUNCATE TABLE users           RESTART IDENTITY CASCADE;

-- ============================================================
-- USERS  (102 total)
-- IDs 1-2: DEMO HERO USERS
-- IDs 3-102: Supporting cast
-- ============================================================
INSERT INTO users (first_name, last_name, email, password_hash, bio, profile_picture, join_date) VALUES
-- ── HERO USERS ──────────────────────────────────────────────
('Ashan',    'Pathirana',  'ashan@demo.com',   '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Software engineer from Colombo 💻 | Cricket fanatic 🏏 | Exploring every corner of Sri Lanka 🇱🇰', 'ashan.jpg',   '2024-01-05'),
('Nimasha',  'Fernando',   'nimasha@demo.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Graphic designer & travel blogger ✈️ | Sunset chaser 🌅 | Colombo girl living her best life ☕', 'nimasha.jpg', '2024-01-08'),
-- ── FRIENDS OF ASHAN (ids 3-16) ─────────────────────────────
('Kasun',    'Bandara',    'kasun3@mail.com',   '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Tea estate worker''s child from Kandy ☕ | Nature lover & weekend hiker', 'kasun3.jpg',   '2024-01-12'),
('Dilini',   'Gunasekara', 'dilini4@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Marine biology student 🐠 | Beach is life 🌊 | Hikkaduwa local', 'dilini4.jpg',  '2024-02-03'),
('Ruwan',    'Weerasinghe','ruwan5@mail.com',   '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Traveller & food blogger 🍛 | Exploring the pearl of the Indian Ocean', 'ruwan5.jpg',   '2024-02-14'),
('Sanduni',  'Perera',     'sanduni6@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Kottu roti is my religion 🌶️ | Street food hunter in Galle', 'sanduni6.jpg', '2024-02-20'),
('Chamara',  'Bandara',    'chamara7@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Batik artist preserving traditional Sri Lankan craft 🎨 | Bentota', 'chamara7.jpg', '2024-03-01'),
('Tharushi', 'Ranasinghe', 'tharushi8@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'History buff & Kandyan dancer 💃 | Proud Sri Lankan from Kandy', 'tharushi8.jpg','2024-03-07'),
('Lahiru',   'Liyanage',   'lahiru9@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Home baker specialising in love cake and kokis 🍰 | Negombo', 'lahiru9.jpg',  '2024-03-15'),
('Kavindi',  'Jayasuriya', 'kavindi10@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Wildlife guide at Yala 🐘 | Safari stories every weekend', 'kavindi10.jpg','2024-03-22'),
('Pavithra', 'Kumara',     'pavithra11@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Yoga & Ayurveda retreat host in Sigiriya 🧘 | Plant mum 🌿', 'pavithra11.jpg','2024-04-01'),
('Isuru',    'Dissanayake','isuru12@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Photographer chasing golden hour across Badulla 📸', 'isuru12.jpg',  '2024-04-09'),
('Hansika',  'Mendis',     'hansika13@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Surfer from Mirissa 🌊 | Chasing waves and good vibes', 'hansika13.jpg','2024-04-17'),
('Nuwan',    'Ekanayake',  'nuwan14@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'IT student at UCSC 💻 | Coder by day, gamer by night 🎮', 'nuwan14.jpg',  '2024-04-25'),
('Anjali',   'Silva',      'anjali15@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Fisherman''s family from Negombo 🎣 | Sun, sea and serenity', 'anjali15.jpg', '2024-05-03'),
('Dinesh',   'Senanayake', 'dinesh16@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Tuk-tuk driver and proud Dambulla local 🛺 | Full-time character', 'dinesh16.jpg', '2024-05-10'),
-- ── FRIENDS OF NIMASHA (ids 17-30) ──────────────────────────
('Sachini',  'Amarasinghe','sachini17@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Fashion designer inspired by Sri Lankan textiles 👗 | Colombo 7', 'sachini17.jpg','2024-05-18'),
('Roshan',   'Rathnayake', 'roshan18@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Athlete & long-distance runner 🏃 | Representing Sri Lanka one race at a time', 'roshan18.jpg','2024-05-25'),
('Madushani','Perera',     'madushani19@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Ayurveda student & herbal garden lover 🌿 | Sigiriya local', 'madushani19.jpg','2024-06-02'),
('Janaka',   'Seneviratne','janaka20@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Full-stack developer | Coffee addict ☕ | Building cool things from Colombo', 'janaka20.jpg','2024-06-10'),
('Thilini',  'Weerasinghe','thilini21@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Interior designer 🏠 | Vintage furniture restorer | Colombo 3', 'thilini21.jpg','2024-06-18'),
('Sampath',  'Silva',      'sampath22@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Mountain biker 🚵 | Exploring Knuckles Range every weekend', 'sampath22.jpg','2024-06-26'),
('Anusha',   'Fernando',   'anusha23@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Primary school teacher 🍎 | Passionate about education in rural Sri Lanka', 'anusha23.jpg', '2024-07-04'),
('Buddhika', 'Herath',     'buddhika24@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Whale watching guide near Mirissa 🐬 | Ocean is my office', 'buddhika24.jpg','2024-07-12'),
('Yasodara', 'Pathirana',  'yasodara25@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Gemologist 💎 | Ratnapura born and raised | Sapphires are my thing', 'yasodara25.jpg','2024-07-20'),
('Mahesh',   'Senanayake', 'mahesh26@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Archaeologist studying ruins in Polonnaruwa 🏛️ | History nerd', 'mahesh26.jpg', '2024-07-28'),
('Chathuri', 'Gunasekara', 'chathuri27@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'New mum 👶 | Baking lover | Anuradhapura girl living in Colombo', 'chathuri27.jpg','2024-08-05'),
('Pradeep',  'Amarasinghe','pradeep28@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Trincomalee beach resort owner 🌴 | Entrepreneur | Sun lover', 'pradeep28.jpg','2024-08-13'),
('Ishara',   'Jayasuriya', 'ishara29@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Environmental activist 🌍 | Beach cleanups every Saturday | Colombo', 'ishara29.jpg', '2024-08-21'),
('Gayan',    'Wijesinghe', 'gayan30@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Drummer in a rock band 🥁 | Night owl | Colombo music scene', 'gayan30.jpg',  '2024-08-29'),
-- ── MUTUAL FRIENDS (both hero users know these, ids 31-40) ──
('Vindya',   'Madushanka', 'vindya31@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'UI/UX designer 🖥️ | Coffee snob ☕ | Remote worker from Kandy', 'vindya31.jpg', '2024-09-05'),
('Sahan',    'Gunasekara', 'sahan32@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Stand-up comedian 🎤 | Making Sri Lanka laugh one joke at a time', 'sahan32.jpg',  '2024-09-12'),
('Nadeesha', 'Bandara',    'nadeesha33@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Vet at Dehiwala Zoo 🦁 | Animal lover | Volunteer on weekends', 'nadeesha33.jpg','2024-09-19'),
('Charith',  'Herath',     'charith34@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Professional cricketer ⚪ | National U23 team | Colombo CC', 'charith34.jpg','2024-09-26'),
('Hashini',  'Dissanayake','hashini35@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Book club organiser 📚 | Amateur poet | Ella coffee farm girl', 'hashini35.jpg','2024-10-03'),
('Damith',   'Dissanayake','damith36@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Street photographer 📷 | Colombo streets after dark', 'damith36.jpg', '2024-10-10'),
('Piumi',    'Ranasinghe', 'piumi37@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Event planner 🎉 | Weddings & corporate | Colombo 5', 'piumi37.jpg',  '2024-10-17'),
('Lakshan',  'Kumara',     'lakshan38@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Chef 👨‍🍳 | Sri Lankan fusion cuisine | Popup restaurant in Colombo 7', 'lakshan38.jpg','2024-10-24'),
('Senani',   'Jayasuriya', 'senani39@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Civil engineer 🏗️ | Building Sri Lanka''s future | Colombo', 'senani39.jpg', '2024-11-01'),
('Manoj',    'Kumara',     'manoj40@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Motorbike tourer 🏍️ | Done the whole island twice | Kurunegala', 'manoj40.jpg',  '2024-11-08'),
-- ── GENERAL COMMUNITY (ids 41-102) ──────────────────────────
('Kalani',   'Ranasinghe', 'kalani41@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Librarian & bookworm 📖 | Polonnaruwa history lover', 'kalani41.jpg', '2024-01-15'),
('Asela',    'Senanayake', 'asela42@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Startup founder 🚀 | EdTech | Colombo innovation hub', 'asela42.jpg',  '2024-01-22'),
('Rashmi',   'Mendis',     'rashmi43@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Surf instructor 🏄 | Hikkaduwa beach | Sea is my soul', 'rashmi43.jpg', '2024-01-29'),
('Tilan',    'Ekanayake',  'tilan44@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Tea sommelier ☕ | Nuwara Eliya estates | Making tea cool again', 'tilan44.jpg',  '2024-02-05'),
('Oshadi',   'Wickramasinghe','oshadi45@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Love cake & kokis master baker 🍰 | Grandma''s secret recipes', 'oshadi45.jpg','2024-02-12'),
('Vimukthi', 'Perera',     'vimukthi46@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Sailor ⛵ | Colombo port | Loves the open sea', 'vimukthi46.jpg','2024-02-19'),
('Dinusha',  'Silva',      'dinusha47@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Nurse 🏥 | National Hospital Colombo | Proud healthcare worker', 'dinusha47.jpg','2024-02-26'),
('Pasan',    'Fernando',   'pasan48@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'DJ & music producer 🎧 | Colombo nightlife | Bass is life', 'pasan48.jpg',  '2024-03-05'),
('Malsha',   'Bandara',    'malsha49@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Pilates instructor 🤸 | Wellness blogger | Colombo 4', 'malsha49.jpg', '2024-03-12'),
('Udara',    'Jayawardena','udara50@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Landscape architect 🌳 | Designing green spaces in Colombo', 'udara50.jpg',  '2024-03-19'),
('Irushi',   'Rathnayake', 'irushi51@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Jewellery designer 💍 | Silver & sapphires | Ratnapura', 'irushi51.jpg', '2024-03-26'),
('Bimal',    'Wijesinghe', 'bimal52@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Scuba diver 🤿 | Coral reef conservation | Trincomalee', 'bimal52.jpg',  '2024-04-02'),
('Dinesha',  'Senanayake', 'dinesha53@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Classical violinist 🎻 | Performs at Sri Lanka Symphony', 'dinesha53.jpg','2024-04-09'),
('Nithya',   'Kumar',      'nithya54@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Tamil literature teacher 📝 | Jaffna University | Cultural bridge', 'nithya54.jpg', '2024-04-16'),
('Raveena',  'Sivarajah',  'raveena55@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Bharatanatyam dancer 💃 | Jaffna arts council | Performing monthly', 'raveena55.jpg','2024-04-23'),
('Arjun',    'Yogarajah',  'arjun56@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Organic farmer 🌾 | Jaffna peninsula | Grows the best mangoes', 'arjun56.jpg',  '2024-04-30'),
('Kavya',    'Muthulingam', 'kavya57@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Social entrepreneur | Women empowerment NGO | Batticaloa', 'kavya57.jpg',  '2024-05-07'),
('Mohamed',  'Farzan',     'farzan58@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Gem trader 💎 | Beruwala | Third generation in the trade', 'farzan58.jpg', '2024-05-14'),
('Fathima',  'Naseem',     'fathima59@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Food vlogger 🍜 | Malay & Sri Lankan fusion | Colombo 10', 'fathima59.jpg','2024-05-21'),
('Rasheed',  'Farook',     'rasheed60@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Architecture student 🏛️ | Old Dutch buildings of Galle Fort fan', 'rasheed60.jpg','2024-05-28'),
('Thiaga',   'Navaratnam', 'thiaga61@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Hindu temple priest 🙏 | Nallur Kovil festival organiser | Jaffna', 'thiaga61.jpg', '2024-06-04'),
('Siva',     'Krishnamurthy','siva62@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Electrical engineer ⚡ | Solar power advocate | Jaffna', 'siva62.jpg',   '2024-06-11'),
('Amara',    'Dissanayake','amara63@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Wedding photographer 📷 | Capturing love stories across Sri Lanka', 'amara63.jpg',  '2024-06-18'),
('Supun',    'Jayaweera',  'supun64@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Lifeguard 🏊 | Unawatuna beach | Training for national swim team', 'supun64.jpg',  '2024-06-25'),
('Dulani',   'Rajapaksa',  'dulani65@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Accountant 📊 | CPA Sri Lanka | Numbers person by day, cook by night', 'dulani65.jpg', '2024-07-02'),
('Ishan',    'Cooray',     'ishan66@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Startup CTO 🚀 | YC alumni | Building the next big Sri Lankan app', 'ishan66.jpg',  '2024-07-09'),
('Nilmini',  'Premachandra','nilmini67@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Sinhala poet ✍️ | Short stories | National literary award 2023', 'nilmini67.jpg','2024-07-16'),
('Ravindu',  'Karunanayake','ravindu68@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Cinnamon spice farmer 🌿 | Kalutara | Sixth generation spice family', 'ravindu68.jpg','2024-07-23'),
('Sandali',  'Weerakoon',  'sandali69@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Colombo 3 barista ☕ | Specialty coffee evangelist', 'sandali69.jpg','2024-07-30'),
('Amila',    'Perera',     'amila70@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Astronomer 🔭 | Colombo University | Star gazing in Mahiyanganaya', 'amila70.jpg',  '2024-08-06'),
('Chanuka',  'Samaraweera','chanuka71@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Rugby player 🏉 | Colombo FC | Proud member of national squad', 'chanuka71.jpg','2024-08-13'),
('Thisari',  'Wickrama',   'thisari72@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Illustrator 🖌️ | Graphic novels about Sri Lankan mythology', 'thisari72.jpg','2024-08-20'),
('Dimuth',   'Karunarathne','dimuth73@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Hotel manager 🏨 | Galle Face Green Colombo | Hospitality is my passion', 'dimuth73.jpg','2024-08-27'),
('Sarani',   'Gunasena',   'sarani74@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Makeup artist 💄 | Bridal specialist | Colombo & Kandy', 'sarani74.jpg', '2024-09-03'),
('Lochana',  'Jayasinghe', 'lochana75@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Podcaster 🎙️ | "Living Lanka" — Sri Lanka''s top travel podcast', 'lochana75.jpg','2024-09-10'),
('Nalin',    'Siriwardena','nalin76@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Financial analyst 📈 | CSE trader | Colombo financial district', 'nalin76.jpg',  '2024-09-17'),
('Kaveeshi', 'Weerasekara','kaveeshi77@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Marine engineer 🚢 | Colombo port | Loves deep-sea fishing', 'kaveeshi77.jpg','2024-09-24'),
('Dulara',   'Fernando',   'dulara78@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Ballet teacher 🩰 | Western Province Arts school | Colombo', 'dulara78.jpg', '2024-10-01'),
('Muditha',  'Alwis',      'muditha79@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Elephant conservationist 🐘 | Pinnawala sanctuary | 10+ years', 'muditha79.jpg','2024-10-08'),
('Sithara',  'Jayakody',   'sithara80@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Science teacher 🔬 | Nalanda College | Inspiring future scientists', 'sithara80.jpg','2024-10-15'),
('Chathurika','Premadasa',  'chathurika81@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Pastry chef 🥐 | French-trained | Opened a patisserie in Colombo 7', 'chathurika81.jpg','2024-10-22'),
('Dinusha',  'Ranawaka',   'dinusha82@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Human rights lawyer ⚖️ | Fighting for justice one case at a time', 'dinusha82.jpg','2024-10-29'),
('Sulochana','Hewawitharana','sulochana83@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Pottery artist 🏺 | Traditional Sri Lankan clay work | Ambalangoda', 'sulochana83.jpg','2024-11-05'),
('Asanka',   'Gamage',     'asanka84@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Football coach ⚽ | FC Colombo Youth Academy | Growing the game', 'asanka84.jpg', '2024-11-12'),
('Hiruni',   'Wickramasinghe','hiruni85@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Novelist ✍️ | Debut book "Monsoon Letters" out now | Colombo', 'hiruni85.jpg','2024-11-19'),
('Priyantha','Wimalasena', 'priyantha86@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Buddhist monk scholar 🙏 | Kelaniya temple | Pali literature', 'priyantha86.jpg','2024-11-26'),
('Sanjeewa', 'Rajapaksha', 'sanjeewa87@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Truck driver 🚛 | Covers the whole island | King of the highway', 'sanjeewa87.jpg','2024-12-03'),
('Erandi',   'Siriwardena','erandi88@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Textile designer 🧵 | Handloom revival project | Kandy', 'erandi88.jpg', '2024-12-10'),
('Niluka',   'Rajaguru',   'niluka89@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Paramedic 🚑 | Saving lives since 2020 | Colombo General Hospital', 'niluka89.jpg', '2024-12-17'),
('Himasha',  'Kaluarachchi','himasha90@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Radio jockey 📻 | FM Hiru 99.1 | Morning show host', 'himasha90.jpg','2024-12-24'),
('Tharaka',  'Peiris',     'tharaka91@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Cybersecurity analyst 🛡️ | CISO at a local bank | Ethical hacker', 'tharaka91.jpg','2025-01-07'),
('Shalini',  'Pathmanathan','shalini92@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Cardiothoracic surgeon 🫀 | Teaching Hospital Kandy | Saving hearts', 'shalini92.jpg','2025-01-14'),
('Kavindu',  'Rajathilaka','kavindu93@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Gaming content creator 🎮 | 50k YouTube subs | Sri Lanka''s top gamer', 'kavindu93.jpg','2025-01-21'),
('Shehani',  'Fernando',   'shehani94@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Yoga teacher 🧘 | Morning sessions at Galle Face | Finding peace daily', 'shehani94.jpg','2025-01-28'),
('Chamath',  'Wijekoon',   'chamath95@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Eco-lodge owner 🌿 | Knuckles Range | Sustainable tourism pioneer', 'chamath95.jpg','2025-02-04'),
('Ridma',    'Withanage',  'ridma96@mail.com',  '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Singer-songwriter 🎵 | Three albums in | Sri Lankan pop scene', 'ridma96.jpg',  '2025-02-11'),
('Vidusha',  'Seneviratne','vidusha97@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Airline pilot ✈️ | SriLankan Airlines | Seeing the world from above', 'vidusha97.jpg','2025-02-18'),
('Danula',   'Hettiarachchi','danula98@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Mountaineer 🏔️ | Summited Sri Pada 47 times | High-altitude dreamer', 'danula98.jpg','2025-02-25'),
('Amaya',    'Wijesuriya',  'amaya99@mail.com', '$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Marine biologist 🐋 | Blue whale researcher | Sea of Ceylon', 'amaya99.jpg',  '2025-03-04'),
('Sachith',  'Dassanayake','sachith100@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'War historian 📚 | Documenting Sri Lanka''s 30-year conflict', 'sachith100.jpg','2025-03-11'),
('Achala',   'Marasinghe', 'achala101@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Botany professor 🌺 | Peradeniya University | Sri Lankan orchid expert', 'achala101.jpg','2025-03-18'),
('Binura',   'Rajapaksha', 'binura102@mail.com','$2b$12$8bb0iiLUp/dXJFxutstl8Otp8lK9mU.zolyK3OkxiWcSjYZ3gYsPG', 'Fast bowler 🏏 | U19 Sri Lanka Cricket | The next Lasith Malinga', 'binura102.jpg','2025-03-25');

-- ============================================================
-- POSTS
-- IDs 1-15:  Ashan's posts (varied, demo-friendly)
-- IDs 16-28: Nimasha's posts (varied)
-- IDs 29-80: Supporting cast posts
-- ============================================================
INSERT INTO posts (content, created_at, image_filename, author_id) VALUES
-- ── ASHAN (user 1) ─────────────────────────────────────────
('Just shipped a new feature at work — dark mode is FINALLY live! 🌙 Took 3 weeks but it''s worth it. If you haven''t tried it yet, go check it out and let me know what you think! #coding #SriLankanDevs', '2025-01-10 09:15:00', NULL, 1),
('Morning cricket practice at the SSC grounds in Colombo. Nothing beats the smell of freshly cut grass at 6 AM 🏏 The team is looking sharp this season — big things coming! @charith34', '2025-01-18 07:30:00', 'ashan_cricket.jpg', 1),
('Weekend trip to Sigiriya! Climbed the rock for the third time and it still takes my breath away 🦁 The view from the top after the rain is absolutely something else. Every Sri Lankan should do this at least once.', '2025-01-25 14:20:00', 'ashan_sigiriya.jpg', 1),
('Hot take: Sri Lankan street food > any restaurant in Colombo. This kottu stall near Pettah has been feeding me for 5 years and I will never stop going there 🌶️ Who else has a go-to spot they will never give up?', '2025-02-03 19:45:00', NULL, 1),
('Attended the Colombo Tech Summit today. So inspiring to see the calibre of Sri Lankan developers building world-class products 💻 Proud to be part of this ecosystem. Talk to me if you need connections — happy to help!', '2025-02-14 17:00:00', 'ashan_techsummit.jpg', 1),
('Full moon poya day 🪔 Visited Kelaniya Raja Maha Vihara with the family. There''s something so grounding about this ritual that has stayed the same for centuries. Grateful for days like today 🙏', '2025-02-22 08:00:00', 'ashan_poya.jpg', 1),
('Just started learning to play the guitar 🎸 Three chords in and I already hate myself lol. Any tips from anyone who went through this pain? Asking for a friend (the friend is me)', '2025-03-01 21:00:00', NULL, 1),
('The Colombo 7 sunset today was absolutely unreal 🌅 Caught it from my rooftop and stood there for 20 minutes just staring. Hard to believe we live in such a beautiful place. Never take it for granted 🇱🇰', '2025-03-10 18:35:00', 'ashan_sunset.jpg', 1),
('Spending the weekend deep-diving into Spring Boot microservices. Send help. Or snacks. Preferably both. ☕💻 Anyone else doing weekend study sessions? Let''s suffer together.', '2025-03-18 15:00:00', NULL, 1),
('Beach cleanup at Mount Lavinia with @ishara29 and the crew! 45 bags of trash collected in 3 hours. The state of our beaches breaks my heart but seeing so many people show up gives me hope ♻️ Next one is April 5!', '2025-03-28 10:00:00', 'ashan_cleanup.jpg', 1),
('Ranked Silver in the national chess tournament! 🏆 Not the gold I wanted but honestly proud of this. Big shoutout to everyone who cheered me on. Levelling up for next year already 🎯', '2025-04-05 20:00:00', NULL, 1),
('My grandmother''s pol sambol recipe. I asked her for it a hundred times and she finally wrote it down 🥥❤️ The secret is toasting the coconut first. I will not be sharing the exact ratios — some things stay in the family 😄', '2025-04-12 12:00:00', 'ashan_sambol.jpg', 1),
('Just got back from a 3-day road trip around the south coast: Galle → Unawatuna → Mirissa → Tangalle. The whale watching at Mirissa alone was worth the whole trip 🐬 Sri Lanka''s south is criminally underrated. Thread below 👇', '2025-04-20 19:00:00', 'ashan_roadtrip.jpg', 1),
('Honest opinion: everyone should read "Funny Boy" by Shyam Selvadurai at least once. It made me understand parts of this country''s history that I had never truly reckoned with. Powerful storytelling. 📖', '2025-04-28 22:00:00', NULL, 1),
('5 years of coding and I still Google how to center a div. That''s the journey. That''s the life. 😂 #WebDev #SriLankaDevCommunity', '2025-05-05 11:00:00', NULL, 1),
-- ── NIMASHA (user 2) ───────────────────────────────────────
('New design portfolio just dropped! 🎨 Six months of work, three rebrands, and one redesigned national NGO website. Couldn''t be prouder. Link in bio. Would love your honest feedback 💪', '2025-01-12 10:30:00', 'nimasha_portfolio.jpg', 2),
('Colombo to Kandy train ride on a rainy morning 🚂 I genuinely think this is one of the most scenic train journeys in the world. Watched the mist roll over the tea hills for 3 hours and barely touched my phone. Rare.', '2025-01-22 08:00:00', 'nimasha_train.jpg', 2),
('My flat whites need to look like art before I drink them ☕ Currently obsessed with Colombo''s independent coffee scene — Kopi Kade, The Good Market Sunday stalls, the little place in Bambalapitiya with no name. Hidden gems everywhere.', '2025-02-01 09:00:00', 'nimasha_coffee.jpg', 2),
('Vesak lantern making 🏮 Spent the whole Sunday with my cousins cutting out patterns and fighting over who got the gold paper. The house looks like a festival and I''m not sorry about it at all!', '2025-02-10 17:30:00', 'nimasha_vesak.jpg', 2),
('Did a sunrise photoshoot at Galle Fort last weekend 📸 The light at 5:45 AM through the Dutch colonial archways is something I want to bottle up forever. New blog post about the trip coming this week!', '2025-02-18 07:00:00', 'nimasha_galle.jpg', 2),
('Colour palette of the week: the inside of a king coconut 🥥 Creamy white, pale gold, tropical green. Sri Lanka gives us the best colour inspiration for free and I am obsessed.', '2025-02-27 14:00:00', NULL, 2),
('Attempted to make Watalappan for the first time using my grandmother''s recipe. It actually set perfectly 🎉 Kithul treacle + coconut milk + cardamom = paradise. If you haven''t had this dessert you are living an incomplete life.', '2025-03-08 16:00:00', 'nimasha_watalappan.jpg', 2),
('Hiking the Knuckles mountain range with @sampath22 🏔️ 18km, 1200m elevation gain, zero complaints (some complaints). The cloud forest at the top is unlike anything else in Sri Lanka. Absolutely magical.', '2025-03-17 06:30:00', 'nimasha_knuckles.jpg', 2),
('I redesigned the menu for a small restaurant in Colombo 3 as a side project. Before and after below ✨ Typography, layout, photography direction — the whole thing. This is why I love what I do 🎨', '2025-03-25 13:00:00', 'nimasha_menudesign.jpg', 2),
('Colombo Literary Festival was incredible this year 📚 Heard from 8 authors in one day, bought 6 books I cannot afford, and ran into @hashini35 which made my whole week. Already counting down to next year!', '2025-04-02 20:00:00', NULL, 2),
('Spent the morning at the Dehiwala Zoo sketching animals for a children''s book illustration project 🦁 Never knew sketching a flamingo could be so humbling. They do not stand still.', '2025-04-11 12:00:00', 'nimasha_zoo.jpg', 2),
('The sunsets from Colombo''s Galle Road between March and May are NOT talked about enough 🌅 Every evening this week has been Instagram gold without even trying. Just walk outside at 6 PM and look west.', '2025-04-19 18:30:00', 'nimasha_sunsetgalleroad.jpg', 2),
('Solo trip to Ella ✨ Two days, one beautiful wooden guesthouse, three hikes, zero Wi-Fi. Best reset I''ve had in months. Little Adam''s Peak at golden hour is something I will think about for a long time 🍃', '2025-04-27 20:00:00', 'nimasha_ella.jpg', 2),
('Working on a Sri Lankan mythology graphic novel. Think Mahabharata energy but set on this island, in these landscapes 🏰 Anyone else think our folklore deserves way more visual storytelling? Tell me what characters or myths you''d want to see!', '2025-05-04 21:30:00', NULL, 2),
-- ── SUPPORTING CAST (ids 29-80) ─────────────────────────────────────────────────────────
('Cricket season opener at the P. Sara Oval today! The energy in that stadium is electric ⚡ Proud to be Sri Lankan 🏏 #CricketSL', '2025-01-15 16:00:00', 'cricket_sara.jpg', 34),
('Best kottu in all of Galle — fight me 🌶️ The place has been here 40 years and the family still runs it. That''s a legacy right there. Sanduni would love this place!', '2025-01-17 20:00:00', NULL, 6),
('Sigiriya sunrise hike! Left at 4 AM, reached the top by 6:30 and had the whole rock to ourselves for 30 minutes 😍 The sky turned pink and gold. I cried a little bit. Don''t judge me 🌄', '2025-01-20 07:00:00', 'sigiriya_sunrise.jpg', 11),
('New cinnamon harvest is in 🌿 The smell of fresh cinnamon bark on a cool Kalutara morning is something no perfume company can ever replicate. Sixth generation in this trade and still feels like magic.', '2025-01-23 08:00:00', 'cinnamon.jpg', 68),
('Whale watching trip near Mirissa — saw a blue whale within 20 minutes of leaving the harbour! 🐋 Blue whales, people. The largest animals to ever exist on earth, right here off our coast. We are so lucky.', '2025-01-26 12:00:00', 'whale.jpg', 24),
('Beach cleanup this Saturday near Unawatuna 🌊 Bring gloves, sunscreen and good energy. Sign up in the comments! Every piece of plastic matters. Let''s keep our coastline beautiful ♻️', '2025-01-29 10:00:00', NULL, 29),
('The Nallur Kovil festival lights at night — I''ve shot this for six years and it never gets old 🙏 The devotion here is something you feel in your whole body. Jaffna gives me chills every single time.', '2025-02-01 22:00:00', 'nallur.jpg', 61),
('Corals off the Trincomalee coast are recovering 🪸 First time in 8 years we''re seeing new growth in the areas we monitor. Climate change has been brutal to these reefs. This little win means everything to me 🌊', '2025-02-04 15:00:00', 'coral.jpg', 52),
('Knuckles Range mountain biking — 40km through cloud forest 🚵 Crashed exactly twice. No regrets. Nimasha I think you''d love this trail!', '2025-02-07 18:00:00', 'knuckles_bike.jpg', 22),
('New pottery series inspired by ancient Anuradhapura vessels 🏺 Made entirely with local red clay, no imported materials. Connecting with 2,500 years of Sri Lankan craft. Every imperfection is intentional.', '2025-02-11 11:00:00', 'pottery.jpg', 83),
('Galle Fort at 5 AM before the tourists arrive 📷 The Dutch colonial architecture in that early morning fog is like stepping into another century. Three hours of shooting, zero regrets, twelve incredible shots.', '2025-02-14 06:00:00', 'gallefort_dawn.jpg', 36),
('My first marathon! 🏃 4 hours 23 minutes. Not fast, but FINISHED. Ran it for my late father who always believed I could do it. Couldn''t have done it without the Colombo Runners community ❤️', '2025-02-18 14:00:00', 'marathon.jpg', 18),
('Full moon night at Pidurangala — the view of Sigiriya rock lit up by moonlight is something I genuinely cannot describe in words. Photo doesn''t do it justice. You just have to go 🌕', '2025-02-22 21:00:00', 'pidurangala.jpg', 11),
('Fermented black tea on a Nuwara Eliya estate at 6 AM ☕ Temperature: 12°C. Mood: perfect. The tea hills look like something from a painting. I understand why this place is called "Little England."', '2025-02-25 07:30:00', 'nuwara_tea.jpg', 44),
('Sri Lankan fusion tasting menu launch 🍽️ Eight courses, local ingredients only, plating inspired by batik patterns. Booked out for the next 3 months. Thank you Colombo for the love!', '2025-03-01 20:00:00', 'chef_menu.jpg', 38),
('Coral reef survey completed at Dutch Bay, Trincomalee 🤿 Recording 47 fish species in a single dive. Our ocean is healing if we give it the chance. Please stop dropping anchor on coral 🙏', '2025-03-05 16:00:00', 'reef.jpg', 52),
('Lost in the Peradeniya Botanical Garden for 3 hours ☀️ 147 acres of pure therapy. The giant bamboo grove genuinely made me feel like I was in a different country. One of the most underrated places in Sri Lanka.', '2025-03-09 15:00:00', 'peradeniya.jpg', 101),
('Teaching my year 7 class about the water cycle using the Mahaweli River as our case study 💧 When kids start drawing connections between what they learn and the world outside their window — that''s when you know you''re doing it right 🌊', '2025-03-13 17:00:00', NULL, 23),
('Sri Lanka vs Australia T20 tonight 🏏 Who''s watching? We CAN chase 185 if everyone stays calm. Believe in the boys. Also if anyone near Bambalapitiya wants to watch together DM me!', '2025-03-17 17:00:00', NULL, 34),
('Sunday morning at the Good Market in Reid Avenue 🌿 Organic mangoes, handmade pottery, cold brew coffee, people doing yoga on the lawn. This is the Colombo I love and want to protect.', '2025-03-21 11:00:00', 'goodmarket.jpg', 42),
('My "Monsoon Letters" book launch was last night 💛 Room was PACKED. Signed 200 copies. Three people told me the story made them cry and honestly that is the highest honour I can imagine as a writer. THANK YOU.', '2025-03-25 11:00:00', 'booklunch.jpg', 85),
('Dambulla Cave Temple at dawn — no crowds, just the monks chanting and the smell of incense and jungle 🙏 If you only visit one cultural site in Sri Lanka, make it Dambulla. Nothing prepares you for the inside.', '2025-03-29 07:00:00', 'dambulla.jpg', 16),
('Handloom weaving workshop in Kandy 🧵 Learned to weave on a traditional loom for the first time. My piece looks like a child made it but the experience was priceless. This craft needs to survive.', '2025-04-02 16:00:00', 'handloom.jpg', 88),
('Scuba diving guide to the wreck of the SS Worcestershire, Trincomalee 🚢 One of the best wreck dives in the Indian Ocean, sitting at 33m. The amount of life living on that hull is absolutely extraordinary.', '2025-04-06 14:00:00', 'wreck_dive.jpg', 52),
('Early morning Galle Face walk before work ☀️ The sea breeze at 6:30 AM and the kite sellers setting up and the crows fighting over string hoppers... this is Colombo at its most honest and most beautiful.', '2025-04-10 07:00:00', 'galleface.jpg', 27),
('Finished building a solar water heater for our Jaffna home ⚡ Total cost: Rs 15,000. Monthly electricity saving: Rs 4,500. Payback period: 11 months. If you want to do the same, DM me — happy to walk you through it.', '2025-04-14 19:00:00', 'solar.jpg', 62),
('Sri Lanka vs India series — watching at a friend''s house with 15 people 🏏 The collective noise when Charith hit that six in the 19th over nearly brought the roof down 😂 Best watching experience of my life', '2025-04-18 22:00:00', NULL, 3),
('Sketching the old Dutch canal system in Colombo for a graphic piece about colonial infrastructure 🖌️ These waterways are 400 years old and most people drive past them every day without knowing their history. That needs to change.', '2025-04-22 15:00:00', 'dutch_canal.jpg', 72),
('Made my first proper cup of Ceylon OP tea in an actual teapot with a cosy 🫖 My Nuwara Eliya colleagues would be proud. Tasting notes: brisk, golden, slightly floral. No milk. Perfect.', '2025-04-26 07:00:00', NULL, 44),
('Pinnawala Elephant Orphanage at feeding time 🐘 Watched baby elephants splash in the river for an hour. Conservation is the greatest act of love for this island. Twenty years in this work and I am still moved every single day.', '2025-04-30 11:00:00', 'pinnawala.jpg', 79),
('Batting in the nets at a Colombo CC session — coach says my cover drive is "actually not terrible now" which is the highest praise I have ever received in my entire life 😂 #cricket #nevergivingup', '2025-05-04 18:00:00', NULL, 1),
('Worked the Colombo-to-Jaffna overnight express last week 🚛 1200km in 18 hours. Delivered school supplies, medicine and two plasma TVs. This road tells the whole story of the country if you know how to read it.', '2025-05-04 21:00:00', NULL, 87),
('Hiking Horton Plains is a spiritual experience 🌫️ World''s End drop-off with fog rolling in over the edge. Wild deer crossing the path without looking at you. Baker''s Falls roaring in the distance. Paradise. Plan for a 5 AM start.', '2025-05-03 10:00:00', 'hortonplains.jpg', 95),
('First pottery piece from my new Sri Lankan mythology series 🏺 This one is inspired by the Mahiyanganaya Stupa — the oldest in Sri Lanka. Red clay, natural coconut-shell ash glaze, hand-finished. Available next month.', '2025-05-02 14:00:00', 'pottery2.jpg', 83),
('"Living Lanka" podcast episode 47 is live 🎙️ This week: road-tripping the Cultural Triangle alone, with zero plan. Grab a coffee, it''s a long one. Link in bio. Thanks for 100k listens!', '2025-05-01 09:00:00', NULL, 75);

-- ============================================================
-- FRIEND REQUESTS & FRIENDSHIPS
--
-- Ashan (1) confirmed friends: 3,4,5,6,7,8,9,10,11,12,14,16,31,32,33,34,35,36,37
-- Nimasha (2) confirmed friends: 17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,35,36
-- Mutual (both are friends): 31,32,33,35,36
-- Ashan has PENDING requests INCOMING from: 38,40 (for demo: Ashan can accept/reject)
-- Ashan has PENDING request OUTGOING to: 39 (for demo: shows sent)
-- Nimasha has PENDING requests INCOMING from: 34, 37 (for demo)
-- Nimasha has PENDING outgoing to: 40
-- ============================================================
INSERT INTO friend_requests (sender_id, receiver_id, status, sent_at) VALUES
-- ASHAN accepted
(1, 3,  'ACCEPTED', '2025-01-10 10:00:00'),
(1, 4,  'ACCEPTED', '2025-01-10 10:05:00'),
(1, 5,  'ACCEPTED', '2025-01-11 09:00:00'),
(6, 1,  'ACCEPTED', '2025-01-12 08:00:00'),
(1, 7,  'ACCEPTED', '2025-01-14 11:00:00'),
(1, 8,  'ACCEPTED', '2025-01-15 12:00:00'),
(9, 1,  'ACCEPTED', '2025-01-16 13:00:00'),
(1, 10, 'ACCEPTED', '2025-01-18 14:00:00'),
(11, 1, 'ACCEPTED', '2025-01-20 15:00:00'),
(1, 12, 'ACCEPTED', '2025-01-22 09:00:00'),
(14, 1, 'ACCEPTED', '2025-01-24 10:00:00'),
(1, 16, 'ACCEPTED', '2025-01-26 11:00:00'),
-- NIMASHA accepted
(2, 17, 'ACCEPTED', '2025-01-11 10:00:00'),
(2, 18, 'ACCEPTED', '2025-01-12 11:00:00'),
(19, 2, 'ACCEPTED', '2025-01-13 12:00:00'),
(2, 20, 'ACCEPTED', '2025-01-14 13:00:00'),
(2, 21, 'ACCEPTED', '2025-01-15 14:00:00'),
(22, 2, 'ACCEPTED', '2025-01-16 15:00:00'),
(2, 23, 'ACCEPTED', '2025-01-17 16:00:00'),
(24, 2, 'ACCEPTED', '2025-01-18 17:00:00'),
(2, 25, 'ACCEPTED', '2025-01-19 18:00:00'),
(26, 2, 'ACCEPTED', '2025-01-20 19:00:00'),
(2, 27, 'ACCEPTED', '2025-01-21 20:00:00'),
(28, 2, 'ACCEPTED', '2025-01-22 21:00:00'),
(2, 29, 'ACCEPTED', '2025-01-23 22:00:00'),
(30, 2, 'ACCEPTED', '2025-01-24 07:00:00'),
-- MUTUAL (both hero users friends with these)
(1,  31, 'ACCEPTED', '2025-01-28 09:00:00'),
(2,  31, 'ACCEPTED', '2025-01-27 09:00:00'),
(32, 1,  'ACCEPTED', '2025-01-29 10:00:00'),
(32, 2,  'ACCEPTED', '2025-01-30 10:00:00'),
(1,  33, 'ACCEPTED', '2025-02-01 11:00:00'),
(2,  33, 'ACCEPTED', '2025-02-02 11:00:00'),
(35, 1,  'ACCEPTED', '2025-02-05 12:00:00'),
(35, 2,  'ACCEPTED', '2025-02-06 12:00:00'),
(36, 1,  'ACCEPTED', '2025-02-08 13:00:00'),
(36, 2,  'ACCEPTED', '2025-02-09 13:00:00'),
-- PENDING INCOMING to Ashan (demo: can accept or reject these)
(38, 1,  'PENDING',  '2025-05-01 08:00:00'),
(40, 1,  'PENDING',  '2025-05-02 09:00:00'),
-- PENDING OUTGOING from Ashan (demo: shows sent request)
(1,  39, 'PENDING',  '2025-05-03 10:00:00'),
-- PENDING INCOMING to Nimasha
(34, 2,  'PENDING',  '2025-05-01 11:00:00'),
(37, 2,  'PENDING',  '2025-05-03 12:00:00'),
-- PENDING OUTGOING from Nimasha
(2,  40, 'PENDING',  '2025-05-04 13:00:00'),
-- REJECTED (for variety)
(13, 1,  'REJECTED', '2025-02-10 09:00:00'),
(15, 2,  'REJECTED', '2025-02-11 09:00:00'),
-- Community friendships (non-hero)
(3,  31, 'ACCEPTED', '2025-02-01 08:00:00'),
(4,  32, 'ACCEPTED', '2025-02-03 08:00:00'),
(5,  33, 'ACCEPTED', '2025-02-05 08:00:00'),
(6,  36, 'ACCEPTED', '2025-02-07 08:00:00'),
(7,  35, 'ACCEPTED', '2025-02-09 08:00:00'),
(8,  34, 'ACCEPTED', '2025-02-11 08:00:00'),
(9,  38, 'ACCEPTED', '2025-02-13 08:00:00'),
(10, 39, 'ACCEPTED', '2025-02-15 08:00:00'),
(11, 40, 'ACCEPTED', '2025-02-17 08:00:00'),
(12, 37, 'ACCEPTED', '2025-02-19 08:00:00'),
(17, 31, 'ACCEPTED', '2025-02-21 08:00:00'),
(18, 32, 'ACCEPTED', '2025-02-23 08:00:00'),
(19, 33, 'ACCEPTED', '2025-02-25 08:00:00'),
(20, 36, 'ACCEPTED', '2025-02-27 08:00:00'),
(21, 35, 'ACCEPTED', '2025-03-01 08:00:00'),
(22, 34, 'ACCEPTED', '2025-03-03 08:00:00'),
(23, 38, 'ACCEPTED', '2025-03-05 08:00:00'),
(24, 39, 'ACCEPTED', '2025-03-07 08:00:00'),
(25, 40, 'ACCEPTED', '2025-03-09 08:00:00'),
(26, 37, 'ACCEPTED', '2025-03-11 08:00:00'),
(41, 42, 'ACCEPTED', '2025-03-13 08:00:00'),
(43, 44, 'ACCEPTED', '2025-03-15 08:00:00'),
(45, 46, 'ACCEPTED', '2025-03-17 08:00:00'),
(47, 48, 'ACCEPTED', '2025-03-19 08:00:00'),
(49, 50, 'ACCEPTED', '2025-03-21 08:00:00'),
(51, 52, 'ACCEPTED', '2025-03-23 08:00:00'),
(53, 54, 'ACCEPTED', '2025-03-25 08:00:00'),
(55, 56, 'ACCEPTED', '2025-03-27 08:00:00'),
(57, 58, 'ACCEPTED', '2025-03-29 08:00:00'),
(59, 60, 'ACCEPTED', '2025-03-31 08:00:00'),
(61, 62, 'ACCEPTED', '2025-04-02 08:00:00'),
(63, 64, 'ACCEPTED', '2025-04-04 08:00:00'),
(65, 66, 'ACCEPTED', '2025-04-06 08:00:00'),
(67, 68, 'ACCEPTED', '2025-04-08 08:00:00'),
(69, 70, 'ACCEPTED', '2025-04-10 08:00:00'),
(71, 72, 'ACCEPTED', '2025-04-12 08:00:00'),
(73, 74, 'ACCEPTED', '2025-04-14 08:00:00'),
(75, 76, 'ACCEPTED', '2025-04-16 08:00:00'),
(77, 78, 'ACCEPTED', '2025-04-18 08:00:00'),
(79, 80, 'ACCEPTED', '2025-04-20 08:00:00'),
(81, 82, 'ACCEPTED', '2025-04-22 08:00:00'),
(83, 84, 'ACCEPTED', '2025-04-24 08:00:00'),
(85, 86, 'ACCEPTED', '2025-04-26 08:00:00'),
(87, 88, 'ACCEPTED', '2025-04-28 08:00:00'),
(89, 90, 'ACCEPTED', '2025-04-30 08:00:00'),
(91, 92, 'ACCEPTED', '2025-05-02 08:00:00'),
(93, 94, 'ACCEPTED', '2025-05-04 08:00:00'),
(95, 96, 'ACCEPTED', '2025-05-06 08:00:00'),
(97, 98, 'ACCEPTED', '2025-05-08 08:00:00'),
(99, 100, 'ACCEPTED', '2025-05-10 08:00:00'),
(101, 102, 'ACCEPTED', '2025-05-12 08:00:00');

-- ============================================================
-- FRIENDSHIPS (mirror of every ACCEPTED request)
-- user1_id always the LOWER id
-- ============================================================
INSERT INTO friendships (user1_id, user2_id, since) VALUES
-- Ashan's friendships
(1, 3,  '2025-01-10 10:30:00'), (1, 4,  '2025-01-10 10:35:00'),
(1, 5,  '2025-01-11 09:30:00'), (1, 6,  '2025-01-12 08:30:00'),
(1, 7,  '2025-01-14 11:30:00'), (1, 8,  '2025-01-15 12:30:00'),
(1, 9,  '2025-01-16 13:30:00'), (1, 10, '2025-01-18 14:30:00'),
(1, 11, '2025-01-20 15:30:00'), (1, 12, '2025-01-22 09:30:00'),
(1, 14, '2025-01-24 10:30:00'), (1, 16, '2025-01-26 11:30:00'),
-- Nimasha's friendships
(2, 17, '2025-01-11 10:30:00'), (2, 18, '2025-01-12 11:30:00'),
(2, 19, '2025-01-13 12:30:00'), (2, 20, '2025-01-14 13:30:00'),
(2, 21, '2025-01-15 14:30:00'), (2, 22, '2025-01-16 15:30:00'),
(2, 23, '2025-01-17 16:30:00'), (2, 24, '2025-01-18 17:30:00'),
(2, 25, '2025-01-19 18:30:00'), (2, 26, '2025-01-20 19:30:00'),
(2, 27, '2025-01-21 20:30:00'), (2, 28, '2025-01-22 21:30:00'),
(2, 29, '2025-01-23 22:30:00'), (2, 30, '2025-01-24 07:30:00'),
-- Mutual friendships
(1, 31, '2025-01-28 09:30:00'), (2, 31, '2025-01-27 09:30:00'),
(1, 32, '2025-01-29 10:30:00'), (2, 32, '2025-01-30 10:30:00'),
(1, 33, '2025-02-01 11:30:00'), (2, 33, '2025-02-02 11:30:00'),
(1, 35, '2025-02-05 12:30:00'), (2, 35, '2025-02-06 12:30:00'),
(1, 36, '2025-02-08 13:30:00'), (2, 36, '2025-02-09 13:30:00'),
-- Community friendships
(3, 31,'2025-02-01 08:30:00'),(4, 32,'2025-02-03 08:30:00'),
(5, 33,'2025-02-05 08:30:00'),(6, 36,'2025-02-07 08:30:00'),
(7, 35,'2025-02-09 08:30:00'),(8, 34,'2025-02-11 08:30:00'),
(9, 38,'2025-02-13 08:30:00'),(10, 39,'2025-02-15 08:30:00'),
(11, 40,'2025-02-17 08:30:00'),(12, 37,'2025-02-19 08:30:00'),
(17, 31,'2025-02-21 08:30:00'),(18, 32,'2025-02-23 08:30:00'),
(19, 33,'2025-02-25 08:30:00'),(20, 36,'2025-02-27 08:30:00'),
(21, 35,'2025-03-01 08:30:00'),(22, 34,'2025-03-03 08:30:00'),
(23, 38,'2025-03-05 08:30:00'),(24, 39,'2025-03-07 08:30:00'),
(25, 40,'2025-03-09 08:30:00'),(26, 37,'2025-03-11 08:30:00'),
(41, 42,'2025-03-13 08:30:00'),(43, 44,'2025-03-15 08:30:00'),
(45, 46,'2025-03-17 08:30:00'),(47, 48,'2025-03-19 08:30:00'),
(49, 50,'2025-03-21 08:30:00'),(51, 52,'2025-03-23 08:30:00'),
(53, 54,'2025-03-25 08:30:00'),(55, 56,'2025-03-27 08:30:00'),
(57, 58,'2025-03-29 08:30:00'),(59, 60,'2025-03-31 08:30:00'),
(61, 62,'2025-04-02 08:30:00'),(63, 64,'2025-04-04 08:30:00'),
(65, 66,'2025-04-06 08:30:00'),(67, 68,'2025-04-08 08:30:00'),
(69, 70,'2025-04-10 08:30:00'),(71, 72,'2025-04-12 08:30:00'),
(73, 74,'2025-04-14 08:30:00'),(75, 76,'2025-04-16 08:30:00'),
(77, 78,'2025-04-18 08:30:00'),(79, 80,'2025-04-20 08:30:00'),
(81, 82,'2025-04-22 08:30:00'),(83, 84,'2025-04-24 08:30:00'),
(85, 86,'2025-04-26 08:30:00'),(87, 88,'2025-04-28 08:30:00'),
(89, 90,'2025-04-30 08:30:00'),(91, 92,'2025-05-02 08:30:00'),
(93, 94,'2025-05-04 08:30:00'),(95, 96,'2025-05-06 08:30:00'),
(97, 98,'2025-05-08 08:30:00'),(99, 100,'2025-05-10 08:30:00'),
(101, 102,'2025-05-12 08:30:00');

-- ============================================================
-- LIKES
-- Heavy likes on Ashan and Nimasha posts (post IDs 1-28)
-- Friends like each other's posts, some strangers too
-- ============================================================
INSERT INTO likes (user_id, post_id, created_at) VALUES
-- Likes on Ashan's posts (1-15)
(3, 1,'2025-01-10 11:00:00'),(4, 1,'2025-01-10 12:00:00'),(5, 1,'2025-01-10 13:00:00'),
(6, 1,'2025-01-10 14:00:00'),(7, 1,'2025-01-11 09:00:00'),(8, 1,'2025-01-11 10:00:00'),
(14,1,'2025-01-11 11:00:00'),(31,1,'2025-01-11 12:00:00'),(33,1,'2025-01-12 09:00:00'),
(2, 1,'2025-01-12 10:00:00'),(42,1,'2025-01-12 11:00:00'),(66,1,'2025-01-12 12:00:00'),

(3, 2,'2025-01-18 08:30:00'),(5, 2,'2025-01-18 09:00:00'),(10,2,'2025-01-18 10:00:00'),
(16,2,'2025-01-19 08:00:00'),(34,2,'2025-01-19 09:00:00'),(36,2,'2025-01-19 10:00:00'),
(2, 2,'2025-01-19 11:00:00'),(12,2,'2025-01-20 09:00:00'),(31,2,'2025-01-20 10:00:00'),

(4, 3,'2025-01-25 15:00:00'),(6, 3,'2025-01-25 16:00:00'),(8, 3,'2025-01-26 09:00:00'),
(11,3,'2025-01-26 10:00:00'),(16,3,'2025-01-26 11:00:00'),(32,3,'2025-01-27 09:00:00'),
(35,3,'2025-01-27 10:00:00'),(2, 3,'2025-01-27 11:00:00'),(17,3,'2025-01-28 09:00:00'),
(19,3,'2025-01-28 10:00:00'),(23,3,'2025-01-28 11:00:00'),(44,3,'2025-01-29 09:00:00'),

(5, 4,'2025-02-03 20:00:00'),(6, 4,'2025-02-03 21:00:00'),(7, 4,'2025-02-04 09:00:00'),
(9, 4,'2025-02-04 10:00:00'),(33,4,'2025-02-04 11:00:00'),(38,4,'2025-02-05 09:00:00'),
(2, 4,'2025-02-05 10:00:00'),(20,4,'2025-02-05 11:00:00'),(30,4,'2025-02-05 12:00:00'),

(3, 5,'2025-02-14 18:00:00'),(7, 5,'2025-02-14 19:00:00'),(12,5,'2025-02-14 20:00:00'),
(14,5,'2025-02-15 09:00:00'),(31,5,'2025-02-15 10:00:00'),(36,5,'2025-02-15 11:00:00'),
(2, 5,'2025-02-15 12:00:00'),(42,5,'2025-02-16 09:00:00'),(66,5,'2025-02-16 10:00:00'),
(93,5,'2025-02-16 11:00:00'),

(8, 6,'2025-02-22 09:00:00'),(9, 6,'2025-02-22 10:00:00'),(11,6,'2025-02-22 11:00:00'),
(16,6,'2025-02-22 12:00:00'),(33,6,'2025-02-23 09:00:00'),(35,6,'2025-02-23 10:00:00'),
(2, 6,'2025-02-23 11:00:00'),(45,6,'2025-02-23 12:00:00'),

(4, 7,'2025-03-01 22:00:00'),(6, 7,'2025-03-01 23:00:00'),(10,7,'2025-03-02 09:00:00'),
(2, 7,'2025-03-02 10:00:00'),(30,7,'2025-03-02 11:00:00'),(48,7,'2025-03-03 09:00:00'),

(3, 8,'2025-03-10 19:00:00'),(5, 8,'2025-03-10 20:00:00'),(7, 8,'2025-03-10 21:00:00'),
(9, 8,'2025-03-11 09:00:00'),(12,8,'2025-03-11 10:00:00'),(16,8,'2025-03-11 11:00:00'),
(31,8,'2025-03-11 12:00:00'),(36,8,'2025-03-12 09:00:00'),(2, 8,'2025-03-12 10:00:00'),
(17,8,'2025-03-12 11:00:00'),(21,8,'2025-03-12 12:00:00'),

(11,9,'2025-03-18 16:00:00'),(14,9,'2025-03-18 17:00:00'),(2, 9,'2025-03-18 18:00:00'),
(32,9,'2025-03-19 09:00:00'),(91,9,'2025-03-19 10:00:00'),

(4, 10,'2025-03-28 11:00:00'),(8, 10,'2025-03-28 12:00:00'),(10,10,'2025-03-28 13:00:00'),
(29,10,'2025-03-28 14:00:00'),(35,10,'2025-03-29 09:00:00'),(2, 10,'2025-03-29 10:00:00'),
(52,10,'2025-03-29 11:00:00'),(84,10,'2025-03-29 12:00:00'),

(3, 11,'2025-04-05 21:00:00'),(5, 11,'2025-04-05 22:00:00'),(7, 11,'2025-04-06 09:00:00'),
(9, 11,'2025-04-06 10:00:00'),(14,11,'2025-04-06 11:00:00'),(2, 11,'2025-04-06 12:00:00'),
(33,11,'2025-04-07 09:00:00'),(42,11,'2025-04-07 10:00:00'),

(6, 12,'2025-04-12 13:00:00'),(8, 12,'2025-04-12 14:00:00'),(11,12,'2025-04-12 15:00:00'),
(16,12,'2025-04-13 09:00:00'),(2, 12,'2025-04-13 10:00:00'),(27,12,'2025-04-13 11:00:00'),
(45,12,'2025-04-13 12:00:00'),(83,12,'2025-04-14 09:00:00'),

(3, 13,'2025-04-20 20:00:00'),(4, 13,'2025-04-20 21:00:00'),(5, 13,'2025-04-20 22:00:00'),
(7, 13,'2025-04-21 09:00:00'),(10,13,'2025-04-21 10:00:00'),(12,13,'2025-04-21 11:00:00'),
(14,13,'2025-04-21 12:00:00'),(16,13,'2025-04-22 09:00:00'),(31,13,'2025-04-22 10:00:00'),
(32,13,'2025-04-22 11:00:00'),(2, 13,'2025-04-22 12:00:00'),(24,13,'2025-04-23 09:00:00'),
(64,13,'2025-04-23 10:00:00'),

(6, 14,'2025-04-28 23:00:00'),(9, 14,'2025-04-29 09:00:00'),(11,14,'2025-04-29 10:00:00'),
(2, 14,'2025-04-29 11:00:00'),(36,14,'2025-04-29 12:00:00'),(67,14,'2025-04-30 09:00:00'),

(4, 15,'2025-05-05 12:00:00'),(7, 15,'2025-05-05 13:00:00'),(14,15,'2025-05-05 14:00:00'),
(2, 15,'2025-05-05 15:00:00'),(31,15,'2025-05-06 09:00:00'),(93,15,'2025-05-06 10:00:00'),

-- Likes on Nimasha's posts (16-29)
(1, 16,'2025-01-12 11:00:00'),(3, 16,'2025-01-12 12:00:00'),(17,16,'2025-01-12 13:00:00'),
(20,16,'2025-01-12 14:00:00'),(25,16,'2025-01-13 09:00:00'),(31,16,'2025-01-13 10:00:00'),
(36,16,'2025-01-13 11:00:00'),(42,16,'2025-01-13 12:00:00'),(63,16,'2025-01-14 09:00:00'),

(1, 17,'2025-01-22 09:00:00'),(18,17,'2025-01-22 10:00:00'),(22,17,'2025-01-22 11:00:00'),
(27,17,'2025-01-23 09:00:00'),(35,17,'2025-01-23 10:00:00'),(44,17,'2025-01-23 11:00:00'),
(72,17,'2025-01-23 12:00:00'),

(1, 18,'2025-02-01 10:00:00'),(17,18,'2025-02-01 11:00:00'),(19,18,'2025-02-01 12:00:00'),
(21,18,'2025-02-02 09:00:00'),(29,18,'2025-02-02 10:00:00'),(33,18,'2025-02-02 11:00:00'),
(69,18,'2025-02-02 12:00:00'),

(1, 19,'2025-02-10 18:30:00'),(17,19,'2025-02-10 19:00:00'),(20,19,'2025-02-10 20:00:00'),
(23,19,'2025-02-11 09:00:00'),(26,19,'2025-02-11 10:00:00'),(30,19,'2025-02-11 11:00:00'),
(36,19,'2025-02-11 12:00:00'),(60,19,'2025-02-12 09:00:00'),

(1, 20,'2025-02-18 08:00:00'),(18,20,'2025-02-18 09:00:00'),(22,20,'2025-02-18 10:00:00'),
(24,20,'2025-02-19 09:00:00'),(27,20,'2025-02-19 10:00:00'),(31,20,'2025-02-19 11:00:00'),
(35,20,'2025-02-20 09:00:00'),(63,20,'2025-02-20 10:00:00'),(75,20,'2025-02-20 11:00:00'),

(1, 21,'2025-02-27 15:00:00'),(20,21,'2025-02-27 16:00:00'),(21,21,'2025-02-27 17:00:00'),
(28,21,'2025-02-28 09:00:00'),(36,21,'2025-02-28 10:00:00'),

(1, 22,'2025-03-08 17:00:00'),(17,22,'2025-03-08 18:00:00'),(19,22,'2025-03-08 19:00:00'),
(21,22,'2025-03-09 09:00:00'),(25,22,'2025-03-09 10:00:00'),(30,22,'2025-03-09 11:00:00'),
(38,22,'2025-03-09 12:00:00'),(45,22,'2025-03-10 09:00:00'),

(1, 23,'2025-03-17 07:30:00'),(18,23,'2025-03-17 08:00:00'),(22,23,'2025-03-17 09:00:00'),
(26,23,'2025-03-18 09:00:00'),(29,23,'2025-03-18 10:00:00'),(33,23,'2025-03-18 11:00:00'),
(95,23,'2025-03-18 12:00:00'),

(1, 24,'2025-03-25 14:00:00'),(17,24,'2025-03-25 15:00:00'),(20,24,'2025-03-25 16:00:00'),
(23,24,'2025-03-26 09:00:00'),(27,24,'2025-03-26 10:00:00'),(31,24,'2025-03-26 11:00:00'),
(36,24,'2025-03-26 12:00:00'),(42,24,'2025-03-27 09:00:00'),

(1, 25,'2025-04-02 21:00:00'),(18,25,'2025-04-02 22:00:00'),(21,25,'2025-04-03 09:00:00'),
(24,25,'2025-04-03 10:00:00'),(33,25,'2025-04-03 11:00:00'),(35,25,'2025-04-04 09:00:00'),
(85,25,'2025-04-04 10:00:00'),

(1, 26,'2025-04-11 13:00:00'),(19,26,'2025-04-11 14:00:00'),(22,26,'2025-04-11 15:00:00'),
(29,26,'2025-04-12 09:00:00'),(32,26,'2025-04-12 10:00:00'),(79,26,'2025-04-12 11:00:00'),

(1, 27,'2025-04-19 19:30:00'),(17,27,'2025-04-19 20:00:00'),(20,27,'2025-04-19 21:00:00'),
(23,27,'2025-04-20 09:00:00'),(25,27,'2025-04-20 10:00:00'),(28,27,'2025-04-20 11:00:00'),
(30,27,'2025-04-21 09:00:00'),(36,27,'2025-04-21 10:00:00'),(3, 27,'2025-04-21 11:00:00'),

(1, 28,'2025-04-27 21:00:00'),(18,28,'2025-04-27 22:00:00'),(22,28,'2025-04-28 09:00:00'),
(24,28,'2025-04-28 10:00:00'),(26,28,'2025-04-28 11:00:00'),(31,28,'2025-04-29 09:00:00'),
(35,28,'2025-04-29 10:00:00'),(95,28,'2025-04-29 11:00:00'),

(1, 29,'2025-05-04 22:30:00'),(18,29,'2025-05-05 09:00:00'),(20,29,'2025-05-05 10:00:00'),
(27,29,'2025-05-05 11:00:00'),(29,29,'2025-05-06 09:00:00'),(32,29,'2025-05-06 10:00:00'),
(72,29,'2025-05-06 11:00:00'),

-- Likes on community posts (30-80)
(1, 30,'2025-01-15 17:00:00'),(2, 30,'2025-01-15 17:30:00'),(3, 30,'2025-01-16 09:00:00'),
(2, 31,'2025-01-17 21:00:00'),(1, 31,'2025-01-18 09:00:00'),(7, 31,'2025-01-18 10:00:00'),
(2, 32,'2025-01-20 09:00:00'),(1, 32,'2025-01-20 10:00:00'),(5, 32,'2025-01-21 09:00:00'),
(1, 33,'2025-01-23 09:00:00'),(2, 33,'2025-01-23 10:00:00'),(6, 33,'2025-01-24 09:00:00'),
(1, 34,'2025-01-26 13:00:00'),(3, 34,'2025-01-26 14:00:00'),(10,34,'2025-01-27 09:00:00'),
(2, 35,'2025-01-29 11:00:00'),(17,35,'2025-01-29 12:00:00'),(25,35,'2025-01-30 09:00:00'),
(1, 36,'2025-02-01 16:00:00'),(9, 36,'2025-02-01 17:00:00'),(29,36,'2025-02-01 18:00:00'),
(2, 37,'2025-02-04 23:00:00'),(19,37,'2025-02-05 09:00:00'),(30,37,'2025-02-05 10:00:00'),
(1, 38,'2025-02-07 19:00:00'),(15,38,'2025-02-07 20:00:00'),(20,38,'2025-02-08 09:00:00'),
(2, 39,'2025-02-11 11:00:00'),(24,39,'2025-02-11 12:00:00'),
(1, 40,'2025-02-14 22:00:00'),(2, 40,'2025-02-15 09:00:00'),
(1, 41,'2025-02-18 15:00:00'),(2, 41,'2025-02-18 16:00:00'),(21,41,'2025-02-19 09:00:00'),
(2, 42,'2025-02-22 12:00:00'),(17,42,'2025-02-22 13:00:00'),(27,42,'2025-02-23 09:00:00'),
(1, 43,'2025-02-25 09:00:00'),(3, 43,'2025-02-25 10:00:00'),
(2, 44,'2025-02-27 17:00:00'),(26,44,'2025-02-28 09:00:00'),
(1, 45,'2025-03-01 21:00:00'),(2, 45,'2025-03-01 22:00:00'),(30,45,'2025-03-02 09:00:00'),
(2, 46,'2025-03-05 17:00:00'),(7, 46,'2025-03-05 18:00:00'),
(1, 47,'2025-03-09 16:00:00'),(23,47,'2025-03-09 17:00:00'),
(2, 48,'2025-03-13 21:00:00'),(18,48,'2025-03-14 09:00:00'),
(1, 49,'2025-03-17 19:00:00'),(34,49,'2025-03-17 20:00:00'),
(2, 50,'2025-03-21 12:00:00'),(1, 50,'2025-03-21 13:00:00'),(42,50,'2025-03-21 14:00:00'),
(1, 51,'2025-03-25 12:00:00'),(85,51,'2025-03-25 13:00:00'),
(2, 52,'2025-03-29 08:00:00'),(16,52,'2025-03-29 09:00:00'),
(2, 53,'2025-04-02 12:00:00'),(1, 53,'2025-04-02 13:00:00'),(44,53,'2025-04-02 14:00:00'),
(1, 54,'2025-04-06 15:00:00'),(29,54,'2025-04-06 16:00:00'),
(2, 55,'2025-04-10 08:00:00'),(27,55,'2025-04-10 09:00:00'),
(1, 56,'2025-04-14 20:00:00'),(2, 56,'2025-04-14 21:00:00'),
(2, 57,'2025-04-18 23:00:00'),(3, 57,'2025-04-19 09:00:00'),
(1, 58,'2025-04-22 16:00:00'),(83,58,'2025-04-22 17:00:00'),
(1, 59,'2025-04-26 08:00:00'),(2, 59,'2025-04-26 09:00:00'),(44,59,'2025-04-26 10:00:00'),
(2, 60,'2025-04-30 12:00:00'),(79,60,'2025-04-30 13:00:00'),
(1, 61,'2025-05-01 10:00:00'),(87,61,'2025-05-01 11:00:00'),
(2, 62,'2025-05-02 15:00:00'),(72,62,'2025-05-02 16:00:00'),
(1, 63,'2025-05-03 11:00:00'),(2, 63,'2025-05-03 12:00:00'),
(1, 64,'2025-05-03 19:00:00'),(96,64,'2025-05-03 20:00:00'),
(2, 64,'2025-05-04 22:00:00'),(75, 64,'2025-05-04 23:00:00');

-- ============================================================
-- COMMENTS
-- Dense threads on hero posts. Realistic conversation flow.
-- ============================================================
INSERT INTO comments (content, created_at, author_id, post_id) VALUES
-- Comments on Ashan post 1 (dark mode)
('Bro dark mode was NEEDED 🙌 Finally! Eyes are saved.', '2025-01-10 12:00:00', 14, 1),
('Just switched it on, looks so clean! Great work Ashan 💻', '2025-01-10 13:00:00', 3,  1),
('Three weeks well spent! Love it 🌙', '2025-01-10 14:00:00', 31, 1),
('The toggle animation is so smooth too 😍 Nice detail!', '2025-01-11 09:00:00', 2,  1),
('We need a light mode option with warmer tones next please 🙏', '2025-01-11 10:00:00', 33, 1),

-- Comments on Ashan post 2 (cricket)
('YES! The team is so good this year. Let''s go! 🏏', '2025-01-18 08:00:00', 34, 2),
('Tagging @charith is giving me confidence for the season haha', '2025-01-18 09:00:00', 5,  2),
('6 AM practice hits different 💪 That focus is unmatched', '2025-01-18 10:00:00', 16, 2),
('Wish I was there bro! Next session?', '2025-01-18 11:00:00', 9,  2),
('The SSC grounds are legendary 🏟️ Nothing like it in Colombo', '2025-01-19 09:00:00', 2,  2),

-- Comments on Ashan post 3 (Sigiriya)
('Never gets old! I climbed it in 2019 and still dream about that view 😍', '2025-01-25 15:00:00', 11, 3),
('Every Sri Lankan should do this at least once — agree 100%', '2025-01-25 16:00:00', 2,  3),
('The rain always makes the view so dramatic! Great photo Ashan ❤️', '2025-01-26 09:00:00', 19, 3),
('Third time for you! I haven''t done it yet 😅 You''re making me feel guilty', '2025-01-26 10:00:00', 4,  3),
('This is one of the best shots of Sigiriya I''ve seen. Framing is perfect 📸', '2025-01-27 09:00:00', 36, 3),
('I cried at the top my first time 🥹 It''s that kind of place', '2025-01-27 10:00:00', 17, 3),

-- Comments on Ashan post 4 (kottu hot take)
('Pettah kottu AT NIGHT is a completely different experience 🌶️🌙', '2025-02-03 20:30:00', 6,  4),
('Drop the name of this stall PLEASE 😭', '2025-02-03 21:00:00', 33, 4),
('Hot take accepted. Restaurants cannot compete with 40 years of street corner mastery', '2025-02-04 09:00:00', 2,  4),
('Is this the place near the bus stand? I think I know it!', '2025-02-04 10:00:00', 7,  4),
('My go-to is a small place in Wellawatte. Family recipe. Zero ambiance. Perfect food. 🍽️', '2025-02-04 11:00:00', 20, 4),

-- Comments on Ashan post 5 (tech summit)
('Was there too! The fintech panel was incredible 💡', '2025-02-14 18:00:00', 42, 5),
('Sri Lankan devs are building amazing things. So proud 💚', '2025-02-14 19:00:00', 31, 5),
('Would love an intro to the AI startup that presented! DM?', '2025-02-14 20:00:00', 2,  5),
('The energy in that room was incredible. This ecosystem is growing so fast 🚀', '2025-02-15 09:00:00', 66, 5),

-- Comments on Ashan post 6 (poya day)
('Kelaniya on poya is so beautiful 🪔 The lamps at sunset are something else', '2025-02-22 09:00:00', 9,  6),
('This is the most Sri Lankan post I have ever seen and I mean that as the highest compliment', '2025-02-22 10:00:00', 2,  6),
('The peace of poya morning is irreplaceable. Glad you have this ritual 🙏', '2025-02-22 11:00:00', 35, 6),

-- Comments on Ashan post 7 (guitar)
('F chord will break you before anything else. Good luck 😂', '2025-03-01 22:00:00', 3,  7),
('Three months in, you''ll be playing something recognisable! I promise 🎸', '2025-03-01 23:00:00', 2,  7),
('Tip: learn fingerpicking patterns early. Changes everything. 🤌', '2025-03-02 09:00:00', 30, 7),
('Haha the "friend is me" got me 😂😂 Good luck Ashan!', '2025-03-02 10:00:00', 14, 7),

-- Comments on Ashan post 8 (sunset)
('Colombo 7 sunsets are ELITE. That orange through the rain clouds last Tuesday?? 🌅', '2025-03-10 19:00:00', 2,  8),
('I stood on my balcony for 25 minutes yesterday doing the same thing. Never take it for granted 🇱🇰', '2025-03-10 20:00:00', 12, 8),
('Perfect picture. No filter can replicate what God does with clouds 📸', '2025-03-11 09:00:00', 36, 8),
('The humidity makes these colours so vivid! I love tropical sunsets 😍', '2025-03-11 10:00:00', 5,  8),

-- Comments on Ashan post 10 (beach cleanup)
('Was there with you! So proud of everyone who came ♻️ 45 bags is massive!', '2025-03-28 11:00:00', 29, 10),
('Booking April 5 in my calendar right now. See you there! 🌊', '2025-03-28 12:00:00', 4,  10),
('Our beaches deserve better. Thank you for organising this 💚', '2025-03-28 13:00:00', 2,  10),
('Ishara is one of the most dedicated people I know. Ashan you picked a great beach buddy 🙏', '2025-03-29 09:00:00', 35, 10),

-- Comments on Ashan post 12 (pol sambol)
('Family recipes are the most sacred things in existence 🥥❤️', '2025-04-12 13:00:00', 2,  12),
('Toasting the coconut first — GAME CHANGER. My mum does the same!', '2025-04-12 14:00:00', 6,  12),
('Not sharing the ratios 😂 Classic. Every family does this.', '2025-04-12 15:00:00', 16, 12),
('I will find out the ratios one day. I will not stop 😅', '2025-04-13 09:00:00', 27, 12),

-- Comments on Ashan post 13 (road trip)
('Mirissa whale watching is life-changing 🐬 100% worth the whole trip', '2025-04-20 20:00:00', 24, 13),
('The south coast in April!! Perfect timing. Glad you went 🌊', '2025-04-20 21:00:00', 2,  13),
('Tangalle is so underrated. Did you go to the bay beach?', '2025-04-21 09:00:00', 13, 13),
('Thread!! Give us the thread Ashan 😂 We need details!', '2025-04-21 10:00:00', 5,  13),
('Galle Fort at golden hour is something else. Did you walk the walls?', '2025-04-21 11:00:00', 31, 13),
('Sri Lankan south criminally underrated — FACTS. More people need to know!', '2025-04-22 09:00:00', 36, 13),

-- Comments on Ashan post 14 (Funny Boy)
('"Funny Boy" absolutely broke me. One of the most important books about Sri Lanka 📖', '2025-04-28 23:00:00', 2,  14),
('I used it in my A/Level literature class. The students were speechless.', '2025-04-29 09:00:00', 23, 14),
('Just ordered it. Thanks for the recommendation Ashan!', '2025-04-29 10:00:00', 14, 14),

-- Comments on Ashan post 15 (centering div)
('Five years and I still have that tab open 😂', '2025-05-05 12:00:00', 31, 15),
('The moment you write flexbox from memory is the moment you have truly arrived 💻', '2025-05-05 13:00:00', 2,  15),
('Same experience after 8 years. Never stops. Never will. 😂', '2025-05-05 14:00:00', 20, 15),

-- Comments on Nimasha post 16 (portfolio)
('This is INCREDIBLE Nimasha! The NGO rebrand especially 🎨💪', '2025-01-12 12:00:00', 1,  16),
('The typography choices in your new portfolio are so clean! Inspired 👏', '2025-01-12 13:00:00', 21, 16),
('Six months of work shows. Every page has intention 🙌', '2025-01-12 14:00:00', 20, 16),
('Shared this with my design team. They''re studying it as a reference 😍', '2025-01-13 09:00:00', 25, 16),

-- Comments on Nimasha post 17 (train)
('Kandy line in the rain 😭 You''ve made me want to do this right now', '2025-01-22 09:00:00', 1,  17),
('The most scenic 3 hours you can spend in Sri Lanka. No debate 🌿', '2025-01-22 10:00:00', 22, 17),
('The fog over the Kadugannawa pass at 7 AM. Nothing compares.', '2025-01-22 11:00:00', 44, 17),

-- Comments on Nimasha post 19 (Vesak lanterns)
('Fighting over the gold paper 😂😂 This is so real! Every year!', '2025-02-10 18:30:00', 1,  19),
('I can smell the paper lanterns through the screen 🏮 This is peak Sri Lanka', '2025-02-10 19:00:00', 17, 19),
('Your house sounds magical ✨ Vesak is the best time of year', '2025-02-10 20:00:00', 30, 19),

-- Comments on Nimasha post 20 (Galle Fort sunrise)
('5:45 AM! The dedication 😍 Those colonial archways in early light are magic', '2025-02-18 08:00:00', 1,  20),
('I''ve been to Galle 20 times and never done sunrise 😭 Adding it to the list', '2025-02-18 09:00:00', 27, 20),
('Can''t wait for the blog post! Your writing about places is always so vivid 🌅', '2025-02-18 10:00:00', 29, 20),
('The Dutch colonials built some beautiful things even while doing terrible things. Complicated history, stunning architecture.', '2025-02-19 09:00:00', 26, 20),

-- Comments on Nimasha post 22 (Watalappan)
('Kithul treacle is the soul of Sri Lankan desserts 😭❤️', '2025-03-08 17:30:00', 1,  22),
('Setting Watalappan on your first try is a FLEX. Mine was soup the first three times 😅', '2025-03-08 18:00:00', 17, 22),
('I need this recipe RIGHT NOW 🙏', '2025-03-08 19:00:00', 24, 22),
('Incomplete life — SO TRUE 😂 More people need to try this dessert!', '2025-03-09 09:00:00', 38, 22),

-- Comments on Nimasha post 23 (Knuckles hike)
('"zero complaints (some complaints)" 😂😂 Best hiking description ever!', '2025-03-17 07:00:00', 1,  23),
('The cloud forest at the top changed my life. I''m not exaggerating 🌫️', '2025-03-17 08:00:00', 22, 23),
('Sampath you lead the best hikes! What''s next?', '2025-03-17 09:00:00', 2,  23),
('18km!! My legs hurt just reading this 😅 Respect!', '2025-03-18 09:00:00', 19, 23),

-- Comments on Nimasha post 27 (Colombo sunset)
('GALLE ROAD MARCH SUNSETS 😭 You''ve said it perfectly!', '2025-04-19 19:30:00', 1,  27),
('I literally stopped my tuk-tuk last Tuesday to watch. Driver wasn''t happy 😂', '2025-04-19 20:00:00', 17, 27),
('Someone finally said it! Been trying to explain this to my foreign colleagues for years', '2025-04-19 21:00:00', 20, 27),
('March-May is truly Colombo''s secret golden season 🌅', '2025-04-20 09:00:00', 3,  27),

-- Comments on Nimasha post 28 (Ella trip)
('ELLA! The wooden guesthouses there are the best sleep I''ve had in years ✨', '2025-04-27 21:00:00', 1,  28),
('Zero Wi-Fi was the best decision. Ella demands your full presence 🍃', '2025-04-27 22:00:00', 18, 28),
('Little Adam''s Peak at golden hour will haunt you forever in the best way 😍', '2025-04-28 09:00:00', 22, 28),
('Solo trips are so healing. You come back a different person 💚', '2025-04-28 10:00:00', 25, 28),

-- Comments on Nimasha post 29 (graphic novel)
('Sri Lankan mythology graphic novel?! TAKE MY MONEY 🏰', '2025-05-04 22:30:00', 1,  29),
('Mahasona and Kurumbara are BEGGING to be illustrated 😱', '2025-05-05 09:00:00', 17, 29),
('Please include the story of Vijaya and Kuveni 🙏 It''s such a powerful founding myth', '2025-05-05 10:00:00', 26, 29),
('The landscapes of this island deserve to anchor an epic 🌴 You are the right person for this!', '2025-05-05 11:00:00', 2,  29),

-- Comments on community posts
('Sri Lanka CAN chase 185! Have you seen our batting lineup?? 🏏', '2025-03-17 18:00:00', 1, 49),
('Those coral recovery numbers made me tear up 🪸 Thank you for this work', '2025-02-04 16:00:00', 2, 37),
('Joining the beach cleanup April 5! Count me in ♻️', '2025-01-29 11:00:00', 1, 35),
('Congratulations!! 200 signed copies is incredible 🎉', '2025-03-25 12:00:00', 2, 51),
('Can''t wait for the full thread on the south coast road trip! 🌊', '2025-04-20 23:00:00', 31, 13),
('The Nallur photos give me chills every year 🙏 Thank you for sharing these', '2025-02-01 23:00:00', 2, 40),
('Watalappan recipe share when?? 😭', '2025-03-08 20:00:00', 1, 22);

-- ============================================================
-- NOTIFICATIONS
-- Simulates what Ashan and Nimasha would see in their bell
-- ============================================================
INSERT INTO notifications (recipient_id, actor_id, type, post_id, comment_id, friend_request_id, is_read, created_at) VALUES
-- Ashan's unread notifications (is_read = false)
(1, 2,  'LIKE',           1,  NULL, NULL, false, '2025-01-12 10:00:00'),
(1, 33, 'COMMENT',        1,  5,    NULL, false, '2025-01-11 10:00:00'),
(1, 2,  'COMMENT',        2,  10,   NULL, false, '2025-01-19 11:00:00'),
(1, 36, 'COMMENT',        3,  15,   NULL, false, '2025-01-27 09:00:00'),
(1, 2,  'LIKE',           3,  NULL, NULL, false, '2025-01-27 11:00:00'),
(1, 38, 'FRIEND_REQUEST', NULL, NULL, (SELECT id FROM friend_requests WHERE sender_id=38 AND receiver_id=1), false, '2025-05-01 08:00:00'),
(1, 40, 'FRIEND_REQUEST', NULL, NULL, (SELECT id FROM friend_requests WHERE sender_id=40 AND receiver_id=1), false, '2025-05-02 09:00:00'),
(1, 35, 'LIKE',           10, NULL, NULL, false, '2025-03-29 09:00:00'),
(1, 2,  'COMMENT',        8,  NULL, NULL, false, '2025-03-10 19:00:00'),
(1, 24, 'COMMENT',        13, NULL, NULL, false, '2025-04-20 20:00:00'),
-- Ashan's read notifications
(1, 3,  'LIKE',           1,  NULL, NULL, true, '2025-01-10 11:00:00'),
(1, 4,  'LIKE',           1,  NULL, NULL, true, '2025-01-10 12:00:00'),
(1, 31, 'LIKE',           1,  NULL, NULL, true, '2025-01-11 12:00:00'),
(1, 3,  'COMMENT',        1,  2,    NULL, true, '2025-01-10 13:00:00'),
(1, 14, 'COMMENT',        1,  1,    NULL, true, '2025-01-10 12:00:00'),
(1, 6,  'FRIEND_ACCEPTED',NULL, NULL, (SELECT id FROM friend_requests WHERE sender_id=6 AND receiver_id=1), true, '2025-01-12 08:30:00'),
(1, 9,  'FRIEND_ACCEPTED',NULL, NULL, (SELECT id FROM friend_requests WHERE sender_id=9 AND receiver_id=1), true, '2025-01-16 13:30:00'),
-- Nimasha's unread notifications
(2, 1,  'COMMENT',        16, NULL, NULL, false, '2025-01-12 12:00:00'),
(2, 1,  'LIKE',           16, NULL, NULL, false, '2025-01-12 11:00:00'),
(2, 1,  'COMMENT',        17, NULL, NULL, false, '2025-01-22 09:00:00'),
(2, 34, 'FRIEND_REQUEST', NULL, NULL, (SELECT id FROM friend_requests WHERE sender_id=34 AND receiver_id=2), false, '2025-05-01 11:00:00'),
(2, 37, 'FRIEND_REQUEST', NULL, NULL, (SELECT id FROM friend_requests WHERE sender_id=37 AND receiver_id=2), false, '2025-05-03 12:00:00'),
(2, 1,  'COMMENT',        19, NULL, NULL, false, '2025-02-10 18:30:00'),
(2, 27, 'COMMENT',        20, NULL, NULL, false, '2025-02-18 10:00:00'),
(2, 1,  'LIKE',           22, NULL, NULL, false, '2025-03-08 17:00:00'),
(2, 1,  'COMMENT',        23, NULL, NULL, false, '2025-03-17 07:00:00'),
(2, 1,  'COMMENT',        28, NULL, NULL, false, '2025-04-27 21:00:00'),
(2, 1,  'COMMENT',        29, NULL, NULL, false, '2025-05-04 22:30:00'),
-- Nimasha's read notifications
(2, 17, 'FRIEND_ACCEPTED',NULL, NULL, (SELECT id FROM friend_requests WHERE sender_id=2 AND receiver_id=17), true, '2025-01-11 10:30:00'),
(2, 36, 'LIKE',           20, NULL, NULL, true, '2025-02-19 11:00:00'),
(2, 22, 'FRIEND_ACCEPTED',NULL, NULL, (SELECT id FROM friend_requests WHERE sender_id=22 AND receiver_id=2), true, '2025-01-16 15:30:00'),
(2, 3,  'LIKE',           27, NULL, NULL, true, '2025-04-21 11:00:00');
