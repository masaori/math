/-
# 章 016 の `ψ̌` で `Ising2D.CheckFermi` の仮定を埋める

正本: `structured-latex/content/018_even_sector_closing.ts`（`check_number_operator_is_hermitian` (3)）
および `content/016_even_sector_fermions.ts`（`def_check_fermi`, `anticommutator_of_check_psi`）。

## 経緯（一次情報）

章 018 の形式化に着手した時点で `Ising2D/Part016/` は存在せず、`Ising2D.CheckFermi`
（`Part018/Setup.lean`）は `ψ̌_μ^†, ψ̌_μ` の正準反交換関係と `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}` を
**仮定として**受け取っていた（`lean/docs/ch018-formalization.md` の 0 章の表）。

その後 `Ising2D/Part016/` が main に入り、`Ising2D.checkPsi_car'`
（`Part016/Claim010_UnconditionalViaPart015.lean`）が CAR を**無条件に**（仮定は `M ≠ 0` だけ）
与えるようになった。本ファイルはそれを使って `CheckFermi` の
**インスタンスを実際に構成する**（`Ising2D.checkFermiOf`）。

`hstar`（`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`）だけは章 016 側に対応する定理が無かったので、
章 018 で無条件に証明済みの `Ising2D.checkZ_conjTranspose` / `checkY_conjTranspose`
（`Part018/Claim008_CheckQHermitian.lean`）と章 008 の `Ising2D.gamma2_neg_eq_neg_conj` から
本ファイルで証明する（`checkPsiDag_conjTranspose`）。これが**噛み合わせのための橋渡し補題**である。
-/
import Ising2D.Part018.Claim008_CheckQHermitian
import Ising2D.Part016.Claim010_UnconditionalViaPart015

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 係数の複素共役 -/

/-- `q = 1/(2√M)` は実数なので共役で不変。 -/
theorem star_checkQ (M : ℕ) : star (checkQ M) = checkQ M := by
  have h : checkQ M = ((1 / (2 * Real.sqrt M) : ℝ) : ℂ) := by
    rw [checkQ, sqrtM]; push_cast; ring
  rw [h, Complex.star_def, Complex.conj_ofReal]

theorem star_two_mul_sqrtM (M : ℕ) : (starRingEnd ℂ) (2 * sqrtM M) = 2 * sqrtM M := by
  have h : (2 : ℂ) * sqrtM M = ((2 * Real.sqrt M : ℝ) : ℂ) := by
    rw [sqrtM]; push_cast; ring
  rw [h, Complex.conj_ofReal]

/-- **原文 `check_number_operator_is_hermitian` (3) の係数版**: `conj(p_μ) = -p_{M+1-μ}`。

`γ_2(-θ) = -conj(γ_2(θ))`（`gamma2_neg_eq_neg_conj`）と `r_{M+1-μ} = r_μ`（`checkR_conj`）、
`γ_2(-θ̃_{M+1-μ}) = γ_2(θ̃_μ)`（`gamma2_neg_thetaTilde_conj`）だけから出る。 -/
theorem star_checkP (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    star (checkP K M μ) = -checkP K M ((M : ℤ) + 1 - μ) := by
  have hconj : (starRingEnd ℂ) (gamma2 K (-thetaTilde M μ)) = -gamma2 K (thetaTilde M μ) := by
    rw [gamma2_neg_eq_neg_conj, map_neg, Complex.conj_conj]
  have hden : (starRingEnd ℂ) (2 * sqrtM M * gamma2 K (-thetaTilde M μ))
      = -(2 * sqrtM M * gamma2 K (thetaTilde M μ)) := by
    rw [map_mul, star_two_mul_sqrtM, hconj, mul_neg]
  rw [checkP, checkP, checkR_conj K hM μ, gamma2_neg_thetaTilde_conj K hM μ, Complex.star_def,
    map_div₀, map_neg, Complex.conj_ofReal, hden, div_neg]

/-! ## `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}` -/

/-- **原文 `check_number_operator_is_hermitian` (3)**: `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`。

`Ising2D.CheckFermi` の場 `hstar` を埋める補題である。 -/
theorem checkPsiDag_conjTranspose (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    (checkPsiDag K M μ)ᴴ = checkPsi K M ((M : ℤ) + 1 - μ) := by
  rw [checkPsiDag, checkPsi, Matrix.conjTranspose_add, Matrix.conjTranspose_smul,
    Matrix.conjTranspose_smul, checkZ_conjTranspose hM, checkY_conjTranspose hM,
    star_checkP K hM μ, star_checkQ M]

/-! ## `CheckFermi` のインスタンス -/

/-- **章 016 から `Ising2D.CheckFermi` を構成する**（仮定は `M ≠ 0` だけ）。

`cre j` は `ψ̌_{j+1}^†`、`ann j` は `ψ̌_{M+1-(j+1)}` である
（`Part018/Setup.lean` の `CheckFermi` の添字づけと同じ）。 -/
noncomputable def checkFermiOf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) : CheckFermi M where
  cre j := checkPsiDag P.const M (checkIdx M j)
  ann j := checkPsi P.const M ((M : ℤ) + 1 - checkIdx M j)
  hcre j := ⟨checkIdx M j, checkP P.const M (checkIdx M j), checkQ M, rfl⟩
  hann j := ⟨(M : ℤ) + 1 - checkIdx M j, -checkP P.const M ((M : ℤ) + 1 - checkIdx M j),
    checkQ M, rfl⟩
  acomm_cre_cre i j := by
    have h := (checkPsi_car' P hM (checkIndex_checkIdx M i) (checkIndex_checkIdx M j)).1
    simpa [acomm] using h
  acomm_ann_ann i j := by
    have hi : CheckIndex M ((M : ℤ) + 1 - checkIdx M i) := by
      rw [checkIdx_rev]; exact checkIndex_checkIdx M (Fin.rev i)
    have hj : CheckIndex M ((M : ℤ) + 1 - checkIdx M j) := by
      rw [checkIdx_rev]; exact checkIndex_checkIdx M (Fin.rev j)
    have h := (checkPsi_car' P hM hi hj).2.2
    simpa [acomm] using h
  acomm_cre_ann i j := by
    have hj : CheckIndex M ((M : ℤ) + 1 - checkIdx M j) := by
      rw [checkIdx_rev]; exact checkIndex_checkIdx M (Fin.rev j)
    have h := (checkPsi_car' P hM (checkIndex_checkIdx M i) hj).2.1
    rw [acomm] at h
    rw [h]
    by_cases hij : i = j
    · subst hij
      rw [if_pos rfl, if_pos rfl, one_smul]
    · have hne : ¬((M : ℤ) + 1 - checkIdx M j = (M : ℤ) + 1 - checkIdx M i) := by
        intro hc
        exact hij (checkIdx_injective M (by omega)).symm
      rw [if_neg hne, if_neg hij, zero_smul]
  hstar j := checkPsiDag_conjTranspose P.const hM (checkIdx M j)

@[simp]
theorem checkFermiOf_cre (P : IsingParam) (hM : M ≠ 0) (j : Fin M) :
    (checkFermiOf P hM).cre j = checkPsiDag P.const M (checkIdx M j) := rfl

@[simp]
theorem checkFermiOf_ann (P : IsingParam) (hM : M ≠ 0) (j : Fin M) :
    (checkFermiOf P hM).ann j = checkPsi P.const M ((M : ℤ) + 1 - checkIdx M j) := rfl

/-- `ň_μ = ψ̌_μ^† ψ̌_{M+1-μ}`（章 016 の `checkX` の被加数と同じ形）。 -/
theorem checkFermiOf_nOp (P : IsingParam) (hM : M ≠ 0) (j : Fin M) :
    (checkFermiOf P hM).nOp j
      = checkPsiDag P.const M (checkIdx M j) * checkPsi P.const M ((M : ℤ) + 1 - checkIdx M j) :=
  rfl

end Ising2D
