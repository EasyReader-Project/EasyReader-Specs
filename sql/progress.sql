-- ============================================
-- 阅读进度表 (progress)
-- ============================================
CREATE TABLE progress (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  book_id INTEGER NOT NULL,
  -- 核心进度数据：JSON 格式存储，结构由 progress.schema.json 约束
  progress_json TEXT NOT NULL,
  -- ===== 冗余字段（用于书架列表快速展示，避免解析 JSON） =====
  current_chapter_title TEXT,
  -- 当前阅读章节的标题
  global_percent REAL CHECK(
    global_percent >= 0
    AND global_percent <= 1
  ),
  -- 全局阅读百分比（0~1）
  -- ===== 阅读统计 =====
  total_reading_minutes INTEGER DEFAULT 0,
  -- 累计阅读时长（分钟）
  last_read_at INTEGER NOT NULL,
  -- 最后阅读时间戳（毫秒），用于冲突仲裁的 Last-Write-Wins
  -- 外键约束：删除书籍时自动删除对应的进度记录
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

-- 索引：加速按书籍查询进度
CREATE INDEX idx_progress_book_id ON progress(book_id);

-- 索引：加速“最近阅读”列表排序
CREATE INDEX idx_progress_last_read ON progress(last_read_at);