/-
章「トーラス上の Kac--Ward 行列式」の
「置換展開の項が非零であるための後続辺条件」の具体版。
人手証明と同じく、固定点と動く点に分けて成分積の非零性を判定する。
-/
import Ising2DLambda.KacWard.DeterminantConstantTerm
import Ising2DLambda.NecSuf.KacWard.DeterminantTermNonzero

namespace Ising2DLambda.KacWard

open Matrix Polynomial Equiv Ising2DLambda.AlgebraicEigenvalue

noncomputable def kacWardDeterminantEntryProduct {ι : Type}
    [Fintype ι] [DecidableEq ι] (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι) : QbarPoly :=
  ∏ i, kacWardPolynomialMatrix M i (σ i)

theorem kacWardDeterminantEntryProduct_ne_zero_iff {ι : Type}
    [Fintype ι] [DecidableEq ι] (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι) :
    kacWardDeterminantEntryProduct M σ ≠ 0 ↔
      ∀ i, σ i ≠ i → M i (σ i) ≠ 0 := by
  change Ising2DLambda.NecSuf.KacWard.determinantEntryProduct M σ ≠ 0 ↔ _
  exact Ising2DLambda.NecSuf.KacWard.determinantEntryProduct_ne_zero_iff M σ

theorem kacWardDeterminantEntryProduct_ne_zero_from_necSuf {ι : Type}
    [Fintype ι] [DecidableEq ι] (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι) :
    kacWardDeterminantEntryProduct M σ ≠ 0 ↔
      ∀ i, σ i ≠ i → M i (σ i) ≠ 0 :=
  kacWardDeterminantEntryProduct_ne_zero_iff M σ

end Ising2DLambda.KacWard
