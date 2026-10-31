# 章 018「偶セクターの完結（Onsager の厳密解）」の Lean 形式化

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`（`epsilon_anticommutes_with_check_Z_Y` から `max_eigenvector_in_even_sector` まで）と `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`（`check_number_operator_is_hermitian` 以降）

この文書は `lean/README.md` への統合前の記録である（統合は呼び出し元が行う）。

## 0. 土台の選択と「仮定として受け取るもの」

章 018 は**本プロジェクトの結論**（Onsager の自由エネルギー）に至る章であり、
章 014–017（半整数運動量のフェルミオン `ψ̌_μ^†, ψ̌_μ`、個数演算子 `ň_μ`、
同時固有射影 `Q̌_ε`、`V^{(+)}` の固有値 `Λ̌_ε`）の上に立つ。
**本章の形式化に着手した時点で、それらは本リポジトリの Lean 側に存在しなかった**
（`Ising2D/` に `Part016` / `Part017` が無く、`Part014`（章 014「偶セクターでの `T` の作用」）
にも `ψ̌` / `ň` / `Q̌` は現れなかった）。

そこで**章 014–017 から受け取る入力だけを束ねた構造**を置き、章 018 の主張は
すべてそこからの帰結として証明した。

| 構造 | 場所 | 受け取る内容（すべて原文の主張そのまま） | 出典の章 |
| --- | --- | --- | --- |
| `Ising2D.CheckFermi` | `Part018/Setup.lean` | `ψ̌` の正準反交換関係（`anticommutator_of_check_psi`）、`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`（`check_number_operator_is_hermitian` (3)） | 016 |
| `Ising2D.VPlusData` | `Part018/Claim003_TraceEpsilonVPlus.lean` | `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`、`Λ̌_ε = C·exp(∑_μ γ(θ̃_μ)(ε_μ − 1/2))`、`C > 0`、`γ(θ̃_μ) > 0`（`eigenvalues_of_V_plus`, `gamma_theta_tilde_mu_positive`） | 015・017 |
| `Ising2D.EvenSectorBridge` | `Part018/Theorem009_CPlusEqualsLambda.lean` | 章 011 の実行列 `W` と章 017 の複素行列 `V^{(+)}` の橋渡し（`W P^{(+)} = V^{(+)} P^{(+)}`、`V^{(+)}` が実行列であること） | 011・017 |

**`ε` が `Ž, Y̌` と反可換であること（`epsilon_anticommutes_with_check_Z_Y` (1)(2)）は
仮定していない。** 章 004・010・013 の形式化済みの定理から**無条件に**従う。

演算の土台は、章 018 の主鎖では**複素行列 `TensorPow M = Matrix (Conf M) (Conf M) ℂ`**、
章 011 と接続する部分では**実行列 `Matrix (Conf M) (Conf M) ℝ`** である。
両者の橋渡しは `Ising2D.cvec`（実ベクトルの複素化）と `Ising2D.EvenSectorBridge.reVec`
（複素ベクトルの実部）で行い、章 011 の `epsilon_eq_ofReal_epsilonR`（`epsilon_is_real_symmetric`）と
同じ性質のものである。

**実数解析（極限・積分・連続性）へ移行するのは、章 012 の
`Ising2D.riemann_sum_to_integral` を経由する最後の等号だけ**である（人手証明の最終段落と同じ）。

## 1. 形式化した定理の一覧

### 1.1 具体版（`lean/Ising2D/Part018/`）

#### `Setup.lean`（章 014–017 からの入力と、その直接の帰結）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.CheckFermi` | 章 016 から受け取る入力（`ψ̌_μ^†`, `ψ̌_{M+1-μ}` と CAR） | `def_check_fermi` / `anticommutator_of_check_psi` |
| `Ising2D.CheckFermi.nOp` | `ň_μ = ψ̌_μ^† ψ̌_{M+1-μ}` | `def_check_number_operator` |
| `CheckFermi.cre_sq` / `ann_sq` / `ann_mul_cre` / `acomm_cre_ann_self` | `(ψ̌^†)² = 0`, `ψ̌² = 0`, `ψ̌ψ̌^† = I − ň` | `anticommutator_of_check_psi` |
| `CheckFermi.nOp_mul_self` | `ň_μ² = ň_μ`（射影） | `def_check_number_operator` |
| `CheckFermi.commute_cre_nOp` / `commute_ann_nOp` / `commute_nOp_nOp` | `ň` どうし・`ň` と `ψ̌` の可換性（異なる添字） | 同上 |
| `Ising2D.CheckFermi.Qproj` | `Q̌_ε = ∏_μ (ň_μ or I−ň_μ)` | `check_joint_eigenspace_decomposition` |
| `CheckFermi.Qproj_mul_self` / `Qproj_mul_Qproj_of_ne` / `sum_Qproj` | 直交射影系で和が `I` | 同上 |
| `CheckFermi.nOp_mul_Qproj` | `ň_μ Q̌_ε = ε_μ Q̌_ε` | 同上 |
| `CheckFermi.trace_Qproj` / `Qproj_ne_zero` | `tr Q̌_ε = 1`（`im Q̌_ε` は 1 次元） | 同上 |
| `CheckFermi.epsilon_anticomm_cre` / `epsilon_anticomm_ann` | `ε ψ̌^† = −ψ̌^† ε`, `ε ψ̌ = −ψ̌ ε` | `epsilon_anticommutes_with_check_Z_Y` (3) |
| **`CheckFermi.commute_epsilon_nOp` / `commute_epsilon_Qproj`** | **`ε ň_μ = ň_μ ε`, `ε Q̌_ε = Q̌_ε ε`** | **同 (4)** |
| `CheckFermi.ann_conjTranspose` / `nOp_conjTranspose` / `Qproj_conjTranspose` | `ψ̌^* = ψ̌^†`, `ň^* = ň`, `Q̌^* = Q̌` | `check_number_operator_is_hermitian` (3)(4) |

#### `Claim001_EpsilonAnticommutes.lean`（ラベル `epsilon_anticommutes_with_check_Z_Y`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.epsilon_anticomm_Z` / `epsilon_anticomm_Y` | `ε Z_j = −Z_j ε`, `ε Y_j = −Y_j ε` | (1)（章 010 で証明済み。再掲） |
| **`Ising2D.epsilon_anticomm_checkZ` / `epsilon_anticomm_checkY`** | **`ε Ž_μ = −Ž_μ ε`, `ε Y̌_μ = −Y̌_μ ε`** | **(2)** |
| `Ising2D.IsCheckMode` | 「`ψ̌_μ^†` は `Ž_μ, Y̌_μ` の ℂ 係数 1 次結合」（章 016 の入力を述語化） | `def_check_fermi` |
| **`Ising2D.epsilon_anticomm_of_isCheckMode`** | **`ε ψ̌_μ^† = −ψ̌_μ^† ε`** | **(3)** |

**(1)(2) は無条件**（章 004・010・013 の形式化済みの定理だけを使う）。

#### `Claim002_EpsilonEigenvalueOnQ.lean`（ラベル `epsilon_eigenvalue_on_check_Q`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.matrix_eq_of_mulVec_eq` | `∀x, Ax = Bx ⇒ A = B` | 補助 |
| `Ising2D.smul_cancel_of_matrix_ne_zero` | `Q ≠ 0`, `ηQ = η'Q ⇒ η = η'` | (1) の「一意に定まる」 |
| `CheckFermi.Qproj_eq` / `Qproj_mulVec_of_mem_range` / `finrank_range_Qproj` / `exists_Qproj_generator` | `im Q̌_ε` が 1 次元で、生成元 `q` がとれる | (1)（1 次元性はここだけで使う） |
| **`CheckFermi.exists_eta` / `eta` / `eta_mem` / `epsilon_mul_Qproj` / `eta_unique`** | **`∃! η_ε ∈ {±1}, ε Q̌_ε = η_ε Q̌_ε`** | **(1)** |
| **`CheckFermi.eta_insert`** | **反転則 `η_{ε[μ→1]} = −η_ε`** | **(2)** |
| `CheckFermi.eta_univ_eq_aux` | `|ε|` に関する帰納法の補助 | (3) |
| **`CheckFermi.eta_eq_eta_univ_mul`** | **`η_ε = η_{(1,…,1)}·(−1)^{M−|ε|}`** | **(3)** |
| `CheckFermi.parityFactor` / `parityProd` / `commute_parityFactor` | `∏_μ (I − 2ň_μ)` とその可換性 | (4) |
| `CheckFermi.parityFactor_mul_Qproj` / `parityProd_mul_Qproj` / `eq_of_mul_Qproj_eq` | 各因子が `Q̌_ε` にスカラー倍として働く／`Q̌_ε` 全体で行列が決まる | (4) |
| **`CheckFermi.epsilon_eq_parityProd`** | **`ε = η_{(1,…,1)}(−1)^M ∏_μ(I − 2ň_μ)`** | **(4)** |

#### `Claim003_TraceEpsilonVPlus.lean`（ラベル `trace_of_epsilon_V_plus_via_check_eigenvalues`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.checkLambda` | `Λ̌_ε = C·exp(∑_μ γ_μ(ε_μ − 1/2))` | `eigenvalues_of_V_plus` |
| `Ising2D.checkLambda_pos` / `checkLambda_le_univ` / `checkLambda_lt_univ` | `Λ̌_ε > 0`、`Λ̌_ε ≤ Λ̌_{(1,…,1)}`（`ε ≠ (1,…,1)` なら狭義） | 同 (2) |
| `Ising2D.VPlusData` | 章 015・017 から受け取る入力 | 同上 |
| `VPlusData.lamMax` / `lamMax_pos` / `checkLambda_le_lamMax` | `Λ̌_max = Λ̌_{(1,…,1)}` とその最大性 | 同 (2) |
| `VPlusData.epsilon_mul_V_mul_Qproj` | `εV^{(+)}Q̌_ε = η_ε Λ̌_ε Q̌_ε` | Step 1 |
| `VPlusData.trace_epsilon_mul_V_eq_sum` | `tr(εV^{(+)}) = ∑_ε η_ε Λ̌_ε` | Step 1 |
| `VPlusData.traceFactor` / `traceFactor_pos` | `C·∏_μ 2 sinh(γ_μ/2) > 0` | Step 2 |
| **`VPlusData.trace_epsilon_mul_V`** | **`tr(εV^{(+)}) = η_{(1,…,1)}·C·∏_μ 2 sinh(γ(θ̃_μ)/2)`** | **Step 2（定理本体）** |
| **`VPlusData.eta_univ_eq_one_of_trace_pos`** | **`tr(εV^{(+)}) > 0 ⇒ η_{(1,…,1)} = +1`** | Step 3 |

#### `Claim008_CheckQHermitian.lean`（ラベル `check_number_operator_is_hermitian`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.expPhase_conj` / `checkPhase_conj_star` | `conj(e^{−2πik/M}) = e^{2πik/M}` と半整数位相の共役 | (2) の計算 |
| **`Ising2D.checkZ_conjTranspose` / `checkY_conjTranspose`** | **`Ž_μ^* = Ž_{M+1−μ}`, `Y̌_μ^* = Y̌_{M+1−μ}`** | **(2)（無条件）** |
| `Ising2D.Z_conjTranspose` / `Y_conjTranspose` | `Z_j^* = Z_j`, `Y_j^* = Y_j` | (1)（章 009 で証明済み） |
| `CheckFermi.nOp_conjTranspose` / `Qproj_conjTranspose` | `ň_μ^* = ň_μ`, `Q̌_ε^* = Q̌_ε` | (4)（`Setup.lean`） |
| `EvenSectorBridge.quad_Qproj` | `x^* Q̌_ε x = ‖Q̌_ε x‖² ≥ 0` | (4) の帰結（`Theorem009_...`） |

#### `Theorem007_MaxEigenvectorEvenSector.lean`（ラベル `max_eigenvector_in_even_sector`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| **`VPlusData.eta_univ_eq_one`** | **`η_{(1,…,1)} = +1`** | **(1)**（`tr(εV^{(+)}) > 0` を仮定として受け取る。下記 3 を参照） |
| **`VPlusData.eta_eq_sign`** | **`η_ε = (−1)^{M−|ε|}`** | **(2)** |
| **`VPlusData.epsilon_eq_parityProd_of_trace_pos`** | **`ε = (−1)^M ∏_μ(I − 2ň_μ)`** | **(3)** |
| **`VPlusData.epsilon_mul_Qproj_univ`** | **`ε Q̌_{(1,…,1)} = Q̌_{(1,…,1)}`** | **(4)** |
| **`VPlusData.mem_evenSector_of_mem_range_univ`** | **最大固有ベクトルは偶セクター `𝓕^{(+)}` に属する** | **定理本体** |

#### `Theorem009_CPlusEqualsLambda.lean`（ラベル `c_plus_equals_Lambda_half_integer`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.cvec` / `cvec_ne_zero` / `star_cvec` / `cvec_mulVec` / `cvec_dotProduct` / `cvec_smul` | 実ベクトルの複素化とその基本性質 | 実／複素の橋渡し（新規） |
| `Ising2D.star_dotProduct_self` | `x^* x = ‖x‖²` | 同上 |
| `Ising2D.EvenSectorBridge` | 章 011 の `W` と章 017 の `V^{(+)}` の橋渡し（上記 0 の表） | 011・017 からの入力 |
| `EvenSectorBridge.quad_Qproj` | `x^* Q̌_ε x = ‖Q̌_ε x‖²` | `check_number_operator_is_hermitian` (4) |
| `EvenSectorBridge.sum_quad_Qproj` | `∑_ε ‖Q̌_ε x‖² = ‖x‖²` | Step 1 |
| `EvenSectorBridge.quad_Vr_eq_sum` | `x^T V^{(+)} x = ∑_ε Λ̌_ε ‖Q̌_ε x‖²` | Step 1 |
| **`EvenSectorBridge.quad_le_lamMax`** | **`x ∈ 𝓕^{(+)}, ‖x‖ = 1 ⇒ x^T W x ≤ Λ̌_max`** | **Step 1** |
| `EvenSectorBridge.reVec` / `cvec_reVec_add` / `reVec_eigen` | 複素固有ベクトルの実部も（実固有値なら）固有ベクトル | Step 2 |
| **`EvenSectorBridge.exists_real_max_eigenvector`** | **`Λ̌_max` の実固有ベクトルが存在し、偶セクターに属する** | **Step 2** |
| **`EvenSectorBridge.c_plus_equals_lamMax`** | **`c_+(M) = Λ̌_max`** | **定理本体（Step 3）** |
| `EvenSectorBridge.exists_maximizer` | 上限が偶セクターの実単位ベクトル `x_0` で**達成される** | 最後の一文 |

#### `Theorem010_OnsagerExactSolution.lean`（ラベル `onsager_exact_solution`、**本プロジェクトの結論**）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `EvenSectorBridge.lamMax_eq_LambdaM` | `Λ̌_max = Λ^{(1/2)}_M`（章 012 の記法との突き合わせ） | 記法の同定 |
| **`EvenSectorBridge.LambdaM_le_rayleighSup`** | **`Λ^{(1/2)}_M = c_+(M) ≤ c(M)`**（章 011 の `c_plus_le_c` と `c_plus_equals_lamMax`） | `c_between_Lambda_half_and_twice_Lambda_half` Step 1 |
| `Ising2D.NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup`（`NecSuf/EvenSectorUpperBound.lean`）/ `Ising2D.onsager_step3_c_le_two_c_plus` | **`c(M) ≤ 2c_+(M)`**（必要十分版とその `ε = epsilonR M` への特殊化） | `c_between_Lambda_half_and_twice_Lambda_half` Step 2 |
| **`EvenSectorBridge.rayleighSup_le_two_mul_LambdaM`** | **`c(M) ≤ 2c_+(M) = 2Λ^{(1/2)}_M`** | `c_between_Lambda_half_and_twice_Lambda_half` Step 2 |
| `EvenSectorBridge.rayleighSup_sandwich_LambdaM` | `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` | `c_between_Lambda_half_and_twice_Lambda_half`（`onsager_exact_solution` の Step 2 が引く） |
| `Ising2D.onsager_limit_in_N_row` | `N_row → ∞` の極限は `(1/M) log c(M)` | Step 1（章 012 の `limit_of_log_Z_in_N_row`） |
| `Ising2D.onsager_limit_in_M` | 挟み撃ち `(1/M)log Λ ≤ (1/M)log c(M) ≤ (1/M)log Λ + (log 2)/M` から、`M → ∞` の極限が Onsager の表式になる | Step 3（`log` の単調性、`(log 2)/M → 0`、章 012 の `onsager_free_energy_expression` を `δ = 1/2` で適用） |
| **`Ising2D.onsager_exact_solution`** | **`lim_{M→∞} lim_{N_row→∞} (1/(M N_row)) log Z = (1/2)log(2 sinh 2K_2) + (1/4π)∫₀^{2π} γ(θ)dθ`** | **定理本体** |

#### `DefinitionOpenChainAndBoundaryOperators.lean`・`ClaimH1PlusInSigmaZForm.lean`（ラベル `def_D0_open_chain_operator`・`def_G_boundary_operator`・`H1_plus_in_sigma_z_form`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.openChainD0` / `boundaryG` | `D_0 = ∑_{m=1}^{M_col-1}σ^z_mσ^z_{m+1}`、`G = σ^z_{M_col}σ^z_1` | `def_D0_open_chain_operator`・`def_G_boundary_operator` |
| `Ising2D.I_smul_Y_mul_Z_next_of_not_last` | `iY_mZ_{m+1} = σ^z_mσ^z_{m+1}` | 内部辺の計算 |
| `Ising2D.Y_last_mul_Z_first` / `epsilon_mul_sigmaZ_last_mul_sigmaZ_first` / `neg_I_smul_Y_last_mul_Z_first` | `Y_{M_col}Z_1 = -iσ^y_1σ^x_2⋯σ^y_{M_col}`、`εσ^z_{M_col}σ^z_1 = -σ^y_1σ^x_2⋯σ^y_{M_col}`、`-iY_{M_col}Z_1 = εσ^z_{M_col}σ^z_1` | 境界項の計算 |
| **`Ising2D.H1_plus_in_sigma_z_form`** | **`iH_1^{(+)} = D_0 + εG`**（`M_col ≥ 2`） | **主張本体** |

#### `ClaimEpsilonD0GCommuteAndDiagonalAction.lean`（ラベル `epsilon_D0_G_pairwise_commute`・`epsilon_G_is_involution`・`D0_G_diagonal_action`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.epsilon_mul_openChainD0` / `epsilon_mul_boundaryG` / `openChainD0_mul_boundaryG` | `εD_0 = D_0ε`、`εG = Gε`、`D_0G = GD_0` | `epsilon_D0_G_pairwise_commute` |
| `Ising2D.epsilon_mul_boundaryG_sq` | `(εG)^2 = I` | `epsilon_G_is_involution` |
| `Ising2D.openChainD0_mulVec_basisVec` / `boundaryG_mulVec_basisVec` | `D_0f_{ι(s)} = (∑_m s(m)s(m+1))f_{ι(s)}`、`Gf_{ι(s)} = s(M_col)s(1)f_{ι(s)}` | `D0_G_diagonal_action` |

#### `ClaimOpenChainSpinSums.lean`（ラベル `def_open_chain_spin_energy`・`open_chain_partition_sum`・`open_chain_endpoint_product_sum`・`open_chain_spin_sums_positive`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.openChainEnergy` / `openChainEnergy_mem_int` | `E(s) = ∑_{m=1}^{M_col-1}s(m)s(m+1) ∈ ℤ` | `def_open_chain_spin_energy` |
| `Ising2D.openChainChange` / `openChainChange_injective` / `openChainChange_bijective` | `Φ(s) = (s(1); t_1,…,t_{M_col-1})` は全単射 | 二つのスピン和の Step 1 |
| `Ising2D.prod_openChainBondSpin` | `∏_m t_m = s(1)s(M_col)` | `open_chain_endpoint_product_sum` の Step 2 |
| **`Ising2D.open_chain_partition_sum`** | **`∑_s exp(KE(s)) = 2(2cosh K)^{M_col-1}`** | **主張本体** |
| **`Ising2D.open_chain_endpoint_product_sum`** | **`∑_s s(M_col)s(1)exp(KE(s)) = 2(2sinh K)^{M_col-1}`** | **主張本体** |
| `Ising2D.open_chain_partition_sum_pos` / `open_chain_endpoint_product_sum_pos` | 二つのスピン和は正（`K > 0`） | `open_chain_spin_sums_positive` |

#### `ClaimTraceEpsilonVPlusReduction.lean`（ラベル `trace_of_epsilon_V_plus` の Step 1・Step 2）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| **`Ising2D.trace_epsilon_VPlusOfTransfer`** | **`tr(εV^{(+)}) = tr(εV_1^{(+)}V_2)`** | **Step 1** |
| `Ising2D.I_mul_smul_H1plus` / `commute_openChainD0_epsilon_mul_boundaryG` | `iK_1H_1^{(+)} = K_1D_0 + K_1εG`、`D_0` と `εG` は可換 | Step 2 |
| `Ising2D.V1plus_eq_exp_openChainD0_mul_exp` | `V_1^{(+)} = exp(K_1D_0)exp(K_1εG)` | Step 2（`theorem_exp_product`） |
| `Ising2D.matExp_hasSum` / `matExp_smul_of_sq_eq_one` / `exp_epsilon_mul_boundaryG` | `exp(X) = ∑_k (k!)^{-1}X^k`、`A^2 = I` なら `exp(tA) = cosh(t)I + sinh(t)A` | Step 2（`def_exp` の級数の偶奇分解） |
| **`Ising2D.epsilon_mul_V1plus`** | **`εV_1^{(+)} = exp(K_1D_0)(cosh(K_1)ε + sinh(K_1)G)`** | **Step 2** |

#### `ClaimTraceEpsilonVPlusMatrixEntries.lean`（ラベル `trace_of_epsilon_V_plus` の Step 3）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.negSpinConf` / `configBasisIso_negSpinConf` | `(-s)(m) := -s(m)`、`ι` のもとで全成分の入れ替えは `ι(s) ↦ ι(-s)` | Step 3 (b) とその理由 |
| `Ising2D.eq_diagonal_of_mulVec_basisVec` / `openChainD0_eq_diagonal` | `D_0` は対角行列で `(D_0)_{ι(s),ι(s)} = E(s)` | Step 3 (a)（`D0_G_diagonal_action`） |
| **`Ising2D.matExp_smul_openChainD0`** / `matExp_smul_openChainD0_apply` | **`exp(K_1D_0)` は対角行列で `(exp(K_1D_0))_{ι(s),ι(s)} = exp(K_1E(s))`** | **Step 3 (a)**（`exp_of_diagonal_matrix`） |
| **`Ising2D.boundaryG_eq_diagonal`** / `boundaryG_apply` | **`G` は対角行列で `G_{ι(s),ι(s)} = s(M_col)s(1)`** | **Step 3 (a)** |
| **`Ising2D.epsilon_mulVec_basisVec_configBasisIso`** | **`εf_{ι(s)} = f_{ι(-s)}`** | **Step 3 (b)** |
| `Ising2D.epsilon_apply_configBasisIso` / `epsilon_mul_apply_configBasisIso` | `ε_{ι(s),J} = δ_{J,ι(-s)}`、`(εA)_{ι(s),J} = A_{ι(-s),J}`（行の形。`epsilon_apply` から） | Step 4 が (b) として使う形 |
| `Ising2D.matExp_smul_openChainD0_mul_apply` / `boundaryG_mul_apply` | `(exp(K_1D_0)X)_{ι(s),J} = exp(K_1E(s))X_{ι(s),J}`、`(GX)_{ι(s),J} = s(M_col)s(1)X_{ι(s),J}` | Step 4 が (a) として使う形 |
| `Ising2D.sum_spin_mul_self` / **`V2_apply_configBasisIso_self`** / **`V2_apply_configBasisIso_neg_self`** | `∑_m s(m)s(m) = M_col`、**`(V_2)_{ι(s),ι(s)} = exp(M_colK_2)`、`(V_2)_{ι(-s),ι(s)} = exp(-M_colK_2)`** | **Step 3 (c)**（一般の成分は `V2_apply_configBasisIso`） |

#### `ClaimTraceEpsilonVPlusClosedForm.lean`（ラベル `trace_of_epsilon_V_plus` の Step 4・Step 5 と主張）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.trace_eq_sum_configBasisIso` | `tr(X) = ∑_{s∈𝔐} X_{ι(s),ι(s)}` | Step 4（`def_trace`） |
| `Ising2D.trace_epsilon_VPlusOfTransfer_split` | `tr(εV^{(+)}) = cosh(K_1)tr(exp(K_1D_0)εV_2) + sinh(K_1)tr(exp(K_1D_0)GV_2)` | Step 4 の最初の式 |
| `Ising2D.matExp_openChainD0_mul_epsilon_mul_V2_apply_self` / `matExp_openChainD0_mul_boundaryG_mul_V2_apply_self` | 二つの項の対角成分 `exp(K_1E(s))exp(-M_colK_2)`、`exp(K_1E(s))s(M_col)s(1)exp(M_colK_2)` | Step 4 |
| `Ising2D.trace_epsilon_VPlusOfTransfer_eq_spin_sums` | トレースを二つのスピン和で書いた形（実数） | Step 4 の最後の式鎖の 1 行目 |
| `Ising2D.trace_epsilon_VPlusOfTransfer_closed_form` | `tr(εV^{(+)}) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col}` | Step 4 の最後の式鎖の 2〜4 行目 |
| `Ising2D.trace_epsilon_VPlusOfTransfer_pos` | `0 < Re tr(εV^{(+)})`（`K_1 > 0`） | Step 5 |
| **`Ising2D.trace_of_epsilon_V_plus`** | **閉じた式と正値性** | **主張本体** |
| `Ising2D.trace_epsilon_vPlusDataOf_pos` | `vPlusDataOf` の `V^{(+)}` について `0 < Re tr(εV^{(+)})`（`VPlusOfTransfer_eq_VPlus` で人手の形へ戻す） | 最終定理の入力から欄 `htr` を外すために使う |

### 1.2 必要十分版（`lean/Ising2D/NecSuf/ParityFermion.lean`、名前空間 `Ising2D.NecSuf`）

| Lean の名前 | 内容 | 台に要求する構造 | 人手証明のラベル |
| --- | --- | --- | --- |
| `NecSuf.anticomm_sum_smul` | `e` が各 `x_i` と反交換 ⇒ `x_i` の任意の有限 `𝕜` 線型結合とも反交換 | `Ring A` + `Algebra 𝕜 A` | `epsilon_anticommutes_with_check_Z_Y` (2)(3) |
| **`NecSuf.commute_parity_num`** | **`e` が `c_i`, `a_i` の両方と反交換 ⇒ `e` は `n_i = c_i a_i` と可換** | **`Ring A` だけ** | 同 (4) 前半 |
| **`NecSuf.commute_parity_projOn`** | **`e` は `Q_ε` とも可換** | **`Ring A` だけ** | 同 (4) 後半 |
| `NecSuf.num_mul_cre` | `n_i c_i = c_i` | `Ring A` | `epsilon_eigenvalue_on_check_Q` Step 2 冒頭 |
| **`NecSuf.projOn_insert_mul_cre`** | **`μ ∈ s`, `μ ∉ T` ⇒ `Q_{T∪{μ}}(c_μ Q_T) = c_μ Q_T`** | **`Ring A` だけ** | 同 (2) Step 2 |
| **`NecSuf.cre_mul_projOn_ne_zero`** | **`Q_T ≠ 0` ⇒ `c_μ Q_T ≠ 0`** | **`Ring A` だけ（1 次元性不要）** | 同 (2) Step 1 |
| `NecSuf.noncommProd_mul_of_mul_eq_smul` | 各因子が `Q` にスカラー倍として働くなら積も働く | `Ring A` + `Algebra 𝕜 A` | 同 (4) |
| `NecSuf.star_projOn` | `n_i` が可換な自己共役族なら `Q_ε^* = Q_ε` | `StarRing A` | `check_number_operator_is_hermitian` (4) |
| `NecSuf.smul_left_cancel_of_ne_zero` | `x ≠ 0` ⇒ `ηx = η'x ⇒ η = η'` | `Module 𝕜 A`（`𝕜` は体） | `epsilon_eigenvalue_on_check_Q` (1) |
| **`NecSuf.sum_powerset_signed_exp`** | **`∑_{T ⊆ s} (−1)^{|s|−|T|} exp(∑_{i∈s} g_i(1_{i∈T} − 1/2)) = ∏_{i∈s} 2 sinh(g_i/2)`** | **ℝ の `exp`/`sinh` だけ** | `trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2 |
| **`NecSuf.open_chain_weighted_sum`**（`NecSuf/OpenChainSpinSum.lean`） | **`∑_{s∈𝔐} ∏_{m=1}^{M_col-1} g(s(m)s(m+1)) = 2(g(1)+g(-1))^{M_col-1}`** | **重みの値は可換半環だけ（`M_col ≠ 0`）** | `open_chain_partition_sum`・`open_chain_endpoint_product_sum` |
| `NecSuf.prod_mul_nextSite_eq_first_mul_last`（同） | 中間のサイトで `x(m)x(m) = 1` なら `∏_{m=1}^{M_col-1} x(m)x(m+1) = x(1)x(M_col)` | 可換モノイド（`M_col ≥ 2`。両端の `x·x = 1` は不要） | `open_chain_endpoint_product_sum` の Step 2 |
| **`NecSuf.exp_series_sum_of_sq_eq_one`**（`NecSuf/ExpOfInvolution.lean`） | **`A^2 = 1` で `∑_k (k!)^{-1}(tA)^k` の部分和の極限が `E` なら `E = cosh(t)·1 + sinh(t)·A`** | **`ℂ`-代数の半環、`ContinuousAdd`・`ContinuousSMul ℂ`・`T2`（ノルム・完備性・可換性・`t ∈ ℝ` は不要）** | `trace_of_epsilon_V_plus` Step 2 |

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 | 具体版は必要十分版の系か |
| --- | --- | --- | --- |
| `epsilon_anticommutes_with_check_Z_Y` (2)(3) | `Ising2D.epsilon_anticomm_checkZ` / `checkY` / `epsilon_anticomm_of_isCheckMode` | `NecSuf.anticomm_sum_smul` | **すべて系** |
| 同 (4) | `CheckFermi.commute_epsilon_nOp` / `commute_epsilon_Qproj` | `NecSuf.commute_parity_num` / `commute_parity_projOn` | **すべて系** |
| `epsilon_eigenvalue_on_check_Q` (1) | `CheckFermi.exists_eta` / `eta` / `eta_unique` | `NecSuf.smul_left_cancel_of_ne_zero`（一意性のみ） | **存在の部分は系にならない**（1 次元性が要る。下記参照） |
| 同 (2) | `CheckFermi.eta_insert` | `NecSuf.projOn_insert_mul_cre` / `cre_mul_projOn_ne_zero` | **系** |
| 同 (4) | `CheckFermi.epsilon_eq_parityProd` | `NecSuf.noncommProd_mul_of_mul_eq_smul` | **系** |
| `trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2 | `VPlusData.trace_epsilon_mul_V` | `NecSuf.sum_powerset_signed_exp` | **系** |
| `check_number_operator_is_hermitian` (4) | `CheckFermi.Qproj_conjTranspose` | `NecSuf.star_projOn` | **系** |
| `max_eigenvector_in_even_sector` | `VPlusData.eta_univ_eq_one` ほか | **置かない** | `Claim002`（反転則）と `Claim003`（トレースの符号）の組み合わせであり、新しい抽象構造が現れない |
| `c_plus_equals_Lambda_half_integer` | `EvenSectorBridge.c_plus_equals_lamMax` | **置かない** | `sSup` は ℝ の完備性そのものでほどく余地がない（章 011 の `Definition006_RayleighSup.lean` と同じ理由）。新しく現れる道具は実／複素の橋渡しだけ |
| `c_between_Lambda_half_and_twice_Lambda_half` Step 2 | `Ising2D.onsager_step3_c_le_two_c_plus` | `Ising2D.NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup` | **系**。効くのは `ε` が対合の置換行列であること、`W` の実対称半正定値性・`εW = Wε`・成分の**非負性**（人手は正を引くが使うのは非負だけ）。`π` が不動点をもたないことは使わない |
| `H1_plus_in_sigma_z_form` | `Ising2D.H1_plus_in_sigma_z_form` | **置かない** | 具体的な複素行列 `Y_m, Z_m, ε, σ^z_m` の等式で、主張に固有なのは各サイトの Pauli 行列の積だけ。一般的な部分は `siteProd_mul`・`siteProd_smul_family` に分離済み（`V1_in_Z_Y_epsilon` と同じ判断） |
| `epsilon_D0_G_pairwise_commute`・`epsilon_G_is_involution`・`D0_G_diagonal_action` | `Ising2D.epsilon_mul_openChainD0` ほか | **置かない** | 具体的な `ε, σ^z_m` の反可換性・`(σ^z)^2 = I`・対角作用だけを使い、取り払える構造が残らない |
| `open_chain_partition_sum`・`open_chain_endpoint_product_sum` | `Ising2D.open_chain_partition_sum` / `open_chain_endpoint_product_sum` / `prod_openChainBondSpin` | `NecSuf.open_chain_weighted_sum` / `NecSuf.prod_mul_nextSite_eq_first_mul_last` | **系**（`Part018/ClaimOpenChainSpinSumsFromNecSuf.lean` の `*_of_necSuf`） |
| `trace_of_epsilon_V_plus` Step 2 の `exp(K_1εG) = cosh(K_1)I + sinh(K_1)εG` | `Ising2D.matExp_smul_of_sq_eq_one` | `NecSuf.exp_series_sum_of_sq_eq_one` | **系**（`Part018/ClaimTraceEpsilonVPlusReductionFromNecSuf.lean` の `matExp_smul_of_sq_eq_one_of_necSuf`）。Step 1 と Step 2 の残りは具体的な `ε, B, V_1^{(+)}, D_0, G` の可換性とトレースの巡回性だけで、取り払える構造が残らないので置かない |
| `trace_of_epsilon_V_plus` Step 3 | `Ising2D.matExp_smul_openChainD0` ほか | **置かない** | 一般化できるのは行列の列の読み取り（任意の半環で成り立つ自明な事実）と `{±1}` の符号反転の組合せだけで、必要十分版にしても何が本質的かについて情報を与えない |
| `onsager_exact_solution`（Step 1・2・4） | `Ising2D.onsager_exact_solution` | **置かない** | 既存の必要十分版（`NecSuf/LogSqueeze.lean`, `NecSuf/RiemannSum.lean`）を章 012 が既に系として使っており、本章はその具体版を章 011・018 の結果に接続するだけ |

### 必要十分版で判明した本質（本文には持ち込まない）

- **`ε` が `ň_μ`・`Q̌_ε` と可換であること（人手証明 (4)）に効いているのは、
  `ε` が生成・消滅演算子の両方と反交換することと `(−1)² = 1` だけである。**
  `ε = σ^x_1⋯σ^x_M` であることも、`ψ̌` が `Ž, Y̌` の 1 次結合であることも、
  行列であることも、複素数であることも、テンソル冪であることも効いていない。
  台は**任意の環**でよい（`NecSuf.commute_parity_num` / `commute_parity_projOn`）。

- **符号の反転則（人手証明 (2)）に `im Q̌_ε` の 1 次元性は要らない。**
  人手証明は (1)(2) の両方で 1 次元性を引くが、必要な材料は次の 3 つだけである。
  1. `Q_{T∪{μ}}(c_μ Q_T) = c_μ Q_T` — `n_μ c_μ = c_μ` と「`n_ν`（`ν ≠ μ`）が `c_μ` と可換」から、
     環の計算だけで出る（`NecSuf.projOn_insert_mul_cre`）。
  2. `c_μ Q_T ≠ 0` — `a_μ c_μ = 1 − n_μ` と `n_μ Q_T = 0`（`μ ∉ T`）から出る
     （`NecSuf.cre_mul_projOn_ne_zero`）。**ここが 1 次元性を使わない要点である。**
  3. `ε(c_μ Q_T) = −η_T (c_μ Q_T)` — 反交換関係だけ。

  すなわち**1 次元性が本当に要るのは `η_ε` の「存在」だけ**であり、反転則そのものは
  1 次元性なしで出る。存在の部分は台が行列環であることが本質的なので、
  具体版（`Part018/Claim002_EpsilonEigenvalueOnQ.lean`）にしか置いていない。

- **`tr(εV^{(+)})` の積への分解（人手証明 Step 2）に効いているのは、
  有限集合の冪集合にわたる和の積への変形（`Finset.prod_add`）と
  `sinh x = (e^x − e^{−x})/2` だけである。** `γ` が `arccosh` で書けることも、
  `V^{(+)}` が転送行列であることも、`Λ̌_ε` が固有値であることも、半整数運動量であることも
  効いていない（`NecSuf.sum_powerset_signed_exp` は `g : ι → ℝ` を任意にとる）。

- **1 次元開鎖の二つのスピン和に効いているのは、変数変換 `Φ(s) = (s(1); s(m)s(m+1))` の全単射と、
  重みの値の側の可換半環の構造（有限積の有限和への展開）だけである。** 重みの値については実数・指数関数・`cosh`・`sinh` は効いておらず、
  二つの和は重み `g(t) = exp(Kt)` と `g(t) = t·exp(Kt)` の特殊化にすぎない（`NecSuf.open_chain_weighted_sum`）。
  スピンの側（`𝔐`）は人手の定義のまま固定した。そこで効くのは、`{-1,1}` が乗法で閉じることと `s·s = 1`（`Φ` の単射性）、
  元の個数 `2` だけで、`ℝ` の加法・順序は効いていない。
  `M_col ≥ 2` は端点因子の書き替えで両端を別々に括り出すところだけで効き、`x(m)x(m) = 1` は中間のサイトでしか効かない。
  人手の端点因子の書き替えの一段「`ℝ` の乗法の可換性と結合性」は、Lean では `∏_m s(m)` と `∏_m s(m+1)` への分解・
  添字のずらし・両端の括り出しの段に割れる。

- **`γ(θ̃_μ) > 0`（半整数運動量に固有の性質）が効くのは 1 箇所だけである。**
  `∏_μ 2 sinh(γ_μ/2) ≠ 0`（したがって `tr(εV^{(+)})` の符号が `η_{(1,…,1)}` で決まる）と、
  `Λ̌_ε ≤ Λ̌_{(1,…,1)}` の 2 つに使う。整数運動量なら `γ = 0` のモードが出て両方が壊れる。

## 3. 形式化できなかった主張とその理由

| 人手証明（ブロック） | 状況 | 理由 |
| --- | --- | --- |
| `closing_006_theorem_trace_of_epsilon_V_plus`（`tr(εV^{(+)}) = (2e^{−K_2}\cosh K_1)^M + (2e^{K_2}\sinh K_1)^M > 0`） | **形式化した**（`ClaimTraceEpsilonVPlusClosedForm.lean` の `trace_of_epsilon_V_plus`） | 依存先の `D_0,G` の定義・`H1_plus_in_sigma_z_form`・可換性と対角作用・二つのスピン和は形式化した（「形式化した定理の一覧」の `DefinitionOpenChainAndBoundaryOperators.lean`・`ClaimH1PlusInSigmaZForm.lean`・`ClaimEpsilonD0GCommuteAndDiagonalAction.lean`・`ClaimOpenChainSpinSums.lean` の表）。この定理本体のうち Step 1・Step 2 は `ClaimTraceEpsilonVPlusReduction.lean`、Step 3 は `ClaimTraceEpsilonVPlusMatrixEntries.lean`、Step 4・Step 5 は `ClaimTraceEpsilonVPlusClosedForm.lean` で形式化した。`Ising2D.VPlusData.eta_univ_eq_one` 以降は一般の `VPlusData` について述べるので `0 < (tr(εV^{(+)})).re` を仮定に置き、最終定理では `trace_epsilon_vPlusDataOf_pos` で埋める。**人手証明で証明済みであり循環参照はない**（この定理は `epsilon_eigenvalue_on_check_Q` にも `max_eigenvector_in_even_sector` にも依存しない） |
| `closing_000_remark_overview` | 形式化対象外 | `remark`（本章の位置づけの説明）であり、数学的主張は他ブロックに含まれる |

詳細と一次情報は `docs/tasks/2026-07_lean-ch009-013/015_ch018-formalization-findings.md` に記録した。

## 4. Onsager の最終定理の挟み撃ち `c_between_Lambda_half_and_twice_Lambda_half`（人手証明と 1 対 1）

人手証明 `c_between_Lambda_half_and_twice_Lambda_half`（もとは `onsager_exact_solution` の Step 2・Step 3。2026-10-31 に独立した主張へ分けた）は
`Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` という**粗い挟み撃ち**を採る（原文 `conversion.notes` に
よれば `c_-(M)` の値に依存しないため）。Lean も同じ挟み撃ちで述べる
（`EvenSectorBridge.LambdaM_le_rayleighSup` / `rayleighSup_le_two_mul_LambdaM`、`onsager_exact_solution` の Step 3 の
`onsager_limit_in_M` で `(log 2)/M → 0` を使う）。

以前の Lean は、章 019 の `Ising2D.c_minus_le_c_plus`（`c_-(M) ≤ c_+(M)`）と `Ising2D.c_equals_c_plus`
（`c(M) = c_+(M)`）で挟み撃ちなしに `c(M) = Λ^{(1/2)}_M` を出していた（旧 `rayleighSup_eq_LambdaM`）。
2026-09-26 に人手の本文が `(−)` セクターを参照用ノート
`structured-latex/notes/minus_sector_not_adopted.ts` へ退避し、章 019 も本文から外れたので、Lean も
本文と同じ経路に揃えた。章 019 の Lean は形式化の記録として残してある（`lean/docs/ch019-formalization.md`）。

`c_between_Lambda_half_and_twice_Lambda_half` の Step 2 の人手証明と Lean の対応（`NecSuf/EvenSectorUpperBound.lean`）:

| 人手の段 | Lean |
| --- | --- |
| `u_k := |x_k|`, `uᵀWu ≥ |xᵀWx| ≥ xᵀWx` | `NecSuf.quad_le_quad_absVec`（`NecSuf/PermMatrix.lean`） |
| `ε` は置換行列（`trace_of_epsilon_V_plus` Step 3 (b)）、`‖εu‖ = ‖u‖ = ‖x‖ = 1` | `epsilonR M = permMat flipConf`、`NecSuf.vecNormSq_permMat_mulVec`、`NecSuf.vecNormSq_absVec` |
| `εv = v`（`ε² = I`）、`v ≠ 0` | `permMat_mul_self`、`v ≥ u` から `‖v‖² ≥ ‖u‖² = 1` |
| `‖v‖² = 2 + 2uᵀεu ≤ 4`（Cauchy–Schwarz） | `Ising2D.psd_cauchy_schwarz` を `P = I` で |
| `vᵀWv = 2uᵀWu + 2uᵀWεu ≥ 2uᵀWu`（`εᵀ = ε`, `εW = Wε`, `ε² = I`） | `mulVec_dotProduct_selfadjoint`（`εᵀ = ε`）、仮定 `hcomm`、`NecSuf.bilin_nonneg_of_nonneg` |
| `c_+ ≥ v̂ᵀWv̂ = vᵀWv/‖v‖² ≥ ⋯ ≥ xᵀWx/2` | `le_evenSectorRayleighSup` と同じ順の `calc` |

Lean は `v ≠ 0` を「`v ≥ u ≥ 0` と `u ≠ 0`」から直接でなく `‖v‖² ≥ ‖u‖² = 1 > 0` の形で示し、
`v̂ := v/‖v‖` の代わりに `(1/√‖v‖²)·v` を使う。

## 5. 検証

```
$ cd exact-solution-of-2d-ising-model/lean
$ lake build                    # Build completed successfully
$ ./scripts/check-no-sorry.sh   # exit 0
OK: ソース中に sorry / admit は無い
OK: 主要定理はいずれも sorryAx に依存していない
```

`scripts/check-no-sorry.sh` の `targets` 配列の末尾に本章の 106 個の定義・定理を追加してある。
`sorry` / `admit` は 1 つも残っていない。

## 6. 本章のあとに入った章 014–017 の形式化との接続（**完了**）

本章のコミット後、並行セッションが章 014・015・016・017 を形式化して main に入れた。
**その結果を差し込んで、`Ising2D.CheckFermi` / `Ising2D.VPlusData` の仮定はすべて
定理に置き換わった。** 章 018 以外の `.lean` ファイルは 1 つも編集していない（読むだけ）。

### 6.1 追加したファイル

| ファイル | 内容 |
| --- | --- |
| `Part018/Claim011_CheckFermiFromPart016.lean` | `Ising2D.checkFermiOf`（`CheckFermi` のインスタンス）と、その `hstar` を埋める橋渡し補題 `Ising2D.checkPsiDag_conjTranspose` |
| `Part018/Claim012_VPlusDataFromPart017.lean` | `Ising2D.vPlusDataOf`（`VPlusData` のインスタンス）と、章 017 の `CheckFermiSetup`（添字型 `CheckIdx M`）と章 018 の `CheckFermi`（添字型 `Fin M`）を噛み合わせる `Ising2D.finCheckIdxEquiv` / `checkFermiSetupOf_Vprime` |
| `Part018/ClaimVPlusRealEntries.lean` | 人手 `c_plus_equals_Lambda_half_integer` Step 2 の「`V^{(+)}` の成分は実である」（`Ising2D.VPlus_hasRealEntries`）と、`vPlusDataOf` の `V^{(+)}` の実行列表示 `Ising2D.VPlusR`・`Ising2D.vPlusDataOf_V_eq_map`（`EvenSectorBridge` の欄 `Vr`・`hVr`） |
| `Part018/ClaimWEqVPlusOnEvenSector.lean` | 人手 `c_plus_equals_Lambda_half_integer` Step 0「`𝓕^{(+)}` の上で `W` と `V^{(+)}` が一致する」。`P^{(+)}x = x`（`Ising2D.epsProjPlus_mulVec_of_even`）、複素ベクトル上の `Wx = V^{(+)}x`（`Ising2D.W_mulVec_eq_VPlus_mulVec_of_even`）、具体的な `W` と `VPlusR` についての実ベクトル版 `Ising2D.hWV_physical`（`EvenSectorBridge` の欄 `hWV`）。必要十分版は `NecSuf/EvenSectorAgreement.lean` の `Ising2D.NecSuf.invProj_smul_of_fixed`（加群・`2` の可逆性だけ）と `Ising2D.NecSuf.smul_eq_of_mul_proj_eq`（半群の作用だけ）で、具体版はその特殊化（`*_of_necSuf`） |
| `Part018/PhysicalEvenSectorBridge.lean` | 具体的な `W = physicalSymTransferR M K_1 K_2` と `vPlusDataOf` の `V^{(+)}` についての `Ising2D.EvenSectorBridge`（`Ising2D.physicalEvenSectorBridge`）。欄 `hWsymm`・`hWpsd` は章 011 `W_is_real_symmetric_positive_definite` の具体版 `physicalSymTransferR_isSymm`・`physicalSymTransferR_posDef`（`x = 0` を足した `Ising2D.physicalSymTransferR_nonneg`）、`Vr`・`hVr` は Step 2、`hWV` は Step 0 |
| `Part018/Theorem013_OnsagerUnconditional.lean` | 仮定を取らない挟み撃ち `Ising2D.rayleighSup_sandwich_LambdaM_physical`、Step 1 `Ising2D.onsager_limit_in_N_row_physical`（`c(M) > 0` は人手 `limit_of_log_Z_in_N_row` と同じく `def_rayleigh_sup` から `rayleighSup_pos` で出す）と、`Ising2D.onsager_exact_solution_unconditional`（入力は結合定数の組だけ） |
| `Part018/TheoremOnsagerExactSolutionEndToEnd.lean` | 通しの定理 `Ising2D.onsager_exact_solution_end_to_end`（`scripts/check-end-to-end.sh` が固定する型。入力は `K_1, K_2` とその正値性だけ）と、被積分関数を `gammaFn` を経ずに書いた `Ising2D.gammaFn_eq_arcosh_Kstar` |

### 6.2 消えた仮定（何で埋めたか）

| もとの仮定 | 出典の章 | 埋めた定理 |
| --- | --- | --- |
| `CheckFermi.hcre` / `hann`（`ψ̌^†, ψ̌` が `Ž, Y̌` の 1 次結合） | 016 | `Ising2D.checkPsiDag` / `checkPsi` の定義そのもの（`Part016/Definition001_CheckFermi.lean`） |
| `CheckFermi.acomm_cre_cre` / `acomm_ann_ann` / `acomm_cre_ann`（CAR） | 016 | `Ising2D.checkPsi_car'`（`Part016/Claim010_UnconditionalViaPart015.lean`。仮定は `M ≠ 0` だけ） |
| `CheckFermi.hstar`（`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`） | 016 | **本セッションで新たに証明**した `Ising2D.checkPsiDag_conjTranspose`（章 018 の `checkZ_conjTranspose` / `checkY_conjTranspose` と章 008 の `gamma2_neg_eq_neg_conj` だけを使う） |
| `VPlusData.hV`（`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`） | 016・017 | `Ising2D.VPlus_eq_smul_checkVprime_const`（016 の `VPlus_eq_smul_checkVprime_of_dual` ＋ 017 の `constant_c_value_even_sector`）と `Ising2D.checkVprime_mul_Qproj` |
| `VPlusData.C`, `hC`（`C = (2 sinh 2K_2)^{M/2} > 0`） | 017 | 同上（`constant_c_value_even_sector` が `c` の値を確定させる） |
| `VPlusData.gam`, `hgam`（`γ(θ̃_μ) > 0`） | 015・017 | `Ising2D.gammaFn_thetaTilde_pos`（`Part017/Theorem011_MaxEigenvalueSimple.lean`。**無条件**） |
| `rayleighSup_sandwich_LambdaM` の `hC` / `hgam`（章 012 の記法との一致） | 012・017 | `rfl` と `Ising2D.sum_checkGam`（`tagPoint_half_eq_thetaTilde` の系） |
| `hWpos`（具体的な `W` の成分が正） | 011 | `Ising2D.physicalSymTransferR_pos`（人手 `W_has_positive_entries`、`Part011/ClaimPhysicalWHasPositiveEntries.lean`） |
| `hWcomm`（`ε` と具体的な `W` の可換性） | 011 | `Ising2D.epsilon_commutes_with_W`（`Part011/ClaimEpsilonCommutesWithW.lean`） |
| `htr`（`tr(εV^{(+)}) > 0`）と `hM`（`M ≠ 0`） | 018 | `Ising2D.trace_epsilon_vPlusDataOf_pos`（人手 `trace_of_epsilon_V_plus`）。`M ≠ 0` は `2 ≤ M` から出す |

### 6.3 噛み合わせが必要だった箇所（一次情報）

1. **添字型のずれ。** 章 017 の `CheckFermiSetup` は `CheckIdx M = {μ ∈ ℤ | 1 ≤ μ ≤ M}`、
   章 018 の `CheckFermi` は `Fin M` で添字づけている。`Ising2D.finCheckIdxEquiv`
   （`j ↦ j+1`、全単射性は `checkIdx_injective` と `CheckIdx.card` から）を置き、
   `X̌` が両側で同じ行列であること（`checkFermiSetupOf_Xop`）を示した。
   これにより章 017 の `constant_c_value_even_sector` を章 016 の `checkVprime` に適用できる。
   なお `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` 自体は章 017 の `Q̌_ε` を経由せず、章 018 側の
   `CheckFermi.nOp_mul_Qproj` から直接導いた（射影を添字型ごと移す必要が無くなる）。
2. **`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}` が章 016 に無かった。** 章 016 は CAR と `V^{(+)} = cV̌'` までで、
   `ψ̌` の共役転置は扱っていない（`grep -rn "conjTranspose" Ising2D/Part016/` が空）。
   係数側の等式 `conj(p_μ) = -p_{M+1-μ}`（`Ising2D.star_checkP`）を新たに証明して埋めた。

### 6.4 残った仮定（無い）

残った仮定は無い。もとの場 `htr`（`tr(εV^{(+)}) > 0`）は `trace_epsilon_vPlusDataOf_pos` で埋め、
その型のために置いていた `hM`（`M ≠ 0`）は `2 ≤ M` から出す。`hWpos`（具体的な `W` の成分が正）は
`Ising2D.physicalSymTransferR_pos`（人手 `W_has_positive_entries`、`Part011/ClaimPhysicalWHasPositiveEntries.lean`）、
`hWcomm`（`ε` と具体的な `W` の可換性）は `Ising2D.epsilon_commutes_with_W`（`Part011/ClaimEpsilonCommutesWithW.lean`）で埋め、
欄を束ねていた構造 `EvenSectorClosureInput` を消した。

`onsager_exact_solution_unconditional` の `Z` は具体的な `partitionFunction N_row M K_1 K_2`、`c(M)` は
`rayleighSup (physicalSymTransferR M K_1 K_2)` で、挟み撃ち `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`（`N_row ≥ 1`）は
章 011 の `partition_function_sandwich_physical`（`Part011/PhysicalPartitionFunctionSandwich.lean`）が与える。
`W` と `V^{(+)}` の橋渡し（もとの場 `bridge` と、`bridge.W` が具体的な `W` であるという仮定 `hW`）は、
`Ising2D.physicalEvenSectorBridge`（`PhysicalEvenSectorBridge.lean`）で具体的な `W` について構成し、仮定から外した。

双対関係 `c_2 s_2^* = c_2^*`（もとの場 `hdual`）は、`IsingParam.K2star` を `Kstar K2`
（人手 `def_second_dual_coupling_constant`）で定義し、人手 `duality_c2_star_eq_s2_star_c2` を
`EigenvalueProblem/ReductionToATheta/ClaimDualityC2StarEqS2StarC2.lean` で形式化したことで定理 `IsingParam.c2_mul_s2star_eq_c2star`
になり、最終定理の仮定から外した。

### 6.5 検証

```
$ cd exact-solution-of-2d-ising-model/lean
$ export PATH="$HOME/.elan/bin:$PATH" && lake build   # Build completed successfully
$ ./scripts/check-no-sorry.sh                          # exit 0
$ ./scripts/check-end-to-end.sh                        # OK（sorryAx に依存しない）
```

`scripts/check-no-sorry.sh` の `targets` 配列の末尾に、本接続で追加した 28 個の
定義・定理（`Ising2D.checkFermiOf` … `Ising2D.onsager_exact_solution_unconditional`）を追加した。

## 7. （旧記録）本章のあとに入った章 016・017 の形式化との関係

本章のコミット後、並行セッションが章 016（`Ising2D/Part016/`）と章 017（`Ising2D/Part017/`）を
形式化して main に入れた。**本章の `Ising2D.CheckFermi` / `Ising2D.VPlusData` を
それらの定理から埋める作業は未着手である。** 本タスクの担当範囲（章 018）外なので、
章 016・017 のファイルには手を触れていない。接続すれば `CheckFermi` の仮定（`ψ̌` の CAR）と
`VPlusData` の仮定（`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` ほか）は定理に置き換わる。
