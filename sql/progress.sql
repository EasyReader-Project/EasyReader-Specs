-- ============================================
-- 阅读进度表 (progress)
-- ============================================
CREATE TABLE IF NOT EXISTS progress (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  book_id INTEGER NOT NULL,
  progress_json TEXT NOT NULL,
  current_chapter_title TEXT,
  global_percent REAL CHECK(
    global_percent >= 0
    AND global_percent <= 1
  ),
  total_reading_minutes INTEGER DEFAULT 0,
  last_read_at INTEGER NOT NULL,
  FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_progress_book_id ON progress(book_id);
CREATE INDEX IF NOT EXISTS idx_progress_last_read ON progress(last_read_at);