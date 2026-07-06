-- ============================================
-- 笔记/批注表 (notes)
-- 记录用户的文字批注，可关联到书签，也可独立存在
-- ============================================
CREATE TABLE notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL,
    bookmark_id INTEGER,                -- 可选：关联到某个书签
    
    -- ===== 笔记正文 =====
    content TEXT NOT NULL,              -- 笔记内容（纯文本或 Markdown）
    
    -- ===== 独立定位（当 bookmark_id 为空时使用） =====
    location_json TEXT,                 -- 若依附书签则可为空，格式与 progress.location 一致
    
    -- ===== 时间戳 =====
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (bookmark_id) REFERENCES bookmarks(id) ON DELETE CASCADE
);

-- 索引：按书籍查询所有笔记
CREATE INDEX idx_notes_book_id ON notes(book_id);
-- 索引：按关联的书签查询笔记（一对多）
CREATE INDEX idx_notes_bookmark_id ON notes(bookmark_id);
-- 索引：按创建时间排序
CREATE INDEX idx_notes_created_at ON notes(created_at);