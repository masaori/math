/-
# `ε` は `V_1, V_2, V_1^{(±)}, (V_1^{(±)})^{1/2}` と可換

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_010_claim_epsilon_commutes`（ラベル **`epsilon_commutes_with_transfer_matrices`**）

## 原文の Step との対応

* Step 1（`ε σ^x_k = σ^x_k ε`, `ε σ^z_k = -σ^z_k ε`, `ε σ^y_k = -σ^y_k ε`）
  → `epsilon_commute_sigmaX` / `epsilon_anticomm_sigmaZ` / `epsilon_anticomm_sigmaY`。
  「1 サイトだけ反可換ならテンソル積は反交換」は既存の
  `Ising2D.siteProd_anticomm_of_single_site`（`Part006/Claim000_AnticommutatorZY.lean`）。
* Step 2, 3（`V_2`, `V_1` との可換性）→ 右辺の式についての `epsilon_commute_V2PauliForm` /
  `epsilon_commute_V1PauliForm` と、人手の `V_2`, `V_1`（`def_transfer_matrix`）についての
  `epsilon_commute_V2` / `epsilon_commute_V1`。人手の鎖の第 1 行・最終行で
  `second_transfer_matrix_pauli_form` / `first_transfer_matrix_pauli_form` を引く段が、
  後者の証明の書き換えにあたる。人手は「可換なら冪とも可換 → 部分和とも可換 → 極限との交換」と
  3 段で書いているが、Lean ではこれが `Commute.exp_right`（mathlib）1 本にあたる。
  `epsilon_commute_V2H2Form` は `V2H2Form`（`V2_exponential_representation` の右辺の式）についての版。
* Step 4（`V_1^{(±)}` と `(V_1^{(±)})^{1/2}`）→ `epsilon_commute_H1` から
  `epsilon_commute_V1pm` / `epsilon_commute_V1pmHalf`。
* Step 5（`P^{(±)}`）→ `epsProj_commute_of_commute_epsilon`
  （必要十分版 `Ising2D.NecSuf.commute_invProj` の系）。

必要十分版は Step 5 の部分だけ（`Ising2D/NecSuf/Projector.lean`）。Step 1〜4 は
`ε` と Pauli 行列の具体的な反交換関係の計算であり、取り払える構造が無い。
-/
import Ising2D.Part010.Claim009_EpsilonProjectors
import Ising2D.Part004.ClaimFirstTransferMatrixPauliForm
import Ising2D.Part004.ClaimSecondTransferMatrixPauliForm
import Ising2D.Part006.Claim000_AnticommutatorZY

namespace Ising2D

open NormedSpace

variable {M : ℕ}

/-! ## Step 1: サイト演算子との関係 -/

/-- `ε = σ^x_1 ⋯ σ^x_M` は全サイトに `σ^x` を置いたクロネッカー積である。 -/
theorem epsilon_eq_siteProd (M : ℕ) :
    epsilon M = siteProd M (fun _ => pauliX) := by
  exact epsilon_eq_siteProd_pauliX_by_induction

/-- ただ 1 サイトで反可換なら `ε` と反交換する、の形にした補助補題。 -/
theorem epsilon_anticomm_of_single_site (y : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (j : Fin M)
    (hj : y j * pauliX = -(pauliX * y j))
    (hcomm : ∀ i, i ≠ j → y i * pauliX = pauliX * y i) :
    epsilon M * siteProd M y = -(siteProd M y * epsilon M) := by
  have h := siteProd_anticomm_of_single_site (fun _ => pauliX) y j hj hcomm
  rw [epsilon_eq_siteProd]
  linear_combination (norm := module) h

/-- 原文 Step 1 の `ε σ^x_k = σ^x_k ε`。 -/
theorem epsilon_commute_sigmaX (k : Fin M) : Commute (epsilon M) (sigmaX k) := by
  rw [epsilon_eq_siteProd, sigmaX, siteOp_apply, Commute, SemiconjBy,
    ← siteProd_mul, ← siteProd_mul]
  congr 1
  funext i
  by_cases h : i = k
  · subst h; simp [Pi.mul_apply]
  · simp [Pi.mul_apply, h]

/-- 原文 Step 1 の `ε σ^z_k = -σ^z_k ε`。 -/
theorem epsilon_anticomm_sigmaZ (k : Fin M) :
    epsilon M * sigmaZ k = -(sigmaZ k * epsilon M) := by
  rw [sigmaZ, siteOp_apply]
  refine epsilon_anticomm_of_single_site _ k ?_ ?_
  · simp only [Function.update_self]
    exact pauliZ_mul_pauliX
  · intro i hi
    simp [Function.update_of_ne hi]

/-- 原文 Step 1 の `ε σ^y_k = -σ^y_k ε`。 -/
theorem epsilon_anticomm_sigmaY (k : Fin M) :
    epsilon M * sigmaY k = -(sigmaY k * epsilon M) := by
  rw [sigmaY, siteOp_apply]
  refine epsilon_anticomm_of_single_site _ k ?_ ?_
  · simp only [Function.update_self]
    exact pauliY_mul_pauliX
  · intro i hi
    simp [Function.update_of_ne hi]

/-- 原文 Step 4 の `ε Z_m = -Z_m ε`。 -/
theorem epsilon_anticomm_Z (m : Fin M) : epsilon M * Z m = -(Z m * epsilon M) := by
  rw [Z]
  refine epsilon_anticomm_of_single_site _ m ?_ ?_
  · rw [jwFamily_self, pauliZ_mul_pauliX]
  · intro i hi
    rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
    · rw [jwFamily_of_lt h]
    · exact absurd (Fin.val_injective h) hi
    · rw [jwFamily_of_gt h, one_mul, mul_one]

/-- 原文 Step 4 の `ε Y_m = -Y_m ε`。 -/
theorem epsilon_anticomm_Y (m : Fin M) : epsilon M * Y m = -(Y m * epsilon M) := by
  rw [Y]
  refine epsilon_anticomm_of_single_site _ m ?_ ?_
  · rw [jwFamily_self, pauliY_mul_pauliX]
  · intro i hi
    rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
    · rw [jwFamily_of_lt h]
    · exact absurd (Fin.val_injective h) hi
    · rw [jwFamily_of_gt h, one_mul, mul_one]

/-- 反交換する 2 つを掛けると可換になる（符号が 2 回反転する）。 -/
theorem commute_of_two_anticomm {a b c : TensorPow M}
    (hb : a * b = -(b * a)) (hc : a * c = -(c * a)) : Commute a (b * c) := by
  show a * (b * c) = (b * c) * a
  rw [← mul_assoc, hb, neg_mul, mul_assoc, hc, mul_neg, neg_neg, mul_assoc]

/-! ## Step 2, 3: `V_1`, `V_2` との可換性 -/

/-- `ε` は `∑_m σ^z_m σ^z_{m+1}` と可換（`σ^z` が 2 個なので符号が戻る）。 -/
theorem epsilon_commute_sum_sigmaZ_sigmaZ (M : ℕ) :
    Commute (epsilon M) (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) :=
  Commute.sum_right _ _ _ fun m _ =>
    commute_of_two_anticomm (epsilon_anticomm_sigmaZ m) (epsilon_anticomm_sigmaZ (nextSite m))

/-- `ε` は `∑_m σ^x_m` と可換。 -/
theorem epsilon_commute_sum_sigmaX (M : ℕ) :
    Commute (epsilon M) (∑ m : Fin M, sigmaX m) :=
  Commute.sum_right _ _ _ fun m _ => epsilon_commute_sigmaX m

/-- 人手 Step 3 の `ε exp(K_1 D) = exp(K_1 D) ε`（右辺の式 `V1PauliForm` について）。 -/
theorem epsilon_commute_V1PauliForm (K1 : ℂ) : Commute (epsilon M) (V1PauliForm M K1) := by
  rw [V1PauliForm, matExp]
  exact ((epsilon_commute_sum_sigmaZ_sigmaZ M).smul_right K1).exp_right

/-- 人手 Step 2 の `ε (2s_2)^{M/2}exp(R) = (2s_2)^{M/2}exp(R) ε`（右辺の式 `V2PauliForm` について）。 -/
theorem epsilon_commute_V2PauliForm (s2 : ℝ) (K2star : ℂ) :
    Commute (epsilon M) (V2PauliForm M s2 K2star) := by
  rw [V2PauliForm]
  exact (((epsilon_commute_sum_sigmaX M).smul_right K2star).exp_right).smul_right _

/-- 同上を `V2H2Form`（`V2_exponential_representation` の右辺の式）について述べた版。 -/
theorem epsilon_commute_V2H2Form (s2 : ℝ) (K2star : ℂ) :
    Commute (epsilon M) (V2H2Form M s2 K2star) := by
  rw [← V2PauliForm_eq_V2H2Form]
  exact epsilon_commute_V2PauliForm s2 K2star

/-- **人手 Step 3: `ε V_1 = V_1 ε`**（`V_1` は `def_transfer_matrix` の `V_1`）。 -/
theorem epsilon_commute_V1 (K1 : ℝ) : Commute (epsilon M) (V1 M K1) := by
  rw [first_transfer_matrix_pauli_form]
  exact epsilon_commute_V1PauliForm _

/-- **人手 Step 2: `ε V_2 = V_2 ε`**（`V_2` は `def_transfer_matrix` の `V_2`、`K_2 > 0`）。 -/
theorem epsilon_commute_V2 {K2 : ℝ} (hK2 : 0 < K2) : Commute (epsilon M) (V2 M K2) := by
  rw [second_transfer_matrix_pauli_form hK2]
  exact epsilon_commute_V2PauliForm _ _

/-! ## Step 4: `V_1^{(±)}` と `(V_1^{(±)})^{1/2}` -/

/-- **原文 Step 4: `ε H_1^{(±)} = H_1^{(±)} ε`**（各項が `Y·Z` の形）。 -/
theorem epsilon_commute_H1 (η : ℂ) : Commute (epsilon M) (H1 M η) := by
  rw [H1]
  refine Commute.sum_right _ _ _ fun m _ => ?_
  exact (commute_of_two_anticomm (epsilon_anticomm_Y m)
    (epsilon_anticomm_Z (nextSite m))).smul_right _

/-- **原文 Step 4: `ε V_1^{(±)} = V_1^{(±)} ε`**。 -/
theorem epsilon_commute_V1pm (K1 η : ℂ) : Commute (epsilon M) (V1pm M K1 η) := by
  rw [V1pm, matExp]
  exact ((epsilon_commute_H1 η).smul_right _).exp_right

/-- **原文 Step 4: `ε (V_1^{(±)})^{1/2} = (V_1^{(±)})^{1/2} ε`**。 -/
theorem epsilon_commute_V1pmHalf (K1 η : ℂ) : Commute (epsilon M) (V1pmHalf M K1 η) := by
  rw [V1pmHalf, matExp]
  exact ((epsilon_commute_H1 η).smul_right _).exp_right

/-! ## Step 5: 射影子との可換性 -/

/-- **原文 Step 5**: `ε` と可換な行列は `P^{(±)}` とも可換
（必要十分版 `Ising2D.NecSuf.commute_invProj` の系）。 -/
theorem commute_epsProj_of_commute_epsilon {a : TensorPow M} (η : ℂ)
    (h : Commute a (epsilon M)) : Commute a (epsProj M η) := by
  rw [epsProj_eq_invProj]
  exact NecSuf.commute_invProj (h.smul_right η)

theorem commute_V1PauliForm_epsProj (K1 η : ℂ) : Commute (V1PauliForm M K1) (epsProj M η) :=
  commute_epsProj_of_commute_epsilon η (epsilon_commute_V1PauliForm K1).symm

theorem commute_V2PauliForm_epsProj (s2 : ℝ) (K2star η : ℂ) :
    Commute (V2PauliForm M s2 K2star) (epsProj M η) :=
  commute_epsProj_of_commute_epsilon η (epsilon_commute_V2PauliForm s2 K2star).symm

theorem commute_V2H2Form_epsProj (s2 : ℝ) (K2star η : ℂ) :
    Commute (V2H2Form M s2 K2star) (epsProj M η) :=
  commute_epsProj_of_commute_epsilon η (epsilon_commute_V2H2Form s2 K2star).symm

/-- 人手 `epsilon_projectors_commute_with_transfer_matrices` の `V_1 P^{(±)} = P^{(±)} V_1`。 -/
theorem commute_V1_epsProj (K1 : ℝ) (η : ℂ) : Commute (V1 M K1) (epsProj M η) :=
  commute_epsProj_of_commute_epsilon η (epsilon_commute_V1 K1).symm

/-- 人手 `epsilon_projectors_commute_with_transfer_matrices` の `V_2 P^{(±)} = P^{(±)} V_2`。 -/
theorem commute_V2_epsProj {K2 : ℝ} (hK2 : 0 < K2) (η : ℂ) : Commute (V2 M K2) (epsProj M η) :=
  commute_epsProj_of_commute_epsilon η (epsilon_commute_V2 hK2).symm

theorem commute_V1pm_epsProj (K1 ηsign η : ℂ) : Commute (V1pm M K1 ηsign) (epsProj M η) :=
  commute_epsProj_of_commute_epsilon η (epsilon_commute_V1pm K1 ηsign).symm

theorem commute_V1pmHalf_epsProj (K1 ηsign η : ℂ) : Commute (V1pmHalf M K1 ηsign) (epsProj M η) :=
  commute_epsProj_of_commute_epsilon η (epsilon_commute_V1pmHalf K1 ηsign).symm

end Ising2D
