/-
# 定数 `c` の決定と `V` の固有値（具体版）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `constant_c_value`（`eigenvalues_of_V_017_claim_constant_c_value`）
- `eigenvalues_of_V`（`eigenvalues_of_V_018_claim_eigenvalues_of_V`）

## 他章への依存（仮定として受け取るもの）

原文 `V_eq_Vprime`（008 章）「ある `c ∈ ℂ^×` が存在して `V = c V'`」は
本リポジトリでは未形式化なので、**仮定 `hVeq : V = c • V'` として受け取る**。
本章の主張はこの `c` の値を決めるものである。

`γ(θ_μ) = arccosh(γ_1(θ_μ))` も（mathlib に `Real.arccosh` が無いため）
非負実数の族 `g` として受け取る（`Claim009_EigenvaluesVprime.lean` 冒頭参照）。

必要十分版は置かない。理由: この主張は
「`tr(V)/tr(V^{-1}) = c^2`」＋「符号反転共役で `tr` が不変」＋「`V` が正定値」という
**この模型の具体的な対象についての主張**であり、取り払える構造が無い
（使っている一般論はトレースの線型性・巡回性だけで、それは既に
`Ising2D/NecSuf/NumberOperator.lean` 側で「加法的かつ巡回的な汎関数」として
抽象化してある）。
-/
import Ising2D.Part009.Claim009_EigenvaluesVprime
import Ising2D.Part009.Claim013_PositiveDefinite
import Ising2D.Part009.Claim016_SignFlip

namespace Ising2D

open Matrix
open scoped ComplexOrder

section ConstantC

variable {M : ℕ}

/-- `exp(A) exp(-A) = I`。 -/
theorem matExp_mul_neg (A : TensorPow M) : matExp A * matExp (-A) = 1 := by
  exact (matExpUnits A).val_inv

/-- `exp(-A) exp(A) = I`。 -/
theorem matExp_neg_mul (A : TensorPow M) : matExp (-A) * matExp A = 1 := by
  exact (matExpUnits A).inv_val

/-- 原文 `V_is_positive_definite` Step 4 の `V^{-1}`。 -/
noncomputable def VmatInv (M : ℕ) (K1 η : ℂ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))⁻¹ •
    (matExp (-(((1 / 2 : ℂ) * Complex.I * K1) • H1 M η))
      * matExp (-((Complex.I * K2star) • H2 M))
      * matExp (-(((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)))

theorem Vmat_eq_smul (K1 η : ℂ) (s2 : ℝ) (K2star : ℂ) :
    Vmat M K1 η s2 K2star
      = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))
        • (V1half M K1 η * matExp ((Complex.I * K2star) • H2 M) * V1half M K1 η) := by
  rw [Vmat, V2, Matrix.mul_smul, Matrix.smul_mul]

private theorem V1half_mul_neg (K1 η : ℂ) :
    V1half M K1 η * matExp (-(((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)) = 1 :=
  matExp_mul_neg _

private theorem neg_mul_V1half (K1 η : ℂ) :
    matExp (-(((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)) * V1half M K1 η = 1 :=
  matExp_neg_mul _

theorem VmatInv_mul_Vmat (K1 η : ℂ) {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) :
    VmatInv M K1 η s2 K2star * Vmat M K1 η s2 K2star = 1 := by
  set A : ℂ := (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) with hA
  have hAne : A ≠ 0 := rpow_two_s2_ne_zero hs2 M
  set E := V1half M K1 η with hE
  set E' := matExp (-(((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)) with hE'
  set B := matExp ((Complex.I * K2star) • H2 M) with hB
  set B' := matExp (-((Complex.I * K2star) • H2 M)) with hB'
  rw [VmatInv, Vmat_eq_smul, smul_mul_smul_comm, inv_mul_cancel₀ hAne]
  have hEE : E' * E = 1 := neg_mul_V1half K1 η
  have hBB : B' * B = 1 := matExp_neg_mul _
  have key : (E' * B' * E') * (E * B * E) = 1 := by
    calc (E' * B' * E') * (E * B * E)
        = E' * B' * (E' * E) * B * E := by noncomm_ring
      _ = E' * (B' * B) * E := by rw [hEE]; noncomm_ring
      _ = E' * E := by rw [hBB]; noncomm_ring
      _ = 1 := hEE
  rw [key, one_smul]

theorem Vmat_mul_VmatInv (K1 η : ℂ) {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) :
    Vmat M K1 η s2 K2star * VmatInv M K1 η s2 K2star = 1 := by
  set A : ℂ := (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) with hA
  have hAne : A ≠ 0 := rpow_two_s2_ne_zero hs2 M
  set E := V1half M K1 η with hE
  set E' := matExp (-(((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)) with hE'
  set B := matExp ((Complex.I * K2star) • H2 M) with hB
  set B' := matExp (-((Complex.I * K2star) • H2 M)) with hB'
  rw [VmatInv, Vmat_eq_smul, smul_mul_smul_comm, mul_inv_cancel₀ hAne]
  have hEE : E * E' = 1 := V1half_mul_neg K1 η
  have hBB : B * B' = 1 := matExp_mul_neg _
  have key : (E * B * E) * (E' * B' * E') = 1 := by
    calc (E * B * E) * (E' * B' * E')
        = E * B * (E * E') * B' * E' := by noncomm_ring
      _ = E * (B * B') * E' := by rw [hEE]; noncomm_ring
      _ = E * E' := by rw [hBB]; noncomm_ring
      _ = 1 := hEE
  rw [key, one_smul]

/-- 原文 `constant_c_value` の `τ = tr(exp(S_1) exp(S_2))`。 -/
noncomputable def tauTrace (M : ℕ) (K1 η K2star : ℂ) : ℂ :=
  (matExp ((Complex.I * K1) • H1 M η) * matExp ((Complex.I * K2star) • H2 M)).trace

/-- **原文 `constant_c_value` Step 1**: `tr(V) = (2s_2)^{M/2} τ`。 -/
theorem trace_Vmat (K1 η : ℂ) (s2 : ℝ) (K2star : ℂ) :
    (Vmat M K1 η s2 K2star).trace
      = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) * tauTrace M K1 η K2star := by
  rw [Vmat_eq_smul, Matrix.trace_smul, smul_eq_mul]
  congr 1
  rw [tauTrace]
  calc (V1half M K1 η * matExp ((Complex.I * K2star) • H2 M) * V1half M K1 η).trace
      = ((V1half M K1 η * V1half M K1 η) * matExp ((Complex.I * K2star) • H2 M)).trace := by
        rw [Matrix.trace_mul_comm (V1half M K1 η * matExp ((Complex.I * K2star) • H2 M))]
        congr 1
        noncomm_ring
    _ = (matExp ((Complex.I * K1) • H1 M η) * matExp ((Complex.I * K2star) • H2 M)).trace := by
        rw [V1half_sq, V1, matExp]

/-- **原文 `constant_c_value` Step 2**: 符号反転共役より
`tr(exp(-S_1) exp(-S_2)) = τ`。 -/
theorem trace_exp_neg_eq_tau (K1 η K2star : ℂ) :
    (matExp (-((Complex.I * K1) • H1 M η)) * matExp (-((Complex.I * K2star) • H2 M))).trace
      = tauTrace M K1 η K2star := by
  rw [tauTrace]
  have hAU : Uflip M * matExp ((Complex.I * K1) • H1 M η) * UflipInv M
      = matExp (-((Complex.I * K1) • H1 M η)) := by
    rw [Uflip_conj_matExp, Uflip_conj_S1]
  have hBU : Uflip M * matExp ((Complex.I * K2star) • H2 M) * UflipInv M
      = matExp (-((Complex.I * K2star) • H2 M)) := by
    rw [Uflip_conj_matExp, Uflip_conj_S2]
  rw [← hAU, ← hBU, ← Uflip_conj_mul]
  exact trace_conj _ _ _ UflipInv_mul

/-- **原文 `constant_c_value` Step 1（後半）**: `tr(V^{-1}) = (2s_2)^{-M/2} τ`。 -/
theorem trace_VmatInv (K1 η : ℂ) (s2 : ℝ) (K2star : ℂ) :
    (VmatInv M K1 η s2 K2star).trace
      = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))⁻¹ * tauTrace M K1 η K2star := by
  rw [VmatInv, Matrix.trace_smul, smul_eq_mul]
  congr 1
  set E := matExp (-(((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)) with hE
  set B := matExp (-((Complex.I * K2star) • H2 M)) with hB
  have hEE : E * E = matExp (-((Complex.I * K1) • H1 M η)) := by
    rw [hE, matExp, matExp, ← Matrix.exp_add_of_commute _ _ (Commute.refl _)]
    congr 1
    rw [← neg_add, ← add_smul]
    congr 2
    ring
  calc (E * B * E).trace
      = ((E * E) * B).trace := by
        rw [Matrix.trace_mul_comm (E * B)]
        congr 1
        noncomm_ring
    _ = tauTrace M K1 η K2star := by rw [hEE, trace_exp_neg_eq_tau]

/-! ## 定数 `c` の決定 -/

/-- **原文 `constant_c_value`**: `V = c V'` の `c` は `(2 sinh 2K_2)^{M/2}`。 -/
theorem constant_c_value {K : IsingConst} (F : FermiSetup M K) (g : F.Idx → ℝ)
    {K1 η K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hη : star η = η) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : Vmat M K1 η s2 K2star = c • F.Vprime g) :
    c = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) := by
  classical
  set a : ℝ := ((2 * s2) ^ ((M : ℝ) / 2) : ℝ) with ha
  have hapos : 0 < a := Real.rpow_pos_of_pos (by linarith) _
  have hane : ((a : ℝ) : ℂ) ≠ 0 := by
    simpa using ((RCLike.ofReal_pos (K := ℂ)).2 hapos).ne'
  obtain ⟨p, hppos, hP⟩ := F.trace_Vprime_pos g
  have hPne : ((p : ℝ) : ℂ) ≠ 0 := by
    simpa using ((RCLike.ofReal_pos (K := ℂ)).2 hppos).ne'
  have hVpos : 0 < (Vmat M K1 η s2 K2star).trace := trace_Vmat_pos hK1 hη hK2 hs2
  have hcne : c ≠ 0 := by
    intro h0
    rw [h0, zero_smul] at hVeq
    rw [hVeq, Matrix.trace_zero] at hVpos
    exact lt_irrefl 0 hVpos
  -- Step 1
  have h1 : (Vmat M K1 η s2 K2star).trace = c * ((p : ℝ) : ℂ) := by
    rw [hVeq, Matrix.trace_smul, smul_eq_mul, hP]
  -- `V^{-1} = c⁻¹ V'^{-1}`（逆元の一意性）
  have hinvEq : VmatInv M K1 η s2 K2star = c⁻¹ • F.Vprime (fun i => -(g i)) := by
    have hleft := VmatInv_mul_Vmat (M := M) K1 η hs2 K2star
    have hright : Vmat M K1 η s2 K2star * (c⁻¹ • F.Vprime (fun i => -(g i))) = 1 := by
      rw [hVeq, smul_mul_smul_comm, F.Vprime_mul_Vprime_neg, mul_inv_cancel₀ hcne, one_smul]
    calc VmatInv M K1 η s2 K2star
        = VmatInv M K1 η s2 K2star
            * (Vmat M K1 η s2 K2star * (c⁻¹ • F.Vprime (fun i => -(g i)))) := by
          rw [hright, mul_one]
      _ = (VmatInv M K1 η s2 K2star * Vmat M K1 η s2 K2star)
            * (c⁻¹ • F.Vprime (fun i => -(g i))) := by noncomm_ring
      _ = c⁻¹ • F.Vprime (fun i => -(g i)) := by rw [hleft, one_mul]
  have h2 : (VmatInv M K1 η s2 K2star).trace = c⁻¹ * ((p : ℝ) : ℂ) := by
    rw [hinvEq, Matrix.trace_smul, smul_eq_mul, F.trace_Vprime_inv g, hP]
  have h3 : (Vmat M K1 η s2 K2star).trace = ((a : ℝ) : ℂ) * tauTrace M K1 η K2star :=
    trace_Vmat K1 η s2 K2star
  have h4 : (VmatInv M K1 η s2 K2star).trace
      = (((a : ℝ) : ℂ))⁻¹ * tauTrace M K1 η K2star := trace_VmatInv K1 η s2 K2star
  have hcp : c * ((p : ℝ) : ℂ) = ((a : ℝ) : ℂ) * tauTrace M K1 η K2star := h1.symm.trans h3
  have hcp' : c⁻¹ * ((p : ℝ) : ℂ) = (((a : ℝ) : ℂ))⁻¹ * tauTrace M K1 η K2star :=
    h2.symm.trans h4
  -- Step 3: `c^2 = a^2`
  have hq : ((a : ℝ) : ℂ) * ((p : ℝ) : ℂ) = c * tauTrace M K1 η K2star := by
    have h : c * ((a : ℝ) : ℂ) * (c⁻¹ * ((p : ℝ) : ℂ))
        = c * ((a : ℝ) : ℂ) * ((((a : ℝ) : ℂ))⁻¹ * tauTrace M K1 η K2star) := by rw [hcp']
    rw [show c * ((a : ℝ) : ℂ) * (c⁻¹ * ((p : ℝ) : ℂ))
          = (c * c⁻¹) * (((a : ℝ) : ℂ) * ((p : ℝ) : ℂ)) from by ring,
      show c * ((a : ℝ) : ℂ) * ((((a : ℝ) : ℂ))⁻¹ * tauTrace M K1 η K2star)
          = (((a : ℝ) : ℂ) * (((a : ℝ) : ℂ))⁻¹) * (c * tauTrace M K1 η K2star) from by ring,
      mul_inv_cancel₀ hcne, mul_inv_cancel₀ hane, one_mul, one_mul] at h
    exact h
  have hsq0 : c ^ 2 * ((p : ℝ) : ℂ) = (((a : ℝ) : ℂ)) ^ 2 * ((p : ℝ) : ℂ) := by
    calc c ^ 2 * ((p : ℝ) : ℂ) = c * (c * ((p : ℝ) : ℂ)) := by ring
      _ = c * (((a : ℝ) : ℂ) * tauTrace M K1 η K2star) := by rw [hcp]
      _ = ((a : ℝ) : ℂ) * (c * tauTrace M K1 η K2star) := by ring
      _ = ((a : ℝ) : ℂ) * (((a : ℝ) : ℂ) * ((p : ℝ) : ℂ)) := by rw [← hq]
      _ = (((a : ℝ) : ℂ)) ^ 2 * ((p : ℝ) : ℂ) := by ring
  have hsq : c ^ 2 = (((a : ℝ) : ℂ)) ^ 2 := mul_right_cancel₀ hPne hsq0
  -- Step 4: 符号の確定
  have hfac : (c - ((a : ℝ) : ℂ)) * (c + ((a : ℝ) : ℂ)) = 0 := by linear_combination hsq
  rcases mul_eq_zero.1 hfac with h | h
  · exact sub_eq_zero.1 h
  · exfalso
    have hc : c = -((a : ℝ) : ℂ) := by linear_combination h
    rw [hc] at h1
    rw [h1] at hVpos
    have hlt : (0 : ℂ) < (((-(a * p) : ℝ)) : ℂ) := by
      push_cast
      convert hVpos using 1
      ring
    have hneg : (0 : ℝ) < -(a * p) := (RCLike.ofReal_pos (K := ℂ)).1 hlt
    nlinarith [mul_pos hapos hppos]

end ConstantC

/-! ## `V` の固有値（原文 `eigenvalues_of_V`） -/

section EigenV

variable {M : ℕ} {K : IsingConst}

/-- **原文 `eigenvalues_of_V` の `Λ_ε`**:
`Λ_ε = (2 sinh 2K_2)^{M/2} exp(∑_μ γ(θ_μ)(ε_μ - 1/2))`。 -/
noncomputable def bigLambda (F : FermiSetup M K) (g : F.Idx → ℝ) (s2 : ℝ)
    (T : Finset F.Idx) : ℝ :=
  ((2 * s2) ^ ((M : ℝ) / 2) : ℝ) * Real.exp (F.gval g T)

/-- **原文 `eigenvalues_of_V` (1)**: `V Q_ε = Λ_ε Q_ε`。 -/
theorem Vmat_mul_Qproj (F : FermiSetup M K) (g : F.Idx → ℝ)
    {K1 η K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hη : star η = η) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : Vmat M K1 η s2 K2star = c • F.Vprime g) (T : Finset F.Idx) :
    Vmat M K1 η s2 K2star * F.Qproj T
      = ((bigLambda F g s2 T : ℝ) : ℂ) • F.Qproj T := by
  have hc := constant_c_value F g hK1 hη hK2 hs2 hVeq
  rw [hVeq, hc, smul_mul_assoc, F.Vprime_mul_Qproj g T, smul_smul, bigLambda]
  norm_cast

/-- **原文 `eigenvalues_of_V` (2)**: 固有値はすべて正の実数。 -/
theorem bigLambda_pos (F : FermiSetup M K) (g : F.Idx → ℝ) {s2 : ℝ} (hs2 : 0 < s2)
    (T : Finset F.Idx) : 0 < bigLambda F g s2 T := by
  rw [bigLambda]
  exact mul_pos (Real.rpow_pos_of_pos (by linarith) _) (Real.exp_pos _)

/-- **原文 `eigenvalues_of_V` (2)**: 最大固有値は全ての `ε_μ = 1` のとき。 -/
theorem bigLambda_le_max (F : FermiSetup M K) (g : F.Idx → ℝ) (hg : ∀ i, 0 ≤ g i)
    {s2 : ℝ} (hs2 : 0 < s2) (T : Finset F.Idx) :
    bigLambda F g s2 T ≤ bigLambda F g s2 Finset.univ := by
  rw [bigLambda, bigLambda]
  refine mul_le_mul_of_nonneg_left ?_ (le_of_lt (Real.rpow_pos_of_pos (by linarith) _))
  refine Real.exp_le_exp.2 ?_
  rw [FermiSetup.gval, FermiSetup.gval]
  refine Finset.sum_le_sum fun i _ => ?_
  have h1 : (if i ∈ T then (1 : ℝ) else 0)
      ≤ (if i ∈ (Finset.univ : Finset F.Idx) then (1 : ℝ) else 0) := by
    simp only [Finset.mem_univ, if_true]
    split <;> norm_num
  nlinarith [hg i]

/-- **原文 `eigenvalues_of_V` (2)**: 最小固有値は全ての `ε_μ = 0` のとき。 -/
theorem bigLambda_min_le (F : FermiSetup M K) (g : F.Idx → ℝ) (hg : ∀ i, 0 ≤ g i)
    {s2 : ℝ} (hs2 : 0 < s2) (T : Finset F.Idx) :
    bigLambda F g s2 (∅ : Finset F.Idx) ≤ bigLambda F g s2 T := by
  rw [bigLambda, bigLambda]
  refine mul_le_mul_of_nonneg_left ?_ (le_of_lt (Real.rpow_pos_of_pos (by linarith) _))
  refine Real.exp_le_exp.2 ?_
  rw [FermiSetup.gval, FermiSetup.gval]
  refine Finset.sum_le_sum fun i _ => ?_
  have h1 : (if i ∈ (∅ : Finset F.Idx) then (1 : ℝ) else 0) ≤ (if i ∈ T then (1 : ℝ) else 0) := by
    simp only [Finset.notMem_empty, if_false]
    split <;> norm_num
  nlinarith [hg i]

/-- **原文 `eigenvalues_of_V`**: `Λ_max Λ_min = (2 sinh 2K_2)^M = c^2`。 -/
theorem bigLambda_max_mul_min (F : FermiSetup M K) (g : F.Idx → ℝ) {s2 : ℝ} (hs2 : 0 < s2) :
    bigLambda F g s2 Finset.univ * bigLambda F g s2 (∅ : Finset F.Idx)
      = ((2 * s2) ^ ((M : ℝ)) : ℝ) := by
  have hsum : F.gval g Finset.univ + F.gval g (∅ : Finset F.Idx) = 0 := by
    rw [FermiSetup.gval, FermiSetup.gval, ← Finset.sum_add_distrib]
    refine Finset.sum_eq_zero fun i _ => ?_
    simp
    ring
  rw [bigLambda, bigLambda]
  calc ((2 * s2) ^ ((M : ℝ) / 2) : ℝ) * Real.exp (F.gval g Finset.univ)
        * (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) * Real.exp (F.gval g (∅ : Finset F.Idx)))
      = (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) * ((2 * s2) ^ ((M : ℝ) / 2) : ℝ))
          * Real.exp (F.gval g Finset.univ + F.gval g (∅ : Finset F.Idx)) := by
        rw [Real.exp_add]; ring
    _ = ((2 * s2) ^ ((M : ℝ)) : ℝ) := by
        rw [hsum, Real.exp_zero, mul_one, ← Real.rpow_add (by linarith)]
        congr 1
        ring

end EigenV

end Ising2D
