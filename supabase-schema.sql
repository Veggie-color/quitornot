-- Supabase 数据库初始化 SQL
-- 在 Supabase Dashboard > SQL Editor 中执行。

create extension if not exists pgcrypto;

create table if not exists public.game_sessions (
  device_id text primary key,
  email text,
  username text,
  leaderboard_name text,
  leaderboard_score integer default 0,
  leaderboard_visible boolean default true,
  total_vents integer default 0,
  total_booms integer default 0,
  best_combo integer default 0,
  quit_date text,
  last_login_at timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.game_sessions
  add column if not exists email text,
  add column if not exists username text,
  add column if not exists leaderboard_name text,
  add column if not exists leaderboard_score integer default 0,
  add column if not exists leaderboard_visible boolean default true,
  add column if not exists last_login_at timestamptz;

alter table public.game_sessions
  drop constraint if exists game_sessions_username_safe,
  drop constraint if exists game_sessions_leaderboard_name_safe;

alter table public.game_sessions
  add constraint game_sessions_username_safe
  check (
    username is null
    or (
      char_length(username) between 2 and 16
      and username !~ '[[:space:]<>"''`;\\/\|{}\[\]\(\)=+*&^%$#@!?]'
    )
  ),
  add constraint game_sessions_leaderboard_name_safe
  check (
    leaderboard_name is null
    or (
      char_length(leaderboard_name) between 2 and 16
      and leaderboard_name !~ '[[:space:]<>"''`;\\/\|{}\[\]\(\)=+*&^%$#@!?]'
    )
  );

alter table public.game_sessions enable row level security;

drop policy if exists "public_read_write_game_sessions" on public.game_sessions;
create policy "public_read_write_game_sessions"
  on public.game_sessions
  for all
  using (true)
  with check (true);
