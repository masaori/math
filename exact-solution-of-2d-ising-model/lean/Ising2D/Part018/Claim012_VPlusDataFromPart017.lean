/-
# 章 016・017 の結果で `Ising2D.VPlusData` の仮定を埋める

正本: `structured-latex/content/017_even_sector_eigenvalues.ts`
（`constant_c_value_even_sector`, `eigenvalues_of_V_plus`）と
`content/015_...`（`def_gamma_theta_tilde_mu` の `γ(θ̃_μ) > 0`）。

## 経緯（一次情報）

`Ising2D.VPlusData`（`Part018/Claim003_TraceEpsilonVPlus.lean`）は

  `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`,  `Λ̌_ε = C exp(∑_μ γ_μ(ε_μ - 1/2))`,  `C > 0`,  `γ_μ > 0`

を仮定として受け取っていた。章 016・017 が main に入ったので、本ファイルはこれを
**実際に構成する**（`Ising2D.vPlusDataOf`）。使う一次情報は次の 3 つである。

| 使うもの | 何を与えるか | 出典 |
| --- | --- | --- |
| `Ising2D.VPlus_eq_smul_checkVprime_of_dual` | `∃ c ≠ 0, V^{(+)} = c V̌'`（仮定は双対関係だけ） | 016 |
| `Ising2D.constant_c_value_even_sector` | その `c` が `(2 sinh 2K_2)^{M/2}` であること | 017 |
| `Ising2D.gammaFn_thetaTilde_pos` | `γ(θ̃_μ) > 0`（無条件） | 017（章 015 の内容） |

## 噛み合わせ（本ファイルの橋渡し部分）

章 017 の `Ising2D.CheckFermiSetup` は添字型が `CheckIdx M`、章 018 の
`Ising2D.CheckFermi` は `Fin M` である。両者は `Ising2D.checkIdx`（`j ↦ j+1`）で
1 対 1 に対応するので、`Ising2D.finCheckIdxEquiv` を置き、
`X̌` が両側で同じ行列であること（`Ising2D.checkFermiSetupOf_Vprime`）を示して
章 017 の `constant_c_value_even_sector` を使えるようにする。

`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` そのものは章 017 の `Q̌_ε` を経由せず、
章 018 側の `Ising2D.CheckFermi.nOp_mul_Qproj`（`Part018/Setup.lean`）から
直接導く（章 017 の `Xop_mul_Qproj` と同じ計算）。射影の添字型を移す必要が無くなるためである。
-/
import Ising2D.Part018.Claim011_CheckFermiFromPart016
import Ising2D.Part018.Claim003_TraceEpsilonVPlus
import Ising2D.Part017.Theorem011_MaxEigenvalueSimple

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## `Fin M ≃ 𝓜̌` -/

/-- `Fin M` と章 017 の添字型 `CheckIdx M = 𝓜̌` の同一視（`j ↦ j+1`）。 -/
noncomputable def finCheckIdxEquiv (M : ℕ) : Fin M ≃ CheckIdx M :=
  Equiv.ofBijective (fun j => ⟨checkIdx M j, mem_checkIdxFinset.2 (checkIndex_checkIdx M j)⟩)
    (by
      refine (Fintype.bijective_iff_injective_and_card _).2 ⟨?_, ?_⟩
      · intro i j h
        exact checkIdx_injective M (congrArg Subtype.val h)
      · simp [CheckIdx.card])

@[simp]
theorem finCheckIdxEquiv_val (M : ℕ) (j : Fin M) :
    (finCheckIdxEquiv M j).1 = checkIdx M j := rfl

/-! ## 章 016 の `ψ̌` から章 017 の `CheckFermiSetup` を作る -/

/-- **章 016 から `Ising2D.CheckFermiSetup` を構成する**（仮定は `M ≠ 0` だけ）。 -/
noncomputable def checkFermiSetupOf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) :
    CheckFermiSetup M where
  hM := hM
  psiDag := checkPsiDag P.const M
  psi := checkPsi P.const M
  hcc _ _ hμ hν := by
    have h := (checkPsi_car' P hM hμ hν).1
    simpa [acomm] using h
  haa _ _ hμ hν := by
    have h := (checkPsi_car' P hM hμ hν).2.2
    simpa [acomm] using h
  hca _ _ hμ hν := by
    have h := (checkPsi_car' P hM hμ hν).2.1
    rw [acomm] at h
    rw [h]
    split <;> simp

/-- 章 017 の `X̌` は章 016 の `checkX`（`Part016/Definition005_CheckVprime.lean`）と同じ行列。 -/
theorem checkFermiSetupOf_Xop (P : IsingParam) (hM : M ≠ 0) :
    (checkFermiSetupOf P hM).Xop (fun i => gammaTilde P M i.1)
      = checkX P.const M (gammaTildeC P M) := by
  rw [CheckFermiSetup.Xop, checkX]
  exact (Fintype.sum_bijective (finCheckIdxEquiv M) (finCheckIdxEquiv M).bijective _ _
    (fun _ => rfl)).symm

/-- 章 017 の `V̌' = exp(X̌)` は章 016 の `checkVprime` と同じ行列。 -/
theorem checkFermiSetupOf_Vprime (P : IsingParam) (hM : M ≠ 0) :
    (checkFermiSetupOf P hM).Vprime (fun i => gammaTilde P M i.1)
      = checkVprime P.const M (gammaTildeC P M) := by
  rw [CheckFermiSetup.Vprime, checkVprime, checkFermiSetupOf_Xop]

/-! ## `V^{(+)} = (2 sinh 2K_2)^{M/2} V̌'`（章 016 ＋ 章 017） -/

theorem star_ofReal_self (r : ℝ) : star ((r : ℝ) : ℂ) = ((r : ℝ) : ℂ) := by
  rw [Complex.star_def, Complex.conj_ofReal]

/-- **章 016 の `V_plus_eq_c_check_Vprime` と章 017 の `constant_c_value_even_sector` の合成**:
`V^{(+)} = (2 sinh 2K_2)^{M/2} V̌'`（仮定は `M ≠ 0` と双対関係だけ）。 -/
theorem VPlus_eq_smul_checkVprime_const (P : IsingParam) (hM : M ≠ 0)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) :
    VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)
      = ((((2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2) : ℝ) : ℂ))
        • checkVprime P.const M (gammaTildeC P M) := by
  obtain ⟨c, _, hc⟩ := VPlus_eq_smul_checkVprime_of_dual P hM hdual
  have hVeq : VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)
      = c • (checkFermiSetupOf P hM).Vprime (fun i => gammaTilde P M i.1) := by
    rw [hc, checkFermiSetupOf_Vprime]
  have hcval := constant_c_value_even_sector (checkFermiSetupOf P hM)
    (fun i => gammaTilde P M i.1) (star_ofReal_self P.K1) (star_ofReal_self P.K2star)
    (sinh_two_K2_pos P) hVeq
  rw [hc, hcval]

/-! ## `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` -/

/-- 章 018 の `Ising2D.checkLambda` に渡す重み `γ_μ := γ(θ̃_{μ})`（`μ = j+1`）。 -/
noncomputable def checkGam (P : IsingParam) (M : ℕ) (j : Fin M) : ℝ :=
  gammaTilde P M (checkIdx M j)

theorem checkGam_pos (P : IsingParam) (hM : M ≠ 0) (j : Fin M) : 0 < checkGam P M j :=
  gammaFn_thetaTilde_pos P hM (checkIndex_checkIdx M j)

/-- `ǧ(ε) = ∑_μ γ_μ(ε_μ - 1/2)`（章 017 の `CheckFermiSetup.gval` の `Fin M` 版）。 -/
noncomputable def checkGval (P : IsingParam) (M : ℕ) (T : Finset (Fin M)) : ℝ :=
  ∑ j : Fin M, checkGam P M j * ((if j ∈ T then (1 : ℝ) else 0) - 1 / 2)

/-- **章 017 `eigenvalues_of_check_Vprime` Step 1 の `Fin M` 版**: `X̌ Q̌_ε = ǧ(ε) Q̌_ε`。 -/
theorem checkX_mul_Qproj (P : IsingParam) (hM : M ≠ 0) (T : Finset (Fin M)) :
    checkX P.const M (gammaTildeC P M) * (checkFermiOf P hM).Qproj T
      = ((checkGval P M T : ℝ) : ℂ) • (checkFermiOf P hM).Qproj T := by
  set F := checkFermiOf P hM with hF
  have hX : checkX P.const M (gammaTildeC P M)
      = ∑ j : Fin M, ((checkGam P M j : ℝ) : ℂ) • (F.nOp j - (1 / 2 : ℂ) • 1) := rfl
  rw [hX, Finset.sum_mul]
  have hterm : ∀ j : Fin M,
      ((checkGam P M j : ℝ) : ℂ) • (F.nOp j - (1 / 2 : ℂ) • 1) * F.Qproj T
        = ((checkGam P M j * ((if j ∈ T then (1 : ℝ) else 0) - 1 / 2) : ℝ) : ℂ) • F.Qproj T := by
    intro j
    simp only [sub_mul, smul_mul_assoc, one_mul]
    rw [F.nOp_mul_Qproj j T, ← sub_smul, smul_smul]
    congr 1
    by_cases hT : j ∈ T <;> simp [hT]
  rw [Finset.sum_congr rfl fun j _ => hterm j, checkGval]
  push_cast
  rw [Finset.sum_smul]

set_option backward.isDefEq.respectTransparency false in
/-- **章 017 `eigenvalues_of_check_Vprime` Step 3 の `Fin M` 版**: `V̌' Q̌_ε = e^{ǧ(ε)} Q̌_ε`。 -/
theorem checkVprime_mul_Qproj (P : IsingParam) (hM : M ≠ 0) (T : Finset (Fin M)) :
    checkVprime P.const M (gammaTildeC P M) * (checkFermiOf P hM).Qproj T
      = ((Real.exp (checkGval P M T) : ℝ) : ℂ) • (checkFermiOf P hM).Qproj T := by
  have h : NormedSpace.exp (checkX P.const M (gammaTildeC P M)) * (checkFermiOf P hM).Qproj T
      = Complex.exp ((checkGval P M T : ℝ) : ℂ) • (checkFermiOf P hM).Qproj T :=
    open scoped Norms.Operator in
      NecSuf.exp_mul_eq_of_mul_eq_smul (checkX_mul_Qproj P hM T)
  rw [checkVprime, matExp, h, Complex.ofReal_exp]

/-! ## `VPlusData` のインスタンス -/

/-- **章 016・017 から `Ising2D.VPlusData` を構成する**（仮定は `M ≠ 0` と双対関係だけ）。

`C = (2 sinh 2K_2)^{M/2}`、`γ_μ = γ(θ̃_μ)`。 -/
noncomputable def vPlusDataOf (P : IsingParam) {M : ℕ} (hM : M ≠ 0)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) :
    VPlusData M (checkFermiOf P hM) where
  V := VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)
  C := ((2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2) : ℝ)
  hC := Real.rpow_pos_of_pos (by linarith [sinh_two_K2_pos P]) _
  gam := checkGam P M
  hgam := checkGam_pos P hM
  hV T := by
    rw [VPlus_eq_smul_checkVprime_const P hM hdual, smul_mul_assoc,
      checkVprime_mul_Qproj P hM T, smul_smul]
    congr 1
    unfold checkLambda checkGval
    rw [Complex.ofReal_mul]

@[simp]
theorem vPlusDataOf_V (P : IsingParam) (hM : M ≠ 0)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) :
    (vPlusDataOf P hM hdual).V = VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ) := rfl

@[simp]
theorem vPlusDataOf_C (P : IsingParam) (hM : M ≠ 0)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) :
    (vPlusDataOf P hM hdual).C = ((2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2) : ℝ) := rfl

@[simp]
theorem vPlusDataOf_gam (P : IsingParam) (hM : M ≠ 0)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) :
    (vPlusDataOf P hM hdual).gam = checkGam P M := rfl

end Ising2D
