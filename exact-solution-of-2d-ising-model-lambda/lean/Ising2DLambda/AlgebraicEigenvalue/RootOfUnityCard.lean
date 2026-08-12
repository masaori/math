/-
「1 の n 乗根の全体はちょうど n 個の元を持つ」の具体版。
人手証明と同じく、既存の上界と、相異なる n 個の根の構成を組み立てる。
住処は Qbar と ℕ であり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityFiniteCardBound
import Ising2DLambda.AlgebraicEigenvalue.RootPolynomialDistinctFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped BigOperators

theorem rootOfUnityCardEq (n : ℕ) (hn : 1 ≤ n) :
    (RootOfUnity n).ncard = n := by
  classical
  obtain ⟨hfinite, hupper⟩ := rootOfUnityFiniteCardLe n hn
  obtain ⟨w, _, hmem, hdist, _, _, _⟩ :=
    rootPolynomialDistinctFactorization n hn n le_rfl
  let s : Finset Qbar := (Finset.range n).image w
  have hwinj : Set.InjOn w (Finset.range n : Set ℕ) := by
    intro i hi i' hi' heq
    by_contra hne
    exact hdist i i' (Finset.mem_range.mp hi) (Finset.mem_range.mp hi') hne heq
  have hcard : s.card = n := by
    rw [show s = (Finset.range n).image w from rfl,
      Finset.card_image_iff.mpr hwinj, Finset.card_range]
  have hsubset : s ⊆ hfinite.toFinset := by
    intro x hx
    obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hx
    exact hfinite.mem_toFinset.mpr (hmem i (Finset.mem_range.mp hi))
  have hlower : n ≤ (RootOfUnity n).ncard := by
    calc
      n = s.card := hcard.symm
      _ ≤ hfinite.toFinset.card := Finset.card_le_card hsubset
      _ = (RootOfUnity n).ncard :=
        (Set.ncard_eq_toFinset_card (RootOfUnity n) hfinite).symm
  omega

end Ising2DLambda.AlgebraicEigenvalue
