# 辞了么

一个给打工人玩的「辞职模拟器」。

打开网页，狂点按钮，把上班受的气一次还清。用户可以积累辞意值、触发爆炸式辞职仪式、生成专属辞职战报，并把战报或网页分享给朋友。

正式地址：[https://www.quitornot.click/](https://www.quitornot.click/)

## 这是个什么东西

`辞了么` 不是严肃的职业建议工具，而是一个带有黑色幽默的职场情绪出口。

它面向经常被加班、周报、KPI、会议、画饼、已读不回和内卷折磨的上班族。用户不用下载 App，打开网页就能玩，通过点击、震动、飞字、仪表盘、进度条和结果战报获得一点轻松的发泄感。

核心关键词：

- 辞职模拟器
- 打工人情绪出口
- 上班发疯小游戏
- 职场压力释放
- 可分享的辞职战报

## 当前功能

- 移动端优先的单页网页游戏
- 「我想辞职 / 我要辞职」点击发泄
- 辞意值进度条和仪表盘反馈
- 飞字动画、震动反馈、爆炸仪式感
- 每日次数和分享奖励机制
- 辞职段位和专属辞职战报
- 结果页二维码，扫码可跳回网站
- 分享图和 Open Graph 信息，适合微信等平台展示
- Supabase 云端数据同步
- 邮箱验证码登录代码已保留，但当前默认隐藏

## 项目结构

```text
.
├── index.html                         # 主入口文件
├── 辞了么.html                         # 同步副本，保持和 index.html 一致
├── supabase-schema.sql                # Supabase 数据表结构
├── share-cover.jpg                    # 当前用于社交分享的轻量封面图
├── share-cover.png                    # 较大的 PNG 封面图
├── 3a8b19800aedd2fbfa7318c57c173186.txt # 微信网站管理员认证文件
├── PROJECT_CONTEXT.md                 # 项目上下文存档
└── AGENTS.md                          # 给后续 AI/Codex 接手用的快速说明
```

## 技术栈

- 静态 HTML 单页应用
- React UMD CDN
- Supabase JS CDN
- qrcode-generator CDN
- Vercel 部署
- 阿里云购买和解析域名

这个项目没有复杂构建流程，主要代码都在 `index.html` 里。

## Supabase 数据同步

Supabase 用于保存游戏数据。当前策略是先降低登录门槛：

- 不显示邮箱登录入口
- 不主动弹出登录提示
- 数据继续同步到 Supabase
- 数据按本地浏览器/设备的 `device_id` 保存
- 一台设备或一个浏览器通常对应一条云端记录

也就是说，用户不用登录也可以保存数据。但如果换设备、换浏览器或清缓存，匿名数据就不能自动找回。

### 恢复邮箱验证码登录

邮箱验证码登录逻辑仍然保留。要恢复登录入口，只需要把 `index.html` 和 `辞了么.html` 里的开关改为：

```js
const ENABLE_EMAIL_LOGIN = true;
```

当前默认是：

```js
const ENABLE_EMAIL_LOGIN = false;
```

## Supabase 表结构

执行 `supabase-schema.sql` 可创建当前数据表。

核心表：

```sql
public.game_sessions
```

主要字段：

```text
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

注意：当前 RLS 策略偏开发期友好。如果产品有真实流量，建议收紧权限，避免匿名用户任意读写全表。

## 域名和部署

当前线上域名：

- `https://www.quitornot.click/`
- `https://quitornot.click/` 会跳转到 `https://www.quitornot.click/`
- Vercel 默认域名：`quitornot.vercel.app`

Vercel 绑定域名后，阿里云 DNS 曾使用过：

```text
@     A      216.198.79.1
www   CNAME  Vercel 后台给出的 *.vercel-dns-*.com
```

## 社交分享

网页分享封面使用：

```text
https://www.quitornot.click/share-cover.jpg
```

`share-cover.jpg` 是压缩后的轻量版，约 130KB，更适合微信抓取分享卡片。

如果微信分享图没有及时刷新，优先检查：

- Vercel 是否已部署最新代码
- `share-cover.jpg` 是否能通过浏览器直接访问
- 微信是否仍在使用旧缓存
- Open Graph 标签是否仍指向正确图片

## 开发和修改建议

修改页面时，建议：

1. 先改 `index.html`
2. 确认没问题后同步到 `辞了么.html`
3. 检查 `git status --short`
4. 只提交本次需要的文件

同步副本可使用：

```powershell
Copy-Item -LiteralPath .\index.html -Destination '.\辞了么.html' -Force
```

提交示例：

```powershell
git add index.html "辞了么.html"
git commit -m "update app"
git push
```

如果只更新 README：

```powershell
git add README.md
git commit -m "update readme"
git push
```

## 后续可做

- 收紧 Supabase RLS 权限
- 增加更完整的排行榜逻辑
- 优化微信分享缓存刷新方案
- 增加更多辞职段位和战报文案
- 根据流量情况决定是否恢复邮箱登录
- 如果用户量上来，评估 Supabase Pro 或迁移到更大容量的 Postgres 服务

## 项目定位

这不是一个鼓励裸辞的网站。

它更像一个小小的情绪按钮：  
上班受的气，在这里先还一点。

