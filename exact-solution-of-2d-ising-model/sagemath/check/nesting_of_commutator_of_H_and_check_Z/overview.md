# SageMath Check: nesting_of_commutator_of_H_and_check_Z

## 対象

**対象ラベル**: `nesting_of_commutator_of_H_and_check_Z`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_002_claim_nesting_commutator`（Ž・Y̌ についての n 重交換子 (h1.z)・(h1.y)・(h2.z)・(h2.y)）
- 範囲: 証明が引く前提 (A)〜(D) と準備（位相の積）の鎖、四つの主張それぞれの基底段階と二つの帰納段階の鎖の全行、主張そのもの

## 証明の行との対応

`k1 := (K_1)_C`、`k2 := (K_2^*)_C`、`C_n` などは証明の記号。鎖の各行は、その行の式どおりにスカラー（ℂ の積）を組んでから本文の成分の式のスカラー倍で行列に掛けて作り、隣り合う行の一致を確かめる。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 前提 (A)〜(D)（`commutator_of_H_and_check_Z_Y`） | `check_premises.sage` | 本文の定め方で作った H_1^(+)・H_2・Ž_μ・Y̌_μ について、`def_ad_X_matrix` の交換子（成分の式）の値が右辺と一致し、Sage の `*`・`-` の交換子とも一致。対照: (A) の位相を `exp(+iθ̃)` にすると θ̃ ≠ π の μ で一致しない | **PASS** | `M_col = 2..5`、全 μ で厳密等号 |
| 準備（位相の積）の 4 行 | 同上 | 指数の 2→3 行（`negative_i_times_complex_is_negation_of_i_times`）と 3→4 行（`negation_plus_self_is_zero_in_cc`）を、i を `QQ(i)` の元、π を不定元に置いた有理関数体で行の式どおり `(-1)i·θ̃`・`-(iθ̃)` に組み、`(-i)θ̃ + iθ̃ = -(iθ̃) + iθ̃ = 0` を確かめる。本文の exp の部分和に尾の上界を半径として付けたボール（`body_exp_i_ball`）で、1 行目の値 `exp(-iθ̃)exp(iθ̃)` のボールが 1 を含み、4 行目の `exp(0_C)` のボールが 1 を含むこと。あわせて `exp(-iθ̃)` のボールが 1 の冪根の値と重なること（円分体の位相の表し方の照合） | **PASS** | 同上 |
| 帰納段階の双線型性の行の根拠 `commutator_of_scalar_multiples` | （`sagemath/check/commutator_of_scalar_multiples/`） | 証明の準備にあった鎖は独立の主張に切り出したので、その検算は主張の検算として移した | — | — |
| 四つの主張の基底段階（4 行） | `check_induction_chains.sage` | `C_0` を Sage の再帰で作った値から `((-1)^0(2k)^0)Ž` まで | **PASS** | `M_col = 2..5`、全 μ |
| 帰納段階の頭の 3 行（`[kH, C_n]`・帰納法の仮定・`commutator_of_scalar_multiples` の行） | 同上 | `C_{n+1}` を Sage の再帰で直接作った値と、本文の交換子で作った `[kH, C_n]`・`[kH, 仮定の式]`、`(k c_n)[H, B_n]` が一致 | **PASS** | `n = 0..6`（`n+1 ≤ 7`）、全 M・μ |
| (A)〜(D) で置き換える行とスカラー倍の結合律の行 | 同上 | `(k c_n)((a)T)` と `(k c_n a)T` が前の行と一致し、`T` が主張の `n+1` の行列 | **PASS** | 同上 |
| 係数の鎖（ℂ の四則・積の可換律と結合律、冪の約束、準備の位相の積、単位元、指数の等式） | 同上 | 人手証明の各行の係数を（`(-1)` の冪の指数は `QQ` の元として行の式どおりに作り、`ZZ_{≥0}` に属することを確かめてから） `k1`・`k2` の多項式と円分体の位相で組み、隣り合う行が一致し、最後の行が主張の `n+1` の右辺 | **PASS** | 同上 |
| 指数の等式 `n/2 = ((n+1)-1)/2`・`n/2+1 = ((n+1)+1)/2`・`(n-1)/2+1 = (n+1)/2` | 同上 | `QQ[n]` の多項式の等式として | **PASS** | — |
| 主張 (h1.z)・(h1.y)・(h2.z)・(h2.y) | 同上 | `n = 0..7` で Sage の再帰の値が右辺と一致。対照: (h1.z) の位相を逆にした式、(h2.z) の奇数側の符号を逆にした式は `n = 1` で一致しない | **PASS** | 同上 |

## 計算の帰属と範囲

- 共通の準備は `_shared/half_integer_check_operators.sage`（`cosh_sinh_coefficient_conversion_for_check` の検算と共有）。

- Z_m・Y_m・H_1^(+)・H_2 は `_shared/pauli_sites_exact.sage`・`_shared/transfer_matrix_factor_inverses.sage` の本文の成分の式で `QQ(i)` に作る。
- 位相 `exp(-i(j_R θ̃_μ)_C)` は、θ̃_μ = 2π(μ - 1/2)/M_col が π の有理数倍なので 1 の冪根 `ζ_{4M}^{-2j(2μ-1)}` として円分体 `QQ(ζ_{4M})` に持つ。
  この表し方は全実数上の Euler の公式（本文で未整備。状態台帳の `half_integer_phase_antiperiodicity` の項）を前提にするので、
  `_shared/half_integer_phase_exact.sage` の `E`（QQbar の 1 の冪根）との一致と、本文の exp の部分和に尾の上界を半径として付けたボールとの重なりを別に確かめる。
  ボール（512 bit）を使うのはこの補助の照合だけで、ℝ への脱出を含む exp の値を本文の定義から囲むためである。
- `(K_1)_C`・`(K_2^*)_C` は円分体上の多項式環の不定元 `k1`・`k2` に置く。不定元での等号は、全ての実数 `K_1, K_2^*` の像での等号を表す。浮動小数点は等号の判定に使わない。
- 帰納法の推論そのもの（全ての n への一般化）は確かめられない。各 n の段は `n = 0..6`、主張は `n = 0..7` で確かめる。
- 範囲外: `M_col ≥ 6`、`n ≥ 8`。

## 確かめられない行と理由

- 「帰納法の仮定」の行は、仮定の式で `C_n` を置き換える推論で、検算は仮定の式が実際の `C_n` に等しいこと（主張の `n` の段）と、置き換えた後の値が前の行と一致することを確かめる。
- 準備（位相の積）の指数の行 `(-i)θ̃ + iθ̃ = -(iθ̃) + iθ̃ = 0_C` は、指数が 0 になることが θ̃ によらず必ず成り立つ（`QQ(i)` 上の有理関数体での検査は行の式どおりに組んだ記録として置くが、作り方から必ず通る）。円分体での `exp(-iθ̃)exp(iθ̃) = 1` も `ζ^{-a}ζ^{a}` なので作り方から必ず通り、位相の積の鎖を確かめるのは上のボールの照合である。
- 冪の約束 `x^0 := 1`・`x^{m+1} := x^m x` は `(-1)^e`・`(2k)^n` を右から 1 つずつ掛けて作ることで反映した。Sage の冪とは比べていない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh nesting_of_commutator_of_H_and_check_Z
```

`check_induction_chains.sage` は引数で `M_col` を絞れる（`sage check_induction_chains.sage 2 3`）。実行ログは `logs/` に保存する。
