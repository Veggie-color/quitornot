-- Supabase 数据库初始化 SQL
create extension if not exists pgcrypto;

create table if not exists public.game_sessions (
  device_id text primary key,
  total_vents integer default 0,
  total_booms integer default 0,
  best_combo integer default 0,
  quit_date text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.game_sessions enable row level security;

create policy if not exists "public_read_write_game_sessions"
  on public.game_sessions
  for all
  using (true)
  with check (true);
