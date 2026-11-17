import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.NecSuf.FisherZero

/-- 正錐の四条件は、台への包含・和と積の閉性・三分法だけで合成できる。 -/
theorem positiveCone_of_closed_trichotomy {K : Type} [Zero K] [Add K] [Mul K] [Neg K]
    (F C : Set K)
    (hsubset : ∀ z, z ∈ C → z ∈ F)
    (hadd : ∀ x y, x ∈ C → y ∈ C → x + y ∈ C)
    (hmul : ∀ x y, x ∈ C → y ∈ C → x * y ∈ C)
    (htri : ∀ z, z ∈ F →
      ((z = 0 ∨ z ∈ C ∨ -z ∈ C) ∧ ¬ (z = 0 ∧ z ∈ C) ∧
        ¬ (z = 0 ∧ -z ∈ C) ∧ ¬ (z ∈ C ∧ -z ∈ C))) :
    IsPositiveConeOn F C :=
  ⟨hsubset, hadd, hmul, htri⟩

end Ising2DLambda.NecSuf.FisherZero
