# Sage optimizer

## 概要
このシェルスクリプトは、[Sage](https://roots.io/sage/)をインストールするとともに、以下の問題を解決します。

- `yarn start` / `npm start`時に発生する`main.css`の404エラー [(GitHub)](https://github.com/roots/sage/issues/1826)
- `yarn start` / `npm start`時にJavaScriptの変更保存で発生するHMRの警告 [(GitHub)](https://github.com/webpack-contrib/webpack-hot-middleware/issues/43)
- `yarn start` / `npm start`時にSSL接続で発生するブラウザからの警告 [(Discourse)](https://discourse.roots.io/t/self-signed-ssl-cert-w-browser-sync-localhost-proxy-chrome-on-windows/5862)
- 初期状態でのjQuery依存 [(GitHub)](https://github.com/roots/sage/pull/2022)
- git管理対象ファイルへの環境変数記載 [(GitHub)](https://github.com/roots/sage/blob/master/resources/assets/config.json)

## 依存関係
- [PHP](http://php.net/) >= 7.1.3
- [WordPress](https://wordpress.org/) >= 4.7
- [Composer](https://getcomposer.org/)
- [Node.js](https://nodejs.org/en/) >= 8.0
- [Yarn](https://yarnpkg.com/) ([npm](https://www.npmjs.com/)で代用可)
- [Bash](https://www.gnu.org/software/bash/)

## 使用方法
1. 上記依存関係が満たされていることを確認
2. 任意の場所にSage optimizer一式を配置
```
$ git clone https://github.com/dsktschy/sage-optimizer.git /path/to/some/dir
```
3. コマンドラインを開く
4. WordPressのthemesディレクトリへ移動
```
$ cd /path/to/wp/wp-content/themes
```
5. 作成するテーマのディレクトリ名を引数として、Sage optimizerを実行
```
$ /path/to/sage-optimizer.sh theme-dir-name
```
6. 各質問の回答を入力
- "Are you sure you want to overwrite the following files?"  
  - **必ずyesと回答してください。** 選択されたCSSフレームワークに合わせ、ファイルの上書きが実行されます。
- "Path to .crt file for SSL (e.g., /.ssl/localhost.crt)"  
  - **`yarn start` / `npm start`時にSSL接続(HTTPS)が必要である場合は、SSL証明書のcrtファイルのフルパスを入力してください。**
  - SSL接続が不要である場合は、何も入力せずEnterを押下してください。
- "Path to .key file for SSL (e.g., /.ssl/localhost.key)"  
  - **`yarn start` / `npm start`時にSSL接続(HTTPS)が必要である場合は、SSL証明書のkeyファイルのフルパスを入力してください。**
  - SSL接続が不要である場合は、何も入力せずEnterを押下してください。
