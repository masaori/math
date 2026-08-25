/-
「隣接する二つの箱の頂点数の差は次の差と互いに素である」の Lean 必要十分版。

三次元の頂点数を落とすと、隣接する二数 `g`・`gNext`、`g` の一つ前の部分 `t`、
両者の差 `offset` が残る。具体版が使うのは、`g = t + 1`、
`gNext = g + offset`、および `offset` の任意の素因子が `t` も割ることだけである。
証明は具体版と同じく、最大公約数の素因子を取り、差を割ることを示し、最後に 1 の整除へ落とす。
-/
import Mathlib.Data.Nat.Prime.Basic

namespace Ising3DCut.NecSuf

/-- 隣接する二数の差の素因子が前項の一つ前の部分も割るなら、二数は互いに素である。 -/
theorem coprime_of_add_one_and_prime_divisors_of_offset_dvd_base
    (g gNext t offset : ℕ)
    (hg : g = t + 1)
    (hnext : gNext = g + offset)
    (hoffset : ∀ p : ℕ, Nat.Prime p → p ∣ offset → p ∣ t) :
    Nat.Coprime g gNext := by
  by_contra hne
  obtain ⟨p, hp, hpd⟩ := Nat.exists_prime_and_dvd (n := Nat.gcd g gNext) hne
  have hgDiv : p ∣ g := hpd.trans (Nat.gcd_dvd_left _ _)
  have hnextDiv : p ∣ gNext := hpd.trans (Nat.gcd_dvd_right _ _)
  have hoffsetDiv : p ∣ offset := (Nat.dvd_add_right hgDiv).mp (hnext ▸ hnextDiv)
  have htDiv : p ∣ t := hoffset p hp hoffsetDiv
  have hone : p ∣ 1 := (Nat.dvd_add_right htDiv).mp (hg ▸ hgDiv)
  exact Nat.Prime.one_lt hp |>.ne' (Nat.dvd_one.mp hone)

end Ising3DCut.NecSuf
