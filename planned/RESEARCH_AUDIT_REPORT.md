# RESEARCH_AUDIT_REPORT.md (Codex Project Documentation Audit)

**Auditor**: Codex (OpenAI) v0.125.0  
**Audit Date**: 2026-05-05  
**Project**: pr0117-PhageProbioticSynergy  
**Model**: gpt-5.4 (OpenAI)  
**Session ID**: 019df6e3-fe04-7913-aebb-9336c5c31406  

---

## 一、总体评价

**总分：5.5/10**

这两个文档各自都有可取之处，但目前**定位不清、主线不一致、维护边界不明确**。  

`README.md` 更像"旧版项目愿景 + 仓库简介"，而 `planned/RESEARCH_TASKS.md` 更像"修订后的单一物种研究方案 + 审稿回复 + 执行细案"。两者没有形成主从关系，反而形成了**双重真相（two sources of truth）**：

- `README.md` 仍在讲"动物健康平台、畜牧业/水产养殖业、公开数据挖掘优先、最终商业化"
- `RESEARCH_TASKS.md` 已收缩为"肉鸡 + 沙门氏菌 + 单一组合 + 单篇论文导向"

从科研项目管理角度看，当前最大问题不是内容不够，而是**内容过多且分布错误**：项目概述、研究方案、执行任务、统计计划、预算、伦理、审稿回复、发表策略、工具清单混在不同文档里，导致更新成本高、版本漂移快、团队成员容易误读当前真实范围。

---

## 二、优先发现的问题（按严重性排序）

### 高优先级

1. **两个文档的项目范围直接冲突**
   - [README.md:7](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/README.md:7) 写的是"动物健康平台、畜牧业/水产养殖业、公开数据挖掘优先"
   - [planned/RESEARCH_TASKS.md:19](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/planned/RESEARCH_TASKS.md:19) 已明确收缩为"broiler chickens + Salmonella + LGG + T4-like phage"
   - [planned/RESEARCH_TASKS.md:404](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/planned/RESEARCH_TASKS.md:404) 甚至明确写了"**No cross-species claims**"

2. **核心假设不一致**
   - [README.md:9](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/README.md:9) 给出单一核心假设，偏向"生态位释放"
   - [planned/RESEARCH_TASKS.md:21](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/planned/RESEARCH_TASKS.md:21) 明确写"5 个机制等权，不预先排序"
   - 这是研究叙事层面的冲突，不只是表述差异

3. **`RESEARCH_TASKS.md` 内部存在严重方法学自相矛盾**
   - [planned/RESEARCH_TASKS.md:219](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/planned/RESEARCH_TASKS.md:219) 写"48 broilers, 4 groups, n=12 birds/group"
   - [planned/RESEARCH_TASKS.md:228](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/planned/RESEARCH_TASKS.md:228) 写"12 pens, 4 groups × 3 replicates/pen, 4 birds/pen"，这意味着**每组 3 个 pen**，不是 12 个 pen
   - [planned/RESEARCH_TASKS.md:248](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/planned/RESEARCH_TASKS.md:248) 又写"12 pens/group"
   - [planned/RESEARCH_TASKS.md:485](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/planned/RESEARCH_TASKS.md:485) 统计表再次写"n=12 pens/group"
   - 这会直接影响功效分析、实验单位定义、预算和伦理审批，必须优先修正

4. **文档引用的仓库结构与实际不符**
   - `RESEARCH_TASKS.md` 多次引用 `scripts/task*.R`、`scripts/Snakefile`、`environment.yml`、`run_all.sh`
   - 但当前仓库中没有 `scripts/` 目录，也未见这些文件
   - 这会让文档从"计划"误读成"已实现流程"，降低可信度

5. **README 的"当前状态"已过时**
   - [README.md:121](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/README.md:121) 仍写"等待启动阶段1分析（公共数据集挖掘）"
   - 但仓库里已有多个 `analyses/*.qmd` 和 `.md/.pdf` 产物，且 `RESEARCH_TASKS.md` 末尾写"Ready for execution"
   - 当前状态描述与仓库现状不匹配

### 中优先级

6. **README 与计划文档的任务体系不一致**
   - README 用 10 个 qmd 模块分阶段推进
   - `RESEARCH_TASKS.md` 用 8 个任务包推进
   - `planned/` 目录里又还有 `11-17` 的 qmd 文件，形成第三套结构
   - 这会让团队无法判断"哪个编号系统才是主线"

7. **`RESEARCH_TASKS.md` 混入过多元信息，削弱主文档可读性**
   - 文件头包含模型、agent、skill、review score
   - 尾部整段"Critique Responses"、"v1→v2 changes"更像修订记录，不应长期留在主计划正文
   - 建议移入 `CHANGELOG` 或 `review-response.md`

8. **学术计划、执行 SOP、发表策略、预算、伦理、统计计划塞在同一文档**
   - 这对"归档"有利，但对"日常维护"不利
   - 每次改一处，容易牵动多处同步更新

9. **语言风格不统一**
   - `README.md` 为中文主导
   - `RESEARCH_TASKS.md` 为英文主导且带 AI 评审痕迹
   - 如果团队是中英混合协作，建议定义：对外/对内/实验执行分别用哪种语言

### 低优先级

10. **README 的仓库说明仍偏"愿景文案"，缺少最小可执行信息**
    - 缺少"本仓库当前唯一主问题是什么""当前版本的真实研究对象是什么""哪个文档是权威计划"

11. **`RESEARCH_TASKS.md` 某些统计表述不够严谨**
    - [planned/RESEARCH_TASKS.md:345](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/planned/RESEARCH_TASKS.md:345) "Post-hoc power analysis" 与标题"Prospective"不一致
    - [planned/RESEARCH_TASKS.md:497](/Volumes/ssd2t/github/rujinlong/pr0117-PhageProbioticSynergy/planned/RESEARCH_TASKS.md:497) LMM 一般不需要用 "sphericity / Greenhouse-Geisser" 这套重复测量 ANOVA 语言

---

## 三、分文档审查

## 1. `README.md` 审查

**评分：4.5/10**

### 优点
- 有清晰的项目主题和阶段式叙述
- 对新读者友好，能快速理解"这是做什么的"
- 目录结构和 quick start 对仓库入门有帮助

### 主要问题
- **定位混乱**：它既像项目主页，又像旧版研究路线图
- **范围过大且过时**：仍保留跨物种、商业化、专利、高影响力期刊等旧叙事
- **与现行计划冲突**：没有体现"范围收缩到肉鸡模型"的决定
- **重复承担了计划文档职能**：阶段计划、成果目标、商业化路线不应在 README 里展开太多
- **Current status 失真**：不符合仓库现状
- **术语和错字**：如"已有权具"应为"已有工具"

### 改进建议
- 把 README 压缩成**仓库入口文档**，只保留：
  - 项目一句话简介
  - 当前研究范围
  - 仓库结构
  - 如何运行/阅读
  - 当前状态
  - 指向权威计划文档的链接
- 删除或大幅缩短"分阶段实施计划"，改成一段"研究路线摘要"
- 不在 README 中承载商业化、专利、跨物种扩展等长周期内容
- 明确写出"当前权威范围：broiler chicken + Salmonella + LGG + T4-like phage"

---

## 2. `planned/RESEARCH_TASKS.md` 审查

**评分：6.5/10**

### 优点
- 研究问题、假设、实验任务、交付物、统计和可重复性部分相对完整
- 相比 README，科学问题收缩得更合理，研究对象更明确
- 非目标、混杂因素、发表标准、数据管理等内容体现了较强的科研项目意识

### 主要问题
- **内部数值冲突严重**：尤其是 bird / pen / group / power 四套数字不一致
- **文档过载**：主计划、审稿回复、版本变更、预算、伦理、发表策略全部堆叠
- **执行状态与仓库实现脱节**：大量引用未存在的脚本和 pipeline
- **文件名与标题不一致**：文件实际是 `RESEARCH_TASKS.md`，标题却是 `RESEARCH_TASKS_v2.md`
- **管理边界不清**：这是"研究计划书"、还是"预注册草案"、还是"项目执行手册"、还是"论文蓝图"？现在四者兼有
- **AI 元信息残留明显**：对长期项目管理帮助不大，反而增加噪声

### 改进建议
- 先修正所有样本量与实验单位
- 保留这份文档作为**主研究计划**，但删去或外移：
  - 模型/agent/skill 元信息
  - "Critique Responses"
  - "v1→v2 changes"
- 将正文收敛为 8 个核心部分：
  - Scope
  - Questions/Hypotheses
  - Study Design
  - Work Packages
  - Milestones
  - Risks/Controls
  - Statistics/Data Management
  - Resources/Ethics
- 把发表目标、预算、修订记录拆出去单独维护
- 所有"计划中的实现文件"统一标记为 `planned` 或 `to be created`，避免误导

---

## 四、两个文档之间的重复与矛盾

### 重复内容
- 项目概述
- 研究目标
- 阶段/任务安排
- 预期成果
- 商业化/转化叙事
- 论文产出预期

### 主要矛盾
- **研究范围**：平台型跨物种 vs 单一肉鸡模型
- **核心机制**：单一主假设 vs 多机制等权
- **工作起点**：公共数据挖掘优先 vs 体外机制实验优先
- **终点**：专利/商业化主线 vs AEM/mBio 论文主线
- **当前状态**：尚未开始 vs ready for execution
- **任务结构**：10 个 qmd 模块 vs 8 个 task 包
- **项目成熟度**：愿景性项目蓝图 vs 可执行方案

**结论**：这两个文档目前不是互补关系，而是**旧版路线图**和**新版收缩方案**并存。

---

## 五、整合建议：如何减少管理压力

建议采用**"一主两辅"**结构，而不是继续让两个大文档并行扩张。

### 方案

1. **README.md**
   - 只做仓库入口与导航，不再承载完整研究计划

2. **planned/PROJECT_PLAN.md**
   - 作为唯一权威研究计划
   - 包含范围、研究问题、任务、时间线、风险、统计、数据管理
   - 任何项目范围变更都只改这里

3. **planned/CHANGELOG.md** 或 `planned/REVIEW_RESPONSES.md`
   - 存放 v1→v2 变化、外部评审意见及回应
   - 不再混入主计划正文

### 可进一步拆分

如果后续实验推进很快，建议再拆一个：

- `planned/STUDY_PROTOCOL.md`
  - 只放实验设计、采样、统计、伦理、预注册要点

这样可以形成清晰边界：

- README = 给所有人看
- PROJECT_PLAN = 给项目负责人和协作者看
- STUDY_PROTOCOL = 给具体执行者和审查/预注册用
- CHANGELOG = 给版本追踪用

---

## 六、优先级排序的改进清单

### 高
- 统一项目范围，明确"当前唯一权威叙事"
- 修正 `RESEARCH_TASKS.md` 中 bird/pen/group/power 的全部数字冲突
- README 删除旧版跨物种与平台化叙事，改为链接到权威计划
- 清理计划文档中与仓库实际不存在的脚本、pipeline、文件引用，或明确标注为"待创建"
- 统一当前状态描述

### 中
- 将 `RESEARCH_TASKS.md` 中的审稿回复、版本对照、AI 工具元信息拆出
- 统一任务编号体系：只保留一套主编号
- 统一中英文术语和文档语言策略
- 将发表策略、预算、伦理放入附录或独立文档，降低主文档长度

### 低
- 优化 README 中的措辞和错字
- 精简部分重复的"重要提醒"句式
- 调整统计表述中的少量术语不严谨问题
- 统一标题命名，如 `RESEARCH_TASKS.md` 与文档内部标题一致

---

## 七、推荐的整合后文档结构（大纲）

## A. `README.md`
1. Project title
2. One-paragraph summary
3. Current scope
4. Repository structure
5. Quick start
6. Current status
7. Key documents
8. Contact / citation

## B. `planned/PROJECT_PLAN.md`
1. Executive summary
2. Scope and non-goals
3. Research questions and hypotheses
4. Study system
5. Work packages / tasks
6. Milestones and timeline
7. Risks, confounders, and controls
8. Statistical plan
9. Data management and reproducibility
10. Ethics and approvals
11. Resource needs
12. Success criteria

## C. `planned/STUDY_PROTOCOL.md`（可选）
1. Experimental design
2. Randomization and blinding
3. Sampling plan
4. Endpoints
5. Power and sample size
6. Statistical models
7. Exclusion criteria
8. Data deposition plan

## D. `planned/CHANGELOG.md`
1. Version history
2. Review comments
3. Responses
4. Scope changes
5. Pending decisions

---

## 八、最终判断

这套文档不是"写得差"，而是**版本演化后没有完成信息架构重组**。  

如果你现在继续在这两个文件上同时迭代，管理压力会越来越大，且后续最容易出问题的不是科研内容，而是：

- 团队成员对当前范围理解不一致
- 统计与实验单位被旧文本带偏
- 计划文档和实际仓库实现继续漂移

最合理的下一步不是继续补内容，而是先做一次**文档主从关系重构**：  

**README 退回导航入口，RESEARCH_TASKS 升级为唯一权威计划，再把修订史和执行细节拆出去。**

如果你愿意，我下一步可以直接帮你起草一版**整合后的 `README.md` 结构**和**`planned/PROJECT_PLAN.md` 骨架**。

---

**End of Audit Report**
