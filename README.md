# 辞了么 · Supabase 部署说明

## 1. 创建 Supabase 表
1. 打开 Supabase Dashboard。
2. 进入 SQL Editor，执行 [supabase-schema.sql](supabase-schema.sql) 中的内容。
3. 复制 Project URL 与 anon public key。

## 2. 配置页面
把 [辞了么.html](辞了么.html) 里这两段替换成真实值：

```html
window.__SUPABASE_CONFIG__ = {
  url: "https://YOUR_PROJECT_REF.supabase.co",
  anonKey: "YOUR_ANON_KEY"
};
```

## 3. 部署到 GitHub Pages
1. 在 GitHub 新建仓库。
2. 把当前文件夹提交并推送：
   ```bash
   git init
   git add .
   git commit -m "feat: add Supabase-backed static app"
   git branch -M main
   git remote add origin https://github.com/<你的用户名>/<仓库名>.git
   git push -u origin main
   ```
3. 在仓库设置中开启 GitHub Pages，Source 选择 `main` 分支，根目录即可。

## 4. 访问
部署后可通过 GitHub Pages 地址访问页面。
