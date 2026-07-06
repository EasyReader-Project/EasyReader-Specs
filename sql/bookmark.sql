-- ============================================
-- 书签/高亮表 (bookmarks)
-- 记录用户标记的阅读位置，可附带高亮文本和样式
-- ============================================
CREATE TABLE bookmarks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL,
    
    -- ===== 定位信息（复用 progress_json 的结构，便于双端共用解析器） =====
    location_json TEXT NOT NULL,        -- 格式与 progress.location 完全一致
    
    -- ===== 书签内容 =====
    name TEXT,                          -- 用户自定义名称（如“关键证据”），可选
    selected_text TEXT,                 -- 选中的高亮文本（纯文本）
    
    -- ===== 样式属性 =====
    color TEXT,                         -- 高亮颜色（如 "#FFCC00" 或预定义枚举值）
    style TEXT DEFAULT 'highlight' CHECK(style IN ('bookmark', 'highlight', 'underline')),
    -- 注：'bookmark' 表示只做书签不涂色，'highlight' 表示背景高亮，'underline' 表示下划线
    
    -- ===== 时间戳 =====
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

-- 索引：按书籍快速查询所有书签
CREATE INDEX idx_bookmarks_book_id ON bookmarks(book_id);
-- 索引：按创建时间排序（最近添加的优先）
CREATE INDEX idx_bookmarks_created_at ON bookmarks(created_at);