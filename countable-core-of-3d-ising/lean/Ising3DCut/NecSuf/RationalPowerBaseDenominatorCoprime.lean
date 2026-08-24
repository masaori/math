/-
「点数乗表示の底の既約分母は有理点の分子と互いに素である」の
Lean 必要十分版で使う整除の骨格。

具体版から合同式・法の移送・冪を落とすと、残るのは、`a` と `v` の
任意の共通素因子が `u` も割ること、および `u` と `v` の互いに素性だけである。
共通素因子を `u` へ移す仮定は、具体版の合同式が担う内容そのものなので削れない。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- `a` と `v` の共通素因子がすべて `u` も割るなら、`u` と `v` の互いに素性から
`a` と `v` の互いに素性が従う。 -/
theorem coprime_of_common_prime_dvd_left
    (u v a : ℕ) (huv : Nat.Coprime u v)
    (hcommon : ∀ p : ℕ, p.Prime → p ∣ a → p ∣ v → p ∣ u) :
    Nat.Coprime a v := by
  by_contra hnc
  obtain ⟨p, hp, hpa, hpv⟩ := Nat.Prime.not_coprime_iff_dvd.mp hnc
  have hpu : p ∣ u := hcommon p hp hpa hpv
  have hp1 : p ∣ Nat.gcd u v := Nat.dvd_gcd hpu hpv
  rw [Nat.Coprime] at huv
  rw [huv] at hp1
  exact hp.one_lt.ne' (Nat.dvd_one.mp hp1)

end Ising3DCut.NecSuf
