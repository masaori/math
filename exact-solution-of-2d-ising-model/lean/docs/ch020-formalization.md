# 章 020「臨界点と比熱の対数発散」の Lean 形式化

正本: `structured-latex/content/020_critical_point.ts`（15 ブロック）

この文書は `lean/README.md` への統合前の記録である（統合は呼び出し元が行う）。

## 0. 土台の選択

章 020 は章 012（Onsager の自由エネルギー）の続きで、対象は最初から
**実数 `ℝ` 上の 1 変数・2 変数の初等関数と Riemann（区間）積分**である。
行列も転送行列も現れない。したがって土台は `ℝ`、`Real.sinh` / `Real.cosh` / `Real.arsinh` /
`Real.sin` / `Real.log`、および `intervalIntegral` である。

**この章は本プロジェクトで実数解析へ最も深く踏み込む章である。** 原文はそのことを自覚しており、
`remark_real_analysis_escape_chapter_E`（ラベル `remark_real_analysis_escape_chapter_E`）で
新たに外から持ち込む事実を **(R3)〜(R6) の 4 つだけ**に限定している。形式化にあたって
それぞれの mathlib での所在を調査した結果は次のとおり。

| 原文 | 内容 | mathlib での所在 |
| --- | --- | --- |
| (R3) 線型性・単調性 | `∫(λg+νh)=λ∫g+ν∫h`、各点 `g ≤ h` ⇒ `∫g ≤ ∫h` | `intervalIntegral.integral_add` / `integral_smul` / `integral_sub` / `integral_mono_on` |
| (R4) 微分積分学の基本定理 | `F' = g` 連続 ⇒ `∫_a^b g = F(b)-F(a)` | `intervalIntegral.integral_eq_sub_of_hasDerivAt` |
| (R5) 積分記号下の微分 | 有界閉長方形上で `g`, `∂g/∂x` 連続 ⇒ `(∫g)' = ∫∂g/∂x` | **そのままの形は無い。** 優関数版 `intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le` から `Ising2D/NecSuf/DiffUnderIntegral.lean` で導いた |
| (R6) 置換積分（`θ ↦ 2π-θ`） | `∫_a^b g(d-t)dt = ∫_{d-b}^{d-a} g` | `intervalIntegral.integral_comp_sub_left` |

**(R5) だけが mathlib に「連続性だけを仮定した形」で存在しない。** これが必要十分版
`Ising2D/NecSuf/DiffUnderIntegral.lean` を立てた理由である
（コンパクト集合上の連続関数は有界だから、優関数を定数として取れば導ける）。

さらに原文は (4)(5) 等で `cosh 0.2 ≤ 1.02007` のような**初等関数の数値評価を外から持ち込む**と
宣言している。**本形式化ではこれを一切持ち込まず**、`cosh t ≤ (1-t²/2)⁻¹`
（mathlib の `Real.cosh_le_exp_half_sq` から出る）と `1 + t²/2 ≤ cosh t`、および
`Real.pi_gt_d6` / `Real.pi_lt_d6` だけから全ての数値評価を導いた。詳細は §4。

## 1. 形式化した定理の一覧

### 1.1 `Claim001_CoshAddHalfAngle.lean`（ラベル `cosh_addition_and_half_angle`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.cosh_add_formula` / `cosh_sub_formula` | `cosh` の加法定理 | (1) |
| `Ising2D.sinh_add_formula` / `sinh_sub_formula` | `sinh` の加法定理 | (1) |
| `Ising2D.cosh_eq_one_add_two_sinh_half_sq` | **`cosh x = 1 + 2 sinh²(x/2)`** | (2) |
| `Ising2D.sinh_eq_two_sinh_half_mul_cosh_half` | **`sinh x = 2 sinh(x/2) cosh(x/2)`** | (2) |
| `Ising2D.sinh_strictMono` / `sinh_injective_real` | `sinh` は狭義単調増加・単射 | (3) |
| `Ising2D.arsinh_eq_log_form` | 原文の `arcsinh y = log(y+√(y²+1))` が mathlib の `Real.arsinh` と一致 | (4) |
| `Ising2D.sinh_arsinh_eq` / `sinh_eq_iff_eq_arsinh` | `arsinh` の逆関数性 | (4) |
| `Ising2D.hasDerivAt_arsinh_form` | **`arcsinh'(y) = 1/√(1+y²)`** | (4) |
| `Ising2D.self_le_sinh_of_nonneg` | **`t ≤ sinh t`**（`t ≥ 0`） | (5) 前半 |
| `Ising2D.sinh_le_mul_cosh_of_nonneg` | **`sinh t ≤ t cosh t`**（`t ≥ 0`） | (5) 後半 |
| `Ising2D.cosh_addition_and_half_angle_five` | (1)〜(5) をまとめた形 | 主張全体 |

### 1.2 `Definition002_KappaAndCritical.lean`（ラベル `def_kappa`, `def_critical_sinh_product_A`, `gamma_kappa_identity`, `critical_point_iff_kappa_zero`, `isotropic_A_equals_one`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.kappaP` | **`κ := 2K_1 - 2K_2^*`** | `def_kappa` |
| `Ising2D.AP` / `AP_pos` | **`A := sinh 2K_1 sinh 2K_2^*`**、`A > 0` | `def_critical_sinh_product_A` |
| `Ising2D.one_sub_cos_eq` | `1 - cos θ = 2 sin²(θ/2)` | `gamma_kappa_identity` の途中 |
| `Ising2D.gamma1R_eq_cosh_kappa_add` | **`γ_1(θ) = cosh κ + 2A sin²(θ/2)`** | `gamma_kappa_identity` (1) |
| `Ising2D.Sparam` / `Sparam_nonneg` / `Sparam_even` | `S(θ) := sinh²(κ/2) + A sin²(θ/2)` | `gamma_kappa_identity` |
| `Ising2D.sinh_half_gammaFn_sq` | **`sinh²(γ(θ)/2) = sinh²(κ/2) + A sin²(θ/2)`** | `gamma_kappa_identity` (2) |
| `Ising2D.gammaFn_eq_two_arsinh` | **`γ(θ) = 2 arcsinh √S`** | `gamma_kappa_identity` (3) |
| `Ising2D.KStar` / `sinh_two_KStar` | `K^* := arsinh(1/sinh 2K)/2` と `sinh 2K^* = 1/sinh 2K` | `def_transfer_matrix_symbols` の双対関係を明示化 |
| `Ising2D.sinh_two_mul_sinh_two_KStar` / `KStar_pos` | `sinh 2K sinh 2K^* = 1`、`K^* > 0` | 同上 |
| `Ising2D.critical_point_iff_kappa_zero` | **`sinh 2K_1 sinh 2K_2 = 1 ⟺ K_1 = K_2^* ⟺ κ = 0`** | `critical_point_iff_kappa_zero` |
| `Ising2D.isoParam` / `AP_isoParam` | 等方な場合 `K_1=K_2=K` と **`A = 1`** | `isotropic_A_equals_one` (1) |
| `Ising2D.kappaK` / `kappaP_isoParam` | **`κ(K) = 2K - 2K^*`** | `isotropic_A_equals_one` (2) |
| `Ising2D.gammaFn_isoParam` | 等方な場合の `γ(θ) = 2 arcsinh√(sinh²(κ/2)+sin²(θ/2))` | `isotropic_A_equals_one` (3) |

### 1.3 `Claim006_KappaOfK.lean`（ラベル `kappa_of_K_basic`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.sqrt_two_bounds` / `cosh_02_bounds` / `sinh_02_bounds` | 数値評価の下準備（外部数値を使わず導出） | (4)(5) の数値部分 |
| `Ising2D.Kc` / `sinh_two_Kc` / `cosh_two_Kc` | **臨界点 `K_c := arsinh 1 / 2`**、`sinh 2K_c = 1` | (1) |
| `Ising2D.Kc_gt_tenth` / `Kc_pos` | `K_c > 0.1 > 0` | (1) |
| `Ising2D.kappaK_eq` | `κ(K) = 2K - arsinh(1/sinh 2K)` | (2) |
| `Ising2D.hasDerivAt_kappaK` / `kappaDeriv` | **`κ'(K) = 2 + 4cosh 2K/sinh 2K · (…)`** | (3) |
| `Ising2D.hasDerivAt_kappaDeriv` / `kappaSecond` | **`κ''(K)`** | (3) |
| `Ising2D.kappaK_Kc` / `kappaK_eq_zero_iff` | **`κ(K_c) = 0`、`κ(K) = 0 ⟺ K = K_c`** | (1)(2) |
| `Ising2D.Dnbhd` / `Dnbhd_convex` / `Kc_mem_Dnbhd` | 近傍 `D = [K_c-0.1, K_c+0.1]`（凸、`K_c` を含む） | (4) |
| `Ising2D.sinh_two_K_bounds` | `D` 上での `sinh 2K` の上下界 | (4) |
| `Ising2D.kappaDeriv_bounds` | **`D` 上で `3.52 ≤ κ' ≤ 4.74`**（原文は `[3.53, 4.72]`） | (4) |
| `Ising2D.abs_kappaSecond_le` | **`D` 上で `\|κ''\| ≤ 9.3`**（原文は `9.19`） | (4) |
| `Ising2D.abs_kappaK_bounds` | **`3.52\|K-K_c\| ≤ \|κ(K)\| ≤ 4.74\|K-K_c\|`** | (5) |
| `Ising2D.kappaDerivSq` / `abs_deriv_kappaDerivSq_le` | `(κ'²)'` と **`\|(κ'²)'\| ≤ 88.2`**（原文は `87`） | (6) |
| `Ising2D.abs_kappaDerivSq_sub_le` | **`\|κ'(K)² - 16\| ≤ 25.1\|κ(K)\|`**（原文は `24.7`） | (6) |

### 1.4 `Claim007_GammaDerivatives.lean`（ラベル `gamma_derivatives_in_kappa`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.Sfun` / `Qfun` / `gammaK` | `S(θ,κ) := sinh²(κ/2)+sin²(θ/2)`、`Q := S(1+S)`、`γ := 2 arcsinh√S` | (1) |
| `Ising2D.Sfun_nonneg` / `Sfun_pos_of_ne_zero` / `Qfun_pos_of_ne_zero` / `sqrt_Qfun_pos` | 正値性（`κ ≠ 0` で `S > 0`） | (1) |
| `Ising2D.sinh_half_gammaK` / `cosh_half_gammaK` / `sinh_gammaK` / `cosh_gammaK` | **`sinh(γ/2)=√S`, `sinh γ = 2√Q`, `cosh γ = 1+2S`** | (1) |
| `Ising2D.hasDerivAt_Sfun` / `hasDerivAt_Qfun` / `hasDerivAt_gammaK` | `∂S/∂κ`, `∂Q/∂κ`, `∂γ/∂κ` の存在と値 | (2) |
| `Ising2D.dgammaK` / `dgammaK_eq_sinh_div_sinh` | **`∂γ/∂κ = sinh κ / sinh γ`** | (2) 第 1 式 |
| `Ising2D.abs_dgammaK_le_one` | **`\|∂γ/∂κ\| ≤ 1`** | (3) |
| `Ising2D.hasDerivAt_dgammaK` / `d2gammaK` / `d2gammaK_eq` | **`∂²γ/∂κ² = cosh κ/sinh γ - sinh²κ cosh γ/sinh³γ`** | (4) |
| `Ising2D.sinh_sq_div_four_le_Qfun` | `sinh²(κ/2)·(…)/4 ≤ Q`（下界評価） | (4) の評価 |
| `Ising2D.continuous_*`（10 本） | `S, Q, γ, ∂γ/∂κ, ∂²γ/∂κ²` の（2 変数・1 変数固定の）連続性 | (R5) 適用のため |

### 1.5 `Claim008_ElementarySineBounds.lean`（ラベル `elementary_sine_bounds`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.c0` / `c0_bounds` / `c0_pos` / `c0_le_one` | **`c_0 := 1 - π²/24`**、`0.5887 ≤ c_0 ≤ 0.5888` | (2) |
| `Ising2D.elementary_sine_bounds_cube` | **`0 ≤ θ/2 - sin(θ/2) ≤ θ³/48`**（`0 ≤ θ ≤ π`） | (1) |
| `Ising2D.elementary_sine_bounds_linear` | **`c_0(θ/2) ≤ sin(θ/2) ≤ θ/2`**（`0 ≤ θ ≤ π`） | (2) |

### 1.6 `Claim009_ClosedFormLogIntegral.lean`（ラベル `closed_form_log_integral`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.integral_inv_sqrt_pi` | **`∫_0^π dθ/√(δ²+θ²/4) = 2 arcsinh(π/(2δ))`** | (1) |
| `Ising2D.arsinh_log_bounds` | **`log(2y) ≤ arcsinh y ≤ log(2y)+1/(4y²)`** | (2) 前半 |
| `Ising2D.integral_inv_sqrt_pi_bounds` | **`2log(π/δ) ≤ ∫ ≤ 2log(π/δ)+2δ²/π²`** | (2) 後半 |
| `Ising2D.integral_inv_pow_three_half_pi` | `∫_0^π dθ/(δ²+θ²/4)^{3/2}` の閉じた形 | (3) |

### 1.7 `Claim010_SineIntegralTwoSided.lean`（ラベル `sine_integral_two_sided`）

**対数発散の源。**

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.Bconst` / `Bconst_le` / `Bconst_nonneg` | **`B := π²/(12c_0(1+c_0))`**、`0 ≤ B ≤ 0.88` | 主張中の `B` |
| `Ising2D.continuous_sineIntegrand` / `continuous_quadIntegrand` | 被積分関数の連続性 | 積分可能性 |
| `Ising2D.sine_integral_two_sided` | **`2log(π/δ) ≤ ∫_0^π dθ/√(δ²+sin²(θ/2)) ≤ 2log(π/δ)+2δ²/π²+B`** | 主張全体 |

### 1.8 `Theorem011_SecondDerivativeLogDivergence.lean`（ラベル `second_derivative_log_divergence`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.Gfun` / `Gfirst` / `Gsecond` | **`G(κ) := (1/4π)∫_0^{2π}γ dθ`** とその 1・2 階導関数の式 | 主張の設定 |
| `Ising2D.hasDerivAt_Gfun` | **Step 1**: `G' = (1/4π)∫∂γ/∂κ`（(R5) 1 回目） | Step 1 |
| `Ising2D.hasDerivAt_Gfirst` | **Step 1**: `G'' = (1/4π)∫∂²γ/∂κ²`（(R5) 2 回目） | Step 1 |
| `Ising2D.abs_Gfirst_le` | `\|G'\| ≤ 1/2`（`\|∂γ/∂κ\| ≤ 1` から） | Step 1 の系 |
| `Ising2D.Sfun_two_pi_sub` / `d2gammaK_two_pi_sub` / `integral_fold` | **Step 2**: `θ ↦ 2π-θ` の対称性で `[0,2π]` を `[0,π]` へ折り畳む（(R6)） | Step 2 |
| `Ising2D.Jint` / `Iint` / `Tint` | 3 つの積分 `J, I, T` の定義 | Step 3 |
| `Ising2D.continuous_Jintegrand` / `continuous_Iintegrand` / `continuous_Tintegrand` | 被積分関数の連続性 | Step 3 |
| `Ising2D.integral_d2gammaK_eq` | **Step 3**: `∫∂²γ/∂κ² = cosh κ · J/2 - T` の分解 | Step 3 |
| `Ising2D.Sfun_le_cosh_sq` / `inv_sqrt_diff_S_Q` / `abs_Jint_sub_Iint` | **Step 4**: `0 ≤ I - J ≤ (π/2)cosh(κ/2)` | Step 4 |
| `Ising2D.coshgamma_div_sinhgamma_cube_le` / `inv_pow_three_half_mono` / `Tint_le` | **Step 5**: `0 ≤ T ≤ 2cosh²(κ/2)/c_0` | Step 5 |
| `Ising2D.two_pi_mul_Gsecond` | `2πG'' = cosh κ·log(π/sinh(κ/2)) + (cosh κ/2)(J - 2log(π/sinh(κ/2))) - T` | Step 6 の分解 |
| `Ising2D.step6_bound` | **Step 6**: `\|cosh κ·log(π/sinh(κ/2)) - log(1/κ)\| ≤ 2.27` | Step 6 |
| `Ising2D.second_derivative_log_divergence_pos` | **`\|G''(κ) - (1/2π)log(1/κ)\| ≤ 6/5`**（`0 < κ ≤ 1/2`） | 主張（`κ>0` の場合） |
| `Ising2D.Sfun_neg` / `d2gammaK_neg` / `Gsecond_neg` | **`G''` は `κ` の偶関数** | 主張の `\|κ\|` への一般化 |
| `Ising2D.second_derivative_log_divergence` | **`\|G''(κ) - (1/2π)log(1/\|κ\|)\| ≤ 6/5`（`0 < \|κ\| ≤ 1/2`）** | **主張全体** |
| `Ising2D.Gsecond_ge` | **`G''(κ) ≥ (1/2π)log(1/\|κ\|) - 6/5 → +∞`（`κ → 0`）** | 主張の帰結 |

### 1.9 `Theorem012_SpecificHeatLogDivergence.lean`（ラベル `specific_heat_log_divergence`）

**章 020 の到達点。** 章 012・018 の自由エネルギー（極限で与えられる）と本章の `G ∘ κ` を
結ぶ橋渡しを含む。

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.gammaFn_isoParam_eq_gammaK` | **橋渡しの核**: 等方な場合 `γ_P(θ) = γ(θ, κ(K))`（`gammaFn (isoParam K hK) θ = gammaK θ (kappaK K)`）。`gammaFn_isoParam` を展開すると両辺は**定義的に等しい**（`rfl`） | Step 1 |
| `Ising2D.integral_gammaFn_isoParam` | **橋渡し**: `(1/4π)∫_0^{2π} γ_P dθ = G(κ(K))` | Step 1 |
| `Ising2D.fFun` | **`f(K) := (1/2)log(2 sinh 2K) + G(κ(K))`** | 主張の設定 |
| `Ising2D.onsager_free_energy_isoParam` | **橋渡し（章 012 へ）**: `(1/M)log Λ^{(δ)}_M → f(K)` | Step 1 |
| `Ising2D.onsager_exact_solution_isoParam` | **橋渡し（章 018 へ）**: Onsager の厳密解の自由エネルギーは等方な場合ちょうど `f(K)`。仮定は `onsager_exact_solution` と同じ 3 つ（`hc`, `hZ1`, `hZ2`）だけで、**追加の仮定は無い** | Step 1 |
| `Ising2D.fFirst` / `Ising2D.fSecond` | `f'`, `f''` の式 | Step 2, 3 |
| `Ising2D.hasDerivAt_logTerm` / `hasDerivAt_logTermDeriv` | `((1/2)log(2 sinh 2K))' = cosh 2K/sinh 2K`、`(cosh 2K/sinh 2K)' = -2/sinh²2K` | Step 2 |
| `Ising2D.hasDerivAt_fFun` / `hasDerivAt_fFirst` | 合成関数の 1・2 階微分（`f'' = G''κ'² + G'κ''`） | Step 3 |
| `Ising2D.eventually_hasDerivAt_fFun` / `hasDerivAt_deriv_fFun` / `deriv_deriv_fFun` | `K ≠ K_c` の近傍で `deriv f = fFirst` となることを経由して、**`deriv (deriv fFun) K = fSecond K`** | Step 3 |
| `Ising2D.abs_logTerm_second_le` | **Step 2**: `\|((1/2)log(2 sinh 2K))''\| ≤ 3.74`（原文 `3.70`） | Step 2 |
| `Ising2D.abs_Gfirst_mul_kappaSecond_le` | **Step 3**: `\|G'κ''\| ≤ 4.65`（原文 `4.60`） | Step 3 |
| `Ising2D.abs_Gsecond_le` | `\|G''(κ)\| ≤ (1/2π)log(1/\|κ\|) + 6/5` | Step 4 の下準備 |
| `Ising2D.abs_kappaDerivSq_sub_mul_Gsecond_le` | **Step 4**: `\|(κ'²-16)G''\| ≤ 15.75`（原文 `15.44`） | Step 4 |
| `Ising2D.abs_sixteen_Gsecond_sub_le` | **Step 5**: `\|16G'' - (8/π)log(1/\|κ\|)\| ≤ 19.2` | Step 5 |
| `Ising2D.abs_fSecond_sub_le` | **Step 6**: `\|f''(K) - (8/π)log(1/\|κ(K)\|)\| ≤ 45` | Step 6 |
| `Ising2D.specific_heat_log_divergence` | **主張全体**: `K ∈ D`, `K ≠ K_c` で `f` は 2 回微分可能かつ **`\|d²f/dK² - (8/π)log(1/\|κ(K)\|)\| ≤ 45`** | **主張全体** |
| `Ising2D.fSecond_ge` | 帰結: `d²f/dK² ≥ (8/π)log(1/\|κ\|) - 45` | 主張の帰結 |
| `Ising2D.log_474_le` / `abs_log_kappa_sub_log_dist_le` | **Step 7**: `log 4.74 ≤ 1.5636`、`\|log(1/\|κ\|) - log(1/\|K-K_c\|)\| ≤ 1.5636` | Step 7 |
| `Ising2D.specific_heat_log_divergence_dist` | **Step 7**: `\|d²f/dK² - (8/π)log(1/\|K-K_c\|)\| ≤ 49` | Step 7 |
| `Ising2D.tendsto_log_inv_dist_atTop` | `K → K_c` で `log(1/\|K-K_c\|) → +∞` | Step 8 |
| `Ising2D.specific_heat_ratio_tendsto` | **Step 8**: `lim_{K→K_c} (d²f/dK²)/log(1/\|K-K_c\|) = 8/π` | Step 8 |

**`specific_heat_log_divergence` が仮定しているもの**: `K ∈ Dnbhd`（`= [K_c-1/10, K_c+1/10]`）
と `K ≠ K_c` の 2 つだけで、これは原文の `0 < |K-K_c| ≤ 1/10` そのものである。
**橋渡しに追加の仮定は要らなかった**——`gammaFn (isoParam K hK) θ` と `gammaK θ (kappaK K)` は
`isotropic_A_equals_one`（`gammaFn_isoParam`）を展開すると定義的に等しく、
章 012 の `onsager_free_energy_expression` の極限値の積分項がそのまま `Gfun (kappaK K)` になる。

`d²f/dK²` は `deriv (deriv fFun)`（mathlib の `deriv` の 2 回適用）で表した。
`deriv fFun` は `K_c` を除いた近傍でのみ `fFirst` に一致する（`κ(K) = 0` すなわち `K = K_c` では
`G` の微分を与える `hasDerivAt_Gfun` が使えない）ので、
`eventually_hasDerivAt_fFun` で「近傍で一致する」ことを示してから
`HasDerivAt.congr_of_eventuallyEq` で 2 階微分へ渡している。

## 2. 具体版と必要十分版の 2 本立ての対応

| 必要十分版（`lean/Ising2D/NecSuf/`） | 対応する具体版 | 必要十分版で判明した本質 |
| --- | --- | --- |
| `HyperbolicBounds.lean` | `Part020/Claim001_CoshAddHalfAngle.lean`, `Part020/Claim009_ClosedFormLogIntegral.lean` | 原文 (1)〜(5) のうち mathlib に無いのは **`sinh t ≤ t cosh t` 1 本だけ**で、それも `(t cosh t - sinh t)' = t sinh t` の**符号**だけで出る。`t ≥ 0` の仮定は結論の向きのためだけで、単調性自体は `ℝ` 全体で成り立つ。原文の `arcsinh` の逆関数性・微分は**対数発散の本体には効いていない**——効いているのは `arsinh y - log(2y) ∈ [0, 1/(4y²)]` という**平方根の 2 次評価**だけである。 |
| `MeanValueTwoSided.lean` | `Part020/Claim006_KappaOfK.lean` (5) | 原文は (R4)（微分積分学の基本定理）＋(R3)（積分の単調性）で `3.53\|K-K_c\| ≤ \|κ\| ≤ 4.72\|K-K_c\|` を出すが、**積分は効いていない**。効いているのは (a) 定義域が凸 (b) 導関数が定数で両側から抑えられる (c) 下界が非負、の 3 点だけで、**平均値の定理で足りる**。`κ` が Ising 模型の量であることも `arcsinh` で書けることも効いていない。 |
| `LogDivergentIntegral.lean` | `Part020/Claim009_ClosedFormLogIntegral.lean`, `Part020/Claim010_SineIntegralTwoSided.lean` | **`sin` は効いていない。** 対数発散に効いているのは被積分関数の分母 `w` についての 2 つの各点評価 `c₀(aθ) ≤ w(θ) ≤ aθ` と `aθ - w(θ) ≤ Cθ³` **だけ**である。この 2 条件から差が `δ` に依存しない定数で抑えられ、発散の形は `∫_0^b dθ/√(δ²+(aθ)²) = arsinh(ab/δ)/a` という**完全に初等的な積分**だけで決まる。三角関数も周期性も `θ/2` という内部関数も効いていない。さらに原文の定数 `B = π²/(12c_0(1+c_0))` は必要十分版の `Cb²/(c_0(1+c_0)a²)` に `a=1/2, b=π, C=1/48` を入れたものと**厳密に一致する**（原文の定数は最良化されていないが、必要十分版と同じ値）。 |
| `DiffUnderIntegral.lean` | `Part020/Theorem011_SecondDerivativeLogDivergence.lean` | 原文 (R5) は `[a,b]×[x_1,x_2]`（有界閉長方形）で述べているが、効いているのは (a) 積分区間がコンパクト (b) パラメータの動く範囲が `x_0` の**近傍**（閉区間である必要はない） (c) `g` と `∂g/∂x` がその上で連続、の 3 点だけである。被積分関数が `θ` について偶関数であることも、`γ` が Ising 模型に由来することも効いていない。**mathlib に (R5) のこの形は無く**、優関数版から導出する必要があった（コンパクト上の連続関数の有界性で優関数を定数に取る）。 |

### 必要十分版を立てなかった主張とその理由

* **`Claim007_GammaDerivatives.lean`（`gamma_derivatives_in_kappa`）**:
  内容は「`κ ↦ 2 arcsinh√(sinh²(κ/2)+c)` の 1・2 階導関数を計算する」ことで、効いているのは
  合成関数の微分と `arcsinh' = 1/√(1+y²)` だけ。`θ` は「`κ` に依存しない非負定数 `c` を足す」
  以上の役割を持たない。この観察を必要十分版に切り出しても mathlib の `HasDerivAt` の合成規則を
  書き写すだけになるので、具体版のみとした。
* **`Claim008_ElementarySineBounds.lean`（`elementary_sine_bounds`）**:
  原文は (R4)(R3) を 3 段重ねて `t - t³/6 ≤ sin t ≤ t` を導くが、**mathlib はこれをそのまま持つ**
  （`Real.sin_le`, `Real.sin_ge_sub_cube`）。本主張に固有なのは `t = θ/2` と置いて `θ ∈ [0,π]` に
  制限することだけで、必要十分版は mathlib の 2 補題そのものになる。

## 3. 形式化できなかった主張とその理由

| 原文のブロック（ラベル） | 内容 | 形式化しなかった理由 |
| --- | --- | --- |
| `critical_013_remark_physical_specific_heat`（`remark_physical_specific_heat`） | 物理的な比熱 `C = k_B K² d²f/dK²` との対応 | **形式化の対象外。** 数学的主張ではなく、無次元量と物理量の辞書（記号の読み替え）を述べる注記である。 |
| `critical_000_remark_escape_to_real_analysis_chapter_E`（`remark_real_analysis_escape_chapter_E`） | (R3)〜(R6) の宣言 | **形式化の対象外（ただし全項目を mathlib へ対応づけ済み）。** これは「この章でどこまで実数解析へ脱出するか」を宣言するメタな注記であり、定理ではない。対応表は §0 に、(R5) の導出は `NecSuf/DiffUnderIntegral.lean` にある。 |

## 4. 人手証明との定数の差（原文の数値評価を持ち込まなかったことによる）

原文は `cosh 0.2 ≤ 1.02007` 等を「初等関数の数値評価」として外から持ち込むと宣言している。
本形式化はこれを持ち込まず、`Ising2D.NecSuf.cosh_le_inv_one_sub_sq_div_two`
（`cosh t ≤ (1-t²/2)⁻¹`）と `one_add_sq_div_two_le_cosh` から導いた。そのぶん定数が悪くなる。

| 量 | 原文 | 本形式化 |
| --- | --- | --- |
| `sinh 2K` の下界（`D` 上） | `0.7353` | `0.7313` |
| `sinh 2K` の上界（`D` 上） | `1.3048` | `1.3091` |
| `κ'` の範囲 | `[3.53, 4.72]` | `[3.52, 4.74]` |
| `\|κ''\|` の上界 | `9.19` | `9.3` |
| `\|(κ'²)'\|` の上界 | `87` | `88.2` |
| `\|κ'²-16\|/\|κ\|` | `24.7` | `25.1` |
| `\|2πG'' - log(1/κ)\|` の上界 | （原文は途中で明示せず） | `6.9` |

**結論の定数 `6/5` は原文のまま成立する**（`6.9/(2π) ≤ 1.10 ≤ 6/5`）。

`specific_heat_log_divergence`（章の到達点）でも同様に各段の定数がわずかに悪くなる。

| Step | 原文 | 本形式化 |
| --- | --- | --- |
| Step 2 `\|((1/2)log(2 sinh 2K))''\|` | `3.70` | `3.74` |
| Step 3 `\|G'κ''\|` | `4.60` | `4.65` |
| Step 4 `\|(κ'²-16)G''\|` | `15.44` | `15.75` |
| Step 5 `\|16G'' - (8/π)log(1/\|κ\|)\|` | `19.2` | `19.2` |
| 合計 | `42.94` | `43.34` |
| Step 7 `log 4.74`（原文は `log 4.72 ≤ 1.5518`） | `1.5518` | `1.5636` |

**結論の定数 `45` と `49` はいずれも原文のまま成立する**
（`43.34 ≤ 45`、`45 + (8/π)·1.5636 ≤ 48.99 ≤ 49`）。

また原文 (4) は `\|κ''\|` の上界に「`t ↦ 4cosh t/sinh²t` が `t > 0` で単調減少」を使うが、
本形式化では `cosh 2K = √(1+sinh²2K)` に直して「`s ↦ 4√(1+s²)/s²` が `s > 0` で単調減少」という
**代数的な**形で使った（`sinh` の単調性しか要らず、微分が要らない）。

## 5. 人手証明に見つけた不備

`docs/tasks/2026-07_lean-ch009-013/016_ch020-formalization-findings.md` に一次情報つきで記録した。
`structured-latex/` の本文は変更していない。
