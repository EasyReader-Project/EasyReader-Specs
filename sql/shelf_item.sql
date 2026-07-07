-- ============================================
-- 书架书籍映射表 (shelf_item)
-- 将 book 表中的书籍关联到具体的书架和文件夹
-- ============================================
CREATE TABLE IF NOT EXISTS shelf_item (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    shelf_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,            -- 关联 book 表
    
    -- 定位（可选）：书籍可以放在根目录（folder_id = NULL），或放入某个文件夹
    folder_id INTEGER,
    
    -- 排序与状态
    sort_order INTEGER DEFAULT 0,        -- 在当前文件夹内的排序位置
    is_archived BOOLEAN DEFAULT 0,       -- 是否归档（隐藏但保留在书架中，不影响删除）
    
    -- 自定义备注（可选）
    notes TEXT,                          -- 用户对该书籍在此书架中的备注（如“待二刷”）
    
    -- 时间戳
    added_at INTEGER NOT NULL,           -- 加入书架的时间
    updated_at INTEGER NOT NULL,
    
    FOREIGN KEY (shelf_id) REFERENCES shelf(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE,
    FOREIGN KEY (folder_id) REFERENCES folder(id) ON DELETE SET NULL,  -- 删除文件夹时，书籍移至根目录
    
    -- 约束：同一书架的同一本书只能出现一次
    UNIQUE(shelf_id, book_id)
);

CREATE INDEX IF NOT EXISTS idx_shelf_item_shelf ON shelf_item(shelf_id);
CREATE INDEX IF NOT EXISTS idx_shelf_item_book ON shelf_item(book_id);
CREATE INDEX IF NOT EXISTS idx_shelf_item_folder ON shelf_item(folder_id);
CREATE INDEX IF NOT EXISTS idx_shelf_item_archived ON shelf_item(is_archived);