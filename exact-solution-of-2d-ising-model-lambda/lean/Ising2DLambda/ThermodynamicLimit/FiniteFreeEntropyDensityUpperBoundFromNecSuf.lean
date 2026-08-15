/- 必要十分版（`upperBound_transport_through_two_monotone_maps_necSuf`）を、`ell := log`（`ℚ_{>0} → Λ`）、
`emb := λ ↦ (1/L²)·ι(λ)`（`Λ → Λ_ℚ`）、上界 `Z_L(q) ≤ 2^{L²}(1+q)^{2L²}`、
二つの等式 `logRat_upperBound_eq`・`scaled_toRational_upperBound_eq` へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.FiniteFreeEntropyDensityUpperBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.FiniteFreeEntropyDensityUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy PartitionPolynomial

theorem rationalLogOrderLE_scaledFreeEntropy_upperBound_from_necSuf (L : ℕ) [NeZero L] {q : ℚ}
    (hq : 0 < q) :
    rationalLogOrderLE (scaledFreeEntropy L q)
      (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))) := by
  have h1q : 0 < 1 + q := by linarith
  have hZpos : 0 < Polynomial.aeval q (partitionPolynomial L) := partitionPolynomial_eval_pos L hq
  have hBpos : 0 < ((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2) :=
    mul_pos (by positivity) (pow_pos h1q _)
  -- 第一の写像は正の有理数の上でだけ順序を保つので、K を正の有理数の部分型に取る
  have habstract :=
    NecSuf.ThermodynamicLimit.upperBound_transport_through_two_monotone_maps_necSuf
      (K := {r : ℚ // 0 < r})
      (leK := fun u v => u.1 ≤ v.1) (leA := logOrderLE) (leB := rationalLogOrderLE)
      (ell := fun u => logRat u.1)
      (emb := fun l => ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
      (x := ⟨Polynomial.aeval q (partitionPolynomial L), hZpos⟩)
      (y := ⟨((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2), hBpos⟩)
      (target := (L ^ 2) • generator ⟨2, Nat.prime_two⟩ + (2 * L ^ 2) • logRat (1 + q))
      (final := toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)))
      (fun {u v} huv => (logRat_le_iff u.2 v.2).mp huv)
      (fun {u v} huv => (rationalLogOrderLE_scaled_toRational_iff L u v).mpr huv)
      (partitionPolynomial_eval_rat_le_upperBound L hq)
      (logRat_upperBound_eq L hq)
      (scaled_toRational_upperBound_eq L q)
  exact habstract

end Ising2DLambda.ThermodynamicLimit
