# 章 015「半整数運動量における `A(θ~)` の対角化」の Lean 形式化

対象: もと `structured-latex/content/015_A_theta_tilde_diagonalization.ts` の 9 主張。章立ての組み直しで、すべて `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` へ移った。

この章は **008 章後半（`A(θ)` の固有ベクトル・対角化・`det A`）の半整数運動量版**である。
`A(θ)` は `θ ∈ ℝ` について述べられた 2×2 の主張なので、
整数運動量の経路の記録（`RoutesNotAdopted/IntegerMomentum/ClaimEigenvectorsAndDiagonalizationOfATheta.lean`）にも同じ形の定理があるが、
本章の固有ベクトル・対角化・行列式はそれを使わず、人手証明の Step どおりに証明している。

**本章に固有で、かつ本章の最大の価値は `γ_2(θ~_μ) ≠ 0` を無条件に閉じたこと**である
（`Ising2D.gamma2_thetaTilde_ne_zero`）。これにより整数運動量にあった臨界点の例外処理
（`μ = ±M` の除外）が偶セクターでは不要になることが機械的に確定した。

## 1. 形式化した定理の一覧

### 具体版（`lean/Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/`）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.AMat_thetaTilde_eq`（`DefinitionGamma1Gamma2OfThetaTilde.lean`） | `A(θ~_μ) = !![γ_1, γ_2(θ~); -γ_2(-θ~), γ_1]` | `def_gamma1_gamma2_of_theta` |
| `Ising2D.thetaTilde_mul_M` | `M·θ~_μ = (2μ-1)π`（**奇数**倍。015 章の要） | 同上（Step 2 の前提） |
| `Ising2D.cos_thetaTilde_eq_neg_one_of_sin_eq_zero`（`ClaimGamma2TildeNonzero.lean`） | `sin θ~_μ = 0 ⟹ cos θ~_μ = -1` | `gamma_2_theta_tilde_nonzero` Step 2+3 |
| **`Ising2D.gamma2_thetaTilde_ne_zero`** | **`γ_2(θ~_μ) ≠ 0`（無条件・全 `μ ∈ ℤ`）** | **`gamma_2_theta_tilde_nonzero`** |
| `Ising2D.gamma2_neg_thetaTilde_ne_zero` | `γ_2(-θ~_μ) ≠ 0` | 同上（statement 末尾） |
| `Ising2D.gamma2_thetaTilde_ne_zero_checkIndex` | 同上の `μ ∈ 𝓜̌` 版（人手証明と 1 対 1） | 同上 |
| `Ising2D.absGamma2`（`ClaimRelationGamma2Tilde.lean`） | `|γ_2(θ)| := √(normSq γ_2(θ))` | `relation_of_gamma_2_theta_tilde` |
| `Ising2D.gamma2_neg_thetaTilde_eq` | (1) `γ_2(-θ~) = -conj γ_2(θ~)` | 同 (1) |
| `Ising2D.gamma2_mul_gamma2_neg_eq_neg_absSq` | (2) `γ_2(θ~)γ_2(-θ~) = -|γ_2|^2` | 同 (2) |
| `Ising2D.sq_absGamma2` | (4) `(|γ_2|)^2 = -γ_2(θ~)γ_2(-θ~)` | 同 (4) |
| `Ising2D.sq_I_absGamma2` | (5) `(i|γ_2|)^2 = γ_2(θ~)γ_2(-θ~)` | 同 (5) |
| `Ising2D.absGamma2_thetaTilde_pos` | `|γ_2(θ~_μ)| > 0` | 同 (2)(4) の狭義部分 |
| `Ising2D.lambdaPlusR` / `lambdaMinusR` | `λ_{±,μ} = γ_1(θ~_μ) ± |γ_2(θ~_μ)| ∈ ℝ` | `eigenvector_of_A_theta_tilde` |
| `Ising2D.gamma2_mul_conj_eq_absGamma2_sq` / `gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq` | `a ā = r^2`、`ab = -r^2`（根拠に引く形） | 同 Step 1・Step 2 の根拠 |
| `Ising2D.factor_identity_thetaTilde` | 準備の因数分解の恒等式 | 同 Step 1 |
| `Ising2D.charPoly_factor_thetaTilde` | `det(A(θ) - λI) = (λ-λ_+)(λ-λ_-)`（先頭の 7 行は差・スカラー倍・単位行列・クロネッカーのデルタの定義の成分 `matrix_sub_apply`・`matrix_smul_apply`・`identity_matrix_apply`・`kroneckerDelta_self`・`kroneckerDelta_of_ne` と、`x·1 = x`・`x·0 = 0`・`y - 0 = y`） | 同 Step 1 |
| `Ising2D.det_AMat_sub_smul_eq_zero_iff` | `det(A(θ) - λI) = 0` となる `λ` は `λ_±` に限る | 同 Step 1 |
| `Ising2D.exists_ne_zero_mulVec_eq_zero_iff_det_fin_two`（`MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNonzeroKernelIffDetZeroTwoByTwo.lean`。同じファイルに `IsEigenvector`・`IsEigenvalue`・`det_two_by_two_def` と鎖の補題を置く） | 2×2 の複素行列 `B` について、`Bv = 0` となる `v ≠ 0` がある ⟺ `det B = 0`（成分計算） | `nonzero_kernel_iff_det_zero_two_by_two`（`def_eigenvector`・`def_eigenvalue`・`def_det_two_by_two`）。`eigenvector_of_A_theta_tilde` Step 1 の同値の鎖の最後の段で引く |
| `Ising2D.exists_ne_zero_mulVec_eq_zero_iff_det_fin_two_of_necSuf` | 同上を必要十分版の系として導出した版 | 同上 |
| `Ising2D.eigenvalue_AMat_iff` | `IsEigenvalue (A(θ)) λ ⟺ λ = λ_±`（`def_eigenvalue` から `det(A(θ) - λI) = 0` までの同値の鎖を経る。2〜5 段目は `MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の `Ising2D.vec_sub_eq_zero_iff`・`identity_matrix_mulVec`・`smul_mulVec_eq`・`sub_mulVec_eq`） | 同 Step 1・statement |
| `Ising2D.vec_sub_eq_zero_iff` / `identity_matrix_mulVec` / `smul_mulVec_eq` / `sub_mulVec_eq`（`ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean`。必要十分版からの導出は `ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf.lean`） | `u - w = 0 ⟺ u = w`、`Iv = v`、`(λB)v = λ(Bv)`、`Av - Bv = (A - B)v`（成分ごとの鎖） | `matrix_difference_zero_iff_equal`・`identity_matrix_is_left_unit_of_mat_mult`・`scalar_multiple_factors_out_of_left_factor`（右の因子が数ベクトルの場合）・`matrix_difference_mul_vector`。同 Step 1 の同値の鎖の 2〜5 段で引く |
| `Ising2D.AMat_mulVec_eigen_pos` / `..._neg` | `v_± = (∓|γ_2|, γ_2(-θ~))` が固有ベクトル（成分ごとの鎖） | 同 Step 2 |
| `Ising2D.isEigenvector_smul_eigen_pos` / `..._neg` | `c ≠ 0` なら `c v_±` は `λ_±` に属する固有ベクトル（`def_eigenvector`） | 同 statement |
| `Ising2D.eigenvector_pos_ne_zero` / `eigenvector_neg_ne_zero` / `AMat_mulVec_smul_eigen_pos` / `..._neg`（`ClaimEigenATildeDiag.lean`） | `v_± ≠ 0` と `c` 倍の固有ベクトル | 同 Step 2 |
| `Ising2D.lambdaPlusR_ne_lambdaMinusR` | `λ_+ ≠ λ_-`（固有値の分離） | 同 Step 1 末尾 |
| `Ising2D.checkPmat` / `checkDmat` / `checkC` | 人手証明の `P̌_μ`, `Ď_μ`, 任意定数 `c` | `diagonalization_check_P_D` |
| `Ising2D.sqrtM_ne_zero`（`DefinitionCheckFermi.lean`。`def_check_fermi` と同じ `√M`） | `√M ≠ 0` | 同 Step 1 |
| `Ising2D.checkC_mul_b` / `checkPmat_col_pos` / `checkPmat_col_neg` | `cb = 1/(2√M)`、`P̌` の列が `v_{±,μ}` | 同 Step 2 |
| `Ising2D.det_checkPmat` | `det P̌_μ = -|γ_2|/(2M γ_2(-θ~_μ))` | 同 Step 3 |
| `Ising2D.det_checkPmat_ne_zero` | `det P̌_μ ≠ 0`（可逆性） | 同 Step 3 |
| `Ising2D.AMat_mul_checkPmat` | `A P̌ = P̌ Ď` | 同 Step 2 |
| **`Ising2D.AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv`** | **`A(θ~_μ) = P̌_μ Ď_μ P̌_μ⁻¹`（場合分けなし）** | **`diagonalization_check_P_D`** Step 4 |
| `Ising2D.charPoly_factor_thetaTilde_of_necSuf` / `det_AMat_sub_smul_eq_zero_iff_of_necSuf` / `eigenvalue_AMat_iff_of_necSuf` / `lambdaPlusR_ne_lambdaMinusR_of_necSuf` / `det_checkPmat_of_necSuf` / `det_checkPmat_ne_zero_of_necSuf` / `AMat_mulVec_eigen_pos_of_necSuf` / `..._neg_of_necSuf` / `AMat_mulVec_smul_eigen_pos_of_necSuf` / `..._neg_of_necSuf` / `AMat_mul_checkPmat_of_necSuf` / `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv_of_necSuf`（`ClaimEigenATildeDiagFromNecSuf.lean`） | `_of_necSuf` を除いた名前の具体版と同じ主張を、必要十分版 `NecSuf/TwoByTwoSkew.lean` の系として導出した版 | `eigenvector_of_A_theta_tilde` Step 1・Step 2、`diagonalization_check_P_D` Step 2〜4 |
| `Ising2D.det_AMat_eq_gamma1_sq_add` | `det A(θ) = γ_1^2 + γ_2(θ)γ_2(-θ)` | `det_A_theta_tilde` Step 1 |
| `Ising2D.exp_I_mul_exp_neg_I_mul` / `gamma2_mul_gamma2_neg_sin_form` / `gamma2_mul_gamma2_neg_cos_form`（`ClaimDetATilde.lean`） | `exp(iθ)exp(-iθ) = 1` と `γ_2γ_2(-θ)` の実部表示 | 同 Step 2 |
| `Ising2D.det_AMat_thetaTilde_eq_one` | `det A(θ~_μ) = 1` | `det_A_theta_tilde` |
| `Ising2D.det_AMat_thetaTilde_eq_one_of_necSuf` | 同上を必要十分版の系として導出した版 | 同上 |
| `Ising2D.gamma1_sq_add_gamma2_mul_thetaTilde` | `γ_1^2 + γ_2γ_2(-θ~) = 1` | 同 第 2 式（Step 3〜5） |
| `Ising2D.gamma1R_sq_thetaTilde` | `γ_1(θ~_μ)^2 = 1 + |γ_2(θ~_μ)|^2` | 同 最終式 |
| `Ising2D.lambda_mul_lambda_thetaTilde` | `λ_+λ_- = 1` | 同 第 3 式（Step 6） |
| `Ising2D.one_lt_gamma1R_sq_thetaTilde` | `γ_1(θ~_μ)^2 > 1` | `gamma1_gt_1_theta_tilde` Step 2 |
| **`Ising2D.one_lt_gamma1R_thetaTilde`** | **`γ_1(θ~_μ) > 1`（狭義）** | **`gamma1_gt_1_theta_tilde`** |
| `Ising2D.one_le_gamma1R_thetaTilde` | `γ_1(θ~_μ) ≥ 1` | 同上（併記） |
| `Ising2D.gammaTilde` | `γ(θ~_μ) = arccosh(γ_1(θ~_μ))` | `def_gamma_theta` の `θ = θ~_μ` での値 |
| `Ising2D.cosh_gammaTilde` / `gammaTilde_nonneg`（`DefinitionGammaTildeMu.lean`） | `cosh γ = γ_1`、`γ ≥ 0` | 同上 |
| **`Ising2D.gammaTilde_pos`** | **`γ(θ~_μ) > 0`（狭義）** | 同上（後半） |
| `Ising2D.sinh_gammaTilde` | `sinh γ(θ~_μ) = |γ_2(θ~_μ)|` | `lambda_eq_exp_gamma_theta_tilde` Step 1 |
| `Ising2D.lambdaPlusR_eq_exp` / `lambdaMinusR_eq_exp` | `λ_{±,μ} = e^{±γ(θ~_μ)}` | 同 Step 2 |
| `Ising2D.lambda_separation` | `λ_+ > 1 > λ_- > 0` | 同 Step 3 |

補助として `Ising2D.IsingParam.c1_pos` / `c2_pos` / `c1_sq_sub_s1_sq` / `c2star_sq_sub_s2star_sq`
（`c_1 = cosh 2K_1 > 0` 等）を置いた。

### 必要十分版（`lean/Ising2D/NecSuf/`）

| ファイル | Lean の名前 | 内容 |
| --- | --- | --- |
| `OddModePhase.lean` | `NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd` | `N·θ = mπ`（`m` 奇数）かつ `sin θ = 0` なら `cos θ = -1` |
| `NegConjPair.lean` | `NecSuf.mul_of_eq_neg_conj` / `ne_zero_of_eq_neg_conj` / `sq_absOf_eq_neg_mul` / `sq_I_mul_absOf_eq_mul` / `absOf_pos` | `w = -conj z` だけから出る 4 つの帰結 |
| `TwoByTwoSkew.lean` | `NecSuf.skew2_factor_identity` / `skew2_charPoly` / `skew2_charPoly_factor` / `skew2_det_eq_zero_iff` / `skew2_eigenvalue_iff` / `skew2_eigenvalues_ne` / `skew2_mulVec_pos` / `skew2_mulVec_neg` / `mulVec_smul_of_mulVec_eq` / `skew2_mul_of_cols` / `det_of_cols` / `det_of_cols_ne_zero` / `eq_conj_of_mul_eq` | `!![g,a;-b,g]` の固有値・固有ベクトル・対角化（**任意の可換環**。固有値が `g ± s` に限る段と `det P ≠ 0` の段は零因子が無いこと、`λ_+ ≠ λ_-` と `det P ≠ 0` は `2s ≠ 0`）。具体版の Step と 1 つずつ対応する |
| `TwoByTwoKernelAndDeterminant.lean` | `NecSuf.det_mul_vec_zero_of_mulVec` / `det_mul_vec_one_of_mulVec` / `det_eq_zero_of_mulVec_eq_zero` / `exists_ne_zero_mulVec_eq_zero_of_det_eq_zero` / `exists_ne_zero_mulVec_eq_zero_iff_det` | 2×2 行列が 0 でないベクトルを 0 へ送る ⟺ `det = 0`（「⇒」は**零因子の無い可換環**、「⇐」は 0 でない可換環） |
| `MatrixVectorIdentityScalarDifference.lean` | `NecSuf.sub_eq_zero_iff_matrix` / `sub_eq_zero_iff_vec` / `one_mulVec_apply` / `smul_mulVec_apply` / `sub_mulVec_apply` / `one_mulVec_eq` / `smul_mulVec_eq'` / `sub_mulVec_eq'` / `mul_assoc_of_smul_mulVec` | `A - B = O ⟺ A = B` は**加法群**、`Iv = v` は `NonAssocSemiring`、`(λB)v = λ(Bv)` は左分配則と乗法の結合則（**可換則は効かない**）、`Av - Bv = (A - B)v` は右分配則。`skew2_eigenvalue_iff` の鎖の 2〜5 段で引く |
| `GammaDetIdentity.lean` | `NecSuf.gamma_det_identity` | `det A = 1` の中身は**可換環の多項式恒等式** |
| `ArcoshExp.lean` | `NecSuf.one_lt_of_sq_gt_one` / `sinh_arcosh_of_sq` / `exp_arcosh_of_sq` / `exp_neg_arcosh_of_sq` / `arcosh_pos_of_one_lt` | `g^2 = 1+r^2` から `e^{±arcosh g} = g ± r` |

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 | 必要十分版から具体版の導出 |
| --- | --- | --- | --- |
| `gamma_2_theta_tilde_nonzero` | `gamma2_thetaTilde_ne_zero` | `NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd` | `cos_thetaTilde_eq_neg_one_of_sin_eq_zero`（必要十分版へ `N := M`, `m := 2μ-1` を代入） |
| `relation_of_gamma_2_theta_tilde` | `gamma2_mul_gamma2_neg_eq_neg_absSq`, `sq_absGamma2`, `sq_I_absGamma2` | `NecSuf.mul_of_eq_neg_conj`, `sq_absOf_eq_neg_mul`, `sq_I_mul_absOf_eq_mul` | 具体版はいずれも必要十分版に `gamma2_neg_eq_neg_conj` を渡しただけ |
| `eigenvector_of_A_theta_tilde`, `diagonalization_check_P_D` | `charPoly_factor_thetaTilde`, `det_AMat_sub_smul_eq_zero_iff`, `eigenvalue_AMat_iff`, `lambdaPlusR_ne_lambdaMinusR`, `AMat_mulVec_eigen_pos/neg`, `AMat_mulVec_smul_eigen_pos/neg`, `AMat_mul_checkPmat`, `det_checkPmat(_ne_zero)`, `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv` | `NecSuf.skew2_charPoly`, `skew2_charPoly_factor`, `skew2_det_eq_zero_iff`, `skew2_eigenvalue_iff`, `skew2_eigenvalues_ne`, `skew2_mulVec_pos/neg`, `mulVec_smul_of_mulVec_eq`, `skew2_mul_of_cols`, `det_of_cols(_ne_zero)`, `eq_conj_of_mul_eq` | 各具体版の `*_of_necSuf`（`ClaimEigenATildeDiagFromNecSuf.lean`。`γ_2` の関係は `a b = -|γ_2|^2` だけを仮定として渡し、`b = -ā` と `a ā = r^2` は渡さない） |
| `nonzero_kernel_iff_det_zero_two_by_two`（`eigenvector_of_A_theta_tilde` Step 1 の同値の鎖の最後の段） | `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two` | `NecSuf.exists_ne_zero_mulVec_eq_zero_iff_det` | `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two_of_necSuf`（係数 `R := ℂ`） |
| `det_A_theta_tilde` | `det_AMat_thetaTilde_eq_one` | `NecSuf.gamma_det_identity` | `det_AMat_thetaTilde_eq_one_of_necSuf`（同じ主張を必要十分版の系として再証明） |
| `gamma1_gt_1_theta_tilde` | `one_lt_gamma1R_thetaTilde` | `NecSuf.one_lt_of_sq_gt_one` | 具体版は必要十分版の系 |
| `gamma_theta_tilde_mu_positive`, `lambda_eq_exp_gamma_theta_tilde` | `gammaTilde_pos`, `sinh_gammaTilde`, `lambdaPlusR_eq_exp`, `lambdaMinusR_eq_exp` | `NecSuf.arcosh_pos_of_one_lt`, `sinh_arcosh_of_sq`, `exp_arcosh_of_sq`, `exp_neg_arcosh_of_sq` | 具体版はいずれも必要十分版の系 |

必要十分版から得られた知見（本文には持ち込まない）:

- **半整数運動量で例外が消える理由は 1 行に還元される。**
  `γ_2(θ~_μ) ≠ 0` に効いているのは「`M θ~_μ = (2μ-1)π` が `π` の**奇数**倍であること」と
  「`sin θ~_μ = 0`」の 2 つだけで、`M`・`μ`・`2π/M` という形も、`θ` が運動量であることも、
  Ising 模型の定数も効いていない。整数運動量が `M θ_μ = 2μ·π`（偶数倍）であることと対比すると、
  008 章が臨界点で場合分けを強いられた原因がこの偶奇の 1 点にあると分かる。
  正値性の側で使うのは `c_1, s_1, c_2, s_2^* > 0` の 4 つだけである。
- **`relation_of_gamma_2_theta_tilde` の (1)〜(5) に効いているのは `w = -conj z` の 1 本だけ。**
  `γ_2` の具体形も `θ` が半整数運動量であることも `M` も効かない。
  `z ≠ 0` が効くのは狭義の不等号（`|γ_2| > 0`）だけで、等式は `z = 0` でも成り立つ。
  さらに、人手証明が `arg^{[0,2π)}` 分岐の複素平方根 `def_sqrt_cc` を経由して (3)(4)(5) を出す部分は、
  **「2 乗が何になるか」だけを述べれば分岐の議論が完全に消える**（本形式化はそうしている）。
- **`A(θ~_μ)` の固有値・固有ベクトル・対角化に効いているのは、
  「行列が `!![g,a;-b,g]` の形（対角成分が等しい）」「`ab = -s^2` を満たす `s` が取れる」「`2s ≠ 0`」の 3 つと、
  固有値が `g ± s` に限る段と `det P ≠ 0` の段での「係数に零因子が無いこと」だけ**で、係数は**任意の可換環**でよい。
  複素数であることも `γ_1` が実数であることも効いていない。`λ_+ ≠ λ_-` に具体版は `r > 0`（実数の順序）を使うが、
  効いているのは `2r ≠ 0` だけで、標数 2 の環では `g + s = g - s` となって対角化が崩れる。
  人手証明 Step 2 の第 1 成分が経る `b = -ā` と `a ā = r^2` の 2 段は、その合成 `ab = -r^2` だけが効いている。
  第 2 成分は仮定なしに環の計算だけで閉じ、人手の第 2 成分の `-b = ā` の代入は `ā` を括り出して `b` へ戻す往復で、
  固有ベクトルであることに効いていない。
  人手証明が `√(-γ_2γ_2(-θ~))` として導入する量は、必要十分版では「`ab = -s^2` を満たす元 `s`」に退化し、
  分岐の選択は `s ↦ -s`（＝ `P` の 2 列と `D` の 2 成分の同時入れ替え）にすぎない。
- **`det A = 1` は可換環の多項式恒等式である。** 効いているのは
  `u^2+v^2 = 1`, `c_1^2-s_1^2 = 1`, `(c_2^*)^2-(s_2^*)^2 = 1`, `c_2s_2^* = c_2^*` の 4 本だけで、
  `u, v` が三角関数であることも、`θ` が半整数運動量か整数運動量かも、実数・複素数であることも、
  `c_1 = cosh 2K_1` という出自も効いていない。
- **固有値の分離 `λ_+ > 1 > λ_- > 0` に効いているのは `r = |γ_2| > 0` の一点だけ。**
  `e^{±γ} = g ± r` 自体は `cosh^2-sinh^2 = 1`、`γ ≥ 0`、`e^{±x} = cosh x ± sinh x` の 3 つだけから出る。
  整数運動量で分離が壊れうるのは、そこで `r` が `0` になりうるからである。

## 3. 形式化できなかった主張とその理由

**無い。** 章 015 の 9 主張はすべて形式化した。ただし 1 点目は形式化の形が人手証明と異なる。2 点目は人手証明の本文から退避した側なので、形式化の対象に無い。

1. **`relation_of_gamma_2_theta_tilde` (3)（`arg^{[0,2π)}(γ_2γ_2(-θ~)) = π`）に直接の対応物を置いていない。**
   これは人手証明が (4)(5) を `def_sqrt_cc`（偏角 `[0,2π)` の一価な複素平方根）から導くための
   中間段階である。本形式化は複素平方根関数を導入せず、(4)(5) を 2 乗の等式
   （`sq_absGamma2` / `sq_I_absGamma2`）として述べるので、偏角の計算が不要になる。
   「積が負の実数である」という (3) の内容自体は (2)（`gamma2_mul_gamma2_neg_eq_neg_absSq` と
   `absGamma2_thetaTilde_pos`）で述べてある。この方針は 008 章
   （`RoutesNotAdopted/IntegerMomentum/ClaimEigenvectorsAndDiagonalizationOfATheta.lean`）と同じである。
2. **`eigenvector_of_A_theta_tilde` の「固有ベクトルは `v_±` のスカラー倍に限る」の側（もとの Step 3）は、本文から退避したので形式化の対象に無い。**
   後段が使うのは固有値 `λ_±`（`eigenvalue_AMat_iff`。特性多項式の因数分解 `det_AMat_sub_smul_eq_zero_iff` を経る）と
   `A v_± = λ_± v_±`（`AMat_mulVec_eigen_pos/neg`）だけで、「限る」の側はどこからも使われないので、
   人手証明でも本文から参照用ノート `claims_unused_by_chapter_goals_not_adopted` へ退避されている（2026-11-01）。

## 4. `det A = 1` に必要な仮定について（008 章と同じ）

`det A(θ~_μ) = 1` は `A(θ)` の定義だけからは出ず、双対関係の帰結
`c_2 s_2^* = c_2^*`（人手証明 Step 0 の (iii)、`duality_c2_star_eq_s2_star_c2`）が要る。
本章の定理はこの関係を引数 `hdual` に取る形で置いてある（`Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean` の `hdual` と同じ扱い）。
`det A(θ~_μ) = 1` に依存する `gamma1_gt_1_theta_tilde` 以降（`γ(θ~_μ) > 0`、`λ_± = e^{±γ}`、
固有値の分離）も同じ引数を引き継ぐ。この関係は人手 `duality_c2_star_eq_s2_star_c2` で証明済みであり、
`IsingParam`（`K2star := Kstar K2`）の上では定理 `IsingParam.c2_mul_s2star_eq_c2star`
（`EigenvalueProblem/ReductionToATheta/ClaimDualityC2StarEqS2StarC2.lean`）で埋まる。

## 5. 人手証明に見つかった誤り・穴

**無い。** 章 015 の 9 主張は、上記の `hdual`（人手証明も Step 0 で明示的に引用している）を除き、
すべて書かれているとおりに閉じた。008 章について既知の問題
（`det A = 1` に (iii) が要ること、`P_μ` の可逆性が確認されていないこと）は、
015 章では人手証明の側で解消されている（Step 0 で (iii) を引用し、Step 3 で `det P̌_μ ≠ 0` を確認している）。

なお `gamma_2_theta_tilde_nonzero` は人手証明が `μ ∈ 𝓜̌ = {1,…,M}` に限って述べているが、
**Lean の証明は `μ ∈ ℤ` 全体で通る**（`μ` の範囲はどこにも効かない）。
人手証明が誤っているわけではなく、仮定が必要以上に強いだけである。
