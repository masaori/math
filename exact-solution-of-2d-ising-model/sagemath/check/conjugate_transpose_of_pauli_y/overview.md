# SageMath Check: conjugate_transpose_of_pauli_y

## 対象

**対象ラベル**: `conjugate_transpose_of_pauli_y`

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_conjugate_transpose_of_pauli_y`（σ^y の共役転置）
- 範囲: 準備の `\bar i = -i`（11 行）・`\overline{-i} = i`（12 行）の鎖と、`(σ^y)^* = σ^y` の 6 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の `\bar i = -i` の 11 行 | `check_chain.sage` | 11 段（`i := (0,1)`・`def_complex_conjugate`・ℝ の乗法の単位元・ℝ の加法の単位元・`real_minus_zero_is_self`・`real_times_zero_is_zero` を 2 箇所へ・`real_zero_times_is_zero`・`definition_of_cc` の積・`(-1)_ℂ = (-1,0)`・`i := (0,1)`・`multiply_by_minus_one`） | **PASS** | 成り立つ |
| 準備の `\overline{-i} = i` の 12 行 | `check_chain.sage` | 12 段（`multiply_by_minus_one`・`i := (0,1)`・`(-1)_ℂ = (-1,0)`・`definition_of_cc` の積・`real_zero_times_is_zero`・`real_times_zero_is_zero` を 2 箇所へ・`real_minus_zero_is_self`・ℝ の加法の単位元・ℝ の乗法の単位元・`def_complex_conjugate`・`real_double_negation`（`a → 1`）・`i := (0,1)`） | **PASS** | 成り立つ |
| ℝ の加法の単位元を引く 2 行（`set_and_algebra_notation`）: `\bar i` の鎖の `(−1)·1 = (−1)·1 + 0`（`x + 0 = x` の `x → (−1)·1` を右辺から左辺へ）、`\overline{-i}` の鎖の `(−1)·1 + 0 = (−1)·1`（`x + 0 = x` の `x → (−1)·1`） | `check_unit_rows_cite_set_and_algebra_notation.sage` | 行に書いた形と代入で形の両辺を作り、前後の行が同じ文脈（対の第 2 成分）の穴にそれを入れたものと `QQ` で等しいことを確かめる。式を正規化するので、形の左右と向きは区別できず、それはレビューの目視で確かめた。対照（`0 + 1 ≠ 0`） | **PASS** | 厳密（2 行） |
| 主の鎖の全行 | `check_chain.sage` | 6 段。`body_star` が Sage の `conjugate_transpose()` と一致することを見てから使う。対照 1 件: 共役を落とした転置は `σ^y` と異なる | **PASS** | 成り立つ |

共通の準備は `sagemath/_shared/hermitian_forms_by_definition.sage`（`body_star`: `def_hermitian_positive_definite` の
`(A^*)_{kl} := \overline{A_{lk}}`）と `sagemath/_shared/complex_as_real_pairs.sage`（`definition_of_cc` の対の和・積、
`inclusion_rr_to_cc`、`multiply_by_minus_one`、`def_complex_conjugate`）。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ` の対で、浮動小数点と ℝ/ℂ への脱出はない。比べる側は `QQ(i)` の Sage の `conjugate_transpose()`。
- 範囲: 主張は 2 次の具体的な行列 1 つについての等式なので、鎖の全行をそのまま確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh conjugate_transpose_of_pauli_y
```

実行ログは `logs/` に保存する。
