# SageMath Check: exp_of_negative_is_left_inverse

## 対象

**対象ラベル**: `exp_of_negative_is_left_inverse` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_exp_of_negative_is_left_inverse`（exp(-A)exp(A) = I）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `((-A)A)_kl = (A(-A))_kl` の 8 行 | `check_preparation.sage` | `A` の成分を不定元の対に置き、`n = 1,…,4` の全成分で隣り合う行が等しい。両端を Sage の積と比べた | **PASS** | 不定元で厳密等号 |
| 準備 `((-A)+A)_kl = O_kl` の 11 行 | 同上 | 同上。Sage の和が零行列であることと比べた | **PASS** | 同上 |
| 主張の鎖 `exp(-A)exp(A) = exp((-A)+A) = exp(O) = I`（形式冪級数） | `check_main_chain.sage` | `A` を `tA` に置き、本文の部分和（冪は `A^{m+1} := A^mA`）で各行が `t` の 6 次まで一致することを不定元で確かめた（`n = 1, 2`） | **PASS** | 同上 |
| 主張の鎖（ℝ への脱出を含む値） | 同上 | 具体の `QQ(i)` の行列（`n = 1,…,4`、各 3 個）で、本文の部分和 `E_60` に尾の評価を半径として足したボールの行列で `exp(-A)exp(A)` を囲み、`I` を厳密に含むことを確かめた（ボールの半径は最大 6e-30）。本文の `exp(A)` のボールが Sage 組み込みの `ComplexBallField` の `exp` と重なることも確かめた | **PASS** | 同上 |

## 計算の帰属と範囲

準備と形式冪級数の段は不定元で厳密に確かめた。exp の値は `ℝ` への脱出（`def_exp` の極限）を含むので、浮動小数点ではなく 256 ビットの区間（`ComplexBallField`）で囲んだ。尾 `Σ_{m>N}‖A‖^m/m!` の上界（`matrix_norm_submultiplicativity` と `|成分| ≤ ‖·‖`）を各成分の半径として足しており、囲みは厳密である。許容誤差は置いていない（`I` を含むかの判定）。

本文の部分和で作ったボールを、Sage 組み込みの `ComplexBallField` の行列の `exp`（arb の厳密な囲み）と比べた。

## 確かめられない行と理由

極限の段（部分和から `exp` への `N → ∞`）は有限の計算では確かめられない。形式冪級数の検算は `t` の有限次まで、ボールの検算は具体の行列についてだけである。`theorem_exp_product`・`theorem_exp_zero` の一般の正しさはそれぞれの検算と人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh exp_of_negative_is_left_inverse
```

実行ログは `sagemath/check/exp_of_negative_is_left_inverse/logs/` に保存する。
