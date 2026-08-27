/-
「末尾周期性は周期だけ離れた箱の分配多項式の冪等式に同値である」の Lean 必要十分版。

具体版の証明が実際に使っている性質だけを残す。分配多項式・有理数・正の実数乗根・
順序は不要であり、必要なのはモノイド上の二つの列、正の添字で根の冪が値に等しいこと、
正の添字で指数が非零であること、および根の値が属する集合の上で非零指数の冪写像が
単射であることだけである。

末尾定数性の必要十分版と違い、ここでは隣接等号を帰納法で束ねる段が要らない
（周期 `p` の等号はそのまま結論の形である）。そのため添字を自然数に固定する必要も
無いが、閾値 `L0 ≤ L` と `L + p` という形が具体版の主張の形なので、添字は自然数の
まま残す。箱の大きさの極限は使わない。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 二つの添字における根の一致と、交差冪等式との同値（周期版の核）。
モノイドの冪乗則と、非零指数の冪写像の単射性だけを使う。 -/
theorem root_eq_iff_crossPowerEquality
    {M : Type*} [Monoid M]
    (root value : ℕ → M) (degree : ℕ → ℕ) (s : Set M)
    (hpowInjective : ∀ {n : ℕ}, n ≠ 0 → Set.InjOn (fun x : M => x ^ n) s)
    {m n : ℕ}
    (hrootm : root m ∈ s) (hrootn : root n ∈ s)
    (hdm : degree m ≠ 0) (hdn : degree n ≠ 0)
    (hpowm : root m ^ degree m = value m) (hpown : root n ^ degree n = value n) :
    root m = root n ↔ value m ^ degree n = value n ^ degree m := by
  have hne : degree m * degree n ≠ 0 := Nat.mul_ne_zero hdm hdn
  constructor
  · intro hroot
    calc
      value m ^ degree n = (root m ^ degree m) ^ degree n := by rw [hpowm]
      _ = root m ^ (degree m * degree n) := by rw [pow_mul]
      _ = root n ^ (degree m * degree n) := by rw [hroot]
      _ = (root n ^ degree n) ^ degree m := by rw [Nat.mul_comm, pow_mul]
      _ = value n ^ degree m := by rw [hpown]
  · intro hcross
    have hpowers :
        root m ^ (degree m * degree n) = root n ^ (degree m * degree n) := by
      calc
        root m ^ (degree m * degree n) = (root m ^ degree m) ^ degree n := by
          rw [pow_mul]
        _ = value m ^ degree n := by rw [hpowm]
        _ = value n ^ degree m := hcross
        _ = (root n ^ degree n) ^ degree m := by rw [hpown]
        _ = root n ^ (degree n * degree m) := by rw [pow_mul]
        _ = root n ^ (degree m * degree n) := by rw [Nat.mul_comm]
    exact hpowInjective hne hrootm hrootn hpowers

/-- モノイド上の根列が末尾周期的であることと、対応する値列の周期交差冪等式との同値。 -/
theorem eventuallyPeriodic_iff_crossPowerIdentity
    {M : Type*} [Monoid M]
    (root value : ℕ → M) (degree : ℕ → ℕ) (s : Set M)
    (hroot : ∀ {L}, 0 < L → root L ∈ s)
    (hdegree : ∀ {L}, 0 < L → degree L ≠ 0)
    (hpow : ∀ {L}, 0 < L → root L ^ degree L = value L)
    (hpowInjective : ∀ {n : ℕ}, n ≠ 0 → Set.InjOn (fun x : M => x ^ n) s) :
    (∃ L0 p : ℕ, 0 < L0 ∧ 0 < p ∧ ∀ L, L0 ≤ L → root L = root (L + p))
      ↔ (∃ L0 p : ℕ, 0 < L0 ∧ 0 < p ∧ ∀ L, L0 ≤ L →
        value L ^ degree (L + p) = value (L + p) ^ degree L) := by
  have hcore : ∀ (L p : ℕ), 0 < L →
      (root L = root (L + p) ↔
        value L ^ degree (L + p) = value (L + p) ^ degree L) := by
    intro L p hLpos
    have hLppos : 0 < L + p := Nat.lt_of_lt_of_le hLpos (Nat.le_add_right L p)
    exact root_eq_iff_crossPowerEquality root value degree s hpowInjective
      (hroot hLpos) (hroot hLppos) (hdegree hLpos) (hdegree hLppos)
      (hpow hLpos) (hpow hLppos)
  constructor
  · rintro ⟨L0, p, hL0, hp, hperiodic⟩
    exact ⟨L0, p, hL0, hp, fun L hL =>
      (hcore L p (lt_of_lt_of_le hL0 hL)).1 (hperiodic L hL)⟩
  · rintro ⟨L0, p, hL0, hp, hcross⟩
    exact ⟨L0, p, hL0, hp, fun L hL =>
      (hcore L p (lt_of_lt_of_le hL0 hL)).2 (hcross L hL)⟩

end Ising3DCut.NecSuf
