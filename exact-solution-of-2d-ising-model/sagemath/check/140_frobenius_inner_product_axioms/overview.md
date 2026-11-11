# SageMath Check: 140_frobenius_inner_product_axioms

## 対象

**対象ラベル**: `frobenius_inner_product_axioms` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`

- 範囲: (0) 成分表示、(1) 共役対称性、(2) 第2変数線型・第1変数共役線型、(3) 正定値性、Cauchy–Schwarz、三角不等式

⟨A,B⟩ = tr(A*B) をトレースで計算した側と、成分の和で計算した側の 2 経路。Cauchy–Schwarz の等号（B = cA）も踏む。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_axioms.sage` | (0)〜(3)、Cauchy–Schwarz、三角不等式、等号条件 | 728 | 1.008e-15 | **PASS** |
| 02 | `check_02_linearity_chains.sage` | (2) の 4 本の鎖（`⟨A,B+C⟩`・`⟨A,λB⟩`・`⟨A+B,C⟩`・`⟨λA,B⟩`）を 1 行ずつ。(0) の段と、`def_matrix_sum`・`def_matrix_scalar_multiple` の段を別の行として確かめ、定義の成分の式が Sage の和・スカラー倍と一致することも確かめる。否定コントロール: 第 1 変数で共役を落とした等式は偽。`n = 1, 2, 3`、`QQ[i]` の厳密計算 | 252 | 厳密 | **PASS** |
| 03 | `check_03_cauchy_schwarz_case2_chain.sage` | Step 5 場合 2（`‖B‖ > 0`）を 1 行ずつ。前置きの `β_ℂ ∈ ℂ^×`・`(β^{-1})_ℂ = (β_ℂ)^{-1}`（`real_inclusion_preserves_inverse`）・`t = ū(β_ℂ)^{-1}`（`def_complex_quotient`）、準備 `t̄ = u(β_ℂ)^{-1}`（5 等号）・`(ūu)(β_ℂ)^{-1} = q_ℂ`（6 等号）、三つの積の項 `t⟨A,B⟩`（6 等号）・`t̄⟨B,A⟩`（8 等号）・`t̄t⟨B,B⟩`（13 等号）、展開式と合わせる鎖（12 等号）。逆元は `definition_of_cc` の積の式から `β_ℂ w = 1_ℂ` を解いて作る。否定コントロール: `t` を `u(β_ℂ)^{-1}` にすると `t⟨A,B⟩ ≠ q_ℂ`。`n = 1, 2, 3`、`QQ[i]` の厳密計算 | 648 | 厳密 | **PASS** |

check_02・check_03 は浮動小数点を使わない（ガウス有理数体 `QQ[i]` の厳密計算）。check_01 の許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

<def_frobenius_inner_product> の内容もこの check に含まれる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 140
```

実行ログは `sagemath/check/140_frobenius_inner_product_axioms/logs/` に保存してある（この表の数値はそのログから取った）。
