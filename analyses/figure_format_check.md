# 图表格式检查报告 — Nature Communications

**检查日期**: 2026-05-05  
**Manuscript**: 08-manuscript-draft-v2.qmd  
**渲染文件**: 08-manuscript-draft-v2.html (92 KB)

---

## 1. 图表数量统计

**Nature Communications 要求**: 最多 10 个 display items（figures + tables 合计）

| 项目 | 数量 | 限制 | 状态 |
|------|------|------|------|
| Figures 引用 | 2 (Figure 3A, Figure 7A) | ≤10 | ✅ 符合 |
| Tables 引用 | 0 | ≤10 | ✅ 符合 |
| **总计** | **2** | **≤10** | **✅ 符合** |

---

## 2. 图表引用检查

从 manuscript 中提取的图表引用：

1. **Figure 3A** (Results 3.2):  
   - 描述: In vitro time-kill assays, pathogen load reduction
   - 引用位置: Line 79
   - 统计信息: p < 0.001

2. **Figure 7A** (Results 3.4):  
   - 描述: In vivo validation, cecal Salmonella load reduction
   - 引用位置: Line 95
   - 统计信息: p < 0.001

**⚠️ 注意**: 当前 manuscript 中这些是**文本引用占位符**，尚未包含实际的图表生成代码（ggplot2 等）。

---

## 3. Nature Communications 图表格式要求

### 3.1 分辨率要求
- **最低**: 300 DPI（打印标准）
- **推荐**: 600 DPI 或更高（确保清晰）

### 3.2 文件格式
✅ **接受**:
- TIFF（推荐）
- EPS（矢量图）
- PDF（矢量图）

❌ **避免**:
- JPEG（有损压缩，不适用于照片/显微镜图）
- PNG（网页格式，不适合印刷）

### 3.3 尺寸规格
| 类型 | 宽度 | 适用场景 |
|------|------|----------|
| 单栏 | 90 mm | 小图、简单图表 |
| 1.5 栏 | 140 mm | 中等复杂度 |
| 双栏 | 180 mm | 复杂图表、多面板图 |

### 3.4 字体要求
- **字体**: Arial 或 Helvetica
- **字号**: 8-12 pt
- **一致性**: 全文字体统一

### 3.5 颜色模式
- **在线版**: RGB
- **印刷版**: CMYK（如需印刷）

---

## 4. 当前状态与待办事项

### ✅ 已完成
1. Manuscript v2 渲染成功（HTML 92 KB）
2. 图表引用数量符合限制（2/10）
3. 引用格式正确（Vancouver style, superscript）

### ⬜ 待完成
1. **添加实际图表生成代码**:
   - QMD 中的 Figure 3A, Figure 7A 需要对应的 R 代码块
   - 使用 ggplot2 生成符合格式的矢量图

2. **导出符合要求的文件**:
   ```bash
   # 示例：导出 300 DPI TIFF
   ggsave("figure3A.tiff", plot = p, dpi = 300, width = 140, height = 100, units = "mm")
   ```

3. **图表文件清单**（需准备）:
   - Figure 1: [描述] → TIFF, 300 DPI, 140 mm width
   - Figure 2: [描述] → TIFF, 300 DPI, 140 mm width
   - Figure 3A: Time-kill kinetics → TIFF, 300 DPI, 90 mm width
   - Figure 4: [描述] → TIFF, 300 DPI
   - Figure 5: [描述] → TIFF, 300 DPI
   - Figure 6: [描述] → TIFF, 300 DPI
   - Figure 7A: In vivo CFU → TIFF, 300 DPI, 90 mm width
   - Table 1: [描述] → Word/Excel 格式
   - Table 2: [描述] → Word/Excel 格式
   - Table 3: [描述] → Word/Excel 格式

4. **上传准备**:
   - 将图表文件放在 `analyses/figures/` 目录
   - 更新 QMD 中的图表引用路径
   - 确保总 display items ≤ 10

---

## 5. 验证命令

```bash
# 检查图表文件分辨率
sips -g dpiWidth -g dpiHeight analyses/figures/*.tiff

# 检查文件大小（应 <100 MB per file）
ls -lh analyses/figures/

# 重新渲染并验证
cd ~/github/rujinlong/pr0117-PhageProbioticSynergy/analyses
quarto render 08-manuscript-draft-v2.qmd --to html
```

---

**总结**: 图表数量符合要求，但需补充实际图表文件和生成代码。Nature Communications 对图表质量要求较高，建议优先准备 Figure 3A 和 Figure 7A 这两个已引用的图表。
