/-
「ずらした自由族は Galois 群が極限量を決めないことの反例である」の
Lean 具体版・束ね。

人手証明 `claim_shifted_free_family_galois_group_does_not_determine_limit_quantity` の
二つの結論を一つの定理に束ねる。

- 非同型: 位数 4 の有限群（`Z_2` の分解体の Galois 群。位数 4 は SageMath 検証
  `galois-group-shifted-free-family-nonisomorphic/` の厳密計算）と、
  既約 40 次因子 `g`（`Z_3 = c (x+1)^14 g`）の分解体の Galois 群は同値でない
  （`forty_dvd_card_galois_group_of_irreducible` と
  `no_equiv_of_card_four_of_forty_dvd_card` の合成）。
- 極限一致: ずらした自由族の極限量 `α'` が存在すれば元の族の極限量 `α` に等しい
  （`shiftedFreeFiniteBoxQuantitySeq_limit_eq`。ℝ への脱出は仮定・結論の極限だけ）。
-/
import Ising3DCut.LimitQuantity.GaloisGroupOrderComparison
import Ising3DCut.LimitQuantity.TailShiftLimit
import Ising3DCut.LimitQuantity.GaloisGroupDoesNotDetermineLimitQuantityAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- ずらした自由族の判定枠で、Galois 群は極限量を決めない。
`G₂` は位数 4 の有限群（`Z_2` の分解体の Galois 群がこれに当たる）、
`g` は既約 40 次多項式（`Z_3` の既約 40 次因子がこれに当たる）。
このとき `G₂` と `g` の分解体の Galois 群は同値でないが、
ずらした自由族の極限量は元の族の極限量に一致する。 -/
theorem galois_group_does_not_determine_limit_quantity
    {G₂ : Type*} [Fintype G₂]
    {F : Type*} [Field F] [CharZero F]
    (g : Polynomial F) [Fintype g.Gal]
    (hg : Irreducible g)
    (hdegree : g.natDegree = 40)
    (h₂ : Fintype.card G₂ = 4)
    (q : ℚ) (N : ℕ → ℕ) (α α' : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 α))
    (h' : Tendsto (shiftedFreeFiniteBoxQuantitySeq q N) atTop (𝓝 α')) :
    ¬ Nonempty (G₂ ≃ g.Gal) ∧ α' = α := by
  exact finite_invariant_does_not_determine_limit_quantity
    4 40 h₂ (forty_dvd_card_galois_group_of_irreducible g hg hdegree) (by decide)
    atTop (fun n => n + 1) (tendsto_add_atTop_nat 1)
    (rootSeq (finiteBoxValueSeq q) N) (shiftedFreeFiniteBoxQuantitySeq q N)
    (shiftedFreeFiniteBoxQuantitySeq_eq_tail q N) α α' h h'

end Ising3DCut.LimitQuantity
