# SageMath Check: 132_matrix_norm_vector_bound

## 対象

**対象ラベル**: `matrix_norm_vector_bound` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.mjs`

- 範囲: ‖Aw‖ ≤ ‖A‖‖w‖

ランク 1 の A と対応する w で等号になることも確認する（評価が緩すぎないこと）。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_vector_bound.sage` | 不等式と等号 | 155 | 2.237e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 132
```

実行ログは `sagemath/check/132_matrix_norm_vector_bound/logs/` に保存してある（この表の数値はそのログから取った）。
