-- ============================================
-- 书籍元数据表 (book)
-- ============================================
CREATE TABLE book (
  -- 主键：自增ID，仅用于本地数据库关联，不具备跨设备意义
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  -- 跨设备唯一标识：文件内容的 SHA-256 哈希值（十六进制字符串）
  file_hash TEXT UNIQUE NOT NULL,
  -- ===== 基础元数据（从 EPUB/PDF 解析） =====
  title TEXT NOT NULL,
  -- 书名
  author TEXT,
  -- 作者
  publisher TEXT,
  -- 出版社
  format TEXT NOT NULL CHECK(format IN ('epub', 'pdf')),
  -- ===== 书籍规模信息 =====
  word_count INTEGER,
  -- 总字数（TXT 直接统计，EPUB 估算/解析）
  page_count INTEGER,
  -- 总页数（PDF 直接读取，EPUB 估算）
  -- ===== 文件信息（各端独立存储） =====
  local_path TEXT NOT NULL,
  file_size INTEGER,
  last_modified INTEGER,
  -- ===== 封面与状态 =====
  cover_path TEXT,
  -- 封面图片本地路径（书籍自带或用户替换均可）
  reading_status TEXT DEFAULT 'unread' CHECK(
    reading_status IN ('unread', 'reading', 'finished')
  ),
  -- ===== 时间戳 =====
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);

-- 索引
CREATE INDEX idx_book_file_hash ON book(file_hash);

CREATE INDEX idx_book_title ON book(title);

CREATE INDEX idx_book_author ON book(author);-- 新增：按作者搜索
CREATE INDEX idx_book_status ON book(reading_status);

CREATE INDEX idx_book_word_count ON book(word_count);-- 新增：用于排序或统计
CREATE INDEX idx_book_updated_at ON book(updated_at);-- 新增：按最后更新时间排序