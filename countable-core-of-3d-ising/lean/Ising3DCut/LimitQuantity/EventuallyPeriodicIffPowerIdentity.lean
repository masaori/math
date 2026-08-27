/-
人手証明の主張「末尾周期性は周期だけ離れた箱の分配多項式の冪等式に同値である」
（ラベル `claim_eventually_periodic_iff_power_identity`）の Lean 具体版。

有限箱の量は正の実数乗根として扱うが、箱の大きさの極限は取らない。
各向きは `rootSeq_pow_siteCountSeq` と自然数冪の指数法則を順に適用し、
逆向きでは正の実数上の非零自然数冪の単射性を使う。
-/
import Ising3DCut.LimitQuantity.EventuallyConstantIffPowerIdentity

namespace Ising3DCut.LimitQuantity

/-- `claim_eventually_periodic_iff_power_identity` の具体版。 -/
theorem eventually_periodic_iff_power_identity (q : ℚ) (hq : 0 < q) :
    (∃ L0 p : ℕ, 0 < L0 ∧ 0 < p ∧
        ∀ L, L0 ≤ L →
          rootSeq (isingValueSeq q) siteCountSeq L =
            rootSeq (isingValueSeq q) siteCountSeq (L + p))
      ↔ (∃ L0 p : ℕ, 0 < L0 ∧ 0 < p ∧
        ∀ L, L0 ≤ L →
          isingValueSeq q L ^ siteCountSeq (L + p) =
            isingValueSeq q (L + p) ^ siteCountSeq L) := by
  constructor
  · rintro ⟨L0, p, hL0, hp, hperiodic⟩
    refine ⟨L0, p, hL0, hp, ?_⟩
    intro L hL
    have hLpos : 0 < L := lt_of_lt_of_le hL0 hL
    have hLppos : 0 < L + p := Nat.add_pos_left hLpos p
    have heq := hperiodic L hL
    calc
      isingValueSeq q L ^ siteCountSeq (L + p)
          = (rootSeq (isingValueSeq q) siteCountSeq L ^ siteCountSeq L) ^
              siteCountSeq (L + p) := by
            rw [rootSeq_pow_siteCountSeq hq hLpos]
      _ = rootSeq (isingValueSeq q) siteCountSeq L ^
            (siteCountSeq L * siteCountSeq (L + p)) := by rw [pow_mul]
      _ = rootSeq (isingValueSeq q) siteCountSeq (L + p) ^
            (siteCountSeq L * siteCountSeq (L + p)) := by rw [heq]
      _ = (rootSeq (isingValueSeq q) siteCountSeq (L + p) ^
              siteCountSeq (L + p)) ^ siteCountSeq L := by
            rw [Nat.mul_comm, pow_mul]
      _ = isingValueSeq q (L + p) ^ siteCountSeq L := by
            rw [rootSeq_pow_siteCountSeq hq hLppos]
  · rintro ⟨L0, p, hL0, hp, hcross⟩
    refine ⟨L0, p, hL0, hp, ?_⟩
    intro L hL
    have hLpos : 0 < L := lt_of_lt_of_le hL0 hL
    have hLppos : 0 < L + p := Nat.add_pos_left hLpos p
    have hx : 0 < rootSeq (isingValueSeq q) siteCountSeq L :=
      posRoot_pos (isingValueSeq q L) (isingValueSeq_pos hq hLpos) (siteCountSeq L)
    have hy : 0 < rootSeq (isingValueSeq q) siteCountSeq (L + p) :=
      posRoot_pos (isingValueSeq q (L + p)) (isingValueSeq_pos hq hLppos)
        (siteCountSeq (L + p))
    have hpowers :
        rootSeq (isingValueSeq q) siteCountSeq L ^
            (siteCountSeq L * siteCountSeq (L + p)) =
          rootSeq (isingValueSeq q) siteCountSeq (L + p) ^
            (siteCountSeq L * siteCountSeq (L + p)) := by
      calc
        rootSeq (isingValueSeq q) siteCountSeq L ^
              (siteCountSeq L * siteCountSeq (L + p))
            = (rootSeq (isingValueSeq q) siteCountSeq L ^ siteCountSeq L) ^
                siteCountSeq (L + p) := by rw [pow_mul]
        _ = isingValueSeq q L ^ siteCountSeq (L + p) := by
              rw [rootSeq_pow_siteCountSeq hq hLpos]
        _ = isingValueSeq q (L + p) ^ siteCountSeq L := hcross L hL
        _ = (rootSeq (isingValueSeq q) siteCountSeq (L + p) ^
                siteCountSeq (L + p)) ^ siteCountSeq L := by
              rw [rootSeq_pow_siteCountSeq hq hLppos]
        _ = rootSeq (isingValueSeq q) siteCountSeq (L + p) ^
              (siteCountSeq (L + p) * siteCountSeq L) := by rw [pow_mul]
        _ = rootSeq (isingValueSeq q) siteCountSeq (L + p) ^
              (siteCountSeq L * siteCountSeq (L + p)) := by rw [Nat.mul_comm]
    have hne : siteCountSeq L * siteCountSeq (L + p) ≠ 0 :=
      Nat.mul_ne_zero (siteCountSeq_ne_zero hLpos) (siteCountSeq_ne_zero hLppos)
    exact (pow_left_inj₀ hx.le hy.le hne).1 hpowers

end Ising3DCut.LimitQuantity
