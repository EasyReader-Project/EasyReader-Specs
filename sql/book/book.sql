-- ============================================
-- 书籍元数据表 (book)
-- 存储所有书籍的基本信息（去重，通过 file_hash 唯一）
-- ============================================
CREATE TABLE IF NOT EXISTS book (
    id INTEGER PRIMARY KEY AUTOINCREMENT,            -- 自增主键
    file_hash TEXT UNIQUE NOT NULL,                  -- 文件 SHA-256 哈希值（唯一标识）
    title TEXT NOT NULL,                             -- 书名
    author TEXT,                                     -- 作者
    publisher TEXT,                                  -- 出版社
    file_type TEXT NOT NULL CHECK(file_type IN ('epub', 'pdf', 'txt', 'doc', 'docx')), -- 书籍格式
    word_count INTEGER,                              -- 总字数
    page_count INTEGER,                              -- 总页数
    local_path TEXT NOT NULL,                        -- 本地文件路径
    file_size INTEGER,                               -- 文件大小（字节）
    last_modified INTEGER,                           -- 文件修改时间戳（毫秒）
    cover_path TEXT,                                 -- 封面图片路径（仅本端）
    reading_status TEXT DEFAULT 'unread' CHECK(reading_status IN ('unread', 'reading', 'finished')), -- 阅读状态
    created_at INTEGER NOT NULL,                     -- 记录创建时间戳（毫秒）
    updated_at INTEGER NOT NULL                      -- 记录更新时间戳（毫秒）
);

CREATE INDEX IF NOT EXISTS idx_book_file_hash ON book(file_hash);
CREATE INDEX IF NOT EXISTS idx_book_title ON book(title);
CREATE INDEX IF NOT EXISTS idx_book_author ON book(author);
CREATE INDEX IF NOT EXISTS idx_book_status ON book(reading_status);
CREATE INDEX IF NOT EXISTS idx_book_word_count ON book(word_count);
CREATE INDEX IF NOT EXISTS idx_book_updated_at ON book(updated_at);