/-
具体版が必要十分版の特殊化として得られることの導出。

必要十分版（`NecSuf.AlgebraicEigenvalue.prod_pair_eq_pow_card_necSuf`）は、
相等の決定できる添字の型 `ι` と可換モノイド `M` について、`s` のすべての元で
`a i * b i = c` ならば `(∏ a) * (∏ b) = c ^ |s|` であることを言う。
具体版は `ι := OrbitIndex L`（軌道の全体）、`M := ℤ[x][t]` と取ったものである
（`ℤ[x][t]` は可換環なので可換モノイドでもあり、加法・分配則は使わない）。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.ProdPairEqPowCard
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ProdPairEqPowCard

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {L : ℕ} [NeZero L]

/-- 具体版は必要十分版の特殊化である（`ι := OrbitIndex L`、`M := ℤ[x][t]`）。 -/
theorem prod_pair_eq_pow_card_from_necSuf (a b : OrbitIndex L → SecondPoly) (c : SecondPoly) :
    ∀ s : Finset (OrbitIndex L), (∀ O ∈ s, a O * b O = c) →
      (∏ O ∈ s, a O) * ∏ O ∈ s, b O = c ^ s.card :=
  fun s hs =>
    NecSuf.AlgebraicEigenvalue.prod_pair_eq_pow_card_necSuf a b c s hs

end Ising2DLambda.AlgebraicEigenvalue
