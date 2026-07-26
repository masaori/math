# SageMath Check: 101_sqrt_nonnegative_existence_uniqueness

## 対象

**対象ラベル**: `sqrt_nonnegative_existence_uniqueness` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.mjs`

- 範囲: 非負実数の平方根 y≥0, y²=x の存在と一意性

存在は二分法で実際に構成する（標準ライブラリの sqrt を使わない独立経路）。一意性は、構成した y を微小にずらすと y²=x が破れることで確認する。値域を R≥0 に限る指定が効いていること（−y は解でない）も見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_existence_uniqueness.sage` | 二分法による構成、y²=x、摂動による一意性、値域の指定 | 294 | 3.656e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

二分法は 200 回反復しており、倍精度の精度限界まで収束している。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 101
```

実行ログは `sagemath/check/101_sqrt_nonnegative_existence_uniqueness/logs/` に保存してある（この表の数値はそのログから取った）。
