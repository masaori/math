# 章 013「偶セクターの半整数運動量モード」の Lean 形式化

対象: もと `structured-latex/content/013_even_sector_modes.ts` の 8 ブロック。章立ての組み直しで、指数和・$\check Z,\check Y$ の定義と周期性・添字集合・交換関係は `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` へ、$\check{\mathcal M}$ の定義・共役添字・反交換関係・$Z,Y$ の復元は `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` へ移った

新規ファイル:

- 具体版: `lean/Ising2D/RoutesNotAdopted/ClaimsUnusedByChapterGoals/ClaimH1H2ViaCheckZY.lean`（参照用ノートへ退避した `H1_H2_via_check_Z_Y` の形式化の記録。旧 `Part013/Claim007_H1H2ViaCheck.lean`。`why_008_applies_only_to_minus_sector` のファイルは整数運動量の経路の記録なので `lean/Ising2D/RoutesNotAdopted/IntegerMomentum/` へ移した。指数和・半整数運動量の定義と周期性・添字集合・交換関係のファイルは、章立てに合わせて `lean/Ising2D/EigenvalueProblem/ReductionToATheta/` へ移した）
- 必要十分版: `lean/Ising2D/NecSuf/AntiperiodicFourier.lean`、`lean/Ising2D/NecSuf/CommutatorSiteSum.lean`（`commutator_of_H_and_check_Z_Y`）

`lean/README.md` への統合は呼び出し元が行う（本ファイルは章 013 の作業記録）。

---

## 1. 形式化した定理の一覧

### 具体版（人手証明と 1 対 1）

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `claims_unused_by_chapter_goals_not_adopted.ts` へ退避したどの章のゴールの主張からも使われない主張、参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した整数運動量の経路のものである（退避の記録はノートの各ブロックの冒頭にある）。

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.lie_H2_hatZMinus_eq`（`ClaimWhyIntegerMomentumOnlyMinusSector.lean`） | `[H_2, hat(Z)^{(-)}_μ] = -2 hat(Y)_μ`（`RoutesNotAdopted/IntegerMomentum/ClaimCommutatorHAndHatZHatY.lean` の再掲） | `why_008_applies_only_to_minus_sector` |
| `Ising2D.lie_H2_hatZPlus_eq` | `[H_2, hat(Z)^{(+)}_μ] = -2 hat(Y)_μ + 4 e^{-iθ_μ} Y_1`（同上） | 同上 |
| `Ising2D.lie_H2_hatZPlus_ne_lie_H2_hatZMinus` | `[H_2, hat(Z)^{(+)}_μ] ≠ -2 hat(Y)_μ`（**本章で新規**） | 同上 |
| `Ising2D.lie_H2_hatZPlus_ne_hatZMinus` | 2 つの交換子が一致しないこと | 同上 |
| `Ising2D.thetaTilde` | `θ~_μ := 2π(μ-1/2)/M ∈ ℝ` | `antiperiodic_exp_sum` |
| `Ising2D.checkPhase` | `e^{-i k θ~_μ} = expPhase (2M) (k(2μ-1))` | 同上 |
| `Ising2D.checkPhase_eq_exp` | `checkPhase` が原文の `e^{-ikθ~_μ}` そのものであること | 同上 |
| `Ising2D.expPhase_two_mul` | `expPhase (2M) (2n) = expPhase M n`（偶数周波数は `M` 乗根） | 同上 |
| `Ising2D.expPhase_two_mul_half` | `expPhase (2M) M = -1`（**反周期性の正体**） | `half_integer_phase_antiperiodicity` |
| `Ising2D.expPhase_sum_zero_based` | `∑_{μ=0}^{M-1} e^{-2π√-1 μk/M} = M δ^M_{k,0}` | 同上（補助） |
| `Ising2D.antiperiodic_complex_exp_sum_delta_difference` | 本文と同じ `Complex.exp` で `2M` 項を奇数番目と偶数番目へ分け、半整数運動量の和を `2M δ^{2M}_{k,0}-M δ^M_{k,0}` とする本文の中間式 | 同上 |
| `Ising2D.antiperiodic_exp_sum_delta_difference` | 直前のデルタ差を内部表現 `checkPhase` で書いたもの | 同上（補助） |
| `Ising2D.antiperiodic_complex_exp_sum` | 定数位相を括り出した補助的な閉形式 `∑_{μ=1}^{M} e^{ikθ~_μ} = e^{-iπk/M} M δ^M_{k,0}` | `antiperiodic_exp_sum`（補助） |
| `Ising2D.antiperiodic_exp_sum` | 直前の補助的な閉形式を内部表現 `checkPhase` で書いたもの | 同上（補助） |
| `Ising2D.antiperiodic_complex_exp_sum_dvd` | 本文と同じ `Complex.exp` で、`k = lM` のとき和は `M(-1)^l` | 同上 |
| `Ising2D.antiperiodic_complex_exp_sum_not_dvd` | 本文と同じ `Complex.exp` で、`M ∤ k` のとき和は `0` | 同上 |
| `Ising2D.antiperiodic_complex_exp_sum_nonzero_of_abs_lt` | 本文と同じ `Complex.exp` で、`|k|<M, k\ne0` のとき和は `0` | 同上（「とくに」） |
| `Ising2D.antiperiodic_complex_exp_sum_zero` | 本文と同じ `Complex.exp` で、`k=0` のとき和は `M` | 同上（「とくに」） |
| `Ising2D.antiperiodic_exp_sum_dvd` / `antiperiodic_exp_sum_not_dvd` / `antiperiodic_exp_sum_nonzero_of_abs_lt` / `antiperiodic_exp_sum_zero`（`ClaimAntiperiodicExpSum.lean`） | 直前四主張を内部表現 `checkPhase` で書いたもの | 同上（補助） |
| `Ising2D.sum_checkPhase` | 上を周波数そのままで書いた形（以降の計算で使う） | 同上 |
| `Ising2D.checkZ`（`DefinitionHalfIntegerModes.lean`） | `check(Z)_μ` | `def_half_integer_checkZ` |
| `Ising2D.checkY` | `check(Y)_μ` | `def_half_integer_checkY` |
| `Ising2D.checkPhase_antiperiodic` | `e^{-iMθ~_μ} = -1` | `half_integer_phase_antiperiodicity` |
| `Ising2D.checkZ_period` | `check(Z)_{μ+M} = check(Z)_μ` | `half_integer_checkZ_periodicity` |
| `Ising2D.checkY_period` | `check(Y)_{μ+M} = check(Y)_μ` | `half_integer_checkY_periodicity` |
| `Ising2D.thetaTilde_one_sub` | (3) `θ~_{1-μ} = -θ~_μ` | `def_half_integer_modes` (3) |
| `Ising2D.checkPhase_one_sub` | (3) の位相因子版 | `def_half_integer_modes` (3) |
| `Ising2D.CheckIndex` | `μ ∈ 𝓜̌ = {1,…,M}` | `def_check_index_set` |
| `Ising2D.thetaTilde_ne` | (1) `μ ≠ ν ⟹ θ~_μ ≠ θ~_ν` | 同上 (1) |
| `Ising2D.thetaTilde_pos` / `thetaTilde_lt_two_pi`（`DefinitionCheckIndexSet.lean`） | (1) `0 < θ~_μ < 2π` | 同上 (1) |
| `Ising2D.checkIndex_conj` | (2) `μ ∈ 𝓜̌ ⟹ M+1-μ ∈ 𝓜̌` | 同上 (2) |
| `Ising2D.conj_index_sub` | (3) `(M+1-μ)-(1-μ) = M` | 同上 (3) |
| `Ising2D.conj_index_self_iff` / `thetaTilde_of_self_conj` | (4) 自己共役点と `θ~_μ = π` | 同上 (4) |
| `Ising2D.dvd_add_sub_one_iff` | (5) `μ+ν ≡ 1 (mod M) ⟺ ν = M+1-μ` | 同上 (5) |
| `Ising2D.deltaMod_add_one_eq` | (5) のデルタ版 | 同上 (5) |
| `Ising2D.thetaTilde_conj` | (1) `θ~_{M+1-μ} = 2π - θ~_μ` | `conjugate_index_of_check_Z_Y` |
| `Ising2D.checkPhase_conj'` | (2) `e^{-ijθ~_{M+1-μ}} = e^{ijθ~_μ}`（人手の 4 行: (1)・指数法則・Euler の公式・`cos(2πj)=1, sin(2πj)=0`） | 同上 (2) |
| `Ising2D.checkPhase_conj` | (2) の右辺を `2M` 乗根の位相因子で書いた形 | 同上 (2) |
| `Ising2D.checkZ_conj` / `checkY_conj`（`ClaimConjugateIndex.lean`） | (3) `check(Z)_{M+1-μ} = check(Z)_{1-μ}` | 同上 (3) |
| `Ising2D.checkZ_conj_eq` / `checkY_conj_eq` | (3) の展開形（`H_1, H_2` の証明で使う） | 同上 |
| `Ising2D.sum_sum_smul_two_deltaM_smul_one` | 証明中の行「`1 ≤ j,k ≤ M` では `δ^M_{(j,k)} = 1 ⟺ j = k`」（二重和の `j = k` の項だけが残る） | `anticommutator_of_check_Z_Y` |
| `Ising2D.deltaMod_sub_one` | 証明中の行 `δ^M_{(μ+ν-1,0)} = δ^M_{(μ+ν,1)}`（`def_delta_M`） | `anticommutator_of_check_Z_Y` |
| `Ising2D.acomm_checkZ_checkZ` | `[check(Z)_μ, check(Z)_ν]₊ = 2M δ^M_{μ+ν,1} I`（原文の式変形と 1 行ずつ対応する `calc`） | `anticommutator_of_check_Z_Y` |
| `Ising2D.acomm_checkZ_checkY` | `[check(Z)_μ, check(Y)_ν]₊ = 0` | 同上 |
| `Ising2D.acomm_checkY_checkY` | `[check(Y)_μ, check(Y)_ν]₊ = 2M δ^M_{μ+ν,1} I` | 同上 |
| `Ising2D.acomm_checkZ_checkZ_of_mem` / `acomm_checkY_checkY_of_mem`（`ClaimAnticommutatorCheckZY.lean`） | 上を `μ,ν ∈ 𝓜̌` で `δ_{ν,M+1-μ}` の形にしたもの（原文の主張そのもの） | 同上 |
| `Ising2D.expPhase_nextSite` | 境界の符号 `-1` が反周期性から出ること | `H1_H2_via_check_Z_Y`（参照用ノートへ退避。`RoutesNotAdopted/ClaimsUnusedByChapterGoals/ClaimH1H2ViaCheckZY.lean`） |
| `Ising2D.H2_eq_check_sum` | `H_2 = (1/M) ∑_μ check(Z)_{M+1-μ} check(Y)_μ` | 同上 |
| `Ising2D.H1Plus_eq_check_sum` | `H_1^{(+)} = (1/M) ∑_μ check(Y)_μ check(Z)_{M+1-μ} e^{-iθ~_μ}` | 同上 |
| `Ising2D.lie_ZY_Z_of_ne` / `lie_ZY_Y_of_ne` / `lie_YZ_Z_of_ne` / `lie_YZ_Y_of_ne`（`ClaimCommutatorHCheckZY.lean`） | Step 1 の、相異なる添字の項が消える 4 式 | `commutator_of_H_and_check_Z_Y` |
| `Ising2D.lie_ZY_Z_self` / `lie_ZY_Y_self` / `lie_YZ_Z_right` / `lie_YZ_Y_left` | Step 1 の、同じ添字を含む項の 4 式（境界項はこの後ろ 2 本へ線型性で帰着） | 同上 |
| `Ising2D.Yflat` / `Zflat` | Step 1 の反周期的な延長 `Y♭_l`・`Z♭_l` | 同上 |
| `Ising2D.lie_H2_Z` / `lie_H2_Y` / `lie_H1Plus_Z` / `lie_H1Plus_Y` | Step 1 の、和へまとめた 4 式 | 同上 |
| `Ising2D.checkPhase_smul_Yflat_boundary` / `checkPhase_smul_Zflat_boundary` | Step 3・Step 4 の境界の二項の等式 | 同上 |
| `Ising2D.lie_H1Plus_checkZ` | (A) `[H_1^{(+)}, check(Z)_μ] = 2 e^{-iθ~_μ} check(Y)_μ` | 同上 |
| `Ising2D.lie_H1Plus_checkY` | (B) `[H_1^{(+)}, check(Y)_μ] = -2 e^{iθ~_μ} check(Z)_μ` | 同上 |
| `Ising2D.lie_H2_checkZ` | (C) `[H_2, check(Z)_μ] = -2 check(Y)_μ` | 同上 |
| `Ising2D.lie_H2_checkY` | (D) `[H_2, check(Y)_μ] = 2 check(Z)_μ` | 同上 |
| `Ising2D.inverse_dft_check` | 反周期的離散フーリエ逆変換（任意の族に対する形） | `recover_Z_Y_from_check_Z_Y` |
| `Ising2D.recover_checkZ` / `recover_checkY`（`ClaimRecoverZYFromCheckZY.lean`） | `∑_μ check(Z)_μ e^{ijθ~_μ} = M Z_j` ほか | 同上 |
| `Ising2D.Z_eq_inverse_dft_check` / `Y_eq_inverse_dft_check` | `Z_j = (1/M) ∑_μ …` ほか | 同上 |
| `Ising2D.checkZYSet` / `checkZ_checkY_generate_algebra` | `check(Z), check(Y)` が `Mat(2^M,ℂ)` を生成する | 同上（「とくに」） |

### 必要十分版（`Ising2D/NecSuf/AntiperiodicFourier.lean`、名前空間 `Ising2D.NecSuf`）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `NecSuf.pow_half_eq_neg_one` | `ξ` が 1 の原始 `2M` 乗根なら `ξ^M = -1` | `half_integer_phase_antiperiodicity` |
| `NecSuf.sq_isPrimitiveRoot` | `ξ` が原始 `2M` 乗根なら `ξ^2` は原始 `M` 乗根 | `antiperiodic_exp_sum`（橋渡し） |
| `NecSuf.zpow_mul_natCast` | `ξ^{lM} = (-1)^l` | `antiperiodic_exp_sum` |
| `NecSuf.sum_zpow_primitiveRoot_zero_based` | 既存の直交性の `0` 始まり版 | 同上（補助） |
| `NecSuf.sum_zpow_antiperiodic_delta_difference` | `2M` 項を奇数番目と偶数番目へ分け、`∑_{μ=1}^{M} ξ^{(2μ-1)k} = 2M δ^{2M}_{k,0}-M δ^M_{k,0}` とする | `antiperiodic_exp_sum` |
| `NecSuf.sum_zpow_antiperiodic_dvd_even` / `sum_zpow_antiperiodic_dvd_odd` | `k=lM` の偶数・奇数の場合をデルタ差から評価する | 同上 |
| `NecSuf.sum_zpow_antiperiodic_not_dvd` | `M∤k` の場合を二つの周期デルタの零評価から導く | 同上 |
| `NecSuf.sum_zpow_antiperiodic` | `∑_{μ=1}^{M} ξ^{(2μ-1)k} = ξ^k M δ^M_{k,0}` | 同上（補助） |
| `NecSuf.acomm_antiperiodic_fourier_clifford` | 奇数周波数フーリエ和どうしの反交換子 | `anticommutator_of_check_Z_Y` |
| `NecSuf.inverse_dft_antiperiodic` | 反周期的離散フーリエ逆変換（任意の体・任意の加群） | `recover_Z_Y_from_check_Z_Y` |

### 必要十分版（`Ising2D/NecSuf/CommutatorSiteSum.lean`、名前空間 `Ising2D.NecSuf`）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `NecSuf.SiteZY` | 反交換関係 5 つを満たす `R`-代数の族 `z, y : Fin M → A` | `commutator_of_H_and_check_Z_Y`（具体版が使う `anticommutator_of_Z_and_Y` の帰結） |
| `NecSuf.SiteZY.lie_zy_z_of_ne` / `lie_zy_y_of_ne` / `lie_yz_z_of_ne` / `lie_yz_y_of_ne` | Step 1 の、相異なる添字の項が消える 4 式 | `commutator_of_H_and_check_Z_Y` |
| `NecSuf.SiteZY.lie_zy_z_self` / `lie_zy_y_self` / `lie_yz_z_right` / `lie_yz_y_left` | Step 1 の、同じ添字を含む項の 4 式 | 同上 |
| `NecSuf.SiteZY.lie_h2_z` / `lie_h2_y` / `lie_h1_z` / `lie_h1_y` | Step 1 の和へまとめた 4 式（延長 `yflat`・`zflat` の境界の符号は `η`） | 同上 |
| `NecSuf.SiteZY.lie_h2_checkZ` / `lie_h2_checkY` | (C)(D) | 同上 Step 2 |
| `NecSuf.SiteZY.phase_smul_yflat_boundary` / `lie_h1_checkZ` | Step 3 の境界の二項（`η = p(M)`）と (A) | 同上 Step 3 |
| `NecSuf.SiteZY.phase_smul_zflat_boundary` / `lie_h1_checkY` | Step 4 の境界の二項（`p(M)η = 1`）と (B) | 同上 Step 4 |

### 必要十分版 → 具体版の導出

| 導出した定理 | 元の必要十分版 | ファイル |
| --- | --- | --- |
| `Ising2D.antiperiodic_complex_exp_sum_delta_difference_of_necSuf` | `NecSuf.sum_zpow_antiperiodic_delta_difference` | `EigenvalueProblem/ReductionToATheta/ClaimAntiperiodicExpSumFromNecSuf.lean` |
| `Ising2D.antiperiodic_exp_sum_delta_difference_of_necSuf` | `NecSuf.sum_zpow_antiperiodic_delta_difference` | `EigenvalueProblem/ReductionToATheta/ClaimAntiperiodicExpSumFromNecSuf.lean` |
| `Ising2D.antiperiodic_complex_exp_sum_dvd_even_of_necSuf` / `antiperiodic_complex_exp_sum_dvd_odd_of_necSuf` / `antiperiodic_complex_exp_sum_not_dvd_of_necSuf` | 必要十分版の偶数・奇数・非整除の場合 | 同上 |
| `Ising2D.antiperiodic_complex_exp_sum_dvd_of_necSuf` | 必要十分版の偶数・奇数の場合を合わせた本文の `k=lM` の主張 | 同上 |
| `Ising2D.antiperiodic_complex_exp_sum_nonzero_of_abs_lt_of_necSuf` / `antiperiodic_complex_exp_sum_zero_of_necSuf` | 本文の二つの「とくに」 | 同上 |
| 対応する `Ising2D.antiperiodic_exp_sum_*_of_necSuf` | 直前三行を内部表現 `checkPhase` で書いたもの | 同上 |
| `Ising2D.antiperiodic_exp_sum_of_necSuf` | `NecSuf.sum_zpow_antiperiodic` | `EigenvalueProblem/ReductionToATheta/ClaimAntiperiodicExpSumFromNecSuf.lean` |
| `Ising2D.checkPhase_M_of_necSuf` | `NecSuf.pow_half_eq_neg_one` | 同上 |
| `Ising2D.checkZ_period_of_necSuf` | **既存の** `NecSuf.transform_periodic` | `half_integer_checkZ_periodicity` |
| `Ising2D.checkY_period_of_necSuf` | **既存の** `NecSuf.transform_periodic` | `half_integer_checkY_periodicity` |
| `Ising2D.acomm_checkZ_checkZ_of_necSuf` / `acomm_checkY_checkY_of_necSuf` | `NecSuf.acomm_antiperiodic_fourier_clifford`（それ自体が既存の `NecSuf.acomm_fourier_clifford_weights` の特殊化） | `EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimAnticommutatorCheckZYFromNecSuf.lean` |
| `Ising2D.inverse_dft_check_of_necSuf` / `recover_checkZ_of_necSuf` / `recover_checkY_of_necSuf` | `NecSuf.inverse_dft_antiperiodic` | `EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimRecoverZYFromCheckZYFromNecSuf.lean` |
| `Ising2D.lie_H1Plus_checkZ_of_necSuf` / `lie_H1Plus_checkY_of_necSuf` / `lie_H2_checkZ_of_necSuf` / `lie_H2_checkY_of_necSuf`（(A)〜(D)） | `NecSuf.SiteZY.lie_h1_checkZ` / `lie_h1_checkY` / `lie_h2_checkZ` / `lie_h2_checkY`（`NecSuf/CommutatorSiteSum.lean`。具体版と同じ手順で、サイトごとの交換関係 `SiteZY.lie_zy_z_of_ne` ほか 8 式から和へまとめる。仮定は `R`-代数の族 `z, y` の反交換関係 5 つ、位相の加法性と `p(0) = 1`、境界の符号 `η` について (A) は `η = p(M)`、(B) は `p(M)η = 1`） | `EigenvalueProblem/ReductionToATheta/ClaimCommutatorHCheckZYFromNecSuf.lean` |

橋渡し補題は `Ising2D.isPrimitiveRoot_expPhase_one`（`e^{-2π√-1/N}` は 1 の原始 `N` 乗根）と
`Ising2D.isPrimitiveRoot_expPhase_neg_one`（`e^{+2π√-1/N}` も同様）。

---

## 2. 必要十分版で判明した本質

**整数運動量と半整数運動量は、同じ必要十分版の別の特殊化である。**
これは本章のゴール（README 4 節の「何が本質的か」）に対する答えそのものなので、
判明したことを列挙する。

1. **`e^{-iθ~}` は 1 の原始 `2M` 乗根であり、半整数運動量とはその「奇数周波数」のことである。**
   `e^{-ijθ~_μ} = ξ^{j(2μ-1)}`（`ξ = e^{-iπ/M}`）。整数運動量は `ζ = ξ^2`（原始 `M` 乗根）の
   周波数 `jμ`、すなわち偶数周波数 `ξ^{2jμ}` である。
   本文が「働く仕組みは 1 つの等式 `e^{-iMθ~_μ} = -1` に集約される」と述べている等式は、
   必要十分版では **`ξ^M = -1`**（`NecSuf.pow_half_eq_neg_one`）であり、
   その証明は「`(ξ^M)^2 = 1` かつ原始性から `ξ^M ≠ 1`、体だから `ξ^M = -1`」の 3 行しかない。
   指数関数も円周率も複素数であることも効いていない。

2. **指数和は同じ直交性の特殊化である。**
   本文と必要十分版はともに、`2M` 項の和を奇数番目と偶数番目へ分けて
   `∑_{μ=1}^{M} ξ^{(2μ-1)k} = 2M δ^{2M}_{k,0}-M δ^M_{k,0}`
   を得る。どちらの項も既存の `NecSuf.sum_zpow_primitiveRoot`
   （整数運動量の `exp_sum` の必要十分版）の特殊化である。
   本文が場合分けして出している `(-1)^l` は、`k=lM` のとき
   `2M ∣ k` が `l` の偶奇と一致することから現れる。
   補助的な閉形式として、定数位相を括り出す
   `∑_{μ=1}^{M} ξ^{(2μ-1)k}=ξ^k Mδ^M_{k,0}` も残す。
   つまり**整数運動量の `exp_sum` と半整数運動量の `antiperiodic_exp_sum` は、
   同じ 1 つの直交性補題の 2 通りの特殊化**である。

3. **反交換関係の必要十分版は既存のもので足りる。**
   `NecSuf.acomm_fourier_clifford_weights`（位相 `ζ^{(j+1)ν}`、重み任意）に
   `ζ := ξ`（`2M` 乗根）・`ν := 2μ-1` を入れるだけでよい。
   **対になる添字が `μ+ν ≡ 0` から `μ+ν ≡ 1` へずれる理由は、
   奇数 + 奇数 = `(2μ-1)+(2ν-1) = 2(μ+ν-1)` の `-1` のただ 1 点**である。
   Clifford 関係と根の直交性以外は何も効いていない（行列であることも複素数であることも不要）。

4. **添字の周期性は文字どおり同じ定理である。**
   既存の `NecSuf.transform_periodic`（重み `w_j`・周波数 `a_j` が任意、仮定は `ζ^M = 1` だけ）に
   `w_j = ξ^{-j}`, `a_j = j`, `ζ = ξ^2` を入れると `check(Z)_{μ+M} = check(Z)_μ` になる。
   整数運動量版 `hatZ_hatY_M_periodicity` は同じ定理に `w_j = ±1` を入れたものである。

5. **交換関係 (A)〜(D) の具体版は、人手証明どおりサイトごとの交換関係から和へまとめて出す。**
   `H` を `check(Z), check(Y)` の和で表してから `NecSuf.CliffordTriple`（3 族 `z, z', y` と反交換子の値 `Dz, Dz', Dy`）に
   `z = z' = check(Z)`, `y = check(Y)`, `Dz = Dz' = Dy = 2M δ^M_{μ+ν,1}` を渡しても (A)〜(D) は出るが、
   その経路は参照用ノートへ退避した `H1_H2_via_check_Z_Y` を使い、人手証明と 1 対 1 でないので採らない。
   整数運動量版（`RoutesNotAdopted/IntegerMomentum/ClaimCommutatorHAndHatZHatY.lean` の 6 本）は、
   同じ構造に `z = hat(Z)^{(±)}`, `z' = hat(Z)^{(∓)}`, `Dz ≠ Dz'` を渡したものである。

6. **「`(+)` セクターで 008 章が壊れる」ことの正体は、`CliffordTriple` の言葉では `Dz ≠ Dz'` の 1 点である。**
   `why_008_applies_only_to_minus_sector` の余分な項 `4 e^{-iθ_μ} Y_1` は、
   必要十分版では `Dz'(μ,ν) = 2M δ^M_{μ+ν,0} - 4 e^{-i2π(μ+ν)/M}` の第 2 項が
   そのまま流れてきたものである。
   `check(Z)` を同じ構造に入れると族が 1 つしかない（`z = z'`）ので、この差が構造的に存在しない。
   本文が「係数に例外項が無い」と書いているのはこのことで、具体版では、境界項の符号を反周期性
   `e^{-iMθ~_μ} = -1` が打ち消すこと（Step 3・Step 4 の境界の二項の等式）に当たる。

7. **逆変換だけは新しい必要十分版が要る。** 既存の `NecSuf.inverse_dft_necSuf` は
   「原始 `M` 乗根 `ζ` の周波数 `(j+1)(μ+1)`」の形に固定されており、奇数周波数は
   `ζ = ξ^2` へ揃わないので特殊化にならない。そこで
   `NecSuf.inverse_dft_antiperiodic` を新設した。ただし**証明の骨格は同一**
   （位相をまとめる → 二重和の順序交換 → 直交性）であり、
   違いは使う直交性が `sum_zpow_primitiveRoot` か `sum_zpow_antiperiodic` かだけである。
   効いているのは「`ξ` が 1 の原始 `2M` 乗根」と「対象が係数体上の加群」だけで、
   行列であること・積があること・Clifford 関係は使っていない。

8. **(A)〜(D) を具体版と同じ手順（サイトごとの交換関係から和へまとめる）で一般化すると、境界の符号 `-1` という値は効いていない**
   （`NecSuf/CommutatorSiteSum.lean`）。`H_1` の境界項の符号を `η`、位相 `e^{-ikθ~_μ}` を `p(k)` と書くと、
   (A) に効くのは `η = p(M)`（境界の符号が位相の一周と一致する）、(B) に効くのは `p(M)η = 1` だけである。
   人手の `H_1^{(+)}` と半整数運動量は `η = p(M) = -1` でこれを満たし、周期境界 `η = 1` と整数運動量 `p(M) = 1` も同じ 4 式を満たす。
   `Z, Y` について効いているのは反交換関係 5 つ（`j ≠ k` で `z_jz_k = -z_kz_j`・`y_jy_k = -y_ky_j`、任意の `j, k` で `z_jy_k = -y_kz_j`、`z_j^2 = y_j^2 = 1`）だけで、
   Jordan–Wigner 文字列の具体形・行列であること・係数が複素数であることは効いていない（係数は任意の可換環）。

---

## 3. 形式化しなかった／できなかったもの

| 対象 | 理由 |
| --- | --- |
| `evensector_000_remark_overview`（この章の目的） | `kind: "remark"` で数学的主張を含まない（章の方針の説明） |
| `heading_even_sector_modes` | 見出し |
| `H1_H2_via_check_Z_Y` の必要十分版 | 整数運動量版 `H1_H2_via_hatZ_hatY` と同じ理由で、この等式は `check(Z), check(Y)` の具体形（半整数運動量の離散フーリエ変換）に本質的に依存しており、取り払える構造が無い。既存の `lean/README.md` も整数運動量版について同じ判断を記録している |
| `def_check_index_set` / `conjugate_index_of_check_Z_Y` の必要十分版 | 整数の不等式と `θ~_μ` の実数値だけを扱っており、環・体・加群のいずれも登場しない。抽象化しても得られる知見が「`𝓜̌` に絞ると合同式が等式に落ちる」という主張そのものにしかならない |
| 原文が `μ ∈ 𝓜̌` に絞っている主張のうち (A)〜(D) と反交換関係の合同式版 | Lean では `μ ∈ ℤ` 全体で証明した（絞る必要が無いことが分かった）。`𝓜̌` に絞った形も併記してある（`*_of_mem`） |
| `periodicity_of_check_fermi`（`def_check_index_set` から参照） | 014 章以降のブロックであり、本章（013）の担当範囲外 |

実数解析（極限・積分・連続性）は本章では不要だった。使った実数の事実は
`Real.pi_pos` / `Real.pi_ne_zero`（`thetaTilde` の範囲）と
`Complex.exp_pi_mul_I`（`expPhase (2M) M = -1`）だけで、いずれも mathlib にある。

---

## 4. 人手証明との突き合わせ

数値検証は `sagemath/check/046_claim_even_sector_modes/`（`M = 2,3,4,5` で全 PASS）。
Lean で形式化した主張はいずれもこれと整合し、**本文の誤りは見つからなかった**。

1 点だけ本文の記述が Lean と食い違う可能性を検討したので記録する。

- `why_008_applies_only_to_minus_sector` の第 2 式
  `[H_2, hat(Z)^{(+)}_μ] = -2 hat(Y)_μ + 4 e^{-i2πμ/M} Y_1` は、
  **008 章の原文 (5) の訂正版**である（008 章の原文は符号と係数を誤っており、
  `RoutesNotAdopted/IntegerMomentum/ClaimCommutatorHAndHatZHatY.lean` の冒頭コメントに記録がある）。
  013 章の本文は訂正後の値を採用しており、Lean（`Ising2D.lie_H2_hatZPlus`）と一致する。
  したがって 013 章側に誤りは無い。
