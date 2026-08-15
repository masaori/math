/-
人手証明の「零点と係数データによる多項式の決定」の具体版。

  最高次係数を落とす反例                 `distinctRoots_do_not_determine_leadingCoefficient`
  代数的重複度を落とす反例               `distinctRoots_do_not_determine_multiplicity`
  零点・重複度・最高次係数による有限積表示 `eq_leadingCoeff_mul_prod_roots`
  同じ三つの有限データを持つ多項式の一致   `eq_of_roots_and_leadingCoeff_eq`

住処は代数的数の代数閉体とその一変数多項式環だけであり、禁止された脱出は無い。
-/
import Mathlib

namespace Ising3DCut.NullModel

noncomputable section

open Polynomial

/-- 最高次係数を落とすと、相異なる零点集合が同じでも多項式は異なり得る。 -/
theorem distinctRoots_do_not_determine_leadingCoefficient :
    let A : Polynomial (AlgebraicClosure ℚ) := X - C 1
    let B : Polynomial (AlgebraicClosure ℚ) := 2 * X - 2
    A ≠ B ∧ ∀ x, A.IsRoot x ↔ B.IsRoot x := by
  dsimp
  constructor
  · intro h
    have heval := congrArg (fun p : Polynomial (AlgebraicClosure ℚ) => p.eval 0) h
    norm_num at heval
  · intro x
    rw [Polynomial.IsRoot.def, Polynomial.IsRoot.def]
    simp only [eval_sub, eval_X, eval_C, eval_mul, eval_ofNat]
    rw [show (2 : AlgebraicClosure ℚ) * x - 2 = 2 * (x - 1) by ring]
    simp

/-- 代数的重複度を落とすと、相異なる零点集合が同じでも多項式は異なり得る。 -/
theorem distinctRoots_do_not_determine_multiplicity :
    let C₁ : Polynomial (AlgebraicClosure ℚ) := X - C 1
    let D : Polynomial (AlgebraicClosure ℚ) := (X - C 1) ^ 2
    C₁ ≠ D ∧ ∀ x, C₁.IsRoot x ↔ D.IsRoot x := by
  dsimp
  constructor
  · intro h
    have heval := congrArg (fun p : Polynomial (AlgebraicClosure ℚ) => p.eval 0) h
    norm_num at heval
  · intro x
    simp [Polynomial.IsRoot]

/-- 非零多項式は、最高次係数と重複度込みの零点多重集合から有限積として復元される。 -/
theorem eq_leadingCoeff_mul_prod_roots (F : Polynomial (AlgebraicClosure ℚ)) (_hF : F ≠ 0) :
    F = C F.leadingCoeff * (F.roots.map fun r => X - C r).prod := by
  exact (IsAlgClosed.splits F).eq_prod_roots

/-- 重複度込みの零点多重集合と最高次係数が同じ非零多項式は等しい。 -/
theorem eq_of_roots_and_leadingCoeff_eq
    {F G : Polynomial (AlgebraicClosure ℚ)} (hF : F ≠ 0) (hG : G ≠ 0)
    (hroots : F.roots = G.roots) (hlead : F.leadingCoeff = G.leadingCoeff) :
    F = G := by
  calc
    F = C F.leadingCoeff * (F.roots.map fun r => X - C r).prod :=
      eq_leadingCoeff_mul_prod_roots F hF
    _ = C G.leadingCoeff * (G.roots.map fun r => X - C r).prod := by
      rw [hlead, hroots]
    _ = G := (eq_leadingCoeff_mul_prod_roots G hG).symm

end

end Ising3DCut.NullModel
