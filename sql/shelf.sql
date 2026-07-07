-- ============================================
-- 书架元数据表 (shelf)
-- 同步的顶层单元，一个书架包含独立的文件夹树和书籍映射
-- ============================================
CREATE TABLE IF NOT EXISTS shelf (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    
    -- 跨设备唯一标识（使用 UUID，便于多端合并）
    uuid TEXT UNIQUE NOT NULL,
    
    -- 基本信息
    name TEXT NOT NULL,                  -- 书架名称（如“我的小说”）
    cover_path TEXT,                     -- 书架自定义封面（可选）
    
    -- 排序与展示
    sort_order INTEGER DEFAULT 0,        -- 在书架列表中的排序位置
    
    -- 同步与状态
    is_default BOOLEAN DEFAULT 0,        -- 是否为默认书架（通常只有一个默认）
    last_sync_at INTEGER,                -- 上次同步时间戳（毫秒）
    
    -- 时间戳
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_shelf_uuid ON shelf(uuid);
CREATE INDEX IF NOT EXISTS idx_shelf_default ON shelf(is_default);