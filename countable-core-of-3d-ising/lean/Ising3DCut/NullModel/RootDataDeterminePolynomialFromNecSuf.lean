/-
具体版が必要十分版の特殊化として得られることの明示。

零点データを根であるという述語、観測を零での評価、復元写像を最高次係数と
重複度込み零点多重集合から作る有限積に取る。
-/
import Ising3DCut.NullModel.RootDataDeterminePolynomial
import Ising3DCut.NecSuf.NullModel.RootDataDeterminePolynomial

namespace Ising3DCut.NullModel

noncomputable section

open Polynomial

/-- 最高次係数と重複度込み零点多重集合から作る有限積。 -/
def reconstructFromRoots (c : AlgebraicClosure ℚ) (roots : Multiset (AlgebraicClosure ℚ)) :
    Polynomial (AlgebraicClosure ℚ) :=
  C c * (roots.map fun r ↦ X - C r).prod

/-- 「相異なる零点だけでは多項式を決めない」の二つの反例を必要十分版から導く。 -/
theorem distinctRoots_do_not_determine_polynomial_from_necSuf :
    let A : Polynomial (AlgebraicClosure ℚ) := X - C 1
    let B : Polynomial (AlgebraicClosure ℚ) := 2 * X - 2
    let C₁ : Polynomial (AlgebraicClosure ℚ) := X - C 1
    let D : Polynomial (AlgebraicClosure ℚ) := (X - C 1) ^ 2
    (A ≠ B ∧ ∀ x, A.IsRoot x ↔ B.IsRoot x) ∧
      (C₁ ≠ D ∧ ∀ x, C₁.IsRoot x ↔ D.IsRoot x) := by
  dsimp
  have hAB := distinctRoots_do_not_determine_leadingCoefficient
  have hCD := distinctRoots_do_not_determine_multiplicity
  have h := NecSuf.NullModel.rootData_does_not_determine_object_twice
    (X - C 1 : Polynomial (AlgebraicClosure ℚ))
    (2 * X - 2 : Polynomial (AlgebraicClosure ℚ))
    (X - C 1 : Polynomial (AlgebraicClosure ℚ))
    ((X - C 1) ^ 2 : Polynomial (AlgebraicClosure ℚ))
    id (fun p x ↦ p.IsRoot x)
    hAB.1 (by funext x; exact propext (hAB.2 x))
    hCD.1 (by funext x; exact propext (hCD.2 x))
  exact ⟨⟨h.1.1, fun x ↦ iff_of_eq (congrFun h.1.2 x)⟩,
    ⟨h.2.1, fun x ↦ iff_of_eq (congrFun h.2.2 x)⟩⟩

/-- 「最高次係数と重複度を加えれば多項式が決まる」を必要十分版から導く。 -/
theorem eq_of_roots_and_leadingCoeff_eq_from_necSuf
    {F G : Polynomial (AlgebraicClosure ℚ)} (hF : F ≠ 0) (hG : G ≠ 0)
    (hroots : F.roots = G.roots) (hlead : F.leadingCoeff = G.leadingCoeff) : F = G := by
  exact NecSuf.NullModel.eq_of_rootData_and_leadingData_eq
    (Object := Polynomial (AlgebraicClosure ℚ))
    (RootData := Multiset (AlgebraicClosure ℚ))
    (LeadingData := AlgebraicClosure ℚ)
    reconstructFromRoots
    F G F.roots G.roots F.leadingCoeff G.leadingCoeff
    (by simpa [reconstructFromRoots] using eq_leadingCoeff_mul_prod_roots F hF)
    (by simpa [reconstructFromRoots] using eq_leadingCoeff_mul_prod_roots G hG)
    hroots hlead

end

end Ising3DCut.NullModel
