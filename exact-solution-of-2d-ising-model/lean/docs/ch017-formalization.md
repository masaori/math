# 章 017「定数 `c` の決定と `V^{(+)}` の固有値」の形式化

対象の人手証明: `structured-latex/content/017_even_sector_eigenvalues.ts`（11 主張）

- 具体版: `Ising2D/Part017/`
- 必要十分版: `Ising2D/NecSuf/PairedFermion.lean`, `Ising2D/NecSuf/ConstantC.lean`,
  `Ising2D/NecSuf/SimpleEigenvalue.lean`
  （加えて、章 009 の `Ising2D/NecSuf/NumberOperator.lean` と
  `Ising2D/NecSuf/JointEigenspace.lean` を**そのまま再利用している**）

---

## 0. 本章の結論（先に要点）

**章 017 の主張のうち 9 本は、章 009 の必要十分版をそのまま特殊化して得られる。**
章 009（整数運動量）と章 017（半整数運動量）の違いは、必要十分版の言葉では

> **対をなす添字を与える単射 `σ` の取り方だけ**（章 009 は `σ(μ) = -μ`、
> 章 017 は `σ(μ) = M+1-μ`）

であり、`Ising2D/NecSuf/PairedFermion.lean` の `acomm_cre_ann_comp` が
その 1 行の橋渡しである。消滅演算子を `a'_i := a_{σ i}` と付け替えれば
`δ_{ν,σ μ}` は Kronecker の `δ_{μν}` になり、章 009 の
`NecSuf.num_mul_num` / `commute_num_num` / `projOn_*` / `two_pow_smul_tau_projOn` /
`exp_mul_eq_of_mul_eq_smul` がすべてそのまま通る。

**そのうえで、本章に固有で数学的に新しいのは次の 2 点だけである。**

1. **添字集合が無条件に確定する。** 章 009 の `FermiSetup` は
   「`{1,…,M}` に含まれ、そこで `γ_2(θ_μ) ≠ 0` となる有限集合 `I`」を
   **仮定として受け取る**形になっていた（臨界点では `|I| = M-1` になりうる）。
   半整数運動量では `γ_2(θ~_μ) ≠ 0` が例外なく成り立つので、
   **`𝓜̌ = {1,…,M}` に確定し、仮定として受け取る余地が無い**
   （`Ising2D.CheckIdx`、`Ising2D.CheckIdx.card : Fintype.card (CheckIdx M) = M`）。
   その帰結として `m = M`、すなわち
   - `tr(Q̌_ε) = 2^{M-M} = 1`（同時固有空間はすべて 1 次元）
   - `tr(V̌')` の前因子 `2^{M-m}` が消える

   が出る。**Lean 側でも `CheckFermiSetup` は添字集合を場として持っていない**
   （章 009 の `FermiSetup` は `I`, `hIlow`, `hIhigh`, `hgam` の 4 つを持っていた）。
2. **`γ(θ~_μ) > 0` が狭義である**（`Ising2D.gammaFn_thetaTilde_pos`）。
   章 009 は `γ(θ_μ) ≥ 0` しか持てないので最大固有値の単純性を言えないが、
   半整数運動量では `0 < θ~_μ < 2π` から `cos θ~_μ < 1` が出て
   `γ_1(θ~_μ) > cosh(2K_1-2K_2^*) ≥ 1`、したがって `γ(θ~_μ) > 0` が
   **すべての `μ ∈ 𝓜̌`、すべての `K_1, K_2 > 0`（臨界点を含む）で**成り立つ。
   この 1 点だけで `Λ̌_max` の単純性が従う。

なお、平方根の分枝の選択（章 009 の `FermiSetup.hbr`、原文の穴）は、
本章では `ψ̌` の CAR を仮定として受け取るため `CheckFermiSetup` に現れない。
分枝の整合が必要なのは CAR を導くところ（章 015）である。

---

## 1. 形式化した定理の一覧

### 必要十分版（`Ising2D.NecSuf`）

| Lean の名前 | 内容 | 対応する人手証明のラベル |
| --- | --- | --- |
| `NecSuf.annPaired` / `numPaired` | `a'_i := a_{σ i}`、`n_i := c_i a_{σ i}` | `def_check_number_operator` |
| `NecSuf.acomm_cre_ann_comp` | `δ_{ν,σ μ}` 型の CAR は付け替えで Kronecker の `δ_{μν}` になる（`σ` の単射性だけ） | `check_number_operator_idempotent` (2)、`check_number_operators_commute` Step 1 |
| `NecSuf.two_pow_smul_tau_noncommProd` | `2^{|s|} τ(∏_{i∈s} n_i) = τ(1)` | `trace_of_check_number_operator_product` |
| `NecSuf.const_eq_of_trace_ratio` | `T = cp = aτ`, `T' = c⁻¹p = a⁻¹τ`, `a,p>0`, `T>0` ⇒ `c = a` | `constant_c_value_even_sector` |
| `NecSuf.sum_weight_lt_of_ne_univ` | 重みが狭義正なら `∑ w_i(χ_T(i)-1/2)` は `T = univ` でのみ最大 | `max_eigenvalue_of_V_plus_simple` (2) |
| `NecSuf.sum_weight_le_univ` / `sum_weight_empty_le` | 重みが非負のときの最大・最小（非狭義） | `eigenvalues_of_V_plus` (2) |
| `NecSuf.eq_proj_of_eigen` | 単位の分解 `∑ Q_ε = 1` と `Q_ε V = Λ_ε Q_ε` と `Λ_ε ≠ Λ_{ε_0}` だけから固有空間を同定 | `max_eigenvalue_of_V_plus_simple` (3) |
| `NecSuf.mul_pow_eq_of_mul_eq_smul` / `mul_exp_eq_of_mul_eq_smul` | `Q X = gQ ⇒ Q exp(X) = e^g Q`（章 009 の左右反転版） | `eigenvalues_of_check_Vprime` Step 2/3 |
| `NecSuf.isInternal_range_proj` / `isInternal_range_matrix_proj` / `exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj` | 内部直和分解と対角化可能性（**章 009 と共通の必要十分版**。`NecSuf/JointEigenspaceDecomposition.lean`） | `check_joint_eigenspace_decomposition` (5)、`eigenvalues_of_check_Vprime` / `eigenvalues_of_V_plus`（対角化可能） |

### 具体版（`Ising2D`, `Ising2D.CheckFermiSetup`）

| Lean の名前 | 内容 | 対応する人手証明のラベル |
| --- | --- | --- |
| `checkIdxFinset` / `CheckIdx` / `CheckIdx.card` | `𝓜̌ = {1,…,M}` と `|𝓜̌| = M` | `def_check_index_set` |
| `conjIdx` / `conjIdx_involutive` | 共役添字 `μ ↦ M+1-μ` が対合であること | `def_check_number_operator` (1) |
| `CheckFermiSetup` | `ψ̌^†, ψ̌` と CAR（章 015 の内容を仮定として受け取る） | `def_check_fermi`, `anticommutator_of_check_psi` |
| `CheckFermiSetup.nOp` | `ň_μ = ψ̌_μ^† ψ̌_{M+1-μ}` | `def_check_number_operator` |
| `CheckFermiSetup.nOp_eq_numPaired` | `ň_μ` が必要十分版 `numPaired` の特殊化であることの確認 | 同上 |
| `CheckFermiSetup.acomm_cre_ann` | `[ψ̌_μ^†, ψ̌_{M+1-ν}]_+ = δ_{μν} I`（**合同式の書き換え不要**） | `anticommutator_of_check_psi` の制限 |
| `CheckFermiSetup.cre_sq` / `ann_sq` / `ann_mul_cre` / `nOp_mul_self` | (1)(2)(3) | `check_number_operator_idempotent` |
| `CheckFermiSetup.commute_cre_nOp` / `commute_ann_nOp` / `commute_nOp_nOp` | (1)(2) | `check_number_operators_commute` |
| `CheckFermiSetup.nOpProd` / `trace_nOpProd` | `tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M-k}` | `trace_of_check_number_operator_product` |
| `CheckFermiSetup.trace_nOp` / `trace_nOpProd_univ` | `tr(ň_μ) = 2^{M-1}`, `tr(ň_1⋯ň_M) = 1` | 同上「とくに」 |
| `CheckFermiSetup.Qproj` / `Qproj'` | `Q̌_ε`（`Finset` 版 / `ε : 𝓜̌ → Bool` 版） | `check_joint_eigenspace_decomposition` |
| `CheckFermiSetup.Qproj_mul_self` / `Qproj_mul_Qproj_of_ne` | (1) | 同 (1) |
| `CheckFermiSetup.sum_Qproj` | `∑_ε Q̌_ε = I` | 同 (2) |
| `CheckFermiSetup.nOp_mul_Qproj` | `ň_ν Q̌_ε = ε_ν Q̌_ε` | 同 (3) |
| `CheckFermiSetup.trace_Qproj` | **`tr(Q̌_ε) = 1`** | 同 (4) |
| `CheckFermiSetup.finrank_range_Qproj` | **`dim im Q̌_ε = 1`** | 同 (4) 後半 |
| `CheckFermiSetup.sum_Qproj_mulVec` / `eq_zero_of_sum_eq_zero` | 直和分解（張ること・直和性） | 同 (5) |
| `CheckFermiSetup.Xop` / `Vprime` / `gval` | `X̌`, `V̌' = exp(X̌)`, `ǧ(ε)` | `def_check_number_operator` (2), `def_check_Vprime` |
| `CheckFermiSetup.Xop_mul_Qproj` / `Qproj_mul_Xop` | `X̌ Q̌_ε = ǧ(ε) Q̌_ε`（左右両方） | `eigenvalues_of_check_Vprime` Step 1 |
| `CheckFermiSetup.Vprime_mul_Qproj` / `Qproj_mul_Vprime` | `V̌' Q̌_ε = e^{ǧ(ε)} Q̌_ε`（左右両方） | 同 Step 3 |
| `CheckFermiSetup.Vprime_mulVec_of_mem_range` | `im Q̌_ε` の元は固有ベクトル | 同 Step 4 |
| `CheckFermiSetup.VprimeUnits` / `Vprime_mul_Vprime_neg` | `(V̌')^{-1} = exp(-X̌)` | `def_check_Vprime` (2) |
| `CheckFermiSetup.sum_exp_gval` | `∑_ε e^{ǧ(ε)} = ∏_μ 2cosh(γ(θ~_μ)/2)` | `trace_of_check_Vprime` Step 2 |
| `CheckFermiSetup.trace_Vprime` | **`tr(V̌') = ∏_μ 2cosh(γ/2)`（前因子なし）** | 同 Step 1〜2 |
| `CheckFermiSetup.trace_Vprime_inv` / `trace_Vprime_pos` | `tr((V̌')^{-1}) = tr(V̌') > 0` | 同 Step 3〜4 |
| `VPlus`（章 014 の定義を再利用）/ `VPlus_eq_Vmat` | `V^{(+)}` は章 014 `Part014/Definition001_VPlus.lean` のものを使う。章 009 の `Vmat M K1 (-1) s2 K2star` と `rfl` で一致することを `VPlus_eq_Vmat` で明示した | `def_V_plus` |
| `VPlus_posDef` | `V^{(+)}` は正定値 | `V_plus_is_positive_definite` |
| `VPlusInv` / `VPlus_mul_VPlusInv` / `VPlusInv_mul_VPlus` | 明示した候補が `V^{(+)}` の右逆かつ左逆である | `V_plus_is_invertible` |
| `VPlusInv_posDef` | `(V^{(+)})^{-1}` の正定値性 | `V_plus_inverse_is_positive_definite` |
| `trace_VPlus_pos` | `tr(V^{(+)})` の正値性 | `trace_V_plus_is_positive` |
| `trace_VPlusInv_pos` | `tr((V^{(+)})^{-1})` の正値性 | `V_plus_inverse_positive_and_trace_positivity` |
| `trace_VPlus` / `trace_VPlusInv` | `tr(V^{(+)}) = (2s_2)^{M/2}τ`, `tr((V^{(+)})^{-1}) = (2s_2)^{-M/2}τ` | `constant_c_value_even_sector` Step 1〜2 |
| `VPlusInv_eq` | `V^{(+)} = cV̌' ⇒ (V^{(+)})^{-1} = c⁻¹(V̌')^{-1}` | 同 Step 3（逆元の一意性） |
| `constant_c_value_even_sector` | **`c = (2 sinh 2K_2)^{M/2}`** | `constant_c_value_even_sector` |
| `checkBigLambda` / `VPlus_mul_Qproj` / `Qproj_mul_VPlus` | `Λ̌_ε` と `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` | `eigenvalues_of_V_plus` (1) |
| `VPlus_mulVec_of_mem_range` | `im Q̌_ε` の元は `V^{(+)}` の固有ベクトル | 同 (1) |
| `checkBigLambda_pos` / `checkBigLambda_le_max` / `checkBigLambda_min_le` | 正値性・最大・最小 | 同 (2) |
| `checkBigLambda_max_mul_min` | `Λ̌_max Λ̌_min = (2 sinh 2K_2)^M = c^2` | 同 |
| `cos_thetaTilde_lt_one` / `one_lt_gamma1R_thetaTilde_checkIndex` | `cos θ~_μ < 1`, `γ_1(θ~_μ) > 1` | 章 015 `gamma1_gt_1_theta_tilde` |
| `gammaFn_thetaTilde_pos` | **`γ(θ~_μ) > 0`** | 章 015 `def_gamma_theta_tilde_mu` |
| `checkIdxFinset_injOn` / `sum_checkIdx` | `𝓜̌` 上の和を `{0,…,M-1}` 上の和へ付け替える（`μ = k+1`） | `max_eigenvalue_of_V_plus_simple` (1) の `Θ^{(1/2)}_M` の元数え |
| `tagPoint_half_eq_thetaTilde` | `t^{(M)}_μ|_{δ=1/2} = θ~_μ` | 同 (1) |
| `checkBigLambda_univ_eq_LambdaM` | **`Λ̌_max = Λ^{(1/2)}_M`** | `max_eigenvalue_of_V_plus_simple` (1) |
| `checkBigLambda_lt_max` / `checkBigLambda_lt_max_of_gammaFn` | **`ε ≠ (1,…,1) ⇒ Λ̌_ε < Λ̌_max`（狭義）** | 同 (2) |
| `eq_Qproj_univ_mulVec_of_eigen` | **固有値 `Λ̌_max` の固有ベクトルは `im Q̌_{(1,…,1)}` に入る** | 同 (3) 前半 |
| `finrank_range_Qproj_univ` | **その空間の次元は `1`（単純固有値）** | 同 (3) 後半 |
| `CheckFermiSetup.isInternal_range_Qproj` | **`ℂ^{2^M} = ⊕_ε im Q̌_ε`（内部直和。各成分は 1 次元）** | `check_joint_eigenspace_decomposition` (5) |
| `CheckFermiSetup.iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj` | 同 (5) を `Submodule` の言葉で分けて述べた版 | 同 (5) |
| `CheckFermiSetup.exists_eigenBasis_Vprime` / `exists_conj_diagonal_Vprime` | **`V̌'` は対角化可能** | `eigenvalues_of_check_Vprime` |
| `exists_eigenBasis_VPlus` / `exists_conj_diagonal_VPlus` | **`V^{(+)}` は対角化可能（固有値は `Λ̌_ε`）** | `eigenvalues_of_V_plus` |

---

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 |
| --- | --- | --- |
| `def_check_number_operator` | `CheckFermiSetup.nOp` | `NecSuf.numPaired`（= `NecSuf.num` に付け替えを噛ませたもの） |
| `check_number_operator_idempotent` | `CheckFermiSetup.cre_sq` / `ann_sq` / `ann_mul_cre` / `nOp_mul_self` | `NecSuf.sq_eq_zero_of_acomm_self` / `ann_mul_cre` / `num_mul_num`（**章 009 と同一**） |
| `check_number_operators_commute` | `CheckFermiSetup.commute_*` | `NecSuf.commute_cre_num` / `commute_ann_num` / `commute_num_num`（**章 009 と同一**） |
| `trace_of_check_number_operator_product` | `CheckFermiSetup.trace_nOpProd` | `NecSuf.two_pow_smul_tau_noncommProd` |
| `check_joint_eigenspace_decomposition` (1)(2)(3)(4) | `CheckFermiSetup.Qproj_*` / `sum_Qproj` / `nOp_mul_Qproj` / `trace_Qproj` | `NecSuf.projOn_*` / `sum_projOn` / `num_mul_projOn` / `two_pow_smul_tau_projOn`（**章 009 と同一**） |
| `eigenvalues_of_check_Vprime` | `CheckFermiSetup.Vprime_mul_Qproj` / `Qproj_mul_Vprime` | `NecSuf.exp_mul_eq_of_mul_eq_smul`（章 009 と同一）／その左右反転 `NecSuf.mul_exp_eq_of_mul_eq_smul` |
| `constant_c_value_even_sector` | `Ising2D.constant_c_value_even_sector` | `NecSuf.const_eq_of_trace_ratio` |
| `eigenvalues_of_V_plus` (2) | `checkBigLambda_le_max` / `checkBigLambda_min_le` | `NecSuf.sum_weight_le_univ` / `sum_weight_empty_le` |
| `max_eigenvalue_of_V_plus_simple` (2)(3) | `checkBigLambda_lt_max` / `eq_Qproj_univ_mulVec_of_eigen` | `NecSuf.sum_weight_lt_of_ne_univ` / `NecSuf.eq_proj_of_eigen` |
| `check_joint_eigenspace_decomposition` (5) | `CheckFermiSetup.isInternal_range_Qproj` / `iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj` | `NecSuf.isInternal_range_proj`（**章 009 と同一**） |
| `eigenvalues_of_check_Vprime` / `eigenvalues_of_V_plus`（対角化可能） | `CheckFermiSetup.exists_eigenBasis_Vprime` / `exists_conj_diagonal_Vprime`、`exists_eigenBasis_VPlus` / `exists_conj_diagonal_VPlus` | `NecSuf.exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj`（**章 009 と同一**） |

具体版はいずれも**必要十分版を特殊化して導出している**。

### 必要十分版で判明した本質

- **直和分解と対角化可能性は、章 009 と文字どおり同じ必要十分版 1 本で足りる。**
  章 009 と章 017 の違い（同時固有空間の次元が `2^{M-m}` か `1` か、和の範囲が `𝓘` か `𝓜̌` か）は
  必要十分版の仮定にまったく現れない。効いているのは「有限個の直交射影の和が恒等」と
  「固有関係 `f Q̌_ε = Λ̌_ε Q̌_ε`」だけである。

- **整数運動量版と半整数運動量版は、同じ必要十分版の別の特殊化である。**
  違いは「対をなす添字を与える写像 `σ`」だけで、章 009 は `σ(μ) = -μ`、
  章 017 は `σ(μ) = M+1-μ`。しかも必要十分版に効いているのは
  **`σ` が単射であることだけ**で、対合であることすら要らない
  （対合性は人手証明が `ň_μ` の個数を数えるのに使うだけである）。
  人手証明が「009 章の `-μ` をそのまま写してはならない」と警告している箇所は、
  必要十分版では `σ` を差し替える 1 箇所に集約される。

- **人手証明が「`𝓜̌` へ絞ったので合同式の計算が要らない」と書いている点**は、
  必要十分版では `Function.Injective σ` から `σ j = σ i ↔ j = i` が出る、というだけである
  （`NecSuf.acomm_cre_ann_comp`）。`M+1-μ` という具体形も、
  `{1,…,M}` に閉じていることも効いていない。

- **`c` の決定（`constant_c_value_even_sector`）に、行列もトレースも指数関数も効いていない。**
  効いているのは体 ℂ の中の 4 つの等式 `T = cp`, `T' = c⁻¹p`, `T = aτ`, `T' = a⁻¹τ` と
  `a > 0`, `p > 0`, `T > 0` だけである（`NecSuf.const_eq_of_trace_ratio`）。
  正定値性も「`tr(V^{(+)})` が正の実数である」という**数**としてしか使われていない。
  **章 009 の `constant_c_value` も同じ補題の特殊化である。**

- **最大固有値の単純性 (3) に、直和分解 (5) は要らない。**
  人手証明は「`x = ∑_ε Q̌_ε x` と (5) の直和性から各項が `0`」と書いているが、
  効いているのは `∑_ε Q̌_ε = 1` と `Q̌_ε V^{(+)} = Λ̌_ε Q̌_ε`（**左からの**固有関係）と
  `Λ̌_ε ≠ Λ̌_max` の 3 つだけで、`Q̌_ε^2 = Q̌_ε` も `Q̌_ε Q̌_{ε'} = 0` も
  有限次元性も使っていない（`NecSuf.eq_proj_of_eigen`）。
  人手証明が `V Q = ΛQ` と `Q V = ΛQ` を区別していないのは `V` と `Q` が可換だからで、
  Lean では `Qproj_mul_Vprime` として明示的に用意した。

- **最大性の狭義性 (2) に効いているのは「重みがすべて狭義に正」だけ**である
  （`NecSuf.sum_weight_lt_of_ne_univ`）。指数関数も転送行列も固有値も効いていない。
  章 009 が単純性を言えなかった理由も、この 1 点（`γ(θ_μ) ≥ 0` しか無い）に還元される。

---

## 3. 形式化できなかった主張とその理由

| 原文の主張 | 状況 | 理由 |
| --- | --- | --- |
| `anticommutator_of_check_psi`（章 015）と `V_plus_eq_c_check_Vprime`（章 016） | **仮定として受け取った** | 章 014・015・016 は並行して形式化中。前者は `CheckFermiSetup` の場 `hcc` / `haa` / `hca` として、後者は `constant_c_value_even_sector` などの仮定 `hVeq : VPlus … = c • F.Vprime g` として明示した |
| `γ(θ~_μ)` と `g : CheckIdx M → ℝ` の同定 | **仮定として受け取った（ただし本章内で埋められる）** | 章 009 と同じく `g` を実数の族として受け取っている。`g i = gammaFn P (thetaTilde M i.1)` を仮定すると `Λ̌_max = Λ^{(1/2)}_M` と狭義最大性が出る（`checkBigLambda_univ_eq_LambdaM`, `checkBigLambda_lt_max_of_gammaFn`）。`γ(θ~_μ) > 0` そのものは**無条件に証明済み**（`gammaFn_thetaTilde_pos`） |
| `eigenvalues_of_check_Vprime` / `eigenvalues_of_V_plus` の「対角化可能」 | **形式化した（2026-07-30）** | `Ising2D.CheckFermiSetup.exists_eigenBasis_Vprime` / `exists_conj_diagonal_Vprime`、`Ising2D.exists_eigenBasis_VPlus` / `exists_conj_diagonal_VPlus`（`Part017/Claim006_DirectSumAndDiagonalization.lean`）。章 009 とまったく同じ必要十分版 `Ising2D.NecSuf.exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj` の特殊化である |
| `check_joint_eigenspace_decomposition` (5) の `DirectSum.IsInternal` 形 | **形式化した（2026-07-30）** | `Ising2D.CheckFermiSetup.isInternal_range_Qproj`（`Part017/Claim006_DirectSumAndDiagonalization.lean`）。`Submodule` の言葉での前半・後半は `iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj`。必要十分版は章 009 と共通（`NecSuf/JointEigenspaceDecomposition.lean`） |

---

## 4. 人手証明に見つかった問題

**結論を覆す誤りは見つからなかった。** 冗長・不要と分かった箇所が 3 つある
（`exact-solution-of-2d-ising-model/docs/tasks/2026-07_lean-ch009-013/004_ch017_冗長な手順と暗黙の前提.md`
に一次情報つきで記録した）。要約:

1. `check_joint_eigenspace_decomposition` (4) の二項展開と二項定理は**不要**
   （章 009 で既に判明していたのと同じ理由）。
2. `max_eigenvalue_of_V_plus_simple` (3) の証明が引用している
   `check_joint_eigenspace_decomposition` (5)（直和分解）は**不要**。
   `∑_ε Q̌_ε = I` と固有関係だけで固有空間が同定できる。
3. `V_plus_inverse_is_positive_definite` の statement は `(V^{(+)})^{-1}` も正定値だと述べるが、
   章 009 の `V_is_positive_definite` には対応する主張が無い
   （章 009 は `V^{-1}` の明示形までしか出していない）。本章で `VPlusInv_posDef` として補った。
