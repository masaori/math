# SageMath Check: gamma1_lower_bound_all_theta

## 対象

**対象ラベル**: `gamma1_lower_bound_all_theta`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `freeenergy_001_claim_gamma1_lower_bound_all_theta`（γ_1(θ) ≥ cosh(2K_1 − 2K_2^*) ≥ 1、θ ∈ ℝ）
- 範囲: 主張の前提 cos θ ≤ 1、準備の s_1 s_2^* > 0 の 2 行と含意の 3 段、主鎖の 6 行（等号 4 本と不等号 2 本）、主張そのもの

## 証明の行との対応

主鎖の第 1〜3 行は略記 `c_1, s_1, c_2^*, s_2^*` と `cos θ` の多項式として、第 4・5 行は `Y = exp(2K_1)`・`X = exp(2K_2^*)` の有理関数として
`_prelude.sage` に写した。第 5 行の `cosh(2K_1 − 2K_2^*)` は `exp(2K_1 − 2K_2^*) = Y/X` から独立に作る。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備: `s_1 s_2^* > 0·s_2^* = 0` | `check_chain_generic.sage`・`check_chain_exact_values.sage` | 等号の行は多項式として、不等号の行と `s_1, s_2^* > 0` は具体値で | **PASS** | 厳密 |
| 準備の含意 `cos θ ≤ 1 ⇒ s_1s_2^* cos θ ≤ s_1s_2^*·1 ⇒ −s_1s_2^*·1 ≤ −s_1s_2^* cos θ` | `check_chain_generic.sage`・`check_chain_exact_values.sage` | 各段の差（右辺 − 左辺）が、前の段の差の `s_1s_2^*` 倍・等しいこと（多項式として）。具体値で全段の不等号 | **PASS** | 厳密 |
| 第 1 行 ≥ 第 2 行（準備の終点の両辺に `c_1c_2^*` を加える） | 同上 | 差がちょうど `s_1 s_2^*(1 − cos θ)` であること（多項式として）。具体値で不等号と、等号が `cos θ = 1` のときだけであること | **PASS** | 多項式として厳密。具体値は 50 通りで厳密 |
| 第 2 行 → 第 3 行（1 は積の単位元） | `check_chain_generic.sage` | 多項式として等しい | **PASS** | 厳密 |
| 第 3 行 → 第 4 行（`def_indexed_hyperbolic_abbreviations`） | 同上 | 略記に `def_cosh_sinh` の値を入れたものが第 4 行と `QQ(Y,X)` で等しい | **PASS** | 作り方から一致する（両辺を同じ `cosh`・`sinh` の式から作る。略記を戻す行なので照合だけ） |
| 第 4 行 → 第 5 行（`cosh_addition_formula` の複号 −） | 同上 | 第 4 行と、`Y/X` から作った `cosh(2K_1 − 2K_2^*)` が `QQ(Y,X)` で等しい。対照: `cosh(2K_1 + 2K_2^*)` とは異なる | **PASS** | 厳密 |
| 第 5 行 ≥ 第 6 行（`cosh_at_least_one`） | 同上 | 差がちょうど `(Y − X)^2/(2XY)` であること。具体値で不等号と、等号が `2K_1 = 2K_2^*` のときだけであること | **PASS** | 同上 |
| 主張 | `check_chain_exact_values.sage` | 全行を AA で比べ、γ_1(θ) ≥ cosh(2K_1 − 2K_2^*) ≥ 1 | **PASS** | 50 通りで厳密 |

## 計算の帰属と範囲

- 一般の検算は `QQ` 上の多項式環と有理関数体 `QQ(Y, X)` で行う（浮動小数点なし）。
- 具体値は `AA`（実代数的数）の厳密な順序で比べる。ℝ への脱出は結合定数の選び方 `K_1 = (1/2) log Y`・`K_2^* = (1/2) log X`
  （`X, Y ∈ QQ_{>1}`、すなわち `K_1, K_2^* > 0`）と、θ = 2πk/n の cos の値を記号式から `AA` へ変換することだけである。
- 範囲: `(Y, X) ∈ {(4, 3), (9, 7/3), (25/4, 2), (2, 5), (3, 3)}`、θ ∈ {0, 2π/3, π/2, 2π/5, 4π/5, π, 6π/7, 5π/4, 7π/6, −2π/3}。

## 確かめられない行と理由

- `cos θ ≤ 1`（全実数の θ）は本文に主張が無く、主張の前提として書いてある。`cosine_at_most_one` は `v ∈ [−π/2, π/2]` に限る。全実数上の cos・sin が未整備であること
  （状態台帳の「検算で見つかった本文の誤り」）の一部で、検算は具体の角度での当てはめを確かめるにとどまる。
- `cosh_at_least_one` の当てはめは、`cosh` を exp の値から作る `def_cosh_sinh` の式を経て確かめる。実数の exp そのもの（部分和の極限）は扱わない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh gamma1_lower_bound_all_theta
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
