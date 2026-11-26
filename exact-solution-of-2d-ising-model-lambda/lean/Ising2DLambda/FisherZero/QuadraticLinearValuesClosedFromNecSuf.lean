import Ising2DLambda.FisherZero.QuadraticLinearValuesClosed
import Ising2DLambda.NecSuf.FisherZero.QuadraticLinearValuesClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数体の部分体へ適用する。 -/
theorem quadraticLinearValues_ringClosed_from_necSuf (F : Subfield Qbar) (a b : Qbar)
    (ha : a ∈ F) (hb : b * b = a) :
    (0 : Qbar) ∈ quadraticLinearValues F b ∧
    (1 : Qbar) ∈ quadraticLinearValues F b ∧
    (∀ y z : Qbar, y ∈ quadraticLinearValues F b →
      z ∈ quadraticLinearValues F b → y + z ∈ quadraticLinearValues F b) ∧
    (∀ y : Qbar, y ∈ quadraticLinearValues F b → -y ∈ quadraticLinearValues F b) ∧
    (∀ y z : Qbar, y ∈ quadraticLinearValues F b →
      z ∈ quadraticLinearValues F b → y * z ∈ quadraticLinearValues F b) := by
  exact Ising2DLambda.NecSuf.FisherZero.quadraticLinearValues_ringClosed_necSuf
    (F : Set Qbar) F.zero_mem F.one_mem
    (fun x y hx hy => F.add_mem hx hy) (fun x hx => F.neg_mem hx)
    (fun x y hx hy => F.mul_mem hx hy) a b ha hb

end Ising2DLambda.FisherZero
