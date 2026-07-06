# Changelog · 契约变更日志

本日志记录 `EasyReader-Specs` 公共契约的所有重要变更（新增、修改、删除、废弃）。

> **版本规则**：[语义化版本 2.0.0](https://semver.org/lang/zh-CN/)  
> **Major**：破坏性变更（字段删除/重命名/类型修改），双端必须同步升级。  
> **Minor**：向下兼容的新增功能（新增可选字段/枚举值），双端可按需升级。  
> **Patch**：文档修正、测试用例补充，不影响数据结构。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)。

---

## [Unreleased]

> 已合并但尚未正式发布的变更。

### Added
- （待补充）

### Changed
- （待补充）

### Deprecated
- （待补充）

### Removed
- （待补充）

### Fixed
- （待补充）

### Security
- （待补充）

---

## [0.1.0] - YYYY-MM-DD

> 初始版本 · 项目启动

### Added
- 初始化仓库目录结构
- 建立 `sql/schema.sql` 基础表结构
- 建立 `schemas/` 下各 JSON Schema 骨架
- 建立 `constants/` 下常量枚举骨架
- 建立 `protocols/` 下同步规则文档骨架

---

## 版本发布规范

1. 发布前确认 Windows 和 Android 端已合并对应的适配代码。
2. 发布时在 GitHub 上创建对应的 **Tag**（如 `v1.0.0`）。
3. 若涉及数据库迁移，需在 `sql/migrations/` 中补充升级脚本，并在日志中附带迁移指引。

---

*模板说明：将 `[0.1.0]` 中的日期替换为实际发布日期，后续每个版本按时间倒序追加在上方。*