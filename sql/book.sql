-- ============================================
-- 书籍元数据表 (book)
-- ============================================
CREATE TABLE IF NOT EXISTS book(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  file_hash TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  author TEXT,
  publisher TEXT,
  format TEXT NOT NULL CHECK(format IN ('epub', 'pdf')),
  word_count INTEGER,
  page_count INTEGER,
  local_path TEXT NOT NULL,
  file_size INTEGER,
  last_modified INTEGER,
  cover_path TEXT,
  reading_status TEXT DEFAULT 'unread' CHECK(
    reading_status IN ('unread', 'reading', 'finished')
  ),
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_book_file_hash ON book(file_hash);
CREATE INDEX IF NOT EXISTS idx_book_title ON book(title);
CREATE INDEX IF NOT EXISTS idx_book_author ON book(author);
CREATE INDEX IF NOT EXISTS idx_book_status ON book(reading_status);
CREATE INDEX IF NOT EXISTS idx_book_word_count ON book(word_count);
CREATE INDEX IF NOT EXISTS idx_book_updated_at ON book(updated_at);