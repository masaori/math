/-
具体版「分母 2 の有理点と整数の有理点を合わせた候補は三つに限られる」が、
必要十分版（`Ising3DCut.NecSuf.DenominatorTwoPointAndFinalCandidateSet`）の
特殊化として得られることを示す。

四つの段のそれぞれについて、必要十分版へ具体的な値を入れると
具体版の主張がそのまま出ることを確かめる。
-/
import Ising3DCut.LimitQuantity.DenominatorTwoPointAndFinalCandidateSet
import Ising3DCut.NecSuf.DenominatorTwoPointAndFinalCandidateSet

namespace Ising3DCut.LimitQuantity

open Ising3DCut.NecSuf

/-- 分離の段。必要十分版の共通因子を `a`、残りの項を `Ω(m+1) * a^m * 2^(E-(m+1))` に取る。 -/
theorem denominatorTwo_scaled_partition_sum_split_viaNecSuf
    (Omega : ℕ → ℕ) (a E : ℕ) :
    (∑ m ∈ Finset.range (E + 1), Omega m * a ^ m * 2 ^ (E - m))
      = 2 ^ E * Omega 0 + a * denominatorTwoTailSum Omega a E := by
  have h :=
    head_split_of_common_factor
      (fun m => Omega m * a ^ m * 2 ^ (E - m))
      (fun m => Omega (m + 1) * a ^ m * 2 ^ (E - (m + 1)))
      a E
      (by intro m; ring)
  simpa [denominatorTwoTailSum, pow_zero, Nat.sub_zero, Nat.mul_comm] using h

/-- 両辺の書き換えの段。必要十分版で `s := 2^E`、`c := 2` と置く。 -/
theorem denominatorTwo_scaled_difference_identity_viaNecSuf
    {a S omega w : ℤ} {E : ℕ}
    (h : (2 : ℤ) ^ E * w = (2 : ℤ) ^ E * omega + a * S) :
    (2 : ℤ) ^ (E + 1) * (w - 1)
      = (2 : ℤ) ^ (E + 1) * (omega - 1) + 2 * a * S := by
  have habs := scale_and_shift_of_linear_relation (c := (2 : ℤ)) h
  calc
    (2 : ℤ) ^ (E + 1) * (w - 1) = ((2 : ℤ) * 2 ^ E) * (w - 1) := by ring
    _ = ((2 : ℤ) * 2 ^ E) * (omega - 1) + 2 * (a * S) := habs
    _ = (2 : ℤ) ^ (E + 1) * (omega - 1) + 2 * a * S := by ring

/-- 分子の確定の段。必要十分版で `b := 2`、`k := E + 1` と置く。 -/
theorem denominatorTwo_numerator_eq_one_viaNecSuf
    {a E : ℕ} (hcoprime : Nat.Coprime a 2) (hdvd : a ∣ 2 ^ (E + 1)) :
    a = 1 :=
  eq_one_of_dvd_coprime_pow hcoprime hdvd

/-- 候補の枚挙の段。必要十分版で `n := 2` と置き、正性と合わせて 1 か 2 に絞る。 -/
theorem positive_integer_dvd_two_candidates_viaNecSuf
    {q : ℕ} (hq : 0 < q) (hdvd : q ∣ 2) :
    q = 1 ∨ q = 2 := by
  have hle : q ≤ 2 := le_of_dvd_pos (by norm_num) hdvd
  omega

end Ising3DCut.LimitQuantity
