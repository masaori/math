/-
「交差冪等式が閾値以後で成り立つことは、列の値が一つの元の点数乗で書けることに同値である」
の Lean 必要十分版。

具体版（`Ising3DCut.LimitQuantity.eventually_cross_power_identity_iff_rational_power_form`）は
正の有理数の素指数と素因数分解の一意性を使って底を取り出しているが、その素因数分解は
必要ではない。必要なのは次の三つだけである。

  * 値が可換群に属すること（可換群であれば整数冪が使える）
  * 閾値以後の隣接する指数が互いに素であること
  * 非零指数の冪写像が単射であること（捩れが無いこと）

底の取り出しは、互いに素性から得られる整数 `u, v`（`u * n L0 + v * n (L0+1) = 1`）を用いて
`c := (a L0) ^ u * (a (L0+1)) ^ v` と置くだけで済む。すなわち素数も有理数も要らない。
指数の具体形（立方数）も使わない。箱の大きさの極限は現れない。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 可換群上の列について、閾値以後の交差冪等式と、一つの元の点数乗という表示との同値。 -/
theorem crossPowerIdentity_iff_powerForm
    {G : Type*} [CommGroup G]
    (a : ℕ → G) (n : ℕ → ℕ) (L0 : ℕ)
    (hn : ∀ L, L0 ≤ L → n L ≠ 0)
    (hcop : ∀ L, L0 ≤ L → Nat.Coprime (n L) (n (L + 1)))
    (hInj : ∀ {m : ℕ}, m ≠ 0 → Function.Injective (fun x : G => x ^ m)) :
    (∀ L, L0 ≤ L → a L ^ n (L + 1) = a (L + 1) ^ n L)
      ↔ (∃ c : G, ∀ L, L0 ≤ L → a L = c ^ n L) := by
  constructor
  · intro hcross
    -- 閾値の箱で、互いに素性から底を取り出す
    have hcop0 : IsCoprime ((n L0 : ℤ)) ((n (L0 + 1) : ℤ)) :=
      Nat.isCoprime_iff_coprime.mpr (hcop L0 le_rfl)
    obtain ⟨u, v, huv⟩ := hcop0
    refine ⟨a L0 ^ u * a (L0 + 1) ^ v, ?_⟩
    -- 底の n L0 乗が a L0 に一致することを整数冪の計算で示す
    have hkey : (a L0 ^ u * a (L0 + 1) ^ v) ^ n L0 = a L0 := by
      have hcross0 : a L0 ^ ((n (L0 + 1) : ℤ)) = a (L0 + 1) ^ ((n L0 : ℤ)) := by
        have := hcross L0 le_rfl
        exact_mod_cast this
      calc
        (a L0 ^ u * a (L0 + 1) ^ v) ^ n L0
            = (a L0 ^ u * a (L0 + 1) ^ v) ^ ((n L0 : ℤ)) := by
              rw [zpow_natCast]
        _ = (a L0 ^ u) ^ ((n L0 : ℤ)) * (a (L0 + 1) ^ v) ^ ((n L0 : ℤ)) := by
              rw [mul_zpow]
        _ = a L0 ^ (u * (n L0 : ℤ)) * (a (L0 + 1) ^ ((n L0 : ℤ))) ^ v := by
              rw [← zpow_mul, ← zpow_mul, ← zpow_mul, mul_comm v ((n L0 : ℤ))]
        _ = a L0 ^ (u * (n L0 : ℤ)) * (a L0 ^ ((n (L0 + 1) : ℤ))) ^ v := by
              rw [hcross0]
        _ = a L0 ^ (u * (n L0 : ℤ)) * a L0 ^ ((n (L0 + 1) : ℤ) * v) := by
              rw [← zpow_mul]
        _ = a L0 ^ (u * (n L0 : ℤ) + (n (L0 + 1) : ℤ) * v) := by
              rw [zpow_add]
        _ = a L0 ^ ((1 : ℤ)) := by
              rw [show u * (n L0 : ℤ) + (n (L0 + 1) : ℤ) * v
                    = u * (n L0 : ℤ) + v * (n (L0 + 1) : ℤ) by ring, huv]
        _ = a L0 := by rw [zpow_one]
    intro L hL
    induction L, hL using Nat.le_induction with
    | base => exact hkey.symm
    | succ m hm ih =>
        -- 交差冪等式の両辺を n m 乗の単射性で外す
        have hpow : a (m + 1) ^ n m
            = ((a L0 ^ u * a (L0 + 1) ^ v) ^ n (m + 1)) ^ n m := by
          calc
            a (m + 1) ^ n m = a m ^ n (m + 1) := (hcross m hm).symm
            _ = ((a L0 ^ u * a (L0 + 1) ^ v) ^ n m) ^ n (m + 1) := by rw [ih]
            _ = (a L0 ^ u * a (L0 + 1) ^ v) ^ (n m * n (m + 1)) := by rw [← pow_mul]
            _ = (a L0 ^ u * a (L0 + 1) ^ v) ^ (n (m + 1) * n m) := by rw [Nat.mul_comm]
            _ = ((a L0 ^ u * a (L0 + 1) ^ v) ^ n (m + 1)) ^ n m := by rw [← pow_mul]
        exact hInj (hn m hm) hpow
  · rintro ⟨c, hc⟩
    intro L hL
    calc
      a L ^ n (L + 1) = (c ^ n L) ^ n (L + 1) := by rw [hc L hL]
      _ = c ^ (n L * n (L + 1)) := by rw [← pow_mul]
      _ = c ^ (n (L + 1) * n L) := by rw [Nat.mul_comm]
      _ = (c ^ n (L + 1)) ^ n L := by rw [← pow_mul]
      _ = a (L + 1) ^ n L := by rw [hc (L + 1) (le_trans hL (Nat.le_succ L))]

end Ising3DCut.NecSuf
