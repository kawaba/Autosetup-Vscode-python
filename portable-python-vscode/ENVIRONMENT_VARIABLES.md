# 環境変数を使ったPythonパス設定

## 概要

このポータブル環境では、VS CodeがPythonを見つけるために**環境変数**を使用しています。
これにより、プロジェクトの配置場所に依存しない、確実な設定が可能になります。

## 仕組み

### 1. launch-vscode.bat（起動時）

```batch
REM Python実行ファイルのフルパスを環境変数に設定
set PORTABLE_PYTHON_PATH=%~dp0python\python.exe
```

**動作**:
- `%~dp0` = バッチファイルのあるディレクトリ（例: `C:\portable-dev\`）
- `PORTABLE_PYTHON_PATH` に `C:\portable-dev\python\python.exe` がセットされる

### 2. settings.json（VS Code設定）

```json
{
  "python.defaultInterpreterPath": "${env:PORTABLE_PYTHON_PATH}"
}
```

**動作**:
- `${env:変数名}` で環境変数を参照
- VS Codeが起動時に `PORTABLE_PYTHON_PATH` の値を取得
- どのプロジェクトを開いても、常に正しいPythonを参照

## メリット

### ? 相対パスの問題がない

**従来の方法（相対パス）**:
```json
"python.defaultInterpreterPath": "${workspaceFolder}/../python/python.exe"
```

**問題点**:
- プロジェクトの階層によってパスが変わる
- 深い階層のプロジェクトでは動作しない

**環境変数方式**:
```json
"python.defaultInterpreterPath": "${env:PORTABLE_PYTHON_PATH}"
```

**利点**:
- プロジェクトの配置場所に関係なく動作
- 常に正しいPythonを参照

### ? プロジェクト配置の自由度

```
# どの配置でも動作する

# パターン1
portable-python-vscode-kit/
└── my-projects/
    └── project1/

# パターン2  
C:\Users\学生\
├── portable-python-vscode-kit/
└── Documents\
    └── python-projects\
        └── project1/

# パターン3（USB）
F:\
├── portable-python-vscode-kit/
└── school-projects\
    └── homework\
        └── chapter01/
```

すべてのケースで、環境変数が正しいPythonを指します。

### ? 明確で理解しやすい

- 起動スクリプトで環境変数を設定
- VS Codeがその環境変数を参照
- 仕組みがシンプルで分かりやすい

## 確認方法

### VS Codeでの確認

1. VS Codeを起動（launch-vscode.bat）
2. `Ctrl + Shift + P` でコマンドパレット
3. 「Python: Select Interpreter」を入力
4. 使用中のPythonパスが表示される

### ターミナルでの確認

VS Codeのターミナルで:
```batch
echo %PORTABLE_PYTHON_PATH%
```

出力例:
```
C:\portable-python-vscode-kit\python\python.exe
```

### Pythonバージョンの確認

```batch
python --version
```

出力例:
```
Python 3.13.0
```

## 注意事項

### ?? 必ず launch-vscode.bat から起動

環境変数は `launch-vscode.bat` で設定されるため、
**必ずこのスクリプトからVS Codeを起動してください。**

**NG例**:
- `Code.exe` を直接ダブルクリック
- スタートメニューから起動（システムにインストール版がある場合）
- 既存のショートカットから起動

**OK例**:
- `launch-vscode.bat` をダブルクリック
- `launch-vscode.bat` のショートカットを作成して使用

### ?? 環境変数はセッションごと

環境変数は **VS Codeを起動している間だけ有効** です。

- VS Codeを閉じると消える
- 次回起動時に再設定される
- システム環境変数は変更しない（ポータブル性を保つため）

## その他の環境変数

launch-vscode.batでは、他にも環境変数を設定しています:

```batch
REM Python実行ファイルのフルパス
set PORTABLE_PYTHON_PATH=%~dp0python\python.exe

REM Pythonのディレクトリ
set PYTHON_PATH=%~dp0python

REM PATH環境変数にPythonとScriptsを追加
set PATH=%PYTHON_PATH%;%PYTHON_PATH%\Scripts;%PATH%

REM Python入出力の文字エンコーディング
set PYTHONIOENCODING=utf-8
```

### PATH環境変数の役割

```batch
set PATH=%PYTHON_PATH%;%PYTHON_PATH%\Scripts;%PATH%
```

**効果**:
- ターミナルで `python` と入力するだけで実行可能
- `pip`, `jupyter` などのコマンドも使用可能
- フルパスを指定する必要がない

### PYTHONIOENCODING の役割

```batch
set PYTHONIOENCODING=utf-8
```

**効果**:
- 日本語の文字化けを防ぐ
- print()で日本語が正しく表示される
- ファイル入出力で日本語が正しく処理される

## トラブルシューティング

### VS CodeがPythonを認識しない

**原因**: launch-vscode.bat以外の方法で起動した

**解決方法**:
1. VS Codeを閉じる
2. `launch-vscode.bat` から再起動

### 環境変数が設定されているか確認

VS Codeのターミナルで:
```batch
echo %PORTABLE_PYTHON_PATH%
echo %PYTHON_PATH%
echo %PYTHONIOENCODING%
```

すべて正しい値が表示されればOK。

表示されない場合は、launch-vscode.batから起動し直してください。

## まとめ

| 項目 | 内容 |
|------|------|
| 設定方法 | 環境変数 `PORTABLE_PYTHON_PATH` |
| 設定場所 | launch-vscode.bat |
| 参照場所 | settings.json |
| 有効期間 | VS Code起動中のみ |
| メリット | プロジェクト配置に依存しない |
| 注意点 | 必ず launch-vscode.bat から起動 |

この仕組みにより、どこにプロジェクトを作成しても、
常に正しいポータブルPythonが使用されます。
