/-
「点数乗表示が成り立つ正の有理点の既約分母は 2 を割る」の
Lean 必要十分版で使う算術の骨格。

有限箱・有理数・素数 2 を落とすと、残るのは次の三条件だけである。
分母 `v` の素因子は指定した自然数 `d` に限られること、`d` 自身は `v` を
割らないこと、および `b ∣ k * v ^ N` であること。この三条件から
`v = 1` と `b ∣ k` を、人手証明と同じ順序で導く。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 分母の素因子が `d` に限られ、`d` 自身も分母を割らないなら、分母は 1 である。 -/
theorem denominator_eq_one_of_prime_divisors_restricted
    (v d : ℕ)
    (hrestricted : ∀ p : ℕ, p.Prime → p ∣ v → p = d)
    (hd : ¬ d ∣ v) :
    v = 1 := by
  rw [Nat.eq_one_iff_not_exists_prime_dvd]
  intro p hp hpv
  have hpd : p = d := hrestricted p hp hpv
  exact hd (hpd ▸ hpv)

/-- 人手証明の算術全体。分母を 1 にしたあと、冪と積の単位元を消して `b ∣ k` を得る。 -/
theorem denominator_one_and_outer_denominator_divides_constant
    (v b k N d : ℕ)
    (hrestricted : ∀ p : ℕ, p.Prime → p ∣ v → p = d)
    (hd : ¬ d ∣ v)
    (hdiv : b ∣ k * v ^ N) :
    v = 1 ∧ b ∣ k := by
  have hv : v = 1 :=
    denominator_eq_one_of_prime_divisors_restricted v d hrestricted hd
  subst hv
  exact ⟨rfl, by simpa using hdiv⟩

end Ising3DCut.NecSuf
