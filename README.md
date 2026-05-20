# 🎓 Smart Campus

Студенттерге арналған ақылды кампус жүйесі — толыққанды full-stack веб-қосымша.

![Smart Campus](https://img.shields.io/badge/React-18-61DAFB?logo=react)
![Supabase](https://img.shields.io/badge/Supabase-Backend-3ECF8E?logo=supabase)
![Vite](https://img.shields.io/badge/Vite-Build-646CFF?logo=vite)

---

## ✨ Мүмкіндіктер

| Функционал | Сипаттама |
|---|---|
| 🔐 Аутентификация | Тіркелу, кіру, пароль өзгерту |
| 👤 Профиль | Аты-жөні, мамандық, топ, bio |
| ✅ Тапсырмалар | CRUD, приоритет, категория, іздеу, сорт |
| 📅 Іс-шаралар | CRUD, тіркелу, толтырылу прогрессі |
| 💬 Хабарламалар | Чат интерфейсі, авто-жауап |
| 🤖 AI Chatbot | Anthropic Claude API негізінде |
| 🌙 Dark/Light mode | Жүйе тақырыбы, localStorage |
| 📱 Responsive | Мобайл, планшет, дестоп |

---

## 🛠 Технологиялар

- **Frontend**: React 18, React Router v6, Vite
- **Backend**: Supabase (PostgreSQL + Auth + API)
- **Стильдеу**: CSS Variables, Custom Design System
- **AI**: Anthropic Claude API
- **Иконкалар**: Lucide React
- **Deploy**: Vercel / Netlify

---

## 🚀 Орнату

### 1. Repository клондау
```bash
git clone https://github.com/YOUR_USERNAME/smart-campus-project.git
cd smart-campus-project
```

### 2. Тәуелділіктерді орнату
```bash
npm install
```

### 3. Supabase баптау

1. [supabase.com](https://supabase.com) сайтына кіріп, жаңа жоба жасаңыз
2. **SQL Editor** → `supabase-schema.sql` файлын орындаңыз
3. **Project Settings → API** бетінен URL мен anon key алыңыз

### 4. .env файлы жасау
```bash
cp .env.example .env
```
`.env` файлын өзіңіздің мәндеріңізбен толтырыңыз:
```env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
```

### 5. Жобаны іске қосу
```bash
npm run dev
```

Браузерде ашыңыз: `http://localhost:5173`

---

## 📁 Жоба құрылымы

```
smart-campus/
├── src/
│   ├── components/
│   │   ├── layout/       # Layout, Sidebar, Topbar
│   │   └── ui/           # AIChat, shared components
│   ├── context/
│   │   ├── AuthContext.jsx   # Аутентификация контексті
│   │   └── ThemeContext.jsx  # Dark/Light тема
│   ├── pages/
│   │   ├── DashboardPage.jsx
│   │   ├── TasksPage.jsx
│   │   ├── EventsPage.jsx
│   │   ├── MessagesPage.jsx
│   │   ├── ProfilePage.jsx
│   │   ├── LoginPage.jsx
│   │   └── RegisterPage.jsx
│   ├── services/
│   │   └── supabase.js   # Supabase CRUD operations
│   ├── App.jsx
│   ├── main.jsx
│   └── index.css         # Design system
├── public/
├── supabase-schema.sql   # Database schema
├── .env.example
├── package.json
└── README.md
```

---

## 🗄 Database схемасы

```sql
profiles        -- Пайдаланушы профилі
tasks           -- Тапсырмалар (CRUD)
events          -- Іс-шаралар (CRUD)
event_registrations  -- Тіркелулер
messages        -- Хабарламалар
```

---

## 🔑 Қорғауға дайын сұрақтар

**Неліктен Supabase таңдадым?**
> Тегін, PostgreSQL негізінде, Auth + Real-time + Storage бар, React-пен жақсы интеграция.

**Authentication қалай жұмыс істейді?**
> `supabase.auth.signUp()` → email/password → JWT token → `onAuthStateChange` listener.

**CRUD қай жерде орындалады?**
> `src/services/supabase.js` — барлық CRUD операциялары. Компоненттер сервисті шақырады.

**Database құрылымы?**
> 5 кесте: profiles, tasks, events, event_registrations, messages. RLS қосылған.

**Қауіпсіздік?**
> Row Level Security (RLS) — пайдаланушы тек өз деректерін көре/өзгерте алады.

---

## 👤 Автор

**[Сіздің атыңыз]**
- GitHub: [@username](https://github.com/username)
- Email: student@campus.kz

---

## 📜 Лицензия

MIT License © 2025
