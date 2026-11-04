# SageMath Check: trace_of_epsilon_V_plus_via_check_eigenvalues

## 対象

**対象ラベル**: `trace_of_epsilon_V_plus_via_check_eigenvalues`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_003_claim_trace_epsilon_V_plus_via_eigenvalues`（ϰ := (2sinh 2K_2)^{M_col/2} Π_μ 2sinh(γ(θ̃_μ)/2) ∈ ℝ について
  (1) tr(εV^{(+)}) = η_{(1,…,1)}ϰ_ℂ、(2) ϰ > 0、(3) η_{(1,…,1)} = +1 ⟺ tr(εV^{(+)}) > 0。ℂ の元の z > 0 は「z = r_ℂ なる r ∈ ℝ_{>0} がある」）
- 範囲: 証明の Step 1（13 行）、Step 2（k = 1 の二つの場合の 5 行・7 行と、帰納法の段の二つの場合の 6 行ずつ）、Step 3（7 行）、
  Step 4（第一の鎖 7 行と第二の鎖 15 行。行数は等号の数）、Step 5（8 行。1 行目は Step 1 の鎖そのもの）、Step 6（4 つの鎖）、Step 7（同値の 2 つの鎖と r = ȟϰ < 0 の鎖）の全ての行と、主張そのもの。
- 記号（証明の中だけ）: ȟ ∈ {1, −1} ⊂ ℝ（ȟ_ℂ = η_{(1,…,1)}）、ǔ^{(1)} := 1、ǔ^{(0)} := −1、|ϵ|_k := #{μ ≤ k | ϵ_μ = 1}、
  ť_ϵ := (Π_μ ǔ^{(ϵ_μ)})Λ̌_ϵ、w̌_μ^{(e)} := ǔ^{(e)}exp(γ(θ̃_μ)(e − 1/2))。

## 使う行列と値

本文の ψ̌（`def_check_fermi` の式どおりの行列）、ε、ň_μ := ψ̌_μ^†ψ̌_{σ(μ)}、Q̌_ϵ、η_ϵ は `../epsilon_eigenvalue_on_check_Q/_prelude.sage` の
`EpsilonSetting` から取る（結合定数 K_1 := 2 log y、K_2 := log x、(x, y) ∈ {(2,2), (3,3/2), (5/4,3)}、M_col = 2, 3。成分は数体 E_1 の元で厳密。
η_ϵ は `epsilon_eigenvalue_on_check_Q` の証明の (1) の作り方で求める）。`_prelude.sage` は、和・積・トレースを本文の定義の帰納法どおりに組む関数と、
E_1 → ComplexBallField(512) の埋め込み、γ(θ̃_μ) の球（`def_gamma_theta`・`def_arccosh`）を足す。全ての設定で η_{(1,…,1)} = +1 だった。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| Step 1 の 13 行（等号の数。`identity_matrix_is_right_unit_of_mat_mult`、`check_joint_eigenspace_decomposition` (2)、`sum_over_binary_words_distributes_in_right_factor`、`trace_of_sum_over_binary_words`、`mat_mult_associative`、`eigenvalues_of_V_plus` (1)、`scalar_multiple_factors_out_of_right_factor`、`epsilon_eigenvalue_on_check_Q` (1)、`scalar_multiple_is_associative`、`trace_of_scalar_multiple`、(4) の tr(Q̌_ϵ) = 1、1_ℂ は単位元、ℂ の交換則） | `check_step1_chain.sage` | 厳密。V^{(+)} を C·Π_μ(a_μň_μ + a_μ^{-1}(I − ň_μ))（C・a_μ は E_1 上のローラン多項式環の不定元）に置き、引いた主張の前提（VQ̌_ϵ = Λ̌_ϵQ̌_ϵ、Σ_ϵQ̌_ϵ = I、tr(Q̌_ϵ) = 1、εQ̌_ϵ = η_ϵQ̌_ϵ）を各 ϵ で確かめる |
| Step 2 の帰納法の全ての行（`def_finite_product_of_real_numbers`、ǔ の定義と `inclusion_rr_to_cc` の略記、`def_power_of_complex_number`、`real_inclusion_preserves_product`、帰納法の仮定、単位元、指数の書き換え）と |ϵ|_k の性質 | `check_step2_sign_power.sage` | 厳密（ℂ = QQ(i)、包含は r ↦ r + 0i）。M_col = 1..7 の全ての ϵ と k |
| Step 3 の 7 行（`epsilon_eigenvalue_on_check_Q` (3)、Step 2、ȟ の取り方、`real_inclusion_preserves_product` を 2 回、ℝ の (ab)c = (bc)a、ť の置き方） | `check_step3_step5_chains.sage` | 厳密な部（行の代数。η_ϵ は本文の ψ̌ の値、実数の量は不定元 C・a_μ の式で、包含は恒等なので包含の 2 行は自明に通る）と球の部（ℂ を ComplexBallField、包含を r ↦ r + 0i、η_ϵ を埋め込みの値として、包含の 2 行を値で） |
| Step 4 の第一の鎖 7 行（ť の置き方、Λ̌ の定義、`real_exp_of_finite_sum`、ℝ の a(bc) = b(ac)、`finite_product_of_real_products`、a^{(e)} の置き方、交換則） | `check_step4_real_chains.sage` | 球（全ての行の値）と厳密（4〜7 行の構造を exp(γ/2) を不定元にして） |
| Step 4 の第二の鎖 15 行（直前の鎖、`real_sum_over_binary_words_distributes_in_left_factor`、`expansion_of_finite_product_of_two_term_sums_of_real_numbers`、置き方、ǔ の定義、1·b = b、a + (−1)b = a − b、1 − 1/2 = 1/2、0 − a = −a、a(−b) = −(ab)、a·1/2 = a/2、b = 2·(b/2)、`def_cosh_sinh` の sinh、交換則、ϰ の置き方） | `check_step4_real_chains.sage` | 球（全ての行の値。sinh の行は Sage の sinh で独立に）と厳密（和の分配・展開・閉形式を不定元で、引数の書き換えを QQ[γ] で、1·b = b・a + (−1)b = a − b を QQ[a,b] で、b = 2·(b/2) を QQ(b) で） |
| Step 5 の 8 行（Step 1、Step 3、`real_inclusion_preserves_sum_over_binary_words`、`real_sum_over_binary_words_distributes_in_left_factor`、Step 4、交換則、`real_inclusion_preserves_product`、ȟ の取り方） | `check_step3_step5_chains.sage` | 厳密な部（行の代数）と球の部（包含の行を、ℂ を ComplexBallField、包含を r ↦ r + 0i として値で） |
| Step 6 の 4 つの鎖（γ/2 = γ·1/2 > 0·1/2 = 0、`cosh_sinh_basic_properties` (3) と 2 倍、`finite_product_of_positive_reals_is_positive`、ϰ の置き方と `def_second_transfer_matrix_prefactor` の C > 0 による ab > 0） | `check_step6_step7_sign.sage` | 球の全体が不等号を満たすこと（有限積は左から畳み込み、各段が正） |
| Step 7（η = +1 なら tr = 1_ℂϰ_ℂ = ϰ_ℂ。逆は (r, 0) = r_ℂ = tr = (ȟϰ)_ℂ = (ȟϰ, 0) から r = ȟϰ、ȟ = −1 なら r = ȟϰ = (−1)ϰ = −ϰ < 0） | `check_step6_step7_sign.sage` | 厳密（ℂ = QQ(i)。ϰ の球の中の正の有理数で、ȟ = ±1 の両方） |
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

- `check_step1_chain.sage`: η_ϵ を落とすと最後の行は C·Π(a + a^{-1}) になり外れる。Λ̌_ϵ の a を a^{-1} に取り違えると 6 行目の項が 5 行目の項と外れる。
- `check_step2_sign_power.sage`: 指数を |ϵ| にすると M_col が奇数で外れる。ǔ^{(0)} を +1 にすると外れる。
- `check_step3_step5_chains.sage`: Step 3 の指数を |ϵ| にすると（M_col = 3）厳密な部で外れ、球の部で重ならない ϵ がある。ȟ を −η に取り違えると外れる。ϰ の sinh を cosh にすると球が重ならない。
- `check_step4_real_chains.sage`: ǔ^{(0)} を +1 にした和（Σ_ϵΛ̌_ϵ）、sinh の引数の 1/2 を落としたもの、C を落としたものは重ならない。展開で ǔ を落とすと厳密に外れる。0 − 1/2 を +1/2 にした書き換えは恒等式でない。
- `check_step6_step7_sign.sage`: sinh の引数を −γ にすると M_col が奇数で ϰ は負。
- `check_claim_statement.sage`: sinh を cosh にした値、η を −1 にした値、ε を I に取り違えた tr(V^{(+)}) は tr(εV^{(+)}) と重ならない。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_step1_chain.sage` | Step 1 の 13 行（等号の数。結合定数 3 組 × M_col = 2, 3） | 実行済み | PASS（78 段、否定コントロール 12 件） |
| `check_step2_sign_power.sage` | Step 2 の帰納法（M_col = 1..7 の全ての ϵ と k） | 実行済み | PASS（9228 行、否定コントロール 171 件） |
| `check_step3_step5_chains.sage` | Step 3 の 7 行（全ての ϵ）と Step 5 の 8 行 | 実行済み | PASS（厳密 294 段、球 294 段、否定コントロール 18 件） |
| `check_step4_real_chains.sage` | Step 4 の二つの鎖（結合定数 7 組 × M_col = 2..6、厳密は M_col = 1..6） | 実行済み | PASS（球 6566 行、厳密 530 行、否定コントロール 112 件） |
| `check_step6_step7_sign.sage` | Step 6・Step 7（結合定数 7 組 × M_col = 2..6） | 実行済み | PASS（1155 行、否定コントロール 14 件） |
| `check_claim_statement.sage` | 主張 (1)(2)(3)（結合定数 3 組 × M_col = 2, 3） | 実行済み | PASS（30 件、否定コントロール 18 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh trace_of_epsilon_V_plus_via_check_eigenvalues
```
