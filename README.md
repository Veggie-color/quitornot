# 辞了么 · 部署说明

## Supabase

1. 在 Supabase 新建项目。
2. 打开 SQL Editor，执行 `supabase-schema.sql`。
3. 复制 Project URL 和 publishable key。
4. 打开 `辞了么.html`，替换：

```js
window.__SUPABASE_CONFIG__ = {
  url: "https://YOUR_PROJECT_REF.supabase.co",
  anonKey: "YOUR_PUBLISHABLE_KEY"
};
```

Auth 登录使用邮箱 magic link。部署到 GitHub Pages 后，到 Supabase Authentication > URL Configuration，把 Site URL 改成你的 GitHub Pages 地址。

## 数据字段

`game_sessions` 现在记录：

```sql
device_id
email
username
leaderboard_name
leaderboard_score
leaderboard_visible
total_vents
total_booms
best_combo
quit_date
last_login_at
created_at
updated_at
```

用户名规则：2-16 个字符，不允许空格和这些敏感符号：

```text
< > " ' ` ; \ / | { } [ ] ( ) = + * & ^ % $ # @ ! ?
```

排行榜可以按 `leaderboard_score desc` 排序，`leaderboard_name` 用来展示名字。`last_login_at` 是用户最近一次登录的完整时间戳，后续生成报告时可以用它统计“最晚登录是哪一天/几点”。

## GitHub Pages

```bash
git add .
git commit -m "feat: connect supabase auth"
git branch -M main
git remote add origin https://github.com/<你的用户名>/<仓库名>.git
git push -u origin main
```

然后在 GitHub 仓库 Settings > Pages 中选择 `main` 分支和根目录。
