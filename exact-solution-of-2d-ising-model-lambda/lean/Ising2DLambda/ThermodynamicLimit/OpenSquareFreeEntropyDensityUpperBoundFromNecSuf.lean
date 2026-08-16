/- 必要十分版（`upperBound_transport_through_two_monotone_maps_necSuf`。周期境界と共有。二つの順序を保つ写像を
通した上界の移送であり、格子の境界条件にも値の具体形にも依らない）を、`ell := log`（`ℚ_{>0} → Λ`）、
`emb := λ ↦ (1/L²)·ι(λ)`（`Λ → Λ_ℚ`）、上界 `Z^op_{L,L}(q) ≤ 2^{L²}(1+q)^{2L²}`、
二つの等式 `logRat_upperBound_eq`・`scaled_toRational_upperBound_eq` へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensityUpperBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.FiniteFreeEntropyDensityUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openScaledFreeEntropy_upperBound_from_necSuf (L : ℕ) [NeZero L] {q : ℚ}
    (hq : 0 < q) :
    rationalLogOrderLE (openScaledFreeEntropy L q)
      (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))) := by
  have h1q : 0 < 1 + q := by linarith
  have hZpos : 0 < openPartitionValueRat L L q := openPartitionValueRat_pos L L hq
  have hBpos : 0 < ((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2) :=
    mul_pos (by positivity) (pow_pos h1q _)
  have hZle : openPartitionValueRat L L q ≤ ((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2) := by
    have h := openPartitionValueRat_le_upperBound L L hq
    simpa [sq] using h
  -- 第一の写像は正の有理数の上でだけ順序を保つので、K を正の有理数の部分型に取る
  have habstract :=
    NecSuf.ThermodynamicLimit.upperBound_transport_through_two_monotone_maps_necSuf
      (K := {r : ℚ // 0 < r})
      (leK := fun u v => u.1 ≤ v.1) (leA := logOrderLE) (leB := rationalLogOrderLE)
      (ell := fun u => logRat u.1)
      (emb := fun l => ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
      (x := ⟨openPartitionValueRat L L q, hZpos⟩)
      (y := ⟨((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2), hBpos⟩)
      (target := (L ^ 2) • generator ⟨2, Nat.prime_two⟩ + (2 * L ^ 2) • logRat (1 + q))
      (final := toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)))
      (fun {u v} huv => (logRat_le_iff u.2 v.2).mp huv)
      (fun {u v} huv => (rationalLogOrderLE_scaled_toRational_iff L u v).mpr huv)
      hZle
      (logRat_upperBound_eq L hq)
      (scaled_toRational_upperBound_eq L q)
  exact habstract

end Ising2DLambda.ThermodynamicLimit
