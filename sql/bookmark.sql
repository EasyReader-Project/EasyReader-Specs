-- ============================================
-- 书签/高亮表 (bookmark)
-- 记录用户标记的阅读位置，可附带高亮文本和样式
-- ============================================
CREATE TABLE IF NOT EXISTS bookmark (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL,
    
    -- ===== 定位信息（复用 progress_json 的结构） =====
    location_json TEXT NOT NULL,
    
    -- ===== 书签内容 =====
    name TEXT,
    selected_text TEXT,
    
    -- ===== 样式属性 =====
    color TEXT,
    style TEXT DEFAULT 'highlight' CHECK(style IN ('bookmark', 'highlight', 'underline')),
    
    -- ===== 时间戳 =====
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
);

-- 索引（名称同步改为单数）
CREATE INDEX IF NOT EXISTS idx_bookmark_book_id ON bookmark(book_id);
CREATE INDEX IF NOT EXISTS idx_bookmark_created_at ON bookmark(created_at);