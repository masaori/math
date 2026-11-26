/-
「空集合上の Pfaffian と行列式はどちらも 1 である」の必要十分版。

具体版が使うのは、空集合上の完全マッチングがただ一つであること（マッチング和が一項になる）と、
その一項の符号・単項式が 1 であることと、行列式が 1 であることだけである。完全マッチングの中身は
使わないので、マッチングの型は元がただ一つの有限型 `P` とし、係数環は任意の可換環とする。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 元がただ一つのマッチングの型と、空集合上の置換だけを使い、係数環は任意の可換環とする。 -/
theorem emptyWeightedPfaffianDeterminant
    {R : Type*} [CommRing R] {P : Type*} [Fintype P] [Unique P]
    (_A : Matrix Empty Empty R)
    (c b : P → R)
    (hc : ∀ D, c D = 1) (hb : ∀ D, b D = 1)
    (hdet : Matrix.det _A = 1) :
    (∑ D : P, c D * b D) = 1 ∧
      Matrix.det _A = 1 ∧
      (∑ D : P, c D * b D) ^ 2 = Matrix.det _A := by
  classical
  have hpf : (∑ D : P, c D * b D) = 1 := by
    simp [hc, hb]
  refine ⟨hpf, hdet, ?_⟩
  rw [hpf, hdet]
  simp

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
