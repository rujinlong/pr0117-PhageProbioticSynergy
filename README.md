# pr0117-PhageProbioticSynergy

噬菌体-益生菌协同作用平台用于动物健康研究（Phage-Probiotic Synergy Platform for Animal Health）

## 项目概述

本项目采用生物信息学优先策略，系统分析噬菌体与益生菌在动物肠道中的协同作用机制，目标是为畜牧业/水产养殖业提供抗生素替代方案。项目结合公开数据集挖掘、噬菌体-宿主预测、益生菌靶点识别等方法，最终在中国完成动物实验验证与商业化准备。

**核心假设**：噬菌体通过选择性清除与益生菌竞争肠道定植位点的病原体，从而增强益生菌的定植效果，两者联用优于单独干预。

## 分阶段实施计划

### 阶段1：2个月内（纯生物信息学分析，快速出成果）

**目标**：利用公开数据集完成初步分析，生成可供基金申请使用的初步数据

**课题方案**：
1. **公共数据集挖掘** (`01-public-data-mining.qmd`)
   - 收集动物肠道宏基因组数据集（禽类、水产等）
   - 整理已知噬菌体、益生菌、病原体数据
   - 构建初始分析数据库

2. **噬菌体-宿主预测** (`02-phage-host-prediction.qmd`)
   - 使用现有工具（vConTACT3、 phage-host prediction tools）预测噬菌体-病原体关系
   - 识别针对主要病原体（如 *Clostridium perfringens*）的裂解性噬菌体

3. **益生菌靶点识别** (`03-probiotic-target-identification.qmd`)
   - 分析益生菌（如 *Lactobacillus*、*Bifidobacterium*）的定植需求
   - 识别与病原体竞争的生态位和受体

4. **协同效应评分** (`04-synergy-scoring.qmd`)
   - 开发评分系统评估噬菌体-益生菌配对效果
   - 生成初步的噬菌体-益生菌优选组合列表

**预期成果**：1篇初步数据分析报告，1份基金申请附件（preliminary data）

---

### 阶段2：3个月内（深入分析与代理菌株策略）

**目标**：深化机制理解，解决"代理菌株"问题

**课题方案**：
5. **代理菌株分析** (`05-proxy-strain-analysis.qmd`)
   - 由于无法获取中国本地病原体菌株，识别可用的国际参考菌株
   - 评估代理菌株与本地菌株的基因组相似性
   - 建立代理验证 → 本地应用的桥梁

6. **分子机制探索** (`06-mechanism-exploration.qmd`)
   - 分析噬菌体清除病原体后的受体景观变化
   - 探索代谢变化、免疫调节等分子机制
   - 整合多组学数据进行系统分析

**预期成果**：1篇研究论文初稿（biinformatics-focused），代理菌株验证方案

---

### 阶段3：6个月内（实验验证与完整项目）

**目标**：在德国完成实验室验证，形成相对完整的项目

**课题方案**：
7. **实验设计** (`07-experimental-design.qmd`)
   - 基于生信分析结果设计湿实验验证方案
   - 在德国实验室进行噬菌体分离、纯化、宿主范围验证
   - 益生菌定植实验（体外模型）

8. **论文撰写** (`08-manuscript-draft.qmd`)
   - 整合生物信息学与初步实验数据
   - 撰写完整研究论文（目标期刊：高影响力期刊）
   - 准备专利申请材料

**预期成果**：1篇完整研究论文提交，1-2项专利申请，德国验证实验完成

---

### 阶段4：12个月内（动物实验与商业化准备）

**目标**：在中国完成动物实验，推进商业化

**课题方案**：
9. **中国动物实验数据分析** (`09-china-trial-analysis.qmd`)
   - 与中国合作机构对接，开展正式动物实验
   - 分析动物实验数据（功效、安全性、经济性）
   - 优化噬菌体-益生菌配方

10. **商业化分析** (`10-commercialization-analysis.qmd`)
    - 市场分析（竞品分析：青岛诺安百特、CJ BIO等）
    - 监管合规与知识产权策略
    - 商业模式设计与合作洽谈

**预期成果**：动物实验成功，商业化可行性报告，产学研合作协议

---

## Quick start

```r
qproj::proj_use_workflow("analyses")
qproj::use_qmd("01-public-data-mining", "analyses")
```

## Project structure

- `analyses/`: qproj 分析模块（按阶段编号）
  - `01-public-data-mining.qmd`: 公共数据集挖掘
  - `02-phage-host-prediction.qmd`: 噬菌体-宿主预测
  - `03-probiotic-target-identification.qmd`: 益生菌靶点识别
  - `04-synergy-scoring.qmd`: 协同效应评分
  - `05-proxy-strain-analysis.qmd`: 代理菌株分析
  - `06-mechanism-exploration.qmd`: 分子机制探索
  - `07-experimental-design.qmd`: 实验设计
  - `08-manuscript-draft.qmd`: 论文撰写
  - `09-china-trial-analysis.qmd`: 中国动物实验数据分析
  - `10-commercialization-analysis.qmd`: 商业化分析
- `analyses/data/`: 数据目录（00-raw/ 原始数据，其他为各模块输出）
- `DESCRIPTION`: R 包元数据

## Current status

项目初始化完成，等待启动阶段1分析（公共数据集挖掘）

## 关键资源与工具

- **已有权具**：ViroProfiler、TPD (Therapeutic Phage Discovery)、ArchaealDefenseAtlas
- **标准流程**：宏基因组组装、病毒contig预测、去冗余、GTDB分类、噬菌体-宿主预测、vConTACT3网络分析
- **合作资源**：
  - 德国湿实验室组（噬菌体分离、验证）
  - 中国合作机构（动物实验、临床试验）
  - 附属公司（商业化开发）

## Citations

待补充
