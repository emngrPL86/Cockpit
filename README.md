# Cockpit — Setup Guide

Personal task command center with cross-device sync via Supabase, hosted free on GitHub Pages.

---

## What you need

- A [GitHub](https://github.com) account (free)
- A [Supabase](https://supabase.com) account (free)
- A [Google AI Studio](https://aistudio.google.com) account for AI summaries (free, optional)

---

## Step 1 — Set up Supabase

1. Go to [supabase.com](https://supabase.com) and sign up / log in
2. Click **New project**, give it a name (e.g. `cockpit`), choose a region close to you, set a database password, click **Create**
3. Wait ~1 minute for the project to provision
4. In the left sidebar go to **SQL Editor** → **New query**
5. Open the file `schema.sql` from this repo, paste the entire contents, and click **Run**
   - You should see: `Success. No rows returned`
6. Go to **Project Settings** (gear icon bottom-left) → **API**
7. Copy and save these two values — you'll need them shortly:
   - **Project URL** (looks like `https://xxxxxxxxxxxx.supabase.co`)
   - **anon / public** key (long string starting with `eyJ...`)

---

## Step 2 — Host on GitHub Pages

1. Go to [github.com](https://github.com) and click **New repository**
2. Name it anything, e.g. `cockpit` — set it to **Public**, click **Create repository**
3. Upload **both files** from this folder: `index.html` and `schema.sql` (drag and drop works)
4. Go to **Settings** → **Pages** (left sidebar)
5. Under **Branch**, select `main` and folder `/root`, click **Save**
6. After ~30 seconds, GitHub will show you a URL like `https://yourusername.github.io/cockpit`
   - That's your app URL — bookmark it on all your devices

---

## Step 3 — First run

1. Open your GitHub Pages URL in a browser
2. You'll see a **Setup** screen asking for your Supabase credentials
3. Paste your **Project URL** and **anon key** from Step 1 → click **Save & Connect**
4. You'll be taken to a **Sign up** screen — create your account with email + password
5. Check your email for a confirmation link and click it
6. Log back in — your Cockpit is ready!

> **On other devices:** just open the same GitHub Pages URL, log in with the same email/password, and all your tasks will be there.

---

## Step 4 — Enable AI Summary (optional, free)

1. Go to [aistudio.google.com/app/apikey](https://aistudio.google.com/app/apikey)
2. Click **Create API key** — no credit card needed, just a Google account
3. In Cockpit, click **⚙ Settings** → paste your key → **Save**
4. Click **✨ AI Summary** to get a daily briefing across all your tasks

---

## Updating the app

When a new version of `index.html` is released:
1. Open your GitHub repo
2. Click on `index.html` → edit (pencil icon) or just drag the new file over it
3. GitHub Pages will update automatically within a minute

---

## Troubleshooting

| Problem | Fix |
|---|---|
| "Invalid API key" on login | Double-check you pasted the **anon/public** key, not the service_role key |
| Email confirmation not arriving | Check spam; or in Supabase → Authentication → Users, confirm manually |
| Tasks not saving | Check browser console for errors; verify the SQL schema ran successfully |
| AI Summary error | Check your Gemini key in ⚙ Settings; make sure it starts with `AIza` |
| Changes not showing on other device | Tap the sync button (↺) or refresh the page |

---

## Security notes

- The Supabase **anon key** is safe to include in a public GitHub repo — it's designed for browser use
- Row Level Security (RLS) ensures users can only access their own data
- Your Gemini API key is stored in your browser's localStorage only — it never leaves your device
- Supabase **service_role** key should NEVER be used in the browser — we don't use it here
