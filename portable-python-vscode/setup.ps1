# ============================================================
# Portable Python + VS Code セットアップスクリプト
# ============================================================

$ErrorActionPreference = "Stop"
$ProgressPreference = 'SilentlyContinue'  # 高速化

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " Portable Python + VS Code 環境セットアップ開始" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# ============================================================
# 1. ポータブルPythonのダウンロード・展開
# ============================================================

Write-Host "[1/5] ポータブルPythonをダウンロード中..." -ForegroundColor Green

# Python 3.12.0 Embeddable版（64bit）
$pythonUrl = "https://www.python.org/ftp/python/3.12.9/python-3.12.9-embed-amd64.zip"
$pythonZip = "python.zip"
$pythonDir = ".\python"

if (Test-Path $pythonDir) {
    Write-Host "  ○ Pythonは既に存在します。スキップします。" -ForegroundColor Yellow
} else {
    Write-Host "  ダウンロード中: $pythonUrl"
    Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonZip
    
    Write-Host "  展開中..."
    Expand-Archive -Path $pythonZip -DestinationPath $pythonDir -Force
    Remove-Item $pythonZip
    
    Write-Host "  Pythonのダウンロード・展開完了" -ForegroundColor Green
}

# ============================================================
# python312._pth の修正（pip有効化のため）
# ============================================================

Write-Host "  python312._pth を修正中..."
$pthFile = Join-Path $pythonDir "python312._pth"

if (Test-Path $pthFile) {
    $content = Get-Content $pthFile
    $newContent = $content -replace '^#import site', 'import site'
    $newContent | Set-Content $pthFile -Encoding ASCII
    Write-Host "  python312._pth の修正完了" -ForegroundColor Green
}

Write-Host ""

# ============================================================
# 2. pipコマンドのインストール
# ============================================================

Write-Host "[2/5] pipをインストール中..." -ForegroundColor Green

$getPipUrl = "https://bootstrap.pypa.io/get-pip.py"
$getPipFile = "get-pip.py"

Write-Host "  get-pip.py をダウンロード中..."
Invoke-WebRequest -Uri $getPipUrl -OutFile $getPipFile

Write-Host "  pip をインストール中..."
& ".\python\python.exe" $getPipFile

Write-Host "  pipのバージョン確認:"
& ".\python\python.exe" -m pip --version

Write-Host "  pipのインストール完了" -ForegroundColor Green
Write-Host ""

# ============================================================
# 3. Pythonライブラリのインストール
# ============================================================

Write-Host "[3/5] Pythonライブラリをインストール中..." -ForegroundColor Green
Write-Host "  （この処理には5~10分かかる場合があります）" -ForegroundColor Yellow
Write-Host ""

# PATHの設定
$env:PATH = "$PWD\python;$PWD\python\Scripts;$env:PATH"

# pipのアップグレード
Write-Host "  pip をアップグレード中..."
& ".\python\python.exe" -m pip install --upgrade pip

# wheelのインストール
Write-Host "  wheel をインストール中..."
& ".\python\python.exe" -m pip install wheel

# コード整形・静的解析ツール
Write-Host "  [1/10] コード整形・解析ツールをインストール中..."
& ".\python\python.exe" -m pip install black pylint flake8 autopep8 isort mypy

# ユーティリティ系
Write-Host "  [2/10] ユーティリティをインストール中..."
& ".\python\python.exe" -m pip install requests python-dotenv tqdm colorama

# 数値・統計・可視化
Write-Host "  [3/10] 数値計算・可視化ライブラリをインストール中..."
& ".\python\python.exe" -m pip install --only-binary :all: numpy pandas matplotlib scipy seaborn

# Web開発
Write-Host "  [4/10] Web開発ライブラリをインストール中..."
& ".\python\python.exe" -m pip install flask fastapi uvicorn beautifulsoup4 lxml

# Excel・画像・テスト
Write-Host "  [5/10] Excel・画像処理・テストライブラリをインストール中..."
& ".\python\python.exe" -m pip install openpyxl pillow pyyaml pytest faker

# Jupyter Notebook
Write-Host "  [6/10] Jupyter Notebookをインストール中..."
& ".\python\python.exe" -m pip install notebook jupyterlab ipykernel ipywidgets

# Jupyter LSP
Write-Host "  [7/10] Jupyter LSPをインストール中..."
& ".\python\python.exe" -m pip install jupyterlab-lsp python-lsp-server

# グラフ・Excel出力拡張
Write-Host "  [8/10] グラフ・Excel出力ライブラリをインストール中..."
& ".\python\python.exe" -m pip install plotly xlsxwriter

# streamlit 関係
Write-Host "  [9/10] グラフ・streamlit関連ライブラリをインストール中..."
& ".\python\python.exe" -m pip install streamlit requests

# その他（settings.jsonで参照されているもの）
Write-Host "  [10/10] その他必要なライブラリをインストール中..."
& ".\python\python.exe" -m pip install debugpy

# tkinputのインストール
Write-Host "  kbinput をインストール中..."
& ".\python\python.exe" -m pip install https://k-webs.jp/lib/python/kbinput-1.0.0-py3-none-any.whl

Write-Host "  Pythonライブラリのインストール完了" -ForegroundColor Green
Write-Host ""

# ============================================================
# 4. VS Codeのダウンロード・展開
# ============================================================

Write-Host "[4/5] VS Code Portableをダウンロード中..." -ForegroundColor Green
$vscodeUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-archive"
			 
$vscodeZip = "vscode.zip"
$vscodeDir = ".\vscode"

if (Test-Path $vscodeDir) {
    Write-Host "  ○ VS Codeは既に存在します。スキップします。" -ForegroundColor Yellow
} else {
    Write-Host "  ダウンロード中（サイズが大きいため時間がかかります）..."
    Invoke-WebRequest -Uri $vscodeUrl -OutFile $vscodeZip
    
    Write-Host "  展開中..."
    Expand-Archive -Path $vscodeZip -DestinationPath $vscodeDir -Force
    Remove-Item $vscodeZip
    
    # ポータブルモード有効化
    Write-Host "  ポータブルモードを有効化中..."
    New-Item -Path "$vscodeDir\data" -ItemType Directory -Force | Out-Null
    
    Write-Host "  VS Codeのダウンロード・展開完了" -ForegroundColor Green
}

Write-Host ""

# ============================================================
# 5. VS Code拡張機能のインストール
# ============================================================

Write-Host "[5/5] VS Code拡張機能をインストール中..." -ForegroundColor Green

$extFile = ".\config\cleanExtentions.txt"

if (Test-Path $extFile) {
    $extensions = Get-Content $extFile | Where-Object { $_.Trim() -ne "" }
    
    $count = 1
    $total = $extensions.Count
    
    foreach ($ext in $extensions) {
        Write-Host "  [$count/$total] インストール中: $ext"
        & ".\vscode\bin\code.cmd" --install-extension $ext --force
        $count++
    }
    
    Write-Host "  拡張機能のインストール完了" -ForegroundColor Green
} else {
    Write-Host "  警告: cleanExtentions.txt が見つかりません" -ForegroundColor Yellow
}

Write-Host ""

# ============================================================
# 5.5 VS Code 日本語化設定を追加
# ============================================================

Write-Host "VS Code の表示言語を日本語に設定中..." -ForegroundColor Green

$localeDir = ".\vscode\data\user-data\User"
$localeFile = Join-Path $localeDir "locale.json"

# ディレクトリが存在しない場合は作成
if (-not (Test-Path $localeDir)) {
    New-Item -Path $localeDir -ItemType Directory -Force | Out-Null
}

# locale.json に "locale": "ja" を書き込む
@'
{
    "locale": "ja"
}
'@ | Out-File -FilePath $localeFile -Encoding utf8 -Force

Write-Host "  日本語化設定(locale.json) の作成完了" -ForegroundColor Green
Write-Host ""

# ============================================================
# 6. 設定ファイルのコピー
# ============================================================

Write-Host "設定ファイルをコピー中..." -ForegroundColor Green

$settingsSource = ".\config\settings.json"
$settingsDir = ".\vscode\data\user-data\User"
$settingsDest = Join-Path $settingsDir "settings.json"

if (Test-Path $settingsSource) {
    # ディレクトリが存在しない場合は作成
    if (-not (Test-Path $settingsDir)) {
        New-Item -Path $settingsDir -ItemType Directory -Force | Out-Null
    }
    
    Copy-Item $settingsSource $settingsDest -Force
    Write-Host "  settings.json のコピー完了" -ForegroundColor Green
    Write-Host ""
    Write-Host "  注意: Pythonパスは環境変数で設定されます" -ForegroundColor Cyan
    Write-Host "  必ず launch-vscode.bat から起動してください" -ForegroundColor Cyan
} else {
    Write-Host "  警告: settings.json が見つかりません" -ForegroundColor Yellow
}

Write-Host ""

# ============================================================
# 完了メッセージ
# ============================================================

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " セットアップが完了しました！" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "次の手順で起動してください:" -ForegroundColor White
Write-Host "  1. launch-vscode.bat をダブルクリック" -ForegroundColor Yellow
Write-Host "  2. VS Codeが起動します" -ForegroundColor Yellow
Write-Host ""
Write-Host "インストールされた環境:" -ForegroundColor White
Write-Host "  ・Python 3.12.9 (Portable)" -ForegroundColor Gray
Write-Host "  ・VS Code (Portable)" -ForegroundColor Gray
Write-Host "  ・拡張機能 ($($extensions.Count)個)" -ForegroundColor Gray
Write-Host "  ・Pythonライブラリ（numpy, pandas, jupyter等）" -ForegroundColor Gray
Write-Host ""

# ============================================================
# セットアップファイルの自動削除
# ============================================================

Write-Host "セットアップファイルを削除中..." -ForegroundColor Yellow
Write-Host ""

# 削除対象のファイルとフォルダ
$itemsToDelete = @(
    ".\config",           # configフォルダ
    ".\get-pip.py",       # get-pip.pyファイル（もし残っている場合）
    "$PSCommandPath",     # setup.ps1自身
    ".\setup.bat"         # setup.bat
)

foreach ($item in $itemsToDelete) {
    if (Test-Path $item) {
        try {
            if (Test-Path $item -PathType Container) {
                # フォルダの場合
                Remove-Item $item -Recurse -Force
                Write-Host "  削除完了: $item (フォルダ)" -ForegroundColor Gray
            } else {
                # ファイルの場合
                Remove-Item $item -Force
                Write-Host "  削除完了: $item" -ForegroundColor Gray
            }
        } catch {
            Write-Host "  警告: $item の削除に失敗しました" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "セットアップファイルの削除が完了しました。" -ForegroundColor Green
Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

