/-
「末尾定数性は隣接する箱の分配多項式の冪等式に同値である」の Lean 必要十分版。

具体版の証明が使う構造だけを残す。分配多項式・有理数・正の実数乗根は不要であり、
必要なのはモノイド上の二つの列、各添字で両列を結ぶ冪等式、正の添字で指数が非零で
あること、および列の値が属する集合上で非零指数の冪写像が単射であることだけである。
添字は、閾値から隣接等号を帰納法で束ねるため自然数のまま残る。
箱の大きさの極限は使わない。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- モノイド上の根列が末尾で定数であることと、対応する値列の隣接交差冪等式との同値。 -/
theorem eventuallyConstant_iff_crossPowerIdentity
    {M : Type*} [Monoid M]
    (root value : ℕ → M) (degree : ℕ → ℕ) (s : Set M)
    (hroot : ∀ {L}, 0 < L → root L ∈ s)
    (hdegree : ∀ {L}, 0 < L → degree L ≠ 0)
    (hpow : ∀ {L}, 0 < L → root L ^ degree L = value L)
    (hpowInjective : ∀ {n : ℕ}, n ≠ 0 → Set.InjOn (fun x : M => x ^ n) s) :
    (∃ L0 : ℕ, 0 < L0 ∧ ∃ c : M, ∀ L, L0 ≤ L → root L = c)
      ↔ (∃ L0 : ℕ, 0 < L0 ∧ ∀ L, L0 ≤ L →
        value L ^ degree (L + 1) = value (L + 1) ^ degree L) := by
  constructor
  · rintro ⟨L0, hL0, c, hc⟩
    refine ⟨L0, hL0, ?_⟩
    intro L hL
    have hLpos : 0 < L := lt_of_lt_of_le hL0 hL
    have hL1pos : 0 < L + 1 := Nat.succ_pos L
    have hcL : root L = c := hc L hL
    have hcL1 : root (L + 1) = c := hc (L + 1) (le_trans hL (Nat.le_succ L))
    calc
      value L ^ degree (L + 1)
          = (root L ^ degree L) ^ degree (L + 1) := by rw [hpow hLpos]
      _ = c ^ (degree L * degree (L + 1)) := by rw [hcL, pow_mul]
      _ = (c ^ degree (L + 1)) ^ degree L := by rw [Nat.mul_comm, pow_mul]
      _ = (root (L + 1) ^ degree (L + 1)) ^ degree L := by rw [hcL1]
      _ = value (L + 1) ^ degree L := by rw [hpow hL1pos]
  · rintro ⟨L0, hL0, hcross⟩
    have hstep : ∀ L, L0 ≤ L → root L = root (L + 1) := by
      intro L hL
      have hLpos : 0 < L := lt_of_lt_of_le hL0 hL
      have hL1pos : 0 < L + 1 := Nat.succ_pos L
      have hpowers :
          root L ^ (degree L * degree (L + 1))
            = root (L + 1) ^ (degree L * degree (L + 1)) := by
        calc
          root L ^ (degree L * degree (L + 1))
              = (root L ^ degree L) ^ degree (L + 1) := by rw [pow_mul]
          _ = value L ^ degree (L + 1) := by rw [hpow hLpos]
          _ = value (L + 1) ^ degree L := hcross L hL
          _ = (root (L + 1) ^ degree (L + 1)) ^ degree L := by rw [hpow hL1pos]
          _ = root (L + 1) ^ (degree (L + 1) * degree L) := by rw [pow_mul]
          _ = root (L + 1) ^ (degree L * degree (L + 1)) := by rw [Nat.mul_comm]
      have hne : degree L * degree (L + 1) ≠ 0 :=
        Nat.mul_ne_zero (hdegree hLpos) (hdegree hL1pos)
      exact hpowInjective hne (hroot hLpos) (hroot hL1pos) hpowers
    refine ⟨L0, hL0, root L0, ?_⟩
    intro L hL
    induction L, hL using Nat.le_induction with
    | base => rfl
    | succ n hn ih => exact (hstep n hn).symm.trans ih

end Ising3DCut.NecSuf
