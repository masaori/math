/-
「有理円板内の格子点数あたりの Fisher 零点数は 2 を超えない」の具体版が、
必要十分版 `div_le_two_of_le_of_le_two_mul_necSuf` の特殊化として得られることの導出。
K を ℚ、a を N_L(c,r)、b を |F_L|、d を L^2 に取る。
-/
import Ising2DLambda.ThermodynamicLimit.FisherZeroDensityInRationalDisc
import Ising2DLambda.NecSuf.ThermodynamicLimit.FisherZeroDensityInRationalDiscLeTwo

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.FisherZero

theorem fisherZeroDensityInRationalDisc_le_two_from_necSuf (L : ℕ) [NeZero L]
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) :
    fisherZeroDensityInRationalDisc L data c r ≤ 2 :=
  NecSuf.ThermodynamicLimit.div_le_two_of_le_of_le_two_mul_necSuf
    (fisherZeroCountInRationalDisc L data c r : ℚ) ((FisherZeroSet L).ncard : ℚ) ((L : ℚ) ^ 2)
    (lattice_size_sq_pos_rat L)
    (by exact_mod_cast fisherZeroCountInRationalDisc_le_ncard L data c r)
    (by exact_mod_cast (fisherZeroSet_finite_ncard_le L).2)

end Ising2DLambda.ThermodynamicLimit
