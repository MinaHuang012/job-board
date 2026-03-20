-- =============================================
-- 求职信息广场 · Supabase 数据库初始化脚本
-- 在 Supabase 控制台 SQL Editor 中执行此脚本
-- =============================================

-- 1. 创建 jobs 表
CREATE TABLE IF NOT EXISTS jobs (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title       TEXT NOT NULL,
  content     TEXT NOT NULL,
  company     TEXT,
  location    TEXT,
  salary      TEXT,
  tags        TEXT[] DEFAULT '{}',
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 创建索引（加速按时间排序）
CREATE INDEX IF NOT EXISTS jobs_created_at_idx ON jobs (created_at DESC);

-- 3. 开启 Row Level Security (RLS)
ALTER TABLE jobs ENABLE ROW LEVEL SECURITY;

-- 4. 策略：任何人可以读取（前台展示用）
CREATE POLICY "Public can read jobs"
  ON jobs FOR SELECT
  USING (true);

-- 5. 策略：任何人可以插入（用 anon key，后台用密码保护）
CREATE POLICY "Anyone can insert jobs"
  ON jobs FOR INSERT
  WITH CHECK (true);

-- 6. 策略：任何人可以删除（管理后台使用）
CREATE POLICY "Anyone can delete jobs"
  ON jobs FOR DELETE
  USING (true);

-- 7. 更新时间触发器
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER jobs_updated_at
  BEFORE UPDATE ON jobs
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- =============================================
-- 测试数据（可选，运行后可以删除）
-- =============================================
INSERT INTO jobs (title, content, company, location, salary, tags) VALUES
(
  '前端工程师 · 字节跳动 · 25K-40K',
  '【职位】前端工程师
【公司】字节跳动
【薪资】25K-40K · 16薪
【地点】北京 · 海淀区
【要求】
- 3年以上前端开发经验
- 熟悉 React / Vue
- 有 TypeScript 使用经验优先
【联系方式】请发送简历至 xxx@bytedance.com',
  '字节跳动', '北京', '25K-40K',
  ARRAY['全职', '技术', '应届生']
),
(
  '产品经理实习 · 腾讯 · 200/天',
  '【职位】产品经理实习生
【公司】腾讯
【薪资】200元/天
【地点】深圳 · 南山区
【要求】
- 在读大三/大四优先
- 有产品思维，逻辑清晰
- 能实习至少3个月
【联系方式】微信：xxxxx',
  '腾讯', '深圳', '200元/天',
  ARRAY['实习', '产品']
);
