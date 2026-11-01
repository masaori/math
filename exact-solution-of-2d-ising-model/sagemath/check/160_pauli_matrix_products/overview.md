# SageMath Check: 160_pauli_matrix_products

## 対象

**対象ラベル**: `pauli_matrix_products` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/006_Z_Y_anticommutation.ts`

- 範囲: σ^aσ^a = I の 3 式と σ^zσ^x = −σ^xσ^z 等の 3 式

2×2 の成分計算。関係式が非自明であること（σ^xσ^x は自分自身と反可換ではない）と、Pauli 群が閉じる根拠になる σ^xσ^y = iσ^z 型の関係も併せて確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_pauli_products.sage` | 6 式と非自明性、および巡回関係 | 10 | 0.000e+00 | **PASS** |
| 02 | `check_02_stepwise_chains.sage` | 証明の各鎖を 1 行ずつ（準備の `(-i)·i = 1`・`i·(-i) = 1`、`σ^xσ^x = I`・`σ^yσ^y = I`・`σ^zσ^z = I` の 3 本の各行と `def_kronecker_delta`・`def_identity_matrix` の段、右辺の積 3 つ、左辺から始まる反可換性の 3 本の各行と `def_matrix_negation` の段。行列の積の段と成分の積の段 `(-1)·(-1) = 1`・`(-1)·i = -i`・`(-i)·(-1) = i` は別の行として確かめる）。否定コントロール: 符号反転を落とした等式は偽。`QQ[i]` の厳密計算 | 21 | 厳密 | **PASS** |

check_02 は浮動小数点を使わない（ガウス有理数体 `QQ[i]` の厳密計算）。check_01 の許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 160
```

実行ログは `sagemath/check/160_pauli_matrix_products/logs/` に保存してある（この表の数値はそのログから取った）。
