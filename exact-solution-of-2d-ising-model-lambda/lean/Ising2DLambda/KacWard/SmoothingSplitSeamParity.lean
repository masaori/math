/-
「二本の閉歩道の切断線偶奇の和は元の切断線偶奇に等しい」の具体版。
人手証明と同じく、γ_A の辺添字 `(k,l]` と γ_B の辺添字 `(l,m]`・`(0,k]` を
合併して元の辺添字 `(0,m]` へ戻し、二成分の有限和を法 2 で読む。
-/
import Ising2DLambda.KacWard.Basic
import Mathlib.Algebra.BigOperators.Intervals
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitSeamParity

namespace Ising2DLambda.KacWard


/-- 接触点分割の三つの辺添字区間は、元の辺添字区間を一度ずつ覆う。 -/
private theorem contactSplit_seam_sum (g : ℕ → ℕ) (m k l : ℕ)
    (hkl : k < l) (hlm : l ≤ m) :
    (∑ r ∈ Finset.Ioc k l, g r)
      + ((∑ r ∈ Finset.Ioc l m, g r) + ∑ r ∈ Finset.Ioc 0 k, g r)
      = ∑ r ∈ Finset.Ioc 0 m, g r := by
  have hfirst : (∑ r ∈ Finset.Ioc 0 k, g r) + ∑ r ∈ Finset.Ioc k l, g r
      = ∑ r ∈ Finset.Ioc 0 l, g r :=
    Finset.sum_Ioc_consecutive g (Nat.zero_le k) (le_of_lt hkl)
  have hsecond : (∑ r ∈ Finset.Ioc 0 l, g r) + ∑ r ∈ Finset.Ioc l m, g r
      = ∑ r ∈ Finset.Ioc 0 m, g r :=
    Finset.sum_Ioc_consecutive g (Nat.zero_le l) hlm
  calc
    (∑ r ∈ Finset.Ioc k l, g r)
        + ((∑ r ∈ Finset.Ioc l m, g r) + ∑ r ∈ Finset.Ioc 0 k, g r)
      = ((∑ r ∈ Finset.Ioc 0 k, g r) + ∑ r ∈ Finset.Ioc k l, g r)
          + ∑ r ∈ Finset.Ioc l m, g r := by
            ac_rfl
    _ = (∑ r ∈ Finset.Ioc 0 l, g r) + ∑ r ∈ Finset.Ioc l m, g r := by
          rw [hfirst]
    _ = ∑ r ∈ Finset.Ioc 0 m, g r := hsecond

theorem smoothing_split_seam_parity {L : ℕ}
    (horizontal vertical : OrientedEdge L → ℕ) (edge : ℕ → OrientedEdge L)
    (m k l : ℕ) (hkl : k < l) (hlm : l ≤ m) :
    (((∑ r ∈ Finset.Ioc k l, horizontal (edge r)) % 2
        + ((∑ r ∈ Finset.Ioc l m, horizontal (edge r))
          + ∑ r ∈ Finset.Ioc 0 k, horizontal (edge r)) % 2) % 2,
      ((∑ r ∈ Finset.Ioc k l, vertical (edge r)) % 2
        + ((∑ r ∈ Finset.Ioc l m, vertical (edge r))
          + ∑ r ∈ Finset.Ioc 0 k, vertical (edge r)) % 2) % 2) =
    ((∑ r ∈ Finset.Ioc 0 m, horizontal (edge r)) % 2,
      (∑ r ∈ Finset.Ioc 0 m, vertical (edge r)) % 2) := by
  have hh := contactSplit_seam_sum (fun r => horizontal (edge r)) m k l hkl hlm
  have hv := contactSplit_seam_sum (fun r => vertical (edge r)) m k l hkl hlm
  apply Prod.ext <;> simp only <;> omega

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_split_seam_parity_from_necSuf {L : ℕ}
    (horizontal vertical : OrientedEdge L → ℕ) (edge : ℕ → OrientedEdge L)
    (m k l : ℕ) (hkl : k < l) (hlm : l ≤ m) :
    (((∑ r ∈ Finset.Ioc k l, horizontal (edge r)) % 2
        + ((∑ r ∈ Finset.Ioc l m, horizontal (edge r))
          + ∑ r ∈ Finset.Ioc 0 k, horizontal (edge r)) % 2) % 2,
      ((∑ r ∈ Finset.Ioc k l, vertical (edge r)) % 2
        + ((∑ r ∈ Finset.Ioc l m, vertical (edge r))
          + ∑ r ∈ Finset.Ioc 0 k, vertical (edge r)) % 2) % 2) =
    ((∑ r ∈ Finset.Ioc 0 m, horizontal (edge r)) % 2,
      (∑ r ∈ Finset.Ioc 0 m, vertical (edge r)) % 2) :=
  smoothing_split_seam_parity horizontal vertical edge m k l hkl hlm

end Ising2DLambda.KacWard
