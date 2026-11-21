# SageMath Check: trace_of_epsilon_V_plus_via_check_eigenvalues

## 対象

**対象ラベル**: `trace_of_epsilon_V_plus_via_check_eigenvalues`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_003_claim_trace_epsilon_V_plus_via_eigenvalues`（ϰ := (2sinh 2K_2)^{M_col/2} Π_μ 2sinh(γ(θ̃_μ)/2) ∈ ℝ について
  (1) tr(εV^{(+)}) = η_{(1,…,1)}ϰ_ℂ、(2) ϰ > 0、(3) η_{(1,…,1)} = +1 ⟺ tr(εV^{(+)}) > 0。ℂ の元の z > 0 は「z = r_ℂ なる r ∈ ℝ_{>0} がある」）
- 範囲: 証明の Step 1（13 行）、Step 2（k = 1 の二つの場合の 5 行・7 行と、帰納法の段の二つの場合の 6 行ずつ、最後の Π_{μ∈M̌} の 3 行の鎖）、Step 3（7 行）、
  Step 4（第一の鎖 9 行と第二の鎖 15 行。行数は等号の数）、Step 5（8 行。1 行目は Step 1 の鎖そのもの）、Step 6（5 つの鎖）、Step 7（同値の 2 つの鎖と r = ȟϰ < 0 の鎖）の全ての行と、主張そのもの。
- 記号（証明の中だけ）: ȟ ∈ {1, −1} ⊂ ℝ（ȟ_ℂ = η_{(1,…,1)}）、ǔ^{(1)} := 1、ǔ^{(0)} := −1、|ε|_k := #{μ ≤ k | ε(μ) = 1}
  （def_number_of_ones_of_binary_assignment_among_first_indices）、ť_ε := (Π_{μ∈M̌} ǔ^{(ε(μ))})Λ̌_ε、w̌_μ^{(e)} := ǔ^{(e)}exp(γ(θ̃_μ)h(e))
  （h(1) := 1/2、h(0) := −(1/2) は def_half_sign_of_binary_value）。ε ∈ {0,1}^{M̌} は値の組 (ε(1), …, ε(M_col)) で持ち、値に算術はしない。
  Λ̌_ε は eigenvalues_of_V_plus の (2sinh 2K_2)^{M_col/2} exp(Σ_{μ∈M̌} γ(θ̃_μ)h(ε(μ)))。

## 使う行列と値

本文の ψ̌（`def_check_fermi` の式どおりの行列）、ε、ň_μ := ψ̌_μ^†ψ̌_{σ(μ)}、Q̌_ε、η_ε は `../epsilon_eigenvalue_on_check_Q/_prelude.sage` の
`EpsilonSetting` から取る（結合定数 K_1 := 2 log y、K_2 := log x、(x, y) ∈ {(2,2), (3,3/2), (5/4,3)}、M_col = 2, 3。成分は数体 E_1 の元で厳密。
η_ε は `epsilon_eigenvalue_on_check_Q` の証明の (1) の作り方で求める）。`_prelude.sage` は、和・積・トレースを本文の定義の帰納法どおりに組む関数と、
E_1 → ComplexBallField(512) の埋め込み、γ(θ̃_μ) の球（`def_gamma_theta`・`def_arccosh`）を足す。全ての設定で η_{(1,…,1)} = +1 だった。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| Step 1 の 13 行（等号の数。`identity_matrix_is_right_unit_of_mat_mult`、`check_joint_eigenspace_decomposition` (2)、`sum_over_binary_words_distributes_in_right_factor`、`trace_of_sum_over_binary_words`、`mat_mult_associative`、`eigenvalues_of_V_plus` (1)、`scalar_multiple_factors_out_of_right_factor`、`epsilon_eigenvalue_on_check_Q` (1)、`scalar_multiple_is_associative`、`trace_of_scalar_multiple`、(4) の tr(Q̌_ε) = 1、1_ℂ は単位元、ℂ の交換律） | `check_step1_chain.sage` | 厳密。V^{(+)} を C·Π_μ(a_μň_μ + a_μ^{-1}(I − ň_μ))（C・a_μ は E_1 上のローラン多項式環の不定元）に置き、引いた主張の前提（VQ̌_ε = Λ̌_εQ̌_ε、Σ_εQ̌_ε = I、tr(Q̌_ε) = 1、εQ̌_ε = η_εQ̌_ε）を各 ε で確かめる |
| Step 2 の帰納法の全ての行（`def_finite_product_of_real_numbers`、ǔ の定義と `inclusion_rr_to_cc` の略記、`def_power_of_complex_number`、`real_inclusion_preserves_product`、帰納法の仮定、単位元、指数の書き換え）、|ε|_k の場合分けの性質、最後の 3 行の鎖（`def_product_over_check_index_set`、帰納法の k = M_col、|ε|_{M_col} = |ε|） | `check_step2_sign_power.sage` | 厳密（ℂ = QQ(i)、包含は r ↦ r + 0i）。M_col = 1..7 の全ての ε と k |
| Step 3 の 7 行（`epsilon_eigenvalue_on_check_Q` (3)、Step 2、ȟ の取り方、`real_inclusion_preserves_product` を 2 回、ℝ の (ab)c = (bc)a、ť の置き方） | `check_step3_step5_chains.sage` | 厳密な部（行の代数。η_ε は本文の ψ̌ の値、実数の量は不定元 C・a_μ の式で、包含は恒等なので包含の 2 行は自明に通る）と球の部（ℂ を ComplexBallField、包含を r ↦ r + 0i、η_ε を埋め込みの値として、包含の 2 行を値で） |
| Step 4 の第一の鎖 9 行（ť の置き方、Λ̌ の定義、`def_product_over_check_index_set`、`def_sum_over_check_index_set`、`real_exp_of_finite_sum`、ℝ の a(bc) = b(ac)、`finite_product_of_real_products`、w̌^{(e)} の置き方、交換律） | `check_step4_real_chains.sage` | 球（全ての行の値。Π_{μ∈M̌}・Σ_{μ∈M̌} と Π_{μ=1}^{M}・Σ_{μ=1}^{M} の行き来の 2 行は定義で同じ畳み込みなので同じ値を並べる）と厳密（6〜9 行の構造を exp(γ/2) を不定元にして） |
| Step 4 の第二の鎖 15 行（直前の鎖、`real_sum_over_binary_words_distributes_in_left_factor`、`expansion_of_finite_product_of_two_term_sums_of_real_numbers`、置き方、ǔ の定義、乗法の単位元 1·x = x、`real_minus_one_times_is_negation`、`def_real_difference` を右辺から左辺へ、`def_half_sign_of_binary_value` の h(1) = 1/2・h(0) = −(1/2)、a(−b) = −(ab)、`real_times_half_is_quotient_by_two`、`real_twice_quotient_by_two_is_original` を右辺から左辺へ、`def_cosh_sinh` の sinh、交換律、ϰ の置き方） | `check_step4_real_chains.sage` | 球（全ての行の値。sinh の行は Sage の sinh で独立に）と厳密（和の分配・展開・閉形式を不定元で、h の値と引数の書き換えを QQ[γ] で、1·b = b・(−1)b = −b・a + (−b) = a − b を QQ[a,b] で、b = 2·(b/2) を QQ(b) で） |
| Step 5 の 8 行（Step 1、Step 3、`real_inclusion_preserves_sum_over_binary_words`、`real_sum_over_binary_words_distributes_in_left_factor`、Step 4、交換律、`real_inclusion_preserves_product`、ȟ の取り方） | `check_step3_step5_chains.sage` | 厳密な部（行の代数）と球の部（包含の行を、ℂ を ComplexBallField、包含を r ↦ r + 0i として値で） |
| Step 6 の準備（`def_real_two` の 1 + 1 = 2、`real_two_is_nonzero` の 2 ≠ 0、`real_inverse_of_positive_is_positive`（a → 2）の 0 < 2^{-1}）と 5 つの鎖（γ/2 = γ·2^{-1}（`def_real_quotient`）> 0（正の数どうしの積は正）、`cosh_sinh_basic_properties` (3) の sinh(γ/2) > 0、`real_zero_less_than_two` の 0 < 2 と直前の鎖による 2sinh(γ/2) > 0（正の数どうしの積は正）、`finite_product_of_positive_reals_is_positive`、ϰ の置き方と `def_second_transfer_matrix_prefactor` の C > 0 と直前の鎖による ϰ > 0（正の数どうしの積は正）） | `check_step6_step7_sign.sage` | 準備は QQ で厳密に。鎖は球の全体が不等号を満たすこと（有限積は左から畳み込み、各段が正） |
| Step 7（η = +1 なら tr = 1_ℂϰ_ℂ = ϰ_ℂ。逆は r_ℂ = tr = (ȟϰ)_ℂ、ȟ = −1 なら r = ȟϰ = (−1)ϰ = −ϰ < 0 で r > 0 と両立しない。1 段目は `inclusion_rr_to_cc_is_injective`（a → r, b → ȟϰ）、3 段目は `real_minus_one_times_is_negation`、4 段目は `real_negation_of_positive_is_negative`（どちらも a → ϰ）、矛盾は `real_less_than_is_asymmetric`（a → 0, b → r）） | `check_step6_step7_sign.sage` | 厳密（ℂ = QQ(i)。ϰ の球の中の正の有理数で、ȟ = ±1 の両方） |
| 主張 (1)(2)(3) | `check_claim_statement.sage` | 球（下の「主張の検算」） |

### 主張の検算（`check_claim_statement.sage`）

V^{(+)} を `V_plus_eq_c_exp_sum_gamma_check_number_operator` の形 C·exp(X̌)（X̌ := Σ_μ γ(θ̃_μ)(ň_μ − (1/2)I)）で本文の ψ̌ の ň_μ と γ(θ̃_μ) の球から作り、
exp を Sage の球の行列の exp と `def_exp` の部分和に尾の上界を足した球の二通りで作って重なることを見る。そのうえで (i) tr(εV^{(+)}) と η_{(1,…,1)}ϰ_ℂ が重なる、
(ii) 独立な経路として `trace_of_epsilon_V_plus` の転送行列の側の値 (2exp(−K_2)cosh K_1)^M + (2exp(K_2)sinh K_1)^M とも重なる、(iii) ϰ > 0、
(iv) η_{(1,…,1)} = +1 で tr(εV^{(+)}) の虚部の球が 0 を含み実部の球が正、を確かめる。虚部がちょうど 0 であることは球では言えず、(1) の厳密な鎖が受け持つ。

### 浮動小数点（球）を使う理由と許容

γ(θ̃_μ)（arccosh の実対数、cos・cosh・sinh・tanh の値）、exp・sinh の値、C = (√(2sinh 2K_2))^M は ℝ への脱出を含むので、RealBallField(512)・ComplexBallField(512) の球で扱う。
等号は「球が重なり、半径が 1e-100 未満」、不等号は「球の全体が満たす」で判定する。区間演算なので丸めで偽の一致・不一致は出ない。

### 否定コントロール

- `check_step1_chain.sage`: η_ε を落とすと最後の行は C·Π(a + a^{-1}) になり外れる。Λ̌_ε の a を a^{-1} に取り違えると 6 行目の項が 5 行目の項と外れる。
- `check_step2_sign_power.sage`: 指数を |ε| にすると M_col が奇数で外れる。ǔ^{(0)} を +1 にすると外れる。
- `check_step3_step5_chains.sage`: Step 3 の指数を |ε| にすると（M_col = 3）厳密な部で外れ、球の部で重ならない ε がある。ȟ を −η に取り違えると外れる。ϰ の sinh を cosh にすると球が重ならない。
- `check_step4_real_chains.sage`: ǔ^{(0)} を +1 にした和（Σ_εΛ̌_ε）、sinh の引数の 1/2 を落としたもの、C を落としたものは重ならない。展開で ǔ を落とすと厳密に外れる。h(0) を +1/2 に取り違えた書き換えは恒等式でない。
- `check_step6_step7_sign.sage`: sinh の引数を −γ にすると M_col が奇数で ϰ は負。
- `check_claim_statement.sage`: sinh を cosh にした値、η を −1 にした値、ε を I に取り違えた tr(V^{(+)}) は tr(εV^{(+)}) と重ならない。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_step1_chain.sage` | Step 1 の 13 行（等号の数。結合定数 3 組 × M_col = 2, 3） | 実行済み | PASS（78 段、否定コントロール 12 件） |
| `check_step2_sign_power.sage` | Step 2 の帰納法（M_col = 1..7 の全ての ε と k） | 実行済み | PASS（9990 行、否定コントロール 171 件。2026-11-21） |
| `check_step3_step5_chains.sage` | Step 3 の 7 行（全ての ε）と Step 5 の 8 行 | 実行済み | PASS（厳密 294 段、球 294 段、否定コントロール 18 件） |
| `check_step4_real_chains.sage` | Step 4 の二つの鎖（結合定数 7 組 × M_col = 2..6、厳密は M_col = 1..6） | 実行済み | PASS（球 8302 行、厳密 532 行、否定コントロール 113 件。2026-11-21） |
| `check_step6_step7_sign.sage` | Step 6・Step 7（結合定数 7 組 × M_col = 2..6） | 実行済み | PASS（1159 行、否定コントロール 14 件） |
| `check_claim_statement.sage` | 主張 (1)(2)(3)（結合定数 3 組 × M_col = 2, 3） | 実行済み | PASS（30 件、否定コントロール 18 件） |

## 書き直し（2026-11-21）

本文の ε の記法の書き直しに合わせた。|ε|_k の性質を ε(1)・ε(k+1) の値の場合分けで確かめ（以前は |ε|_1 = ε_1・|ε|_{k+1} = |ε|_k + ε_{k+1}）、Step 2 の最後の
Π_{μ∈M̌} の 3 行の鎖を足した。Step 4 は w̌_μ^{(e)}・Λ̌_ε の指数を γ(e − 1/2) から γh(e) に替え、第一の鎖に Π・Σ を M̌ の上から 1..M_col へ開く 2 行を足し、
第二の鎖の `real_one_minus_half_is_half` の行と 0 − a = −a の行を h(1)・h(0) を引く 1 行にした。Step 1・Step 3 の Λ̌_ε の不定元の指数を
a_μ^{2ε_μ−1} から a_μ^{2h(ε(μ))} に、|ε| を値の数え上げに替えた（値は同じ）。Q̌_ε は `../epsilon_eigenvalue_on_check_Q/_prelude.sage` が
def_check_Q_epsilon の Π R_μ^{(ε(μ))} で作る。

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh trace_of_epsilon_V_plus_via_check_eigenvalues
```
