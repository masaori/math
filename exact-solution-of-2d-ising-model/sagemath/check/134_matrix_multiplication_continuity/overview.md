# SageMath Check: 134_matrix_multiplication_continuity

## 対象

**対象ラベル**: `matrix_multiplication_continuity` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.mjs`

- 範囲: ‖A_N−A‖→0 ⟹ ‖A_N B − AB‖→0

摂動を 2^{-k} で細かくしていき、出力側の誤差が単調に減ること、かつ ‖A_N−A‖‖B‖ で抑えられることを確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_continuity.sage` | 単調減少と上界 | 90 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 134
```

実行ログは `sagemath/check/134_matrix_multiplication_continuity/logs/` に保存してある（この表の数値はそのログから取った）。
