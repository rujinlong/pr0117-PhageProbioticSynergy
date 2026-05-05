# PhageProbioticSynergy 项目经验报告

**项目**: pr0117-PhageProbioticSynergy  
**时间**: 2026-05-04 至 2026-05-05  
**目的**: 记录项目全流程、遇到的问题及解决方案，为未来类似项目提供标准工作流程和避坑指南。

---

## 一、项目概述

### 1.1 项目目标
研究噬菌体-益生菌协同作用机制，通过生物信息学分析指导实验设计，最终产出可发表的 manuscript。

### 1.2 技术栈
- **项目管理**: qproj (R/Quarto 项目框架)
- **文档系统**: Quarto Markdown (QMD)
- **版本控制**: Git + GitHub
- **渲染工具**: Quarto CLI
- **分析语言**: R (tidyverse, qproj, here)
- **目标期刊**: AEM/mBio 级别

---

## 二、完整工作流程（标准流程）

### 阶段 1: 项目初始化

```bash
# 1. 创建项目目录（所有项目放在 ~/github/rujinlong/ 下）
cd ~/github/rujinlong/
mkdir pr0117-PhageProbioticSynergy
cd pr0117-PhageProbioticSynergy

# 2. 初始化 qproj 项目
R -e "qproj::proj_create('PhageProbioticSynergy')"

# 3. 初始化 Git
git init
git add -A
git commit -m "Initial commit: qproj setup"
git remote add origin git@github.com:rujinlong/pr0117-PhageProbioticSynergy.git
git push -u origin main
```

**关键点**:
- ✓ 项目必须放在 `~/github/rujinlong/` 目录下
- ✓ 使用 qproj 框架管理分析模块
- ✓ 首次提交包括完整的 qproj 结构

---

### 阶段 2: 分析模块创建

#### 2.1 标准 QMD 文件结构

每个分析模块（01-10）遵循相同的 QMD 结构：

```r
---
title: "模块标题"
params:
  name: "XX-module-name"
---

# 模块标题

## Setup

```{r}
# 注意：如果 YAML 中定义了 params，不要在 R chunk 中手动覆盖 params <- list(...)，否则会导致 locked binding 错误
here::i_am(paste0(params$name, ".qmd"), uuid = "uuid-here")

qproj::proj_create_dir_target(params$name)
path_target <- qproj::proj_path_target(params$name)() # 注意：v0.1.5+ 需要加括号调用返回的函数
path_source <- qproj::proj_path_source(params$name)

# 读取上游数据
path_upstream <- qproj::proj_path_source("upstream-module")
```

## Load Packages

```{r}
library(tidyverse)
library(here)
library(qproj)
# 其他需要的包
```

## 分析章节

### 1.1 第一节

```{r}
# 分析代码
```

---

#### 2.2 创建分析模块的顺序

1. **01-public-data-mining.qmd** - 公共数据挖掘
2. **02-phage-host-prediction.qmd** - 噬菌体-宿主预测
3. **03-probiotic-target-identification.qmd** - 益生菌靶点识别
4. **04-synergy-scoring.qmd** - 协同作用评分
5. **05-proxy-strain-analysis.qmd** - 替代菌株分析
6. **06-mechanism-exploration.qmd** - 机制探索
7. **07-experimental-design.qmd** - 实验设计
8. **08-manuscript-draft-v2.qmd** - 手稿撰写（唯一渲染为 PDF 的模块）
9. **09-china-trial-analysis.qmd** - 中国试验分析
10. **10-commercialization-analysis.qmd** - 商业化分析

**关键点**:
- ✓ 每个模块有唯一的 `uuid`
- ✓ 使用 `qproj::path_source()` 读取上游模块数据
- ✓ 使用 `here::i_am()` 设置文件路径上下文
- ✓ **Chunk header 使用 `{r}` 格式，不要添加 `#| label:`**（避免 duplicated labels 错误）

---

### 阶段 3: 渲染策略（重要！）

#### 3.1 渲染规则

**用户工作风格**：
- ✓ **所有 QMD 文件** → 渲染为 **Markdown** (默认格式)
- ✓ **只有 Manuscript (08)** → 渲染为 **Markdown + PDF**

#### 3.2 渲染命令

```bash
cd ~/github/rujinlong/pr0117-PhageProbioticSynergy/analyses

# 渲染所有 QMD 为 Markdown（默认）
for f in *.qmd; do
  quarto render "$f" --to markdown
done

# 单独渲染 Manuscript 为 PDF
quarto render 08-manuscript-draft-v2.qmd --to pdf
```

**关键点**:
- ✓ 不要批量渲染 PDF（浪费时间，没必要）
- ✓ 只有手稿需要 PDF 格式用于投稿
- ✓ 其他模块的 Markdown 用于 Notion 知识库整合

---

### 阶段 4: 迭代与修改

#### 4.1 修改 QMD 文件的正确方法

**❌ 禁止操作**（会导致文件损坏）：
```r
# 不要这样做！
read_file("analyses/XX-module.qmd")  # 返回带行号的内容 "1|content"
write_file("analyses/XX-module.qmd", content)  # 写入后文件被污染
```

**✓ 正确操作**：
```bash
# 方法 1: 用命令行工具直接编辑
sed -i '' 's/old_pattern/new_pattern/g' analyses/XX-module.qmd

# 方法 2: 用 git 恢复原始版本
git checkout HEAD -- analyses/XX-module.qmd

# 方法 3: 查看历史版本
git show <commit>:<file.qmd> > analyses/XX-module.qmd
```

#### 4.2 常见修改场景

**场景 1: 修改 chunk 内容**
```bash
# 直接用 sed 或编辑器修改，不要用 read_file + write_file
vim analyses/XX-module.qmd
```

**场景 2: 修复 duplicated labels 错误**
```bash
# 移除所有 #| label: 行（chunk header 已有 label）
sed -i '' '/^[[:space:]]*#| label:/d' analyses/*.qmd
```

**场景 3: 重新渲染单个模块**
```bash
quarto render analyses/XX-module.qmd --to markdown
git add analyses/
git commit -m "Update XX-module analysis"
git push origin main
```

---

### 阶段 5: 版本控制与推送

#### 5.1 提交规范

```bash
# 检查状态
git status

# 添加修改
git add analyses/  # 只添加 analyses 目录
# 或添加特定文件
git add analyses/XX-module.qmd analyses/XX-module.md

# 提交（写明修改内容）
git commit -m "描述性提交信息，包含：
- 修改了什么
- 为什么修改
- 解决了什么问题"

# 推送
git push origin main
```

#### 5.2 提交信息模板

**好例子**:
```
Fix 07-experimental-design: Remove duplicated labels

- Removed '#| label:' lines causing Quarto render errors
- Re-rendered to Markdown
- Verified chunk headers use '{r}' format without pipe labels
```

**坏例子**:
```
fix
update
changes
```

---

## 三、遇到的问题及解决方案

### 问题 1: QMD 文件被行号污染（最严重！）

**症状**:
- Quarto 渲染失败
- QMD 文件中出现 `1|params <- list(...)` 这样的行
- Chunk 标记变成 `\{r\}` 转义格式

**根本原因**:
- `read_file` 工具返回内容时**带行号**（格式：`1|content`）
- 如果将该内容通过 `write_file` 写回 QMD 文件，行号被注入源文件
- 污染后的文件被提交到 Git，导致后续所有操作都基于损坏的文件

**错误操作示例**:
```r
# ❌ 这是错误的！
content <- read_file("analyses/07-experimental-design.qmd")
# content 现在包含: "1|params <- list(...)", "2|here::i_am(...)", etc.
write_file("analyses/07-experimental-design.qmd", content)
# 文件现在被永久污染
```

**解决方案**:
```bash
# 1. 从 Git 历史恢复干净版本（如果历史版本也脏了，跳过此步）
git checkout HEAD -- analyses/*.qmd

# 2. 用 sed 批量移除行号
sed -i '' 's/^[[:space:]]*[0-9]*|//' analyses/*.qmd

# 3. 修复转义的 chunk 标记
sed -i '' 's/\\{r/\{r/g; s/\\}/}/g' analyses/*.qmd

# 4. 验证修复
grep '^[0-9]*|' analyses/*.qmd  # 应该无输出
grep '\\{r' analyses/*.qmd      # 应该无输出

# 5. 重新渲染
for f in analyses/*.qmd; do
  quarto render "$f" --to markdown
done

# 6. 提交修复
git add analyses/
git commit -m "CRITICAL FIX: Repair QMD file corruptions from read_file line numbers"
git push origin main
```

**教训**:
> **永远不要**用 `read_file` + `write_file` 操作 QMD 文件！
> 使用命令行工具（sed/grep/git）或直接在终端编辑。

---

### 问题 2: Duplicated chunk labels 错误

**症状**:
```
ERROR: Duplicated label 'setup' in chunk 'setup'
```

**原因**:
- Chunk header 已有 label：````{r setup}```
- Pipe comment 又设置了 label：`#| label: setup`
- Quarto 认为这是重复的

**错误示例**:
````markdown
```{r setup}`
#| label: setup  # ❌ 重复！
params <- list(name = "07-experimental-design")
```
````

**正确示例**:
````markdown
```{r setup}`
params <- list(name = "07-experimental-design")
```
````

**解决方案**:
```bash
# 移除所有 #| label: 行
sed -i '' '/^[[:space:]]*#| label:/d' analyses/*.qmd

# 验证
grep '#| label:' analyses/*.qmd  # 应该无输出
```

---

### 问题 3: Quarto 渲染失败（隐式错误）

**症状**:
- `quarto render` 报错但不明确
- 渲染卡住或产生空输出

**排查步骤**:
```bash
# 1. 检查 QMD 文件语法
quarto check

# 2. 逐个渲染，定位问题文件
for f in analyses/*.qmd; do
  echo "Testing: $f"
  quarto render "$f" --to markdown 2>&1 | head -20
done

# 3. 检查 R 代码是否有语法错误
R -e "parse('analyses/XX-module.qmd')"

# 4. 查看 Quarto 日志
cat ~/.quarto/log/*.log
```

---

### 问题 4: Git 历史也被污染

**症状**:
- 即使 `git checkout HEAD -- file.qmd`，文件依然是脏的
- 发现 Git 历史中的最新版本本身就包含污染

**原因**:
- 污染文件被提交到 Git
- `git checkout` 只是恢复到最近的 commit，而那个 commit 本身就是脏的

**解决方案**:
```bash
# 方案 1: 找到干净的历史版本
git log --oneline analyses/XX-module.qmd
git show <earlier-commit>:analyses/XX-module.qmd > analyses/XX-module.qmd

# 方案 2: 手动修复（如果所有历史都脏了）
sed -i '' 's/^[[:space:]]*[0-9]*|//' analyses/XX-module.qmd
sed -i '' 's/\\{r/\{r/g' analyses/XX-module.qmd

# 方案 3: 重写 Git 历史（谨慎！）
git rebase -i <commit-before-pollution>
# 在交互式 rebase 中编辑污染的 commit
```

---

### 问题 5: qproj 包 API 破坏性变更

**症状**:
- 错误信息：`Error: 'path_target' is not an exported object from 'namespace:qproj'`
- 渲染时提示找不到函数。

**原因**:
- `qproj` 包从 v0.1.5 开始进行了 API 重构：
  1. `path_target` 重命名为 `proj_path_target`。
  2. `path_source` 重命名为 `proj_path_source`。
  3. **关键差异**：`proj_path_target(name)` 现在返回的是一个**函数工厂**，必须再次调用（即 `proj_path_target(name)()`）才能获得路径字符串。

**解决方案**:
```r
# 旧版代码
# path_target <- qproj::path_target(params$name)

# 新版代码 (v0.1.5+)
path_target <- qproj::proj_path_target(params$name)()
path_source <- qproj::proj_path_source(params$name)
```

---

### 问题 6: Quarto 中的 params 锁定绑定 (Locked Binding)

**症状**:
- 渲染失败，错误信息：`Error: cannot change value of locked binding for 'params'`

**原因**:
- 在 Quarto 中，如果在 YAML header 中定义了 `params:`，Quarto 会在执行 R 代码前自动创建并**锁定** `params` 对象。
- 如果在 R setup chunk 中再次尝试 `params <- list(...)` 进行手动赋值，R 会抛出锁定绑定错误。

**解决方案**:
- 移除 R chunk 中的手动赋值行。
- 确保 YAML header 中的 `params` 定义正确。

---

### 问题 7: 缺少数据/脚本子目录导致写入失败

**症状**:
- 错误信息：`Cannot open file for writing: .../scripts/download_sra.sh`

**原因**:
- `qproj::proj_create_dir_target(params$name)` 只会创建基础的目标目录（如 `data/XX-module/`）。
- 如果后续代码尝试向 `scripts/` 或 `raw/` 等子目录写入文件，而这些子目录尚未创建，则会导致失败。

**解决方案**:
- 在 setup chunk 中显式创建所有需要的子目录：
```r
qproj::proj_create_dir_target(params$name)
dir.create(file.path(path_target, "scripts"), showWarnings = FALSE)
dir.create(file.path(path_target, "raw"), showWarnings = FALSE)
```

---

## 四、用户工作风格总结（AI 学习要点）

### 4.1 项目管理风格

1. **目录规范**:
   - 所有项目放在 `~/github/rujinlong/` 下
   - 项目命名：`prXXXX-ProjectName`

2. **框架选择**:
   - 科研计算项目使用 **qproj** (R/Quarto)
   - 不使用 Snakemake/Nextflow 等流程管理工具（偏好 R 生态）

3. **版本控制**:
   - 每个功能完成立即提交
   - 提交信息详细，包含修改原因和解决方案
   - 使用 GitHub 作为远程备份

---

### 4.2 分析迭代风格

1. **模块化分析**:
   - 每个分析步骤一个 QMD 文件（01, 02, 03...）
   - 模块间通过 `qproj::path_source()` 传递数据
   - 上游模块完成后才能开始下游模块

2. **渲染策略**:
   - **所有模块** → Markdown（用于 Notion 知识库）
   - **只有手稿** → PDF（用于投稿）
   - 不浪费时间渲染不必要的格式

3. **修改流程**:
   - 发现问题 → 用命令行工具修复 → 重新渲染 → 提交推送
   - 不在 RStudio/VS Code 中手动编辑（避免忘记提交）
   - 让 AI 通过终端命令完成所有操作

---

### 4.3 技术偏好（避坑指南）

1. **QMD 文件操作**:
   - ❌ 禁止：`read_file` + `write_file`（会注入行号）
   - ✓ 正确：sed/grep/git 命令行工具

2. **Chunk 格式**:
   - ✓ 使用：````{r chunk-name}```
   - ❌ 避免：`#| label: chunk-name`（导致 duplicated labels）

3. **依赖管理**:
   - 使用 R 的 `renv` 或 Python 的 `uv`/`conda`
   - 不在 conda 环境中使用 `pip install --user`

4. **文件路径**:
   - 使用 `here::here()` 和 `qproj::path_source/target()`
   - 不使用绝对路径或 `../` 相对路径

---

### 4.4 沟通风格

1. **消息偏好**:
   - 减少频繁短消息
   - 功能完成后只发一条总结
   - 不发中间过程（如"现在运行XX"）

2. **技术讨论**:
   - 直接给出解决方案，不过度解释
   - 遇到错误直接修复，不要等待确认
   - 提供可执行的命令，不要只说理论

3. **文档语言**:
   - 正文：简体中文
   - 专业术语：保留英文（phage, virome, synergy 等）
   - 代码/文件名：始终英文

---

## 五、给未来 AI 的改进建议请求

### 5.1 需要审核的方面

1. **QMD 文件管理**:
   - 是否有更安全的方法操作 QMD 文件？
   - 能否在 AI 工具层面添加 QMD 文件保护机制？

2. **错误处理**:
   - 遇到渲染错误时，是否有更系统的排查流程？
   - 能否自动检测并修复常见的 QMD 错误？

3. **工作流程**:
   - 当前的模块化分析流程是否合理？
   - 是否有更高效的渲染策略（如增量渲染）？

4. **版本控制**:
   - 提交信息是否足够规范？
   - 是否需要添加 pre-commit hooks 来防止污染文件被提交？

---

### 5.2 希望 AI 审核者回答的问题

1. **针对 QMD 污染问题**:
   - 除了"不用 read_file + write_file"，还有其他预防措施吗？
   - 能否在 AI 工具中添加一个"QMD 安全检查"功能？

2. **针对工作流程**:
   - 当前的渲染策略（所有 Markdown + 手稿 PDF）是否合理？
   - 是否有必要添加自动化测试（如渲染后自动检查输出）？

3. **针对错误处理**:
   - 遇到类似问题时，是否有更快速的定位和修复方法？
   - 能否建立一个"常见 QMD 错误速查表"？

---

## 六、附录：快速参考命令

### A1: 修复污染的 QMD 文件

```bash
# 一键修复脚本
cat > /tmp/fix_qmd.sh << 'EOF'
#!/bin/bash
for f in analyses/*.qmd; do
  echo "Fixing: $f"
  sed -i '' 's/^[[:space:]]*[0-9]*|//' "$f"           # 移除行号
  sed -i '' 's/\\{r/\{r/g; s/\\}/}/g' "$f"           # 修复转义
  sed -i '' '/^[[:space:]]*#| label:/d' "$f"           # 移除重复 labels
done
EOF
chmod +x /tmp/fix_qmd.sh
/tmp/fix_qmd.sh
```

### A2: 渲染所有 QMD

```bash
cd ~/github/rujinlong/pr0117-PhageProbioticSynergy/analyses
for f in *.qmd; do
  echo "Rendering: $f"
  quarto render "$f" --to markdown
done
quarto render 08-manuscript-draft-v2.qmd --to pdf
```

### A3: 检查 QMD 完整性

```bash
cd ~/github/rujinlong/pr0117-PhageProbioticSynergy/analyses

# 检查行号污染
grep -l '^[0-9]*|' *.qmd && echo "❌ Found line numbers" || echo "✓ No line numbers"

# 检查转义 chunk
grep -l '\\{r' *.qmd && echo "❌ Found escaped chunks" || echo "✓ No escaped chunks"

# 检查重复 labels
grep -l '#| label:' *.qmd && echo "❌ Found duplicated labels" || echo "✓ No duplicated labels"

# 检查旧版 qproj API 
grep -E 'qproj::path_(target|source)' *.qmd && echo "❌ Found old qproj API" || echo "✓ qproj API is up to date"
```

---

## 七、总结

本项目的主要教训是：**AI 工具的文件操作 API 可能会意外污染源文件**。

关键要点：
1. ✅ 用命令行工具操作 QMD，不用 `read_file` + `write_file`
2. ✅ 提交前验证文件完整性
3. ✅ 保持模块化分析，清晰的数据流
4. ✅ 渲染策略：所有 Markdown + 手稿 PDF
5. ✅ 详细记录问题和解决方案，便于未来项目参考

希望这份报告能帮助未来的 AI 工具避免类似错误，并学习用户的项目管理工作风格。

---

**报告生成时间**: 2026-05-05  
**项目状态**: ✅ 所有问题已修复，QMD 文件已清理，重新渲染完成并推送到 GitHub
