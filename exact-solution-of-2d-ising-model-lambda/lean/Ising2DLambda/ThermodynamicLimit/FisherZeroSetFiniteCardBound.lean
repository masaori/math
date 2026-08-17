/-
章「熱力学極限」の「有限格子の Fisher 零点の全体は有限集合であり元の個数は 2L^2 を超えない」
（`claim_fisher_zero_set_finite_card_bound`）の具体版。
人手証明と同じく、無限性から 2L^2+1 個の有限部分集合を取り、
`claim_fisher_zero_finset_card_bound`（`fisherZeroSet_finset_card_le`）と矛盾させる。
そのあと有限集合 F_L 自身を同じ主張に当てて |F_L| ≤ 2L^2 を得る。
住処: Qbar と ℕ。実数体・複素数体は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.FisherZeroFinsetCardBound
import Mathlib.Data.Set.Card

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.FisherZero

variable (L : ℕ) [NeZero L]

theorem fisherZeroSet_finite_ncard_le :
    (FisherZeroSet L).Finite ∧ (FisherZeroSet L).ncard ≤ 2 * L ^ 2 := by
  classical
  -- 背理法: 無限なら |S| = 2L^2 + 1 の有限部分集合 S があり、|S| ≤ 2L^2 と矛盾。
  have hfinite : (FisherZeroSet L).Finite := by
    by_contra hnot
    have hinfinite : (FisherZeroSet L).Infinite := hnot
    obtain ⟨S, hS, hcard⟩ := hinfinite.exists_subset_card_eq (2 * L ^ 2 + 1)
    have hle : S.card ≤ 2 * L ^ 2 := fisherZeroSet_finset_card_le L S fun w hw => hS hw
    omega
  constructor
  · exact hfinite
  · -- 有限集合 F_L 自身を有限部分集合として当てる。
    rw [Set.ncard_eq_toFinset_card (FisherZeroSet L) hfinite]
    exact fisherZeroSet_finset_card_le L hfinite.toFinset fun w hw =>
      hfinite.mem_toFinset.1 hw

end Ising2DLambda.ThermodynamicLimit
