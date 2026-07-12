-- ============================================
-- 书架书籍映射表 (shelf_item)
-- 将 book 表中的书籍关联到具体的书架和文件夹
-- ============================================
CREATE TABLE IF NOT EXISTS shelf_item (
    id INTEGER PRIMARY KEY AUTOINCREMENT,     -- 自增主键
    shelf_id INTEGER NOT NULL,                -- 所属书架 ID（外键 → shelf.id）
    book_id INTEGER NOT NULL,                 -- 关联书籍 ID（外键 → book.id）
    shelf_folder_id INTEGER,                  -- 所属文件夹 ID，NULL 表示根目录（外键 → shelf_folder.id）
    sort_order INTEGER DEFAULT 0,             -- 在当前文件夹内的排序位置
    is_archived BOOLEAN DEFAULT 0,            -- 是否归档（隐藏但保留，不影响删除）
    notes TEXT,                               -- 用户备注（如“待二刷”）
    added_at INTEGER NOT NULL,                -- 加入书架的时间戳（毫秒）
    updated_at INTEGER NOT NULL,              -- 更新时间戳（毫秒）
    FOREIGN KEY (shelf_id) REFERENCES shelf(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE,
    FOREIGN KEY (shelf_folder_id) REFERENCES shelf_folder(id) ON DELETE SET NULL,
    UNIQUE(shelf_id, book_id)                 -- 同一书架的同一本书只能出现一次
);

CREATE INDEX idx_shelf_item_shelf ON shelf_item(shelf_id);
CREATE INDEX idx_shelf_item_book ON shelf_item(book_id);
CREATE INDEX idx_shelf_item_folder ON shelf_item(shelf_folder_id);
CREATE INDEX idx_shelf_item_archived ON shelf_item(is_archived);