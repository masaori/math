# 章 014「偶セクターでの `T` の作用」の Lean 形式化

対象: もと `structured-latex/content/014_even_sector_T_action.ts` の定義・主張 19 本。章立ての組み直しで、すべて `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` へ移った

新規ファイル:

- 具体版: `lean/Ising2D/EigenvalueProblem/ReductionToATheta/`（章立てに合わせて旧 `Part014/` から移した。ファイル名の番号は外した）
- 必要十分版: `lean/Ising2D/NecSuf/TVActionSandwich.lean`（新規は 1 本だけ。理由は 2 節）

`lean/README.md` への統合は呼び出し元が行う（本ファイルは章 014 の作業記録）。

---

## 1. 形式化した定理の一覧

### 具体版（人手証明と 1 対 1）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.H1plus`（章 004）/ `V1plusHalf`（章 010） | `H_1^{(+)}` と `(V_1^{(+)})^{1/2}`（人手の本文は定義を章 004・010 の 1 か所にまとめ、章 014 の重複定義を削除した） | `def_H1_plus` / `def_V1_plus_square_root` |
| `Ising2D.VPlus` / `VPlusUnits` | `V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}` とその単元版（`V_2` を `V2H2Form M s2 K2star` で書いた一般形） | `def_V_plus` |
| `Ising2D.VPlusOfTransfer_eq_VPlus` | 人手の `V_2`（`def_transfer_matrix`）で作った `V^{(+)}`（章 010 の `VPlusOfTransfer`）は `VPlus M (sinh 2K_2) K_1 K_2^*` に等しい（`V2_exponential_representation` による） | `def_V_plus` |
| `Ising2D.V2Units` / `V2Units_eq_V2H2FormUnits` / `isUnit_V2` | 人手の `V_2` の単元と可逆性 | `V2_invertible` |
| `Ising2D.isUnit_V1plusHalf` | `(V_1^{(+)})^{1/2}` の可逆性 | `V1_plus_half_invertible` |
| `Ising2D.isUnit_VPlus` | `V^{(+)}` の可逆性 | `V_plus_factors_invertible` |
| `Ising2D.V1_plus_square_root_property`（章 010） | `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}` | `V1_plus_square_root_property` |
| `Ising2D.TVPlus` | `T_{(V^{(+)})}` を ℂ-代数自己同型として（一般形） | `def_T_V_plus` |
| `Ising2D.TV_V1plusHalfUnits_V2Units` | 人手の `V_2` で作った `T_{(V^{(+)})}` は `TVPlus` の `s_2 = sinh 2K_2`, `K_2^*` での値 | `def_T_V_plus` |
| `Ising2D.TVPlus_eq_TConj` / `TVPlus_apply_eq_conj` | `T_{(V^{(+)})} = T_{V^{(+)}}` | `T_V_plus_is_conjugation` |
| `Ising2D.checkPhase_mul_neg`（`ClaimNestedCommutator.lean`） | `e^{-iθ~_μ} e^{iθ~_μ} = 1`（帰納段階で使う唯一の位相の性質） | `nesting_of_commutator_of_H_and_check_Z` の proof |
| `Ising2D.comm_smul_smul` | 交換子の双線型性 `[αX, βW] = αβ[X, W]`（人手の証明の冒頭の 4 行の鎖） | `nesting_of_commutator_of_H_and_check_Z` の proof |
| `Ising2D.nesting_H1Plus_checkZ_step_even_to_odd` / `..._step_odd_to_even` ほか 8 本 | 4 式それぞれの帰納段階 1（`n` 偶数 → `n+1` 奇数）・帰納段階 2（`n` 奇数 → `n+1` 偶数）の鎖（`C_{n+1} = [K_1H_1^{(+)}, C_n]` と帰納法の仮定 → 双線型性 → (A)〜(D) → スカラーの整理） | 同上 |
| `Ising2D.nesting_H1Plus_checkZ_even` / `..._odd` | (h1.z) の偶数側・奇数側（偶数側は基底段階の `calc` と、帰納段階 1・2 を続けて当てる `k` の帰納法） | `nesting_of_commutator_of_H_and_check_Z` (h1.z) |
| `Ising2D.nesting_H1Plus_checkY_even` / `..._odd` | (h1.y) の偶数側・奇数側 | 同上 (h1.y) |
| `Ising2D.nesting_H2_checkZ_even` / `..._odd` | (h2.z) の偶数側・奇数側 | 同上 (h2.z) |
| `Ising2D.nesting_H2_checkY_even` / `..._odd` | (h2.y) の偶数側・奇数側 | 同上 (h2.y) |
| `Ising2D.adPow_eq_iterComm` / `Ising2D.nesting_*_of_necSuf` 8 本（`ClaimNestedCommutatorFromNecSuf.lean`） | 同じ 8 本を、必要十分版 `NecSuf.nested_*`（`NecSuf/NestedCommutatorTwoDim.lean`。`[h,z] = 2p y`・`[h,y] = -2q z`・`pq = 1`）に `(h, p, q) = (H_1^{(+)}, e^{-iθ~}, e^{iθ~})`・`(H_2, -1, -1)` を渡して導いたもの | 同上 |
| `Ising2D.ad_smul_left` / `ad_smul_right` / `adPow_smul_left`（`ClaimCoefficientConversion.lean`） | 補題 1 `ad_{αX}^n = α^n ad_X^n`（`ad_{αX} = α ad_X`、`ad_X` の ℂ 線型性、`n` の帰納法） | `cosh_sinh_coefficient_conversion_for_check` の補題 1 |
| `Ising2D.I_pow_even` / `I_pow_odd` | 補題 2 `i^{2k} = (-1)^k`、`i^{2k+1} = i(-1)^k` | 同上の補題 2 |
| `Ising2D.conversion_H1Plus_checkZ_even` / `..._odd` ほか 8 本 | (h1.z)(h1.y)(h2.z)(h2.y)。人手の鎖（補題 1 → `nesting_*` の代入 → `(i/2)^n = i^n2^{-n}`・`(2K_1)^n = 2^nK_1^n`・`2^{-n}2^n = 1` → 補題 2 → 符号の整理）どおりの `calc` | `cosh_sinh_coefficient_conversion_for_check` |
| `Ising2D.adPow_smul_left_of_necSuf` / `conversion_*_of_necSuf` 8 本（`ClaimCoefficientConversionFromNecSuf.lean`） | 同じ 8 本を、具体版と同じ手順のまま補題 1 を `NecSuf.iterComm_smul_left` の特殊化、代入する入れ子交換子を `nesting_*_of_necSuf` に差し替えて導いたもの | 同上 |
| `Ising2D.ad_V1plusHalf_checkZ` / `ad_V1plusHalf_checkY` / `ad_V2H2Form_checkZ` / `ad_V2H2Form_checkY` / `sK1_sq` / `sK2_sq`（同） | スカラー倍した生成子 `(i/2)K_1H_1^{(+)}`・`iK_2^*H_2` の 2 次元不変性（`αβ = K_1^2`, `(2K_2^*)^2`）。`T_actions_on_check_Z_Y` を必要十分版から導く `ClaimTActionsOnCheckFromNecSuf.lean` が使う | `T_actions_on_check_Z_Y` |
| `Ising2D.extract_taylor_H1Plus_checkZ` / `..._checkY`（`ClaimExtractTaylor.lean`） | (h1.z)(h1.y) の級数和 `cosh K_1 Ž + i e^{-iθ~} sinh K_1 Y̌` ほか | `extract_taylor_coefficient_of_check_Z_Y` |
| `Ising2D.extract_taylor_H2_checkZ` / `..._checkY` | (h2.z)(h2.y) の級数和 | 同上 |
| `Ising2D.hasSum_extract_taylor_H1Plus_checkZ` ほか 4 本 | 4 式の級数の収束と和。人手の 4 行（係数変換 → 偶奇分割 → 定数の括り出し → `cosh`・`sinh` のテイラー級数）どおり（`Complex.hasSum_cosh`・`Complex.hasSum_sinh`・`HasSum.even_add_odd`） | 同上 |
| `Ising2D.hasSum_extract_taylor_H1Plus_checkZ_of_necSuf` ほか 4 本（`ClaimExtractTaylorFromNecSuf.lean`） | 同じ 4 式を必要十分版 `NecSuf.hasSum_two_dim_series` の特殊化として導いたもの | 同上 |
| `Ising2D.checkPhase_one_eq_exp` / `checkPhase_neg_one_eq_exp`（`ClaimTActionsOnCheck.lean`） | `e^{∓iθ~_μ}` の指数表示との橋渡し | `T_actions_on_check_Z_Y` |
| `Ising2D.TConj_V1plusHalf_checkZ` / `..._checkY` | 原文 第 1・第 2 式（`def_T_g` → `def_V1_plus_square_root` → `exp(X)^{-1}=exp(-X)` → `exp_X_Y_exp_-X` → (h1.z)(h1.y) の `calc`） | `T_actions_on_check_Z_Y` |
| `Ising2D.smul_conj_smul_inv_eq` | 第 3・第 4 式の証明の、前因子 `(2s_2)^{M/2}` を打ち消す 2 行（スカラーを左端へ移す・`c c^{-1} = 1`） | 同上 |
| `Ising2D.TConj_V2H2Form_checkZ` / `..._checkY` | 原文 第 3・第 4 式を `V2H2Form` の単元（一般形）で述べたもの（前因子 `(2s_2)^{M/2}` の相殺つき） | `T_actions_on_check_Z_Y` |
| `Ising2D.TConj_V2_checkZ` / `..._checkY` | 原文 第 3・第 4 式（人手の `V_2` の単元 `V2Units` について） | 同上 |
| `Ising2D.linearity_of_T_on_check` | `T_g` の ℂ 線型性 | `linearity_of_T` |
| `Ising2D.linearity_of_T_V1plusHalf` | `T_g` の ℂ 線型性の半指数行列への特殊化 | `linearity_of_T_on_check_Z_Y` |
| `Ising2D.linearity_of_T_V2` / `linearity_of_T_V2H2Form` | `T_g` の ℂ 線型性の `V_2`（人手の `V_2`／一般形 `V2H2Form`）への特殊化 | `linearity_of_T_V2` |
| `Ising2D.B1mat_zero_zero` ほか 8 本（`DefinitionB1B2.lean`） | `B_1(θ), B_2` の 4 成分が原文の行列と一致すること | `def_B1_theta_B2` |
| `Ising2D.actsBy_TConj_V1plusHalf` | `(T Ž, T Y̌) = (Ž, Y̌) B_1(θ~_μ)`（上の第 1・第 2 式を 2 列に並べ、`def_B1_theta_B2` の成分と突き合わせる） | `calc_of_TxT_check_Z_Y` 第 1 式 |
| `Ising2D.actsBy_TConj_V2H2Form_check` / `actsBy_TConj_V2_check` | `(T Ž, T Y̌) = (Ž, Y̌) B_2`（同じく第 3・第 4 式から。`V_2` を `V2H2Form`／人手の `V_2` で書いた 2 本） | 同 第 2 式 |
| `Ising2D.actsBy_TConj_V1plusHalf_fromNecSuf` / `actsBy_TConj_V2H2Form_check_fromNecSuf` / `actsBy_TConj_V2_check_fromNecSuf` | 上の 2 式を必要十分版 `NecSuf.exp_conj_two_dim_actsBy`・`NecSuf.conj_smul_eq` の特殊化として得たもの（`ClaimTActionsOnCheckFromNecSuf.lean`） | 同 第 1・第 2 式 |
| `Ising2D.B1mat_eq_twoDimConjMat` / `B2mat_eq_twoDimConjMat` / `actsBy_TConj_matExpUnits` / `actsBy_TConj_smulUnits` | 特殊化に使う、運動量の取り方に依らない補題（同じファイル。整数運動量の経路の記録もこれを使う） | 同上 |
| `Ising2D.factorization_of_A_theta_general`（`ClaimFactorizationATheta.lean`） | `B_1(θ) B_2 B_1(θ) = A(θ)`（`θ ∈ ℝ` 一般） | `factorization_of_A_theta_general` |
| `Ising2D.factorization_of_A_thetaTilde` | 上の `θ = θ~_μ` への特殊化 | 同上（「とくに」） |
| `Ising2D.TVPlus_apply_checkZ` / `TVPlus_apply_checkY` | 原文の (z)・(y) の鎖（`def_T_V_plus` → `T_actions_on_check_Z_Y` → `linearity_of_T_V2` → `calc_of_TxT_check_Z_Y`（`B_2`）→ `linearity_of_T_on_check_Z_Y` → `calc_of_TxT_check_Z_Y`（`B_1(θ~)`）の 6 行の `calc`） | `T_V_plus_check_Z_Y` |
| `Ising2D.B1mat_col_zero` / `B1mat_col_one` / `mulVec_mulVec_col`（`ClaimTVPlusAction.lean`） | (z)・(y) の列ベクトルが `B_1(θ~)` の第 1・第 2 列であること、`B_1(B_2(B_1 の第 j 列))` が `B_1B_2B_1` の第 j 列であること | `def_B1_theta_B2`（最後の鎖の 1 行目） |
| **`Ising2D.TVPlus_checkZ_checkY`** | **章の結論** `(T_{(V^{(+)})}(Ž_μ), T_{(V^{(+)})}(Y̌_μ)) = (Ž_μ, Y̌_μ) A(θ~_μ)`（(z)・(y) の鎖を 2 列に並べ、`factorization_of_A_thetaTilde` を当てる） | **`T_V_plus_check_Z_Y`** |
| `Ising2D.TVPlus_checkZ_checkY_of_necSuf` | 上を必要十分版 `NecSuf.actsBy_TV_sandwich` の特殊化として得たもの（`ClaimTVPlusActionFromNecSuf.lean`） | 同上 |
| `Ising2D.TVPlus_checkZ_checkY_components` | 上を 2 本の等式（成分の形）で書いた版 | 同上 |
| `Ising2D.T_V_plus_check_Z_Y_via_B1_B2_B1`（`ClaimTVPlusCheckZYViaB1B2B1.lean`） | 章「離散 Fourier 変換による 2×2 行列 A(θ~_μ) への帰着」の章末の主張: `V^{(+)} X (V^{(+)})^{-1} = T_{(V^{(+)})}(X)`（`X = Ž_μ, Y̌_μ`）と、`(Ž_μ, Y̌_μ)` への作用行列が `A(θ~_μ)` かつ `B_1(θ~_μ) B_2 B_1(θ~_μ)` であること（既存の主張を並べたもの） | `T_V_plus_check_Z_Y_via_B1_B2_B1` |

### 必要十分版

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.NecSuf.actsBy_sandwich`（`TVActionSandwich.lean`） | `T_1` が `B_1`、`T_2` が `B_2` で作用するなら `T_1∘T_2∘T_1` は `B_1B_2B_1` で作用する（ℂ 上の任意の加群・任意の ℂ 線型写像） | `T_V_plus_check_Z_Y` / `calc_of_TxT_check_Z_Y` / `linearity_of_T_on_check_Z_Y` / `linearity_of_T_V2` |
| `Ising2D.NecSuf.actsBy_TV_sandwich` | 上を `T_{(V)} = T_{g_1}∘T_{g_2}∘T_{g_1}` の形で述べた版（任意の ℂ-代数の単元） | 同上 |
| `Ising2D.NecSuf.iterComm` / `iterComm_smul_left_one` / `iterComm_smul_right_one` / `iterComm_smul_left`（`IteratedCommutatorSmul.lean`） | `ad_{αx} = α ad_x`、`ad_x` の線型性、`ad_{αx}^n = α^n ad_x^n`（台は積を持つ加法群で、スカラーの作用が引き算と分配し、積と `(αx)w = α(xw)`・`x(αw) = α(xw)` で両立すればよい。スカラーは任意のモノイド） | `cosh_sinh_coefficient_conversion_for_check` の補題 1 |

---


### `V_2` の一般形について

本章の `VPlus M s2 K1 K2star` / `VPlusUnits` / `TVPlus` とその上の定理（章 015〜018 も同じ）は、`V_2` を
`V2_exponential_representation` の右辺の式 `V2H2Form M s2 K2star`（`s2`, `K2star` を独立な引数とする一般化）
で書いたまま残してある。人手の `V_2` は `def_transfer_matrix` の成分定義 `Ising2D.V2` であり、両者は
`s2 = sinh 2K_2`, `K2star = K_2^*`（`K_2 > 0`）のとき一致する（`V2_exponential_representation`）。
人手が `V_2` そのものについて述べる `V2_invertible`, `def_V_plus`, `def_T_V_plus`, `T_actions_on_check_Z_Y` の
第 3・第 4 式, `linearity_of_T_V2` には、人手の `V_2` についての Lean の主張（上表）を別に立てた。
一般形の定理をすべて人手の `V_2` の言葉に書き直すことはしていない。

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

### 本章で新しく足した必要十分版

新しく足した必要十分版は 2 本である。1 本は、原文が `T_actions → linearity → calc_of_TxT → linearity → calc_of_TxT` と
4 段で往復している部分を 1 本にまとめた `NecSuf.actsBy_sandwich` である。
もう 1 本は `extract_taylor_coefficient_of_check_Z_Y` の `NecSuf.hasSum_two_dim_series`（位相 ℂ 加群）である。
既存の `NecSuf.exp_conj_two_dim_z` / `_y` は指数共役と級数の和の 2 つの主張を束ねており、この主張だけの必要十分版にならないため、級数の和の部分を切り出した。
ほかの主要主張は既存の必要十分版の特殊化で閉じた。

| 人手証明のラベル（章 014） | 具体版 | 必要十分版 |
| --- | --- | --- |
| `def_H1_plus` / `def_V1_plus_square_root` / `V1_plus_square_root_property` / `def_V_plus` / `V_plus_factors_invertible` / `def_T_V_plus` / `T_V_plus_is_conjugation` | `Ising2D.H1plus` / `V1plusHalf` / `V1_plus_square_root_property` / `VPlus` / `TVPlus` / `TVPlus_eq_TConj` / `VPlusOfTransfer_eq_VPlus` / `TV_V1plusHalfUnits_V2Units` / `isUnit_V2` | 既存の `Ising2D.TConj` / `TV` / `TV_eq_TConj`（任意の環 + ℂ-代数。`Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean`） |
| `nesting_of_commutator_of_H_and_check_Z` | `Ising2D.nesting_H1Plus_checkZ_even` ほか 8 本（人手の帰納法どおり） | `NecSuf.nested_z_even` / `nested_z_odd` / `nested_y_even` / `nested_y_odd`（同じ帰納段階 1・2。スカラーは可換環、台は引き算と積があればよい。導出は `Ising2D.nesting_*_of_necSuf`） |
| `cosh_sinh_coefficient_conversion_for_check` | `Ising2D.conversion_H1Plus_checkZ_even` ほか 8 本（人手の補題 1・補題 2 と代入の鎖どおり） | 補題 1 は `NecSuf.iterComm_smul_left`（台は引き算と積があればよく、スカラーは任意のモノイド）。8 本は補題 1 と `NecSuf.nested_*` の特殊化から具体版と同じ手順で得る（導出は `Ising2D.adPow_smul_left_of_necSuf`・`conversion_*_of_necSuf`） |
| `extract_taylor_coefficient_of_check_Z_Y` | `Ising2D.extract_taylor_H1Plus_checkZ` ほか 4 本（`hasSum_extract_taylor_*` が人手の 4 行どおり） | `NecSuf.hasSum_two_dim_series`（位相 ℂ 加群。導出は `Ising2D.hasSum_extract_taylor_*_of_necSuf`） |
| `T_actions_on_check_Z_Y` / `calc_of_TxT_check_Z_Y` | `Ising2D.actsBy_TConj_V1plusHalf` / `actsBy_TConj_V2H2Form_check` ほか | 既存の `NecSuf.twoDimConjMat` / `exp_conj_two_dim_actsBy` / `conj_smul_eq` |
| `linearity_of_T` | `Ising2D.linearity_of_T_on_check` | 既存の `Ising2D.TConj_linear`（任意の環 + ℂ-代数） |
| `linearity_of_T_on_check_Z_Y` | `Ising2D.linearity_of_T_V1plusHalf` | 既存の `Ising2D.TConj_linear` の半指数行列への特殊化 |
| `linearity_of_T_V2` | `Ising2D.linearity_of_T_V2` | 既存の `Ising2D.TConj_linear` の `V_2` への特殊化 |
| `def_B1_theta_B2` | 既存の `Ising2D.B1mat` / `B2mat`（最初から `θ : ℂ` 一般） | 既存の `NecSuf.twoDimConjMat` |
| `factorization_of_A_theta_general` | 既存の `Ising2D.B1_mul_B2_mul_B1_eq_AMat`（最初から `θ : ℝ` 一般） | （2×2 行列の計算そのもので、取り払える構造が無い） |
| **`T_V_plus_check_Z_Y`** | **`Ising2D.TVPlus_checkZ_checkY`**（人手の 6 行の鎖どおり） | **`NecSuf.actsBy_sandwich` / `actsBy_TV_sandwich`（新規。導出は `Ising2D.TVPlus_checkZ_checkY_of_necSuf`）** |

### 必要十分版で判明した本質（README 4 節が求めている答え）

**整数運動量版（008 章）と半整数運動量版（本章）は、同じ必要十分版の別の特殊化である。**
違いは `ad X` が `span{z, y}` に及ぼす係数 `(α, β)` の位相因子だけである。

| | `z` | `y` | `α` | `β` | `s` | 作用行列 |
| --- | --- | --- | --- | --- | --- | --- |
| 008 章 `T_{(V_1^{(-)})^{1/2}}` | `Ẑ_μ^{(-)}` | `Ŷ_μ` | `iK_1 e^{-iθ_μ}` | `-iK_1 e^{iθ_μ}` | `K_1` | `B_1(θ_μ)` |
| 本章 `T_{(V_1^{(+)})^{1/2}}` | `Ž_μ` | `Y̌_μ` | `iK_1 e^{-iθ~_μ}` | `-iK_1 e^{iθ~_μ}` | `K_1` | `B_1(θ~_μ)` |
| 両章の `T_{V_2}` | 上に同じ | 上に同じ | `-2iK_2^*` | `2iK_2^*` | `2K_2^*` | `B_2` |

`αβ = s^2` の検証に使うのは **`e^{-iθ}e^{iθ} = 1` と `i^2 = -1` の 2 つだけ**であり、
`θ` が `2πμ/M` か `2π(μ-1/2)/M` かは一切効いていない。これが原文
`evensectorT_000_remark_overview` の「008 章の各証明は `θ_μ` に固有の性質
（`e^{-iMθ_μ} = +1`、添字集合 `𝓜` の形、`M` 周期性）を使っていない」という観察の、
Lean での機械的裏づけである。

具体的な確認として、`Ising2D.TV_hatZ_hatY_via_sandwich`（本文から退避した整数運動量の経路の記録 `RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean`）で
**008 章の結論を本章の必要十分版から導き直した**。本章の結論を必要十分版から導いた
`Ising2D.TVPlus_checkZ_checkY_of_necSuf`（`ClaimTVPlusActionFromNecSuf.lean`）とこの定理は、`NecSuf.actsBy_TV_sandwich` に渡す
`ActsBy` が `(Ẑ^{(-)}, Ŷ, B_1(θ_μ))` か `(Ž, Y̌, B_1(θ~_μ))` かだけが違う。

さらに、必要十分版から次の 3 点が分かった。

1. **原文が「入れ子交換子の偶奇の場合分け」（`nesting_of_commutator_of_H_and_check_Z`）と
   「テイラー係数の抽出」（`extract_taylor_coefficient_of_check_Z_Y`）と
   「補題 1・補題 2 によるスカラーの付け替え」（`cosh_sinh_coefficient_conversion_for_check`）の
   3 段でやっていることは、「`ad X` が `span{Ž_μ, Y̌_μ}` を保つ」という 1 つの事実に集約できる。**
   とくに原文の補題 1（`ad_{αX}^n = α^n ad_X^n`）と補題 2（`i^n` の偶奇）は、
   `T_actions_on_check_Z_Y` の導出が使う 2 次元の必要十分版 `NecSuf.exp_conj_two_dim_*` では `(α, β, s)` の付け替えに完全に吸収される
   （各主張の必要十分版は、具体版と同じ手順をたどる `NecSuf.nested_*`・`NecSuf.iterComm_smul_left`・`NecSuf.hasSum_two_dim_series` である）。原文で
   `(-1)^{n/2}(2K_1)^n` が `K_1^n` へ変わるのは、`s` が純虚数 `2iK_1` から実の `K_1` へ
   変わることに他ならない（`Ising2D.sK1_sq`）。
2. **原文が 4 段の往復（`T_actions` → 線型性 → `calc_of_TxT` → 線型性 → `calc_of_TxT`）で
   行っている合成の計算に効いているのは、「`T` が ℂ 線型であること」と
   「行ベクトル記法のもとで合成が行列の積になること」の 2 つだけである。**
   指数関数も、共役であることも、行列であることも、`Ž, Y̌` が何であるかも効いていない
   （`NecSuf.actsBy_sandwich` は ℂ 上の任意の加群と任意の ℂ 線型写像で成り立つ）。
3. `V_2` の前因子 `(2s_2)^{M/2}` が共役で打ち消えることに効いているのは、
   任意の ℂ-代数で成り立つ `(c g) a (c⁻¹ g⁻¹) = g a g⁻¹`（既存の `NecSuf.conj_smul_eq`）
   だけである（008 章と同じ）。ノルムも完備性も指数関数も要らない。

---

## 3. 形式化できなかった主張とその理由

無し。章 014 の 11 主張はすべて形式化した（`sorry` / `admit` はゼロ）。

ただし次の 2 点は**仮定として残している**。いずれも 008 章と同じもので、
未形式化に由来する穴ではなく**数学的に必要な前提**である。

1. `hdual : s_2^* c_2 = c_2^*`（双対関係 `sinh 2K_2 · sinh 2K_2^* = 1` の帰結）。
   `B_1(θ)B_2B_1(θ)` の非対角成分に現れるのは `c_2^*` だが、`def_A_theta` の `A(θ)` には
   `c_2` が現れるため、一致にこの等式が要る。
   **本章の原文はこれを `duality_c2_star_eq_s2_star_c2` として proof 中で明示的に引用しており、
   008 章で欠けていた前提がここでは補われている**（008 章の問題点は
   `lean/README.md`「形式化の過程で見つかった原文の問題」を参照）。
2. `IsingConst` の 5 成分が `K_1, K_2^*` の双曲線関数であること
   （`hc1 : c_1 = cosh 2K_1` など）。原文が記号 `c_1, s_1, c_2, c_2^*, s_2^*` の定義として
   `def_transfer_matrix_symbols` に置いているものであり、Lean の `IsingConst` は
   5 個の実数を保持するだけなので仮定として渡す。

### 添字の量化について

原文は本章の主張をすべて `μ ∈ 𝓜̌ = {1,…,M}` について述べているが、
Lean 側の定理はすべて `μ : ℤ` 全体で成り立つ形にした。`𝓜̌` に絞る必要があるのは
反交換関係を `δ_{ν,M+1-μ}` の形で述べるとき（章 013）だけで、本章の主張には
`𝓜̌` に固有の性質が使われていない。これは原文より強い主張であり、原文の主張は
`μ ∈ 𝓜̌` を代入すれば直ちに従う。

### `n` 重交換子の偶奇の書き方

原文は `n ∈ ℤ_{≥0}` について右辺を `n` の偶奇で場合分けして書いているが、
Lean では `n = 2k` / `n = 2k+1` と書き分けた 2 本ずつの定理にした
（`(-1)^{n/2} = (-1)^k`、`(-1)^{(n-1)/2} = (-1)^k`、`(-1)^{(n+1)/2} = (-1)^{k+1}`）。
主張の内容は同値である。

---

## 4. 人手証明に見つかった誤り・穴

**無し。** 章 014 の 11 主張はすべて、係数まで含めて原文どおりに形式化できた。
とくに次の 2 点は原文が 008 章より改善している。

- 008 章が `B_1B_2B_1 = A(θ)` に必要な双対関係 `c_2^* = s_2^* c_2` を明示していなかったのに対し、
  本章の `factorization_of_A_theta_general` の proof は Step 4 でこれを明示的に引用している。
- 008 章が `(V_1^{(±)})^{1/2}` を「`exp(iK_1H_1^{(±)})` の `1/2` 乗」と書いて proof 中で
  `exp((i/2)K_1H_1^{(±)})` に読み替えていたのに対し、本章は最初から
  `exp((i/2)K_1H_1^{(+)})` を定義とし、それが平方根であることを (2) で示している。
