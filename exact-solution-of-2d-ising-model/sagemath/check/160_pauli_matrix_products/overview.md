# SageMath Check: 160_pauli_matrix_products

## 対象

**対象ラベル**: `pauli_matrix_products` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/006_Z_Y_anticommutation.mjs`

- 範囲: σ^aσ^a = I の 3 式と σ^zσ^x = −σ^xσ^z 等の 3 式

2×2 の成分計算。関係式が非自明であること（σ^xσ^x は自分自身と反可換ではない）と、Pauli 群が閉じる根拠になる σ^xσ^y = iσ^z 型の関係も併せて確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_pauli_products.sage` | 6 式と非自明性、および巡回関係 | 10 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 160
```

実行ログは `sagemath/check/160_pauli_matrix_products/logs/` に保存してある（この表の数値はそのログから取った）。
