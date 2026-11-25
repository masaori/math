import Ising2DLambda.KacWard.ModeSmallMatrixSignedSumAlgebra
import Ising2DLambda.KacWard.ModeSmallMatrixFourCycles
import Ising2DLambda.KacWard.ModeSmallMatrixForbiddenTerm
import Ising2DLambda.KacWard.ModeSmallMatrixRemainingTerms
import Ising2DLambda.KacWard.AdmissibleDirectionPermutationSigns

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

set_option maxRecDepth 4000

/-- 四桁表示 `abcd` の方向番号の写像（行 0, 1, 2, 3 の列番号を順に並べたもの）。 -/
private def fourDigitMap (a b c d : ZMod 4) : ZMod 4 → ZMod 4 :=
  fun i => if i = 0 then a else if i = 1 then b else if i = 2 then c else d

/-- 四桁表示 `abcd` の置換。逆写像の四桁表示 `a'b'c'd'` を添えて作る。 -/
private def fourDigitPerm (a b c d a' b' c' d' : ZMod 4)
    (hl : Function.LeftInverse (fourDigitMap a' b' c' d') (fourDigitMap a b c d))
    (hr : Function.RightInverse (fourDigitMap a' b' c' d') (fourDigitMap a b c d)) :
    Equiv.Perm (ZMod 4) :=
  ⟨fourDigitMap a b c d, fourDigitMap a' b' c' d', hl, hr⟩

private def perm0123 : Equiv.Perm (ZMod 4) :=
  fourDigitPerm 0 1 2 3 0 1 2 3 (by decide) (by decide)
private def perm0132 : Equiv.Perm (ZMod 4) :=
  fourDigitPerm 0 1 3 2 0 1 3 2 (by decide) (by decide)
private def perm0213 : Equiv.Perm (ZMod 4) :=
  fourDigitPerm 0 2 1 3 0 2 1 3 (by decide) (by decide)
private def perm1023 : Equiv.Perm (ZMod 4) :=
  fourDigitPerm 1 0 2 3 1 0 2 3 (by decide) (by decide)
private def perm1032 : Equiv.Perm (ZMod 4) :=
  fourDigitPerm 1 0 3 2 1 0 3 2 (by decide) (by decide)
private def perm1230 : Equiv.Perm (ZMod 4) :=
  fourDigitPerm 1 2 3 0 3 0 1 2 (by decide) (by decide)
private def perm3012 : Equiv.Perm (ZMod 4) :=
  fourDigitPerm 3 0 1 2 1 2 3 0 (by decide) (by decide)
private def perm3120 : Equiv.Perm (ZMod 4) :=
  fourDigitPerm 3 1 2 0 3 1 2 0 (by decide) (by decide)
private def perm3210 : Equiv.Perm (ZMod 4) :=
  fourDigitPerm 3 2 1 0 3 2 1 0 (by decide) (by decide)

/-- 方向番号の置換は四つの値で決まる。 -/
private theorem perm_eq_iff_four_values (σ : Equiv.Perm (ZMod 4))
    (a b c d a' b' c' d' : ZMod 4) (hl hr) :
    σ = fourDigitPerm a b c d a' b' c' d' hl hr ↔
      σ 0 = a ∧ σ 1 = b ∧ σ 2 = c ∧ σ 3 = d := by
  have hcases : ∀ i : ZMod 4, i = 0 ∨ i = 1 ∨ i = 2 ∨ i = 3 := by decide
  have e10 : (1 : ZMod 4) ≠ 0 := by decide
  have e20 : (2 : ZMod 4) ≠ 0 := by decide
  have e21 : (2 : ZMod 4) ≠ 1 := by decide
  have e30 : (3 : ZMod 4) ≠ 0 := by decide
  have e31 : (3 : ZMod 4) ≠ 1 := by decide
  have e32 : (3 : ZMod 4) ≠ 2 := by decide
  constructor
  · rintro rfl
    simp [fourDigitPerm, fourDigitMap, e10, e20, e21, e30, e31, e32]
  · rintro ⟨h0, h1, h2, h3⟩
    ext i
    rcases hcases i with rfl | rfl | rfl | rfl <;>
      simp [fourDigitPerm, fourDigitMap, h0, h1, h2, h3, e10, e20, e21, e30, e31, e32]

/-- 有限積を方向番号 0, 1, 2, 3 の四つの因子に開く。 -/
private theorem prod_direction_four {R : Type*} [CommMonoid R] (f : ZMod 4 → R) :
    ∏ j : ZMod 4, f j = f 0 * f 1 * f 2 * f 3 := by
  rw [show (Finset.univ : Finset (ZMod 4)) = {0, 1, 2, 3} from by decide,
    Finset.prod_insert (by decide), Finset.prod_insert (by decide),
    Finset.prod_insert (by decide), Finset.prod_singleton]
  ac_rfl

/-- `claim_mode_small_matrix_determinant_dispersion`: 本文の七つの等号。
置換展開（`def_qbar_polynomial_determinant`）→ 逆方向を選ぶ項の零
（`claim_opposite_direction_permutation_term_zero`）→ 九つの置換の列挙
（`claim_admissible_direction_permutations`）→ 符号（`claim_admissible_direction_permutation_signs`）
→ 七つの成分積（`claim_mode_small_matrix_remaining_terms`）→ 四周期二項
（`claim_mode_small_matrix_four_cycle_terms`）→ 代数の整理（`claim_mode_small_matrix_signed_sum_algebra`）。 -/
theorem modeSmallMatrix_determinant_dispersion
    (z varpi varsigma : Qbar) (hz4 : z ^ 4 = -1)
    (hp : varpi ≠ 0) (hs : varsigma ≠ 0) :
    (Matrix.det (1 - (X : QbarPoly) •
      (modeSmallMatrix z varpi varsigma).map C : Matrix (ZMod 4) (ZMod 4) QbarPoly)) =
      (1+X^2)^2-X*(1-X^2)*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) := by
  classical
  let A : Matrix (ZMod 4) (ZMod 4) QbarPoly :=
    1 - (X : QbarPoly) • (modeSmallMatrix z varpi varsigma).map C
  let d0 : QbarPoly := 1 - X * C varpi
  let d1 : QbarPoly := 1 - X * C varsigma
  let d2 : QbarPoly := 1 - X * C varpi⁻¹
  let d3 : QbarPoly := 1 - X * C varsigma⁻¹
  let P : Equiv.Perm (ZMod 4) → QbarPoly := fun σ => ∏ j : ZMod 4, A j (σ j)
  let sgnC : Equiv.Perm (ZMod 4) → QbarPoly := fun σ => ((directionPermSign σ : ℤ) : QbarPoly)
  have hz : z ≠ 0 := by
    intro h
    simp [h] at hz4
  -- 逆方向を選ばない置換の全体（`claim_admissible_direction_permutations` の九個）。
  have hset : (Finset.univ.filter fun σ : Equiv.Perm (ZMod 4) => ∀ i, σ i ≠ i + 2) =
      {perm0123, perm0132, perm0213, perm1023, perm1032, perm1230, perm3012, perm3120,
        perm3210} := by
    ext σ
    simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_insert,
      Finset.mem_singleton, perm0123, perm0132, perm0213, perm1023, perm1032, perm1230,
      perm3012, perm3120, perm3210, perm_eq_iff_four_values]
    exact admissibleDirectionPermutations σ
  -- 符号（`claim_admissible_direction_permutation_signs`）。
  have hsign : ∀ σ : Equiv.Perm (ZMod 4), (∀ i, σ i ≠ i + 2) →
      sgnC σ = if (σ 0 = 0 ∧ σ 1 = 1 ∧ σ 2 = 2 ∧ σ 3 = 3) ∨
          (σ 0 = 1 ∧ σ 1 = 0 ∧ σ 2 = 3 ∧ σ 3 = 2) ∨
          (σ 0 = 3 ∧ σ 1 = 2 ∧ σ 2 = 1 ∧ σ 3 = 0) then 1 else -1 := by
    intro σ hσ
    simp only [sgnC, admissibleDirectionPermutationSigns σ hσ]
    split_ifs <;> simp
  have hP : ∀ σ : Equiv.Perm (ZMod 4), P σ = A 0 (σ 0) * A 1 (σ 1) * A 2 (σ 2) * A 3 (σ 3) :=
    fun σ => prod_direction_four _
  have hterms := modeSmallMatrix_remaining_terms z varpi varsigma hz hp hs
  have hcycles := modeSmallMatrix_four_cycle_terms z varpi varsigma hz4 hp hs
  dsimp only at hterms hcycles
  rcases hterms with ⟨ht0, ht1, ht2, ht3, ht4, ht5, ht6⟩
  rcases hcycles with ⟨hc0, hc1⟩
  change A.det = _
  calc
    A.det = ∑ σ : Equiv.Perm (ZMod 4), sgnC σ * P σ := by
        -- 本文の定義の行指定の置換展開。符号は方向番号の転倒数による（`directionPermSign_eq_sign`）。
        rw [← Matrix.det_transpose, Matrix.det_apply']
        simp only [Matrix.transpose_apply, sgnC, P, directionPermSign_eq_sign]
    _ = ∑ σ ∈ Finset.univ.filter (fun σ : Equiv.Perm (ZMod 4) => ∀ i, σ i ≠ i + 2),
          sgnC σ * P σ := by
        refine (Finset.sum_filter_of_ne ?_).symm
        intro σ _ hne
        by_contra hσ
        push_neg at hσ
        obtain ⟨i, hi⟩ := hσ
        exact hne (by
          simp only [P, A]
          rw [modeSmallMatrix_forbidden_term_zero z varpi varsigma σ i hi, mul_zero])
    _ = ∑ σ ∈ ({perm0123, perm0132, perm0213, perm1023, perm1032, perm1230, perm3012,
          perm3120, perm3210} : Finset (Equiv.Perm (ZMod 4))), sgnC σ * P σ := by
        rw [hset]
    _ = A 0 0 * A 1 1 * A 2 2 * A 3 3
      - A 0 0 * A 1 1 * A 2 3 * A 3 2
      - A 0 0 * A 1 2 * A 2 1 * A 3 3
      - A 0 1 * A 1 0 * A 2 2 * A 3 3
      + A 0 1 * A 1 0 * A 2 3 * A 3 2
      - A 0 1 * A 1 2 * A 2 3 * A 3 0
      - A 0 3 * A 1 0 * A 2 1 * A 3 2
      - A 0 3 * A 1 1 * A 2 2 * A 3 0
      + A 0 3 * A 1 2 * A 2 1 * A 3 0 := by
        rw [Finset.sum_insert (by decide), Finset.sum_insert (by decide),
          Finset.sum_insert (by decide), Finset.sum_insert (by decide),
          Finset.sum_insert (by decide), Finset.sum_insert (by decide),
          Finset.sum_insert (by decide), Finset.sum_insert (by decide),
          Finset.sum_singleton]
        simp only [hP]
        rw [hsign perm0123 (by decide), hsign perm0132 (by decide), hsign perm0213 (by decide),
          hsign perm1023 (by decide), hsign perm1032 (by decide), hsign perm1230 (by decide),
          hsign perm3012 (by decide), hsign perm3120 (by decide), hsign perm3210 (by decide)]
        simp (config := { decide := true }) only [perm0123, perm0132, perm0213, perm1023,
          perm1032, perm1230, perm3012, perm3120, perm3210, fourDigitPerm, Equiv.coe_fn_mk,
          fourDigitMap, if_true, if_false]
        ring
    _ = d0*d1*d2*d3 - X^2 *
      (C varpi⁻¹*C varsigma⁻¹*d0*d1 + C varpi⁻¹*C varsigma*d0*d3 +
       C varpi*C varsigma*d2*d3 + C varpi*C varsigma⁻¹*d1*d2) + 2*X^4
       - A 0 1 * A 1 2 * A 2 3 * A 3 0 - A 0 3 * A 1 0 * A 2 1 * A 3 2 := by
        rw [ht0, ht1, ht2, ht3, ht4, ht5, ht6]
        ring
    _ = d0*d1*d2*d3 - X^2 *
      (C varpi⁻¹*C varsigma⁻¹*d0*d1 + C varpi⁻¹*C varsigma*d0*d3 +
       C varpi*C varsigma*d2*d3 + C varpi*C varsigma⁻¹*d1*d2) + 4*X^4 := by
        rw [hc0, hc1]
        ring
    _ = (1+X^2)^2-X*(1-X^2)*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) :=
      modeSmallMatrix_signed_sum_algebra varpi varsigma hp hs

end Ising2DLambda.KacWard
