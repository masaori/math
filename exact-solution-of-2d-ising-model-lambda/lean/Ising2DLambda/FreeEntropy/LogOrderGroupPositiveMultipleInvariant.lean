/-
人手証明「対数順序群の順序は正整数倍で変わらない」
（`claim_log_order_group_positive_multiple_invariant`）の具体版。

補助等式 rat_Λ(Nλ) = rat_Λ(λ)^N を N の帰納法で示し（N = 0 は 0λ = 0 と空積、N → N+1 は
整数倍の分配則と `rationalOfLog_add`）、主張は
Nλ ≤_Λ Nμ ⟺ rat_Λ(Nλ) ≤ rat_Λ(Nμ) ⟺ rat_Λ(λ)^N ≤ rat_Λ(μ)^N ⟺ rat_Λ(λ) ≤ rat_Λ(μ) ⟺ λ ≤_Λ μ
の同値の鎖で示す。三段目は正の有理数上で N 乗が狭義単調増加であること。
住処は ℕ・ℤ・ℚ・Λ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.LogOrderGroupAddMonotone

namespace Ising2DLambda.FreeEntropy

/-- 補助等式。正整数倍は正の有理数の冪へ移る（`N` の帰納法）。 -/
theorem rationalOfLog_natSmul (N : ℕ) (l : LogOrderGroup) :
    rationalOfLog (N • l) = rationalOfLog l ^ N := by
  induction N with
  | zero =>
      -- N = 0: 0λ = 0 で、rat_Λ(0) は空積 1
      rw [zero_smul, pow_zero]
      exact Finsupp.prod_zero_index
  | succ N ih =>
      calc
        rationalOfLog ((N + 1) • l) = rationalOfLog (N • l + l) := by rw [add_smul, one_smul]
        _ = rationalOfLog (N • l) * rationalOfLog l := rationalOfLog_add _ _
        _ = rationalOfLog l ^ N * rationalOfLog l := by rw [ih]
        _ = rationalOfLog l ^ (N + 1) := (pow_succ _ _).symm

/-- `claim_log_order_group_positive_multiple_invariant`。整数倍は `(N : ℤ) • l` で読む。 -/
theorem logOrderLE_natSmul_iff (N : ℕ) (hN : 1 ≤ N) (l m : LogOrderGroup) :
    logOrderLE l m ↔ logOrderLE ((N : ℤ) • l) ((N : ℤ) • m) := by
  unfold logOrderLE
  rw [natCast_zsmul, natCast_zsmul, rationalOfLog_natSmul, rationalOfLog_natSmul]
  -- 三段目: 正の有理数上で N 乗は順序を保ちかつ反映する
  exact (pow_le_pow_iff_left₀ (le_of_lt (rationalOfLog_pos l))
    (le_of_lt (rationalOfLog_pos m)) (Nat.pos_iff_ne_zero.mp hN)).symm

end Ising2DLambda.FreeEntropy
