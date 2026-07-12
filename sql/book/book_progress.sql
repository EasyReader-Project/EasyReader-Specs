-- ============================================
-- 阅读进度表 (book_progress)
-- 记录用户在书籍中的精确阅读位置
-- ============================================
CREATE TABLE IF NOT EXISTS book_progress (
    id INTEGER PRIMARY KEY AUTOINCREMENT,            -- 自增主键
    book_id INTEGER NOT NULL,                        -- 所属书籍 ID（外键 → book.id）
    progress_json TEXT NOT NULL,                     -- 完整进度数据（JSON，包含 location, percent 等）
    current_chapter_title TEXT,                      -- 当前章节标题（冗余，便于展示）
    global_percent REAL CHECK(global_percent >= 0 AND global_percent <= 1), -- 全局阅读百分比（0~1）
    total_reading_minutes INTEGER DEFAULT 0,         -- 累计阅读时长（分钟）
    last_read_at INTEGER NOT NULL,                   -- 最后阅读时间戳（毫秒）
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_book_progress_book_id ON book_progress(book_id);
CREATE INDEX IF NOT EXISTS idx_book_progress_last_read ON book_progress(last_read_at);