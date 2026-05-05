# pr0117-PhageProbioticSynergy

**噬菌体-益生菌协同作用平台用于动物健康研究**  
Phage-Probiotic Synergy Platform for Animal Health

---

## 一句话简介

本项目通过**机制驱动**的科研方法，研究噬菌体与益生菌在肉鸡模型中的协同作用，为畜牧业提供抗生素替代方案。

**当前范围（已收缩，2026-05-05 更新）**：
- **单一宿主**：肉鸡（broiler chickens, *Gallus gallus domesticus*）
- **单一病原**：*Salmonella enterica* serovar Typhimurium ATCC 14028
- **单一组合**：T4-like 噬菌体 + *Lactobacillus rhamnosus* GG
- **核心目标**：机制解析（Transwell + 13C 代谢流）+ 体内验证（21天肉鸡实验）

---

## 仓库结构

```
pr0117-PhageProbioticSynergy/
├── README.md                     # 本文件：仓库入口
├── DESCRIPTION                   # R 包元数据
├── NAMESPACE                    # R 包命名空间
├── PhageProbioticSynergy.Rproj  # RStudio 项目文件
├── planned/                      # 规划文档（已整合）
│   ├── PROJECT_PLAN.md         # ★ 唯一权威研究计划
│   ├── RESEARCH_AUDIT_REPORT.md  # Codex 文档审核报告
│   └── CHANGELOG.md           # 版本历史与评审回应
├── analyses/                    # 分析模块（qproj 框架，★ 不修改）
│   ├── 01-public-data-mining.qmd
│   ├── 02-phage-host-prediction.qmd
│   ├── ...
│   └── data/README.md
└── references/                  # 参考文献（待补充）
```

---

## 快速开始

### 阅读顺序（新成员）
1. **本 README** → 了解项目当前范围
2. **planned/PROJECT_PLAN.md** → 完整研究计划（假设、任务、统计、预算）
3. **planned/CHANGELOG.md** → 版本变更历史

### 执行分析（已有 qproj 框架）
```r
# 在 R 中运行
qproj::proj_use_workflow("analyses")
qproj::use_qmd("01-public-data-mining", "analyses")
```

### 当前状态
✅ 研究范围已收缩（单宿主、单病原、单组合）  
✅ 研究计划已修订（v2，Codex 评审后）  
✅ 文档架构已重组（一主两辅结构）  
⏳ 等待启动 Task 1：In Vitro Baseline Calibration  

---

## 关键文档链接

| 文档 | 用途 | 状态 |
|------|------|------|
| **planned/PROJECT_PLAN.md** | ★ 唯一权威研究计划 | 活跃（v2，2026-05-05） |
| **planned/CHANGELOG.md** | 版本历史、评审回应 | 活跃（新建） |
| **planned/RESEARCH_AUDIT_REPORT.md** | Codex 文档审核报告 | 存档（参考） |
| `analyses/*.qmd` | 分析模块（★ 不修改） | 已有 10+ 模块 |

---

## 当前权威范围声明

**本项目的唯一权威研究计划是 `planned/PROJECT_PLAN.md`**。所有研究范围、假设、任务、统计计划、预算均以该文档为准。

**不包含**（已明确排除）：
- ❌ 跨物种研究（猪/反刍动物/水产）
- ❌ "通用平台"或"普适原理"声明
- ❌ 高影响力期刊（*Nature Microbiology*）目标
- ❌ 实证 ROI 或商业化声明（仅为情景建模）

---

## 联系与引用

**PI**: Dr. RU Jinlong  
**项目代码**: pr0117-PhageProbioticSynergy  
**GitHub**: `github.com/rujinlong/pr0117-PhageProbioticSynergy`  

**引用格式**（待补充完整）：
```
[1] RU Jinlong. pr0117-PhageProbioticSynergy: Mechanistic dissection of 
    phage-probiotic synergy in broiler chickens. GitHub repository. 2026.
```

---

## 文档管理原则

1. **一主两辅**：README（入口）+ PROJECT_PLAN（权威）+ CHANGELOG（历史）
2. **不修改 analyses/**：所有 `.qmd` 分析文件保留原样
3. **单线叙事**：避免多个文档间的范围冲突
4. **版本追踪**：所有重大变更记录到 CHANGELOG.md

---

**最后更新**：2026-05-05  
**文档版本**：README v3（整合重构版，按 Codex 建议）
