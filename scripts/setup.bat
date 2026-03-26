@echo off
chcp 65001 >nul
echo ============================================================
echo   RAG 知识库助手 - 快速安装脚本
echo ============================================================
echo.

REM 检查 Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 Python，请先安装 Python 3.8+
    echo 下载地址：https://www.python.org/downloads/
    pause
    exit /b 1
)

echo [1/3] 检查 Python 环境...
python -c "import sys; print(f'  Python {sys.version}')" 

echo.
echo [2/3] 安装依赖包...
echo 这可能需要几分钟 (首次需要下载约 200MB)
echo.

pip install -r requirements.txt
if errorlevel 1 (
    echo.
    echo [错误] 依赖安装失败
    echo 请检查网络连接或手动运行：pip install -r requirements.txt
    pause
    exit /b 1
)

echo.
echo [3/3] 验证安装...
python -c "from langchain_community.embeddings import HuggingFaceEmbeddings; print('  ✓ LangChain OK')" 2>nul
if errorlevel 1 (
    echo  [警告] LangChain 验证失败，但可能仍可运行
)

python -c "import chromadb; print('  ✓ ChromaDB OK')" 2>nul
if errorlevel 1 (
    echo  [警告] ChromaDB 验证失败，但可能仍可运行
)

echo.
echo ============================================================
echo   安装完成！
echo ============================================================
echo.
echo 下一步:
echo   1. 将文档放入：C:\Users\admin\.openclaw\workspace\knowledge
echo   2. 运行索引：python index_knowledge.py --knowledge-dir ../../workspace/knowledge
echo   3. 开始检索：python rag_query.py --interactive
echo.
echo 详细文档：../README.md
echo.
pause
