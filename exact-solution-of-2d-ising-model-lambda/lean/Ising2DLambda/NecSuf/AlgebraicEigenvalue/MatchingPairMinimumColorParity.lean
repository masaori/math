import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairMinimumPermutation

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 成分最小元からの後続置換の偶数番目が、構成した第一色に一致する。 -/
theorem matchingPairMinimum_iterate_color_iff_even
    (τ υ : FixedPointFreeInvolution J) (i : J) (n : ℕ) :
    (matchingPairMinimumPermutation τ υ)^[n] (matchingPairComponentMinimum τ υ i) ∈
      matchingPairFirstColor τ υ ↔ Even n := by
  induction n with
  | zero =>
      have hm := matchingPairMinimum_self_and_color τ υ (· ≤ ·)
        (fun _ _ => le_antisymm) (matchingPairComponentMinimum τ υ)
        (matchingPairComponentMinimum_mem τ υ) (matchingPairComponentMinimum_le τ υ) i
      simpa [matchingPairFirstColor] using hm.2
  | succ n ih =>
      have hflip (j : J) :
          matchingPairMinimumPermutation τ υ j ∈ matchingPairFirstColor τ υ ↔
            j ∉ matchingPairFirstColor τ υ := by
        exact matchingPairSuccessor_color_necSuf τ.val υ.val
          (fun k => k ∈ matchingPairFirstColor τ υ)
          (matchingPairFirstColor_first_mate τ υ)
          (matchingPairFirstColor_second_mate τ υ) j
      rw [Function.iterate_succ_apply', hflip, ih]
      simpa [Nat.even_add_one] using (not_even_iff_odd n)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
