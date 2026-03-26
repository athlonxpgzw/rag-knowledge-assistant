@echo off
chcp 65001 >nul
echo ============================================================
echo   RAG 知识库 - 构建索引
echo ============================================================
echo.

REM 设置知识库路径
set KNOWLEDGE_DIR=..\..\workspace\knowledge
set VECTORSTORE_DIR=..\..\workspace\vectorstore

echo 知识库目录：%KNOWLEDGE_DIR%
echo 向量库输出：%VECTORSTORE_DIR%
echo.

REM 检查知识库是否存在
if not exist "%KNOWLEDGE_DIR%" (
    echo [错误] 知识库目录不存在：%KNOWLEDGE_DIR%
    echo.
    echo 请先创建目录并放入文档:
    echo   mkdir "%KNOWLEDGE_DIR%"
    echo   copy 你的文档.pdf "%KNOWLEDGE_DIR%"
    pause
    exit /b 1
)

REM 检查知识库是否有文件
dir /b "%KNOWLEDGE_DIR%" >nul 2>&1
if errorlevel 1 (
    echo [警告] 知识库目录为空，请先放入文档
    echo 支持的格式：.pdf, .md, .txt, .docx, .xlsx
    pause
)

echo.
echo 开始构建索引...
echo 这可能需要几分钟 (取决于文档数量)
echo.

python index_knowledge.py --knowledge-dir "%KNOWLEDGE_DIR%" --output-dir "%VECTORSTORE_DIR%" %*

if errorlevel 1 (
    echo.
    echo [错误] 索引构建失败
    pause
    exit /b 1
)

echo.
echo ============================================================
echo   索引构建完成！
echo ============================================================
echo.
echo 现在可以:
echo   1. 直接向 AI 助手提问
echo   2. 运行测试：python rag_query.py --interactive
echo.
pause
