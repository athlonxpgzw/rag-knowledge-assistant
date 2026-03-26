# RAG 知识库检索助手

基于向量数据库的智能知识库检索系统，支持语义理解和多格式文档处理。

## 特性

- 🧠 **语义检索** - 理解问题意图，不仅限于关键词匹配
- 📄 **多格式支持** - PDF、Word、Excel、Markdown、TXT
- 🎯 **精准溯源** - 回答标注来源文件和位置
- ⚡ **快速检索** - <1 秒返回结果 (5000+ 文档片段)
- 🔧 **灵活配置** - 可调整分块、阈值、Embedding 模型

## 快速开始

### 1. 安装依赖

```bash
cd scripts
pip install -r requirements.txt
```

### 2. 准备知识库

将文档放入 `knowledge` 目录：

```
knowledge/
├── company-policies/
│   ├── 员工手册.pdf
│   └── 考勤制度.docx
├── product-docs/
│   └── API 文档.md
└── technical/
    └── 安全规范.pdf
```

### 3. 创建索引

```bash
python index_knowledge.py --knowledge-dir ../../workspace/knowledge --output-dir ../../workspace/vectorstore
```

### 4. 开始检索

```bash
# 交互模式
python rag_query.py --interactive

# 或直接问 AI 助手
"帮我查一下公司的年假政策"
```

## 目录结构

```
rag-skill/
├── SKILL.md              # Skill 主文件
├── README.md             # 使用说明
├── rag-config.yaml       # 配置文件模板
├── scripts/
│   ├── index_knowledge.py  # 索引构建脚本
│   ├── rag_query.py        # 向量检索脚本
│   └── requirements.txt    # Python 依赖
├── references/
│   ├── pdf_reading.md      # PDF 处理指南
│   ├── excel_reading.md    # Excel 读取指南
│   └── excel_analysis.md   # Excel 分析方法
└── knowledge/            # 示例知识库 (可选)
```

## 核心原理

```
用户提问 → Embedding 向量化 → 向量相似度检索 → 返回相关片段 → AI 生成回答
                                    ↓
                              标注来源引用
```

## 配置说明

编辑 `rag-config.yaml` 调整参数：

```yaml
rag:
  retrieval:
    top_k: 5              # 返回结果数量
    score_threshold: 0.6   # 相似度阈值
  
  chunking:
    chunk_size: 500       # 分块大小
    chunk_overlap: 50     # 重叠字数
  
  embedding:
    model: BAAI/bge-m3    # 中文推荐
```

## 常见问题

**Q: 检索结果为空？**
- 检查向量库是否创建成功
- 降低阈值：`--score-threshold 0.4`
- 确认文档已正确索引

**Q: 回答不准确？**
- 调整分块参数 (减小 chunk_size)
- 更换 Embedding 模型
- 优化文档质量和结构

**Q: 索引速度慢？**
- 首次索引需要下载模型 (~2GB)
- 后续索引会快很多
- 可使用 GPU 加速 (如有)

## 技术栈

- **向量数据库**: Chroma
- **Embedding 模型**: BAAI/bge-m3 (中文优化)
- **文档处理**: LangChain + pypdf + unstructured
- **框架**: OpenClaw Skills

## 许可证

MIT License
