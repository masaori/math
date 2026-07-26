# SageMath Check: 130_matrix_norm_triangle_inequality

## 対象

**対象ラベル**: `matrix_norm_triangle_inequality` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.mjs`

- 範囲: (1) 正定値性、(2) 斉次性、(3) 三角不等式、および定義式との一致

<def_matrix_norm> の Frobenius ノルム（成分の平方和の平方根）を定義式から直接計算し、公理を確認する。三角不等式の等号（B = tA, t>0）も踏む。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_norm_axioms.sage` | ノルムの公理と等号条件 | 415 | 3.320e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

(4) 極限の一意性は数値では直接確認できないため、この check には含めていない（134 の連続性で間接的に触れている）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 130
```

実行ログは `sagemath/check/130_matrix_norm_triangle_inequality/logs/` に保存してある（この表の数値はそのログから取った）。
