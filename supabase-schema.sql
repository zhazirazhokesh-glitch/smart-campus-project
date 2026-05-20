-- ============================================
-- SMART CAMPUS - Supabase Database Schema
-- Supabase SQL Editor-ге осыны жүктеңіз
-- ============================================

-- 1. Profiles table (пайдаланушы профилі)
CREATE TABLE IF NOT EXISTS profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  full_name TEXT,
  specialty TEXT,
  group_name TEXT,
  bio TEXT,
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Tasks table (тапсырмалар)
CREATE TABLE IF NOT EXISTS tasks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  priority TEXT DEFAULT 'medium' CHECK (priority IN ('high', 'medium', 'low')),
  category TEXT DEFAULT 'study',
  completed BOOLEAN DEFAULT FALSE,
  due_date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Events table (іс-шаралар)
CREATE TABLE IF NOT EXISTS events (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  creator_id UUID REFERENCES auth.users(id),
  title TEXT NOT NULL,
  description TEXT,
  event_date DATE,
  location TEXT,
  category TEXT DEFAULT 'other',
  capacity INTEGER,
  registered INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Event registrations (іс-шараға тіркелу)
CREATE TABLE IF NOT EXISTS event_registrations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  event_id UUID REFERENCES events(id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(event_id, user_id)
);

-- 5. Messages table (хабарламалар)
CREATE TABLE IF NOT EXISTS messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  sender_id UUID REFERENCES auth.users(id),
  receiver_id UUID REFERENCES auth.users(id),
  content TEXT NOT NULL,
  read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- ROW LEVEL SECURITY (RLS) - Қауіпсіздік
-- ============================================

-- Profiles RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view all profiles" ON profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON profiles FOR INSERT WITH CHECK (auth.uid() = id);

-- Tasks RLS
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can CRUD own tasks" ON tasks USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own tasks" ON tasks FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Events RLS (барлығы оқи алады, тіркелген жасай алады)
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can view events" ON events FOR SELECT USING (true);
CREATE POLICY "Auth users can create events" ON events FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);
CREATE POLICY "Creators can update events" ON events FOR UPDATE USING (auth.uid() = creator_id);
CREATE POLICY "Creators can delete events" ON events FOR DELETE USING (auth.uid() = creator_id);

-- Event registrations RLS
ALTER TABLE event_registrations ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can register" ON event_registrations FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can view registrations" ON event_registrations FOR SELECT USING (true);

-- Messages RLS
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own messages" ON messages FOR SELECT USING (auth.uid() = sender_id OR auth.uid() = receiver_id);
CREATE POLICY "Users can send messages" ON messages FOR INSERT WITH CHECK (auth.uid() = sender_id);
CREATE POLICY "Users can delete own messages" ON messages FOR DELETE USING (auth.uid() = sender_id);

-- ============================================
-- SAMPLE DATA (мысал деректер)
-- ============================================
INSERT INTO events (title, description, event_date, location, category, capacity, registered) VALUES
  ('IT-Фестиваль 2025', 'Жыл сайынғы технологиялар фестивалі. Хакатон, конкурстар, сыйлықтар!', '2025-01-22', 'Басты зал', 'festival', 200, 87),
  ('Ғылым олимпиадасы', 'Математика, физика, информатика пәндерінен олимпиада.', '2025-01-25', '3-кабинет', 'olympiad', 50, 32),
  ('Кариера күні', 'Жетекші IT компаниялармен кездесу.', '2025-02-01', 'Конференц-зал', 'career', 150, 120),
  ('React Workshop', 'Бастауыштарға арналған React.js воркшоп.', '2025-02-05', 'Компьютер класы', 'workshop', 30, 28);
