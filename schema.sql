-- ============================================================
--  Cockpit — Supabase Schema
--  Run this entire file in Supabase → SQL Editor → New query
-- ============================================================

-- ── Tables ────────────────────────────────────────────────

create table if not exists public.tabs (
  id          text        primary key,
  user_id     uuid        not null references auth.users on delete cascade,
  name        text        not null,
  ck          text        not null default 'work',
  position    integer     not null default 0,
  created_at  timestamptz not null default now()
);

create table if not exists public.tasks (
  id           text        primary key,
  user_id      uuid        not null references auth.users on delete cascade,
  tab_id       text        not null,
  title        text        not null,
  stakeholder  text,
  note         text,
  status       text        not null default 'inprogress',
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

create table if not exists public.user_settings (
  user_id     uuid        primary key references auth.users on delete cascade,
  gemini_key  text,
  updated_at  timestamptz not null default now()
);

-- ── Indexes ───────────────────────────────────────────────

create index if not exists tasks_user_id_idx on public.tasks (user_id);
create index if not exists tasks_tab_id_idx  on public.tasks (tab_id);
create index if not exists tabs_user_id_idx  on public.tabs  (user_id);

-- ── Row Level Security ────────────────────────────────────
-- Each user can only read/write their own rows.

alter table public.tabs           enable row level security;
alter table public.tasks          enable row level security;
alter table public.user_settings  enable row level security;

-- tabs
create policy "tabs: users own their rows"
  on public.tabs for all
  using  (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- tasks
create policy "tasks: users own their rows"
  on public.tasks for all
  using  (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- user_settings
create policy "settings: users own their rows"
  on public.user_settings for all
  using  (auth.uid() = user_id)
  with check (auth.uid() = user_id);
