import Ising2DLambda.NecSuf.FisherZero.QuadraticLinearValuesInverseClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticLinearValues_inv_mem_from_necSuf (F : Subfield Qbar) (a b : Qbar)
    (ha : a ∈ F) (hb : b * b = a) (hbF : b ∉ F)
    (y : Qbar) (hy : y ∈ quadraticLinearValues F b) (hy0 : y ≠ 0) :
    y⁻¹ ∈ quadraticLinearValues F b := by
  exact Ising2DLambda.NecSuf.FisherZero.quadraticLinearValues_inv_mem_necSuf
    (F : Set Qbar) (fun _ _ hx hy => F.sub_mem hx hy)
    (fun _ _ hx hy => F.mul_mem hx hy) (fun _ _ hx hy => F.div_mem hx hy)
    (fun _ hx => F.neg_mem hx) a b ha hb
    (fun u v hu hv hz => quadraticNorm_ne_zero F a b u v ha hu hv hbF hb hz)
    y hy hy0

end Ising2DLambda.FisherZero
