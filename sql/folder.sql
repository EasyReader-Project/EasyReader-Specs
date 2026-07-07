-- ============================================
-- 文件夹表 (folder)
-- 支持多级嵌套，属于某个书架
-- ============================================
CREATE TABLE IF NOT EXISTS folder (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    shelf_id INTEGER NOT NULL,           -- 所属书架
    
    -- 跨设备唯一标识（便于同步时合并）
    uuid TEXT UNIQUE NOT NULL,
    
    -- 父子关系（自引用）
    parent_folder_id INTEGER,            -- 父文件夹 ID，NULL 表示根目录
    
    -- 基本信息
    name TEXT NOT NULL,                  -- 文件夹名称
    sort_order INTEGER DEFAULT 0,        -- 在父目录下的排序位置
    
    -- 可选扩展
    icon TEXT,                           -- 自定义图标（如 📚 或 emoji）
    is_expanded BOOLEAN DEFAULT 1,       -- UI 默认是否展开（仅客户端状态，同步时可选）
    
    -- 时间戳
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    
    FOREIGN KEY (shelf_id) REFERENCES shelf(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_folder_id) REFERENCES folder(id) ON DELETE CASCADE  -- 删除父文件夹时级联删除子文件夹
);

CREATE INDEX IF NOT EXISTS idx_folder_shelf_id ON folder(shelf_id);
CREATE INDEX IF NOT EXISTS idx_folder_parent ON folder(parent_folder_id);
CREATE INDEX IF NOT EXISTS idx_folder_uuid ON folder(uuid);