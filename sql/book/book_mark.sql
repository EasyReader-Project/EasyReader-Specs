-- ============================================
-- 书签/高亮表 (book_mark)
-- 记录用户标记的阅读位置，可附带高亮文本和样式
-- ============================================
CREATE TABLE IF NOT EXISTS book_mark (
    id INTEGER PRIMARY KEY AUTOINCREMENT,            -- 自增主键
    book_id INTEGER NOT NULL,                        -- 所属书籍 ID（外键 → book.id）
    location_json TEXT NOT NULL,                     -- 定位信息（JSON，结构与 progress 一致）
    name TEXT,                                       -- 用户自定义名称（可选）
    selected_text TEXT,                              -- 选中的高亮文本（纯文本）
    color TEXT,                                      -- 高亮颜色（十六进制，如 #FFCC00）
    style TEXT DEFAULT 'highlight' CHECK(style IN ('bookmark', 'highlight', 'underline')), -- 样式类型
    created_at INTEGER NOT NULL,                     -- 创建时间戳（毫秒）
    updated_at INTEGER NOT NULL,                     -- 更新时间戳（毫秒）
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
);

CREATE INDEX idx_book_mark_book_id ON book_mark(book_id);
CREATE INDEX idx_book_mark_created_at ON book_mark(created_at);