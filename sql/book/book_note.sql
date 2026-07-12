-- ============================================
-- 笔记/批注表 (book_note)
-- 用户的文字批注，可依附书签或独立存在
-- ============================================
CREATE TABLE IF NOT EXISTS book_note (
    id INTEGER PRIMARY KEY AUTOINCREMENT,            -- 自增主键
    book_id INTEGER NOT NULL,                        -- 所属书籍 ID（外键 → book.id）
    book_mark_id INTEGER,                            -- 关联的书签 ID（外键 → book_mark.id，可为 NULL）
    content TEXT NOT NULL,                           -- 笔记正文（纯文本或 Markdown）
    location_json TEXT,                              -- 独立定位（仅当 book_mark_id 为空时使用）
    created_at INTEGER NOT NULL,                     -- 创建时间戳（毫秒）
    updated_at INTEGER NOT NULL,                     -- 更新时间戳（毫秒）
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE,
    FOREIGN KEY (book_mark_id) REFERENCES book_mark(id) ON DELETE CASCADE
);

CREATE INDEX idx_book_note_book_id ON book_note(book_id);
CREATE INDEX idx_book_note_book_mark_id ON book_note(book_mark_id);
CREATE INDEX idx_book_note_created_at ON book_note(created_at);