-- ============================================
-- 笔记/批注表 (note)
-- 记录用户的文字批注，可关联到书签，也可独立存在
-- ============================================
CREATE TABLE IF NOT EXISTS note (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL,
    bookmark_id INTEGER,                -- 关联到单数表名 bookmark
    
    -- ===== 笔记正文 =====
    content TEXT NOT NULL,
    
    -- ===== 独立定位 =====
    location_json TEXT,
    
    -- ===== 时间戳 =====
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE,
    FOREIGN KEY (bookmark_id) REFERENCES bookmark(id) ON DELETE CASCADE
);

-- 索引（名称同步改为单数）
CREATE INDEX IF NOT EXISTS idx_note_book_id ON note(book_id);
CREATE INDEX IF NOT EXISTS idx_note_bookmark_id ON note(bookmark_id);
CREATE INDEX IF NOT EXISTS idx_note_created_at ON note(created_at);