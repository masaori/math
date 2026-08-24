/-
人手証明の主張「末尾定数性は隣接する箱の分配多項式の冪等式に同値である」
（ラベル `claim_eventually_constant_iff_power_identity`）の具体版。

人手証明の各段とこのファイルの対応:

  a_L(q) = Z_L(q)^{1/#V_L}                     `rootSeq` の定義
  Z_L(q)^{#V_{L+1}} = (a_L(q)^{#V_L})^{#V_{L+1}}   `posRoot_pow`
                    = c^{#V_L #V_{L+1}}            末尾定数性の仮定
                    = (c^{#V_{L+1}})^{#V_L}        正の実数の冪の指数法則
                    = Z_{L+1}(q)^{#V_L}            `posRoot_pow`
  逆向きは同じ計算を a_L(q)^{#V_L #V_{L+1}} から始め、
  正の実数の正の自然数乗の単射性（`pow_left_inj₀`）で a_L(q) = a_{L+1}(q) を得て、
  閾値からの帰納法で末尾定数性を出す。

箱の大きさの極限は取らない。ℝ に触れるのは有限箱の量が正の実数乗根であることだけである。
-/
import Ising3DCut.LimitQuantity.LimitQuantityAtOneEqualsTwo
import Ising3DCut.LimitQuantity.PartitionValuePositive

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 正の有理点では、正の箱サイズの有限箱値は正である。 -/
theorem isingValueSeq_pos {q : ℚ} (hq : 0 < q) {L : ℕ} (hL : 0 < L) :
    0 < isingValueSeq q L := by
  unfold isingValueSeq
  exact_mod_cast partitionPolynomial_evalAtRational_pos hL hq

/-- 正の箱サイズでは点の個数は零でない。 -/
theorem siteCountSeq_ne_zero {L : ℕ} (hL : 0 < L) : siteCountSeq L ≠ 0 := by
  unfold siteCountSeq
  rw [card_site]
  exact pow_ne_zero 3 hL.ne'

/-- 有限箱の量の `#V_L` 乗は有限箱値に等しい。 -/
theorem rootSeq_pow_siteCountSeq {q : ℚ} (hq : 0 < q) {L : ℕ} (hL : 0 < L) :
    rootSeq (isingValueSeq q) siteCountSeq L ^ siteCountSeq L = isingValueSeq q L :=
  posRoot_pow (isingValueSeq q L) (isingValueSeq_pos hq hL) (siteCountSeq L)
    (siteCountSeq_ne_zero hL)

/-- `claim_eventually_constant_iff_power_identity` の具体版。 -/
theorem eventually_constant_iff_power_identity (q : ℚ) (hq : 0 < q) :
    (∃ L0 : ℕ, 0 < L0 ∧ ∃ c : ℝ,
        ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c)
      ↔ (∃ L0 : ℕ, 0 < L0 ∧ ∀ L, L0 ≤ L →
        isingValueSeq q L ^ siteCountSeq (L + 1)
          = isingValueSeq q (L + 1) ^ siteCountSeq L) := by
  constructor
  · rintro ⟨L0, hL0, c, hc⟩
    refine ⟨L0, hL0, ?_⟩
    intro L hL
    have hLpos : 0 < L := lt_of_lt_of_le hL0 hL
    have hL1pos : 0 < L + 1 := Nat.succ_pos L
    have hcL : rootSeq (isingValueSeq q) siteCountSeq L = c := hc L hL
    have hcL1 : rootSeq (isingValueSeq q) siteCountSeq (L + 1) = c :=
      hc (L + 1) (le_trans hL (Nat.le_succ L))
    calc
      isingValueSeq q L ^ siteCountSeq (L + 1)
          = (rootSeq (isingValueSeq q) siteCountSeq L ^ siteCountSeq L) ^ siteCountSeq (L + 1) := by
            rw [rootSeq_pow_siteCountSeq hq hLpos]
      _ = c ^ (siteCountSeq L * siteCountSeq (L + 1)) := by rw [hcL, pow_mul]
      _ = (c ^ siteCountSeq (L + 1)) ^ siteCountSeq L := by
            rw [Nat.mul_comm, pow_mul]
      _ = (rootSeq (isingValueSeq q) siteCountSeq (L + 1) ^ siteCountSeq (L + 1)) ^ siteCountSeq L := by
            rw [hcL1]
      _ = isingValueSeq q (L + 1) ^ siteCountSeq L := by
            rw [rootSeq_pow_siteCountSeq hq hL1pos]
  · rintro ⟨L0, hL0, hcross⟩
    have hstep : ∀ L, L0 ≤ L →
        rootSeq (isingValueSeq q) siteCountSeq L
          = rootSeq (isingValueSeq q) siteCountSeq (L + 1) := by
      intro L hL
      have hLpos : 0 < L := lt_of_lt_of_le hL0 hL
      have hL1pos : 0 < L + 1 := Nat.succ_pos L
      have hx : 0 < rootSeq (isingValueSeq q) siteCountSeq L :=
        posRoot_pos (isingValueSeq q L) (isingValueSeq_pos hq hLpos) (siteCountSeq L)
      have hy : 0 < rootSeq (isingValueSeq q) siteCountSeq (L + 1) :=
        posRoot_pos (isingValueSeq q (L + 1)) (isingValueSeq_pos hq hL1pos) (siteCountSeq (L + 1))
      have hpowers :
          rootSeq (isingValueSeq q) siteCountSeq L ^ (siteCountSeq L * siteCountSeq (L + 1))
            = rootSeq (isingValueSeq q) siteCountSeq (L + 1)
                ^ (siteCountSeq L * siteCountSeq (L + 1)) := by
        calc
          rootSeq (isingValueSeq q) siteCountSeq L ^ (siteCountSeq L * siteCountSeq (L + 1))
              = (rootSeq (isingValueSeq q) siteCountSeq L ^ siteCountSeq L)
                  ^ siteCountSeq (L + 1) := by rw [pow_mul]
          _ = isingValueSeq q L ^ siteCountSeq (L + 1) := by
                rw [rootSeq_pow_siteCountSeq hq hLpos]
          _ = isingValueSeq q (L + 1) ^ siteCountSeq L := hcross L hL
          _ = (rootSeq (isingValueSeq q) siteCountSeq (L + 1) ^ siteCountSeq (L + 1))
                ^ siteCountSeq L := by rw [rootSeq_pow_siteCountSeq hq hL1pos]
          _ = rootSeq (isingValueSeq q) siteCountSeq (L + 1)
                ^ (siteCountSeq (L + 1) * siteCountSeq L) := by rw [pow_mul]
          _ = rootSeq (isingValueSeq q) siteCountSeq (L + 1)
                ^ (siteCountSeq L * siteCountSeq (L + 1)) := by rw [Nat.mul_comm]
      have hne : siteCountSeq L * siteCountSeq (L + 1) ≠ 0 :=
        Nat.mul_ne_zero (siteCountSeq_ne_zero hLpos) (siteCountSeq_ne_zero hL1pos)
      exact (pow_left_inj₀ hx.le hy.le hne).1 hpowers
    refine ⟨L0, hL0, rootSeq (isingValueSeq q) siteCountSeq L0, ?_⟩
    intro L hL
    induction L, hL using Nat.le_induction with
    | base => rfl
    | succ n hn ih => exact (hstep n hn).symm.trans ih

end Ising3DCut.LimitQuantity
