# Portable Python + VS Code セットアップキット

## 概要

このキットは、Pythonプログラミング学習のためのポータブル環境です。
管理者権限なしでインストールでき、USBメモリでも動作します。

## 含まれる内容

- **Python 3.13.0** (Embeddable版)
- **Visual Studio Code** (Portable版)
- **拡張機能**:
  - Python開発ツール
  - GitHub Copilot
  - Jupyter Notebook
  - その他17個の拡張機能
- **Pythonライブラリ**:
  - numpy, pandas, matplotlib（データ分析）
  - flask, fastapi（Web開発）
  - jupyter, jupyterlab（ノートブック）
  - その他多数

## セットアップ手順

### 1. ダウンロード

このリポジトリからgitで取得するか、zipファイルをダウンロードしてください。

### 2. cloneまたは解凍場所

任意のフォルダで構いませんが、ネットワークドライブ以外を推奨します。

**推奨場所**:
- `C:\Users\[ユーザー名]\portable-dev`
- USBメモリの場合: `F:\portable-dev` など

**注意**: 日本語を含むパスは避けてください。

### 3. セットアップ実行

`setup.bat` をダブルクリックして実行します。

**所要時間**: 約10-15分
- ダウンロード: 5-10分（回線速度による）
- インストール: 3-5分

**実行される処理**:
1. Python 3.13.0のダウンロード・展開
2. pipコマンドのインストール
3. Pythonライブラリのインストール（40以上）
4. VS Codeのダウンロード・展開
5. VS Code拡張機能のインストール（17個）
6. 設定ファイルのコピー

### 4. 起動
【重要】
`launch-vscode.bat` をダブルクリックしてVS Codeを起動します。

## ディレクトリ構成

```
portable-python-vscode-kit/
├── setup.ps1               # セットアップスクリプト（PowerShell）
├── setup.bat               # セットアップ実行用（★最初にこれを実行）
├── launch-vscode.bat       # VS Code起動用（★セットアップ後に使用）
├── README.md               # このファイル
├── config/
│   ├── settings.json       # VS Code設定
│   └── cleanExtentions.txt # 拡張機能リスト
│
├── python/                 # ★セットアップで作成される
│   ├── python.exe
│   ├── Scripts/
│   └── Lib/
│
└── vscode/                 # ★セットアップで作成される
    ├── Code.exe
    ├── bin/
    └── data/
        ├── extensions/     # 拡張機能
        └── user-data/      # ユーザー設定
```

## 使い方

### 基本操作

1. `launch-vscode.bat` をダブルクリックして起動＜重要＞
2. workspaceフォルダが開いている状態で起動する
   このフォルダ内に、サブフォルダを作って必要なファイルを作成する

### 新しいライブラリの追加

ターミナルで:
```bash
python -m pip install [パッケージ名]
```

例:
```bash
python -m pip install opencv-python
```

## インストールされる拡張機能

- **Python開発**:
  - Python
  - Pylance
  - Python Debugger
  - Python Environments Manager
  
- **AI支援**:
  - GitHub Copilot
  - GitHub Copilot Chat
  
- **Jupyter**:
  - Jupyter
  - Jupyter Keymap
  - Jupyter Cell Tags
  - Jupyter Slide Show
  
- **その他**:
  - Prettier（コード整形）
  - 日本語言語パック

## インストールされるPythonライブラリ

### コード品質
- black, pylint, flake8, autopep8, isort, mypy

### ユーティリティ
- requests, python-dotenv, tqdm, colorama

### データ分析
- numpy, pandas, matplotlib, scipy, seaborn

### Web開発
- flask, fastapi, uvicorn, beautifulsoup4, lxml

### ファイル処理
- openpyxl, pillow, pyyaml

### テスト・開発
- pytest, faker, debugpy

### Jupyter
- notebook, jupyterlab, ipykernel, ipywidgets
- jupyterlab-lsp, python-lsp-server

### 可視化
- plotly, xlsxwriter

## 環境の持ち運び

### USBメモリへのコピー

1. セットアップ完了後、フォルダごとコピー
2. USBメモリで `launch-vscode.bat` を実行

### 別のPCでの使用

1. フォルダごとコピー
2. `launch-vscode.bat` で起動
3. 再セットアップ不要

## アンインストール

フォルダごと削除するだけです。
レジストリや他のファイルは一切変更されません。

## ライセンス

- **Python**: PSF License
- **Visual Studio Code**: Microsoft Software License
- **拡張機能**: 各拡張機能のライセンスに準拠

本キットはこれらのソフトウェアを公式サイトから自動ダウンロードして
セットアップするツールです。

## 更新履歴

- 2025-12: 初版リリース
  - Python 3.13.0
  - VS Code最新版
  - 拡張機能17個
  - Pythonライブラリ40以上

---

**制作**: Takashi Kawaba  
**バージョン**: 1.0.0  
**最終更新**: 2025年12月
