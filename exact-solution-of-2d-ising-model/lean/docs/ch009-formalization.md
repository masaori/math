# 章 009「転送行列 `V` の固有値」の形式化

対象の人手証明: `structured-latex/content/009_eigenvalues_of_V.ts`（19 ブロック）

- 具体版: `Ising2D/Part009/`
- 必要十分版: `Ising2D/NecSuf/NumberOperator.lean`, `Ising2D/NecSuf/JointEigenspace.lean`

`lake build` 成功・`scripts/check-no-sorry.sh` exit 0（`sorry` / `admit` ゼロ）。

---

## 1. 形式化した定理の一覧

### 必要十分版（`Ising2D.NecSuf`）

| Lean の名前 | 内容 | 対応する人手証明のラベル |
| --- | --- | --- |
| `NecSuf.num` | `n_i := c_i a_i` | `def_number_operator` |
| `NecSuf.sq_eq_zero_of_acomm_self` | `x + x = 0 → x = 0` の下で `x x = 0` | `number_operator_idempotent` (1) |
| `NecSuf.ann_mul_cre` | `a_i c_i = 1 - n_i` | 同 (2) |
| `NecSuf.num_mul_num` | `n_i^2 = n_i` | 同 (3) |
| `NecSuf.commute_mul_of_anticommute` | 反可換 2 元の積との可換性 | `number_operators_commute` Step 2 |
| `NecSuf.commute_cre_num` / `commute_ann_num` | `c_i`, `a_i` は `n_j` (`i≠j`) と可換 | `number_operators_commute` (1) |
| `NecSuf.commute_num_num` | `n_i n_j = n_j n_i` | 同 (2) |
| `NecSuf.commute_num_of_commute` | `c_i, a_i` が `P` と可換なら `n_i` も | 補助（原文は暗黙） |
| `NecSuf.tau_num_mul_add_self` | `τ(n_i P) + τ(n_i P) = τ(P)` | `trace_of_number_operator_product` の帰納段階 |
| `NecSuf.projFactor` / `projOn` | `R_μ^{(ε_μ)}` と `Q_ε = ∏ R` | `joint_eigenspace_decomposition` |
| `NecSuf.projOn_mul_self` | `Q_ε^2 = Q_ε` | 同 (1) 後半 |
| `NecSuf.projOn_mul_projOn_of_ne` | `ε≠ε' ⇒ Q_ε Q_{ε'} = 0` | 同 (1) 前半 |
| `NecSuf.sum_projOn` | `∑_ε Q_ε = 1` | 同 (2) |
| `NecSuf.num_mul_projOn` | `n_ν Q_ε = ε_ν Q_ε` | 同 (3) |
| `NecSuf.two_pow_smul_tau_projOn` | `2^{|s|} τ(Q_ε) = τ(1)` | 同 (4)、`trace_of_number_operator_product` |
| `NecSuf.pow_mul_eq_of_mul_eq_smul` | `X Q = gQ ⇒ X^k Q = g^k Q` | `eigenvalues_of_Vprime` Step 2 |
| `NecSuf.exp_mul_eq_of_mul_eq_smul` | `X Q = gQ ⇒ exp(X) Q = e^g Q` | 同 Step 3 |
| `NecSuf.isInternal_range_proj` | 直交する射影の族の像は**内部直和分解**を与える（`DirectSum.IsInternal`） | `joint_eigenspace_decomposition` (5) |
| `NecSuf.iSupIndep_range_proj` / `iSup_range_proj_eq_top` | 同 (5) の後半（独立性）・前半（全体を張ること） | 同 (5) |
| `NecSuf.idem_of_ortho_of_sum_eq_one` | **冪等性 (1) 後半は仮定に要らず、(1) 前半と (2) から従う** | 同 (1) |
| `NecSuf.eigen_of_mem_range_proj` / `collectedBasis_eigen` | `f Q_ε = c_ε Q_ε` なら `im Q_ε` の元は固有値 `c_ε` の固有ベクトル。各成分の基底を集めたものは固有ベクトルからなる基底 | `eigenvalues_of_Vprime` Step 4 |
| `NecSuf.toMatrix_collectedBasis_eq_diagonal` | その基底に関する表現行列は対角行列 | 同 Step 4 |
| `NecSuf.isInternal_range_matrix_proj` / `exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj` | 上記の行列版（**対角化可能性**: `P P' = P' P = 1` かつ `P' A P = diagonal Λ`） | 同 Step 4 の結論 |

### 具体版（`Ising2D`, `Ising2D.FermiSetup`）

| Lean の名前 | 内容 | 対応する人手証明のラベル |
| --- | --- | --- |
| `trace_eq_sum_diag` | `tr(A) = ∑_k A_{kk}`（mathlib `Matrix.trace` と一致） | `def_trace` |
| `trace_linear` / `trace_cyclic` / `trace_one_eq_card` / `trace_conj` | 線型性・巡回性・`tr(I)=n`・共役不変 | `trace_basic_properties` (1)(2)(3)(4) |
| `trace_of_idempotent` | `Q^2=Q ⇒ tr(Q) = dim im Q` | `trace_of_idempotent` |
| `isCompl_range_ker_of_idempotent` | `ℂ^n = im Q ⊕ ker Q` | 同 Step 1 |
| `trace_one_tensorPow` | `tr(I) = 2^M` | `trace_of_number_operator_product` の `k=0` |
| `tensorPow_two_torsion_free` | `x+x=0 → x=0`（`Mat(2^M,ℂ)`） | `number_operator_idempotent` (1) の「`2≠0`」 |
| `FermiSetup` | 原文 `def_number_operator` の設定（`𝓘`, 分枝 `t`） | `def_number_operator` |
| `FermiSetup.nOp` | `n_μ = ψ_μ^† ψ_{-μ}` | `def_number_operator` |
| `FermiSetup.acomm_cre_cre` / `acomm_ann_ann` / `acomm_cre_ann` | `𝓘` 上の CAR（`δ^M` が Kronecker `δ_{μν}` になる） | `anticommutator_of_psi` の制限 |
| `FermiSetup.cre_sq` / `ann_sq` | `(ψ^†)^2 = 0`, `(ψ)^2 = 0` | `number_operator_idempotent` (1) |
| `FermiSetup.ann_mul_cre` | `ψ_{-μ}ψ_μ^† = I - n_μ` | 同 (2) |
| `FermiSetup.nOp_mul_self` | `n_μ^2 = n_μ` | 同 (3) |
| `FermiSetup.commute_cre_nOp` / `commute_ann_nOp` | `ψ_μ^†, ψ_{-μ}` は `n_ν` と可換 | `number_operators_commute` (1) |
| `FermiSetup.commute_nOp_nOp` | `n_μ n_ν = n_ν n_μ` | 同 (2) |
| `FermiSetup.Qproj` / `Qproj'` | `Q_ε`（`Finset` 版 / `ε : 𝓘 → Bool` 版） | `joint_eigenspace_decomposition` |
| `FermiSetup.Qproj_mul_self` / `Qproj_mul_Qproj_of_ne` | (1) | 同 (1) |
| `FermiSetup.sum_Qproj` | `∑_ε Q_ε = I` | 同 (2) |
| `FermiSetup.nOp_mul_Qproj` | `n_ν Q_ε = ε_ν Q_ε` | 同 (3) |
| `FermiSetup.two_pow_mul_trace_Qproj` / `trace_Qproj` | `2^m tr(Q_ε) = 2^M`, `tr(Q_ε) = 2^{M-m}` | 同 (4) |
| `FermiSetup.finrank_range_Qproj` | `dim im Q_ε = 2^{M-m}` | 同 (4) 後半 |
| `FermiSetup.card_I_le` | `m ≤ M` | 同（`2^{M-m}` が書けることの根拠） |
| `FermiSetup.sum_Qproj_mulVec` / `eq_zero_of_sum_eq_zero` | 直和分解（張ること・直和性） | 同 (5) Step 5 |
| `FermiSetup.Xop` / `Vprime` / `gval` | `X`, `V' = exp(X)`, `g(ε)` | `def_number_operator`, `def_Vprime` |
| `FermiSetup.Xop_mul_Qproj` | `X Q_ε = g(ε) Q_ε` | `eigenvalues_of_Vprime` Step 1 |
| `FermiSetup.Vprime_mul_Qproj` | `V' Q_ε = e^{g(ε)} Q_ε` | 同 Step 3 |
| `FermiSetup.Vprime_mulVec_of_mem_range` | `im Q_ε` の元は固有ベクトル | 同 Step 4 |
| `FermiSetup.Vprime_mul_Vprime_neg` / `Vprime_neg_mul_Vprime` | `V'^{-1} = exp(-X)` | `trace_of_Vprime` Step 1 |
| `FermiSetup.sum_exp_gval` | `∑_ε e^{g(ε)} = ∏_μ 2cosh(γ_μ/2)` | 同 Step 3 |
| `FermiSetup.trace_Vprime` | `tr(V') = 2^{M-m}∏ 2cosh(γ_μ/2)` | 同 Step 2〜3 |
| `FermiSetup.trace_Vprime_inv` | `tr(V'^{-1}) = tr(V')` | 同 Step 4 |
| `FermiSetup.trace_Vprime_pos` | `tr(V') > 0` | 同 Step 5 |
| `pauliX/Y/Z_transpose`, `..._conjTranspose` | Pauli 行列の転置・共役転置 | `iH_is_real_symmetric` Step 3 |
| `siteProd_transpose` / `siteProd_conjTranspose` | クロネッカー積の転置は因子ごとの転置 | `kronecker_transpose` |
| `Z_transpose` / `Z_conjTranspose` / `Y_transpose` / `Y_conjTranspose` | `Z^⊤=Z`, `Y^⊤=-Y`, `Z^*=Z`, `Y^*=Y` | 同（原文には無い中間段階） |
| `S1_isHermitian` / `S1_transpose` / `S2_isHermitian` / `S2_transpose` | `S_1^{(±)}, S_2` は実対称 | `iH_is_real_symmetric` |
| `entries_real_of_isHermitian_of_transpose` | 「実対称」＝「エルミート＋転置不変」 | `def_hermitian_positive_definite` の最後の注意 |
| `posDef_smul_of_pos` | 正定値の正実数倍は正定値 | `exp_hermitian_is_positive_definite` (3) |
| `posDef_exp_of_isHermitian` | エルミートの `exp` は正定値 | 同 (1) |
| `Vmat` / `Vmat_posDef` / `trace_Vmat_pos` | `V` の定義・正定値性・`tr(V) > 0` | `V_is_positive_definite` |
| `Uflip` / `UflipInv` / `Uflip_mul_inv` / `UflipInv_mul` | 符号反転共役 `U = EF` と可逆性 | `sign_flip_conjugation` Step 0 |
| `Uflip_conj_sigmaX/Y/Z` | `U σ^a_k U^{-1}` の符号 | 同 Step 1 |
| `Uflip_conj_Z` / `Uflip_conj_Y` | `U Z_m U^{-1} = -Z_m`, `U Y_m U^{-1} = Y_m` | 同（原文には無い中間段階） |
| `Uflip_conj_H1` / `Uflip_conj_H2` / `Uflip_conj_S1` / `Uflip_conj_S2` | `U H U^{-1} = -H`, `U S U^{-1} = -S` | `sign_flip_conjugation` |
| `Uflip_conj_matExp` | `U exp(S) U^{-1} = exp(USU^{-1})` | `constant_c_value` Step 2 |
| `VmatInv` / `Vmat_mul_VmatInv` / `VmatInv_mul_Vmat` | `V^{-1}` の明示形 | `V_is_positive_definite` Step 4 |
| `tauTrace` / `trace_Vmat` / `trace_VmatInv` | `τ`, `tr(V) = (2s_2)^{M/2}τ`, `tr(V^{-1}) = (2s_2)^{-M/2}τ` | `constant_c_value` Step 1 |
| `trace_exp_neg_eq_tau` | `tr(exp(-S_1)exp(-S_2)) = τ` | 同 Step 2 |
| `constant_c_value` | **`c = (2 sinh 2K_2)^{M/2}`** | `constant_c_value` |
| `bigLambda` / `Vmat_mul_Qproj` | `Λ_ε` と **`V Q_ε = Λ_ε Q_ε`** | `eigenvalues_of_V` (1) |
| `bigLambda_pos` | `Λ_ε > 0` | 同 (2) |
| `bigLambda_le_max` / `bigLambda_min_le` | `Λ_max` は全 `ε_μ=1`、`Λ_min` は全 `ε_μ=0` | 同 (2) |
| `bigLambda_max_mul_min` | `Λ_max Λ_min = (2 sinh 2K_2)^M` | 同 |
| `FermiSetup.isInternal_range_Qproj` | **`ℂ^{2^M} = ⊕_ε im Q_ε`（内部直和）** | `joint_eigenspace_decomposition` (5) |
| `FermiSetup.iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj` | 同 (5) を `Submodule` の言葉で分けて述べた版 | 同 (5) |
| `FermiSetup.exists_eigenBasis_Vprime` | **`V'` の固有ベクトルからなる基底が取れ、表現行列は対角行列** | `eigenvalues_of_Vprime`（対角化可能） |
| `FermiSetup.exists_conj_diagonal_Vprime` | **`P' V' P = diagonal Λ`（`P` は可逆）** | 同 |
| `FermiSetup.exists_conj_diagonal_Vmat` | **`V = cV'` を仮定した `V` の対角化** | `eigenvalues_of_V`（対角化可能） |

---

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 |
| --- | --- | --- |
| `def_number_operator` | `Ising2D.FermiSetup.nOp`（`Mat(2^M,ℂ)`） | `Ising2D.NecSuf.num`（任意の環、任意の添字型） |
| `number_operator_idempotent` | `FermiSetup.cre_sq` / `ann_sq` / `ann_mul_cre` / `nOp_mul_self` | `NecSuf.sq_eq_zero_of_acomm_self` / `ann_mul_cre` / `num_mul_num` |
| `number_operators_commute` | `FermiSetup.commute_cre_nOp` / `commute_ann_nOp` / `commute_nOp_nOp` | `NecSuf.commute_cre_num` / `commute_ann_num` / `commute_num_num` |
| `trace_of_number_operator_product` | `FermiSetup.two_pow_mul_trace_Qproj`（`Matrix.trace`） | `NecSuf.tau_num_mul_add_self` / `two_pow_smul_tau_projOn`（加法的かつ巡回的な汎関数） |
| `joint_eigenspace_decomposition` (1)(2)(3)(4) | `FermiSetup.Qproj_*` / `sum_Qproj` / `nOp_mul_Qproj` / `trace_Qproj` | `NecSuf.projOn_*` / `sum_projOn` / `num_mul_projOn` / `two_pow_smul_tau_projOn` |
| `eigenvalues_of_Vprime` Step 2/3 | `FermiSetup.Vprime_mul_Qproj` | `NecSuf.pow_mul_eq_of_mul_eq_smul` / `exp_mul_eq_of_mul_eq_smul` |
| `joint_eigenspace_decomposition` (5) | `FermiSetup.isInternal_range_Qproj` / `iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj`（既存の `sum_Qproj_mulVec` / `eq_zero_of_sum_eq_zero` が人手証明の書き方に 1 対 1 で対応する版） | `NecSuf.isInternal_range_proj` / `isInternal_range_matrix_proj`（任意の環上の加群、有限個の直交射影だけ） |
| `eigenvalues_of_Vprime` / `eigenvalues_of_V`（対角化可能） | `FermiSetup.exists_eigenBasis_Vprime` / `exists_conj_diagonal_Vprime` / `exists_conj_diagonal_Vmat` | `NecSuf.exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj`（任意の体上の有限次元、固有関係 `f Q_ε = c_ε Q_ε` だけ） |

具体版はいずれも**必要十分版を特殊化して導出している**（`Definition004_NumberOperator.lean` /
`Claim008_JointEigenspace.lean` / `Claim009_EigenvaluesVprime.lean` を参照）。
そのうえで、人手証明と 1 対 1 に対応する形の主張を具体版として別に立ててある。

### 必要十分版で判明した本質

- **直和分解 (5) に効いているのは「有限個の直交射影の和が恒等」だけ**である。行列であること・
  有限次元性・複素数であること・個数演算子であること・CAR はどれも効いていない。
  さらに **`Q_ε^2 = Q_ε`（原文 (1) 後半）は独立な仮定ではなく、(1) 前半と (2) から従う**
  （`NecSuf.idem_of_ortho_of_sum_eq_one`）。原文が 2 つに分けて述べている性質の一方は冗長である。
- **対角化可能性に追加で効いているのは、係数が体であること（各成分に基底が取れる）と
  固有関係 `f Q_ε = c_ε Q_ε` だけ**である。`V'` が指数関数であることも、固有値が正の実数であることも
  効いていない。

- **個数演算子の冪等性・可換性に効いているのは、台が環であることと CAR、
  そして加法群に 2-捩れが無いこと（`x + x = 0 → x = 0`）の 3 つだけ**である。
  `ψ` の具体形（`hat(Z)^{(-)}, hat(Y)` の線型結合）も、行列であることも、
  複素数であることも、テンソル冪であることも、`M` も `γ_2` も効いていない。
  添字型は等号の決定可能性すら要らない（`δ_{ij}` は各定理へ反交換子の値として渡すだけ）。
  2-捩れの仮定は**省略できない**: 標数 2 では `(ψ^†)^2 = 0` が CAR から出ない。

- **同時固有空間分解 (1)(2)(3) に効いているのは、台が環であることと
  「`n_i` が互いに可換な冪等元であること」の 2 つだけ**である。CAR すら要らない
  （CAR は `n_i` が可換な冪等元であることを導くために使うだけ）。

- **トレースの計算に効いているのは「加法的かつ巡回的な汎関数 `τ` が 1 つあること」だけ**である。
  `τ` の値域は任意の可換群でよく（(4) では可換**群**、`trace_of_number_operator_product` の
  帰納段階だけなら可換モノイドで足りる）、割り算も、複素数であることも、
  行列のトレースであることも効いていない。`τ(1) = 2^M` という具体値も結論に
  そのまま現れるだけである。

- **人手証明 (4) の二項展開と二項定理は不要**である。効いているのは
  「どちらの因子（`n_j` でも `1 - n_j` でも）についても `2 τ(R_j X) = τ(X)`」という
  1 段の帰納法だけで、`1 - n_j` の場合はその差として自動的に出る。

- **`exp(X) Q = e^{g} Q` に効いているのは ℂ 上の完備ノルム環であることだけ**である。
  行列であることも、有限次元であることも、`Q` が射影であることも効いていない。

- 積の順序について: 人手証明の「因子は互いに可換なので積の順序は問わない」は、
  Lean では `Finset.noncommProd`（可換性の証明を引数に取る積）としてそのまま書ける。
  非可換環に `Finset.prod` が無いことへの回避であり、数学的な内容は増えていない。

### 必要十分版を置かなかった主張とその理由

- `def_trace` / `trace_basic_properties`: mathlib の `Matrix.trace_add` / `trace_smul` /
  `trace_mul_comm` / `trace_one` が既に任意の可換半環について述べており、
  これ以上取り払える構造が無い。巡回性という**性質だけ**を仮定にした必要十分版は
  上記の `τ` として存在する。
- `iH_is_real_symmetric` / `V_is_positive_definite` / `sign_flip_conjugation` /
  `constant_c_value` / `eigenvalues_of_V`: いずれも**この模型の具体的な対象**
  （`Z_m, Y_m, H_1^{(±)}, H_2, V_1, V_2, U`）についての主張であり、
  取り払える一般構造が無い。使っている一般論（トレースの線型性・巡回性、
  共役が環準同型であること、`exp` の性質）はすべて既存の必要十分版で押さえてある。

---

## 3. 形式化できなかった主張とその理由

| 原文の主張 | 状況 | 理由 |
| --- | --- | --- |
| `joint_eigenspace_decomposition` (5) の `DirectSum.IsInternal` 形 | **形式化した（2026-07-30）** | `Ising2D.FermiSetup.isInternal_range_Qproj`（`Part009/Claim009_DirectSumAndDiagonalization.lean`）。必要十分版 `Ising2D.NecSuf.isInternal_range_matrix_proj`（`NecSuf/JointEigenspaceDecomposition.lean`）の特殊化。人手証明 Step 5 の 2 つの事実（`x = ∑_ε Q_ε x` / 直和性）は従来どおり `sum_Qproj_mulVec` / `eq_zero_of_sum_eq_zero` にあり、`Submodule` の言葉での対応物が `iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj` である |
| `eigenvalues_of_Vprime` / `eigenvalues_of_V` の「`V'`（`V`）は対角化可能」 | **形式化した（2026-07-30）** | `Ising2D.FermiSetup.exists_eigenBasis_Vprime`（固有ベクトルからなる基底 `b` と `LinearMap.toMatrix b b V' = diagonal Λ`）、`exists_conj_diagonal_Vprime`（`P' V' P = diagonal Λ`, `P P' = P' P = 1`）、`exists_conj_diagonal_Vmat`（`V = cV'` を仮定した `V` 版）。いずれも必要十分版 `Ising2D.NecSuf.exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj` の特殊化 |
| `γ(θ_μ) = arccosh(γ_1(θ_μ))` であること | **仮定として受け取った** | mathlib に `Real.arccosh` が無い（`lean/README.md`「mathlib に無いことが分かっているもの」に既出）。本章が `γ` について使うのは `γ(θ_μ) ≥ 0` だけなので、非負実数の族 `g : 𝓘 → ℝ` として受け取っている |
| `V_eq_Vprime`（008 章、「ある `c ∈ ℂ^×` が存在して `V = cV'`」） | **仮定として受け取った** | 008 章の内容で本リポジトリでは未形式化。`constant_c_value` の仮定 `hVeq : Vmat = c • Vprime` として明示 |
| `gamma_2_theta_is_0` による `𝓘` の同定（`𝓘 = {1,…,M}` または `{1,…,M-1}`） | **仮定として受け取った** | 008 章の内容（`Ising2D.gamma2_eq_zero_iff` として形式化済み）。009 章では「`{1,…,M}` に含まれ、そこで `γ_2(θ_μ) ≠ 0` となる有限集合 `I`」として `FermiSetup` の仮定に置いた |
| `ψ` の平方根の分枝の一意性 | **仮定として受け取った** | 008 章で既に指摘済みの**原文の穴**。`FermiSetup.hbr` として明示（`docs/tasks/2026-07_lean-ch009-013/001_...md` (2) 参照） |

---

## 4. 人手証明に見つかった問題

`exact-solution-of-2d-ising-model/docs/tasks/2026-07_lean-ch009-013/003_ch009_未定義記号と暗黙の仮定.md`
に一次情報つきで記録した。要約:

1. `number_operator_idempotent` の証明中で、009 章では定義されていない記号 `\mathcal{M}` を使っている。
2. 平方根の分枝の整合（008 章で指摘済みの穴）が 009 章にも波及するが、本章はそれに触れていない。
3. `constant_c_value` Step 3 の `V^{-1} = c^{-1}V'^{-1}` に逆元の一意性への言及がない
   （可逆性は他のブロックにあるので埋まる）。

いずれも**結論を覆すものではない**。加えて、`sign_flip_conjugation` の `M` の偶奇による場合分けと
`joint_eigenspace_decomposition` (4) の二項定理は、証明として正しいが**不要**であることが分かった
（同じ文書の「誤りではないが冗長と分かった箇所」参照）。
