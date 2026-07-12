-- ============================================
-- 书架文件夹表 (shelf_folder)
-- 支持多级嵌套文件夹，属于某个书架
-- ============================================
CREATE TABLE IF NOT EXISTS shelf_folder (
    id INTEGER PRIMARY KEY AUTOINCREMENT,           -- 自增主键
    shelf_id INTEGER NOT NULL,                      -- 所属书架 ID（外键 → shelf.id）
    uuid TEXT UNIQUE NOT NULL,                      -- 跨设备唯一标识（UUID）
    parent_shelf_folder_id INTEGER,                 -- 父文件夹 ID，NULL 表示根目录（自引用 → shelf_folder.id）
    name TEXT NOT NULL,                             -- 文件夹名称
    sort_order INTEGER DEFAULT 0,                   -- 在父目录下的排序位置
    icon TEXT,                                      -- 自定义图标（如 📚 或 emoji）
    is_expanded BOOLEAN DEFAULT 1,                  -- UI 默认是否展开（客户端状态）
    created_at INTEGER NOT NULL,                    -- 创建时间戳（毫秒）
    updated_at INTEGER NOT NULL,                    -- 更新时间戳（毫秒）
    FOREIGN KEY (shelf_id) REFERENCES shelf(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_shelf_folder_id) REFERENCES shelf_folder(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_shelf_folder_shelf_id ON shelf_folder(shelf_id);
CREATE INDEX IF NOT EXISTS idx_shelf_folder_parent ON shelf_folder(parent_shelf_folder_id);
CREATE INDEX IF NOT EXISTS idx_shelf_folder_uuid ON shelf_folder(uuid);