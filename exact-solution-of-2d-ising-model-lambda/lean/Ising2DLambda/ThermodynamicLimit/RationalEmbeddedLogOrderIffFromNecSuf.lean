/- 必要十分版を具体的な対象（正の有理数を部分型で受け、`f := fun x => logRat x.1`、
`e := toRational`、`s := 1/1^2 : ℚ`、`leA := (·.1 ≤ ·.1)`、`leB := logOrderLE`、
`leC := rationalLogOrderLE`）へ特殊化する。(1) は `logRat_le_iff`、(2) は
`rationalLogOrderLE_scaled_toRational_iff 1`。 -/
import Ising2DLambda.ThermodynamicLimit.RationalEmbeddedLogOrderIff
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalEmbeddedLogOrderIff

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_toRational_logRat_iff_from_necSuf {q q' : ℚ} (hq : 0 < q) (hq' : 0 < q') :
    q ≤ q' ↔ rationalLogOrderLE (toRational (logRat q)) (toRational (logRat q')) :=
  NecSuf.ThermodynamicLimit.iff_comp_of_iff_of_scaled_iff_necSuf
    (A := {x : ℚ // 0 < x}) (fun x y => x.1 ≤ y.1) logOrderLE rationalLogOrderLE
    (fun x => logRat x.1) toRational ((1 : ℚ) / (((1 : ℕ) : ℚ) ^ 2))
    (fun x y => logRat_le_iff x.2 y.2)
    (fun l m => (rationalLogOrderLE_scaled_toRational_iff 1 l m).symm)
    (by rw [Nat.cast_one, one_pow, div_one]) ⟨q, hq⟩ ⟨q', hq'⟩

end Ising2DLambda.ThermodynamicLimit
