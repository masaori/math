/-
有限格子の Fisher 零点の代数性の必要十分版。
この組み立てに要るのは、候補 f が零元でないことと、指定した値で零になることだけである。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.FisherZero

/-- 零元でない根の候補が既にあれば、その候補を代数性の証拠として選べる。 -/
theorem nonzero_root_witness_necSuf {P : Type} {V : Type} [Zero P] [Zero V]
    (evaluate : V → P → V) (xi : V) (f : P) (hf : f ≠ 0) (hroot : evaluate xi f = 0) :
    ∃ g : P, g ≠ 0 ∧ evaluate xi g = 0 := by
  exact ⟨f, hf, hroot⟩

end Ising2DLambda.NecSuf.FisherZero
