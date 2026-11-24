# SageMath Check: antiperiodic_exp_sum

## 対象

**対象ラベル**: `antiperiodic_exp_sum`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensector_002_claim_antiperiodic_exp_sum`（半整数運動量 θ̃_μ の指数和
  `Σ_{μ=1}^{M} exp(i(k_R θ̃_μ)_C)` は `k = lM` なら `(M)_C(-1_C)^l`、`k ≢ 0 (mod M)` なら `0_C`）
- 範囲: 証明の全ての鎖と段、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 最初の準備の鎖（`(2n)_ℤ = 2_ℤ·n_ℤ` の 10 行（`inclusion_nn_to_zz_preserves_product`・ℕ の数字 `2 := 1 + 1`・`inclusion_nn_to_zz` の二つの式・`def_power_of_integer` の `2_ℤ := 1_ℤ + 1_ℤ`）、`(2_ℤ·a)_ℝ = 2_ℝ·a_ℝ` の 5 行（`inclusion_zz_to_rr_preserves_product`・`inclusion_zz_to_rr_preserves_sum`・`inclusion_zz_to_rr_of_one`・`def_real_two`）、`2μ = 1 + (d + μ)` の 5 行と `(2μ − 1) + 1 = 2μ` の 2 行、`(2μ − 1)_ℤ = 2_ℤμ_ℤ − 1_ℤ` の 7 行、`((2μ − 1)_ℤ)_ℝ = 2_ℝ(μ_ℤ)_ℝ − 1_ℝ` の 4 行（`inclusion_zz_to_rr_preserves_difference`）、`((2μ)_ℤ)_ℝ = 2_ℝ(μ_ℤ)_ℝ` の 2 行）と、自然数の項数と整数の格子幅の像の 7 式、主張の前置きの `(2_ℤ)_ℝ = 2_ℝ` の 4 行と証明の `((1_ℕ)_ℤ)_ℝ = 1_ℝ` の 6 行（`N_ℝ ≥ 1_ℝ` の前） | `check_image_lines.sage` | n = 0..80、a = −80..80、μ = 1..80、N = 1..80、M_col = 2..40 で、ι_{N→Z} = `ZZ`、ι_{Z→R} = `QQ`、ι_{R→C} = UCF への埋め込みとして各行を組み、隣の行と比べる。ι_{N→Z} を `inclusion_nn_to_zz` の二つの式だけで組んだ値でも各行を作る（ℕ の数字 `2 := 1 + 1` と ℕ の加法の単位元の行は、Sage が引数の ℕ の計算を先に済ませるので数の上では区別できない）。前提 (M)_R ≥ 2 > 0、2(M)_R ≠ 0 | **PASS** | 成り立つ |
| 鎖 `k_R θ̃_μ = ⋯ = 2π(2_Rμ_R-1_R)k_R/(2_R(M)_R)` の 6 等号 | `check_angle_chain.sage` | π・k・μ・M を不定元にした `QQ(π, k, μ, M)` で、各行をその行の式の形のまま組み、隣の行と比べる。具体の (M, μ, k) で 2π を外した有理数の形とも合わせる。対照: 第 3 行で分母にだけ 2 を掛ける、θ̃ の 1/2 を外すと崩れる | **PASS** | 成り立つ |
| `S := Σ exp(i(k_R θ̃_{μ_Z})_C)` を書き換える 1 等号、奇偶の分割の前提（{1..2M} = {2μ-1} ⊔ {2μ}）、`T_{2M,k} = ⋯ = S + T_{M,k}` の 9 等号（4 行目の根拠は準備の鎖 `((2μ − 1)_ℤ)_ℝ = 2_ℝ(μ_ℤ)_ℝ − 1_ℝ`・`((2μ)_ℤ)_ℝ = 2_ℝ(μ_ℤ)_ℝ`。その鎖自体は `check_image_lines.sage`） | `check_S_and_T_split_chain.sage` | M_col = 2..8、k = -3M..3M で、各行の和を項の式の形のまま UCF で厳密に組み、隣の行と比べる。対照: 半整数運動量を整数運動量に替えると S の等号が崩れる k がある | **PASS** | 成り立つ |
| exp_sum の適用の 4 行、`S = T_{2M,k} - T_{M,k} = (2M)_C δ^{2M} - (M)_C δ^{M}` の 2 等号 | `check_exp_sum_application_and_difference.sage` | 同じ範囲で、T を和のまま、δ を def_delta_M の場合分けのまま作って比べる | **PASS** | 成り立つ |
| 非整除の段（2M ∤ k、二つの δ が 0、和の 7 等号の鎖）、整除の段の 2 つの同値、l が偶数の鎖の 10 等号、l が奇数の鎖の 8 等号、「とくに」の背理法の鎖（`0_ℤ ≤ ι((M)_ℕ) = ((M)_ℕ)_ℤ = M`（`inclusion_nn_to_zz_image_is_nonnegative`）、`|l|M = |lM| = |k| < M`（`|l|M = |lM|` は `int_absolute_value_of_product_with_nonnegative` に `0 ≤ M`）（`|·|` は `def_int_absolute_value` の場合分けの式）、`0_ℤ ≤ |l|`（`int_absolute_value_is_nonnegative`）、`|l| < 1`（`int_less_than_one_of_product_less_than_nonnegative_factor` に `0 ≤ M` と `|l|M < M`）、`|l| + 1 ≤ 1`（`def_int_strict_order`）、`|l| = |l| + 0 = |l| + (1 + (−1)) = (|l| + 1) + (−1) ≤ 1 + (−1) = 0`、`|l| = 0`（反対称律）、`l = 0`（`int_absolute_value_zero_implies_zero`）、`k = lM = 0·M = 0`（`int_zero_times_is_zero`）と k = 0 の 2 等号 | `check_cases_chains.sage` | M_col = 2..8、k = -3M..3M、l = -6..6。鎖の始まりは主張の左辺の式、終わりは (-1_C)^l を本文の言葉どおり（非負は積、負は逆元の積）に作った値で、各行を UCF で厳密に組んで隣の行と比べる。背理法の鎖は仮定を外した全ての l で各等号を確かめ、仮定 |k| < M が成り立つのが l = 0 だけであることを見る | **PASS** | 成り立つ |
| 主張 | `check_claim_ball.sage` | 本文の exp を、部分和と尾の上界のボールで組み、π を Arb のボールにして、左辺を θ̃ の定義の式のまま作り、右辺の場合分けの値と重なることを見る。あわせて、他のファイルが使う E(q)（1 の冪根）が本文の exp(i(2πq)_C) のボールに入ることを、証明に現れる全ての q で確かめる。対照: (-1)^l を外すと l が奇数の k で交わらない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 整数と有理数は `ZZ`・`QQ`。π を含む行は π を不定元にした `QQ` 上の有理関数体。
  exp(i(2πq)_C)（q ∈ `QQ`）は 1 の冪根 ζ_d^m として `UniversalCyclotomicField`（代数的数の可算な部分体）で持ち、
  和・差・積・等号を厳密に計算する。
- **ℝ への脱出**: `check_claim_ball.sage` だけ。π と本文の exp の値（級数の極限）を 512 bit のボールで囲む。
  部分和の項数は N = 4⌈r⌉ + 60（r は |x| の上界）で、尾は 2r^{N+1}/(N+1)!（N + 2 ≥ 2r）で抑えて半径に足す。
  E(q) を本文の exp と結ぶのはここだけで、重なりは等号の必要条件であって証明ではない。
- 範囲外: M_col ≥ 9（像の行は ≤ 40）、|k| > 3M、|l| > 6。
- 根拠 `exp_sum` は主張を像の記号を省いて `exp(2πijk/M)` と書いており、証明はその項を `exp(i(2π(j_Z)_R k_R/(M)_R)_C)`、
  係数を `(M)_C` と読む旨を地の文で述べてから適用している。検算では両者を同じ E(q) で表しており、この読み替えそのものは確かめていない
  （`exp_sum` の書き方を直すのは、そのブロックの見直しで扱う）。
- 像の行（`check_image_lines.sage`）と「とくに」の背理法の鎖の各行は、`ZZ`・`QQ` の上では自明に成り立つ比較であり、
  具体の値で計算が通ることを確かめるだけである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh antiperiodic_exp_sum
```

実行ログは `logs/` に保存する。
