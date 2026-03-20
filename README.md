# 求职信息广场 · 部署教程

完成以下步骤大约需要 **15-20 分钟**，全程免费。

---

## 第一步：注册 Supabase（免费数据库）

1. 打开 [https://supabase.com](https://supabase.com)，点击 **Start your project**
2. 用 GitHub 账号登录（没有就顺便注册一个，免费的）
3. 点击 **New Project**，填写：
   - **Name**：`job-board`（随意）
   - **Database Password**：设一个强密码（记住，但不会用到）
   - **Region**：选 `Northeast Asia (Tokyo)` 延迟最低
4. 等待约 1 分钟创建完成

### 获取你的 API 信息

创建完成后：
1. 左侧菜单 → **Project Settings** → **API**
2. 复制两个值，稍后要用：
   - `Project URL`（形如 `https://xxxxx.supabase.co`）
   - `anon public` key（一长串字符）

### 创建数据库表

1. 左侧菜单 → **SQL Editor**
2. 点击 **New query**
3. 把 `supabase-setup.sql` 文件里的所有内容粘贴进去
4. 点击 **Run**，看到 `Success` 即可

---

## 第二步：修改网站配置

打开 `public/index.html` 和 `public/admin.html`，
找到文件顶部的这段注释，替换三处内容：

```javascript
// ============================================================
// CONFIG — 部署后替换为你的 Supabase 信息
// ============================================================
const SUPABASE_URL = 'YOUR_SUPABASE_URL';        // 替换为你的 Project URL
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY'; // 替换为 anon public key
const TABLE_NAME = 'jobs';
// admin.html 额外还有：
const ADMIN_PASSWORD = 'YOUR_ADMIN_PASSWORD';    // 设置一个你记得住的密码
// ============================================================
```

**示例：**
```javascript
const SUPABASE_URL = 'https://abcdefghij.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI...（很长一串）';
const ADMIN_PASSWORD = 'MySecret2024';
```

> ⚠️ **两个文件都要改**：`index.html` 和 `admin.html`

---

## 第三步：部署到 Vercel（免费托管）

### 方式一：直接上传文件夹（最简单）

1. 打开 [https://vercel.com](https://vercel.com)，用 GitHub 登录
2. 进入 Dashboard，点击 **Add New → Project**
3. 选择 **Browse** 上传整个 `job-board` 文件夹
4. Framework Preset 选 **Other**
5. 点击 **Deploy**，等待约 30 秒
6. 部署完成后你会得到一个网址，如 `https://job-board-xxx.vercel.app`

### 方式二：通过 GitHub（推荐，以后修改更方便）

1. 把 `job-board` 文件夹上传到你的 GitHub 仓库
2. Vercel → **Import Git Repository** → 选择该仓库
3. Deploy，完成

---

## 第四步：使用你的网站

部署完成后：

| 页面 | 地址 | 说明 |
|------|------|------|
| 前台展示 | `https://你的域名/` | 所有人都能访问 |
| 管理后台 | `https://你的域名/admin` | 需要密码，只有你能用 |

### 日常使用流程（约 5 秒操作）

1. 在微信群里看到想分享的求职信息
2. **长按消息 → 复制**
3. 打开手机浏览器，访问你的管理后台地址
4. 粘贴内容 → 填写标题 → 选标签 → 点发布
5. 前台网站立即更新 ✅

> 💡 **建议**：把管理后台地址存到手机书签，操作更快

---

## 自定义域名（可选）

如果你有自己的域名（如 `jobs.yourdomain.com`）：

1. Vercel 项目 → **Settings → Domains**
2. 输入你的域名，按提示配置 DNS
3. 等待几分钟生效

---

## 常见问题

**Q：网站显示"暂时无法加载数据"**
→ 检查 `index.html` 里的 `SUPABASE_URL` 和 `SUPABASE_ANON_KEY` 是否正确填写

**Q：管理后台密码不对**
→ 检查 `admin.html` 里的 `ADMIN_PASSWORD` 是否和你输入的完全一致（区分大小写）

**Q：发布后前台没有立即更新**
→ 网站每 60 秒自动刷新一次；也可以手动刷新浏览器

**Q：想换一个标签分类**
→ 修改 `admin.html` 中 `tag-selector` 那段 HTML，增删 `<span class="tag-option">` 即可

**Q：想给网站改个名字**
→ 搜索 "求职信息广场"，全部替换成你想要的名字

---

## 项目文件说明

```
job-board/
├── public/
│   ├── index.html      ← 前台展示页（访客看到的）
│   └── admin.html      ← 管理后台（你专用的发布页面）
├── supabase-setup.sql  ← 数据库建表脚本（只用一次）
├── vercel.json         ← Vercel 部署配置
└── README.md           ← 本教程
```
