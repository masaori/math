/- 二つの一定な値の区間を一周する和には、対角の零と二つの接合の相殺だけが必要である。 -/
import Ising2DLambda.NecSuf.KacWard.WindingTransverseStaircase

namespace Ising2DLambda.NecSuf.KacWard

def twoBlockSequence {α : Type*} (p : ℕ) (a b : α) (s : ℕ) : α :=
  if s < p then a else b

def cyclicAdjacentSum {α M : Type*} [AddCommMonoid M]
    (weight : α → α → M) (n : ℕ) (u : ℕ → α) : M :=
  (∑ s ∈ Finset.range (n - 1), weight (u s) (u (s + 1))) + weight (u (n - 1)) (u 0)

theorem twoBlock_cyclicAdjacentSum_zero_necSuf
    {α M : Type*} [AddCommMonoid M] (weight : α → α → M)
    (p q : ℕ) (a b : α) (haa : weight a a = 0) (hbb : weight b b = 0)
    (hab : weight a b + weight b a = 0) :
    cyclicAdjacentSum weight (p + q) (twoBlockSequence p a b) = 0 := by
  by_cases hp : p = 0
  · simp [cyclicAdjacentSum, twoBlockSequence, hp, hbb]
  by_cases hq : q = 0
  · have hlast : p - 1 < p := by omega
    have hfirst : 0 < p := by omega
    have hinternal : (∑ s ∈ Finset.range (p - 1),
        weight (twoBlockSequence p a b s) (twoBlockSequence p a b (s + 1))) = 0 := by
      apply Finset.sum_eq_zero
      intro s hs
      have hs' := Finset.mem_range.mp hs
      simp [twoBlockSequence, show s < p by omega, show s + 1 < p by omega, haa]
    simp only [hq, Nat.add_zero, cyclicAdjacentSum]
    rw [hinternal]
    simp [twoBlockSequence, hlast, hfirst, haa]
  · have hfirst : 0 < p := by omega
    have hlast : ¬p + q - 1 < p := by omega
    have hinternal : (∑ s ∈ Finset.range (p + q - 1),
        weight (twoBlockSequence p a b s) (twoBlockSequence p a b (s + 1))) =
        weight a b := by
      rw [Finset.sum_eq_single (p - 1)]
      · simp [twoBlockSequence, show p - 1 < p by omega,
          show ¬p - 1 + 1 < p by omega]
      · intro s _ hs
        by_cases hsp : s < p
        · simp [twoBlockSequence, hsp, show s + 1 < p by omega, haa]
        · simp [twoBlockSequence, hsp, show ¬s + 1 < p by omega, hbb]
      · intro hnot
        exact False.elim (hnot (Finset.mem_range.mpr (by omega)))
    unfold cyclicAdjacentSum
    rw [hinternal]
    simpa [twoBlockSequence, hlast, hfirst] using hab

/-- 座標の順序や正値性は、階段の隣接差を求めるだけなら不要である。 -/
theorem twoPhaseStaircase_difference_necSuf {G : Type*} [AddCommGroup G]
    (p : ℕ) (a b : G) (s : ℕ) :
    twoPhaseStaircase p a b (s + 1) - twoPhaseStaircase p a b s =
      twoBlockSequence p a b s := by
  by_cases hs : s < p
  · simp [twoPhaseStaircase, twoBlockSequence, hs, show s ≤ p by omega,
      show s + 1 ≤ p by omega, add_nsmul]
  · by_cases heq : s = p
    · subst s
      simp [twoPhaseStaircase, twoBlockSequence]
    · have hsub : s + 1 - p = (s - p) + 1 := by omega
      simp [twoPhaseStaircase, twoBlockSequence, hs, show ¬s ≤ p by omega,
        show ¬s + 1 ≤ p by omega, hsub, add_nsmul]

theorem reversedTwoPhaseStaircase_difference_necSuf {G : Type*} [AddCommGroup G]
    (p q : ℕ) (a b : G) (s : ℕ) (hs : s < p + q) :
    twoPhaseStaircase p a b (p + q - 1 - s) -
        twoPhaseStaircase p a b (p + q - s) =
      twoBlockSequence q (-b) (-a) s := by
  have hindex : p + q - s = (p + q - 1 - s) + 1 := by omega
  rw [hindex, ← neg_sub, twoPhaseStaircase_difference_necSuf]
  by_cases hsq : s < q
  · simp [twoBlockSequence, hsq, show ¬p + q - 1 - s < p by omega]
  · simp [twoBlockSequence, hsq, show p + q - 1 - s < p by omega]

end Ising2DLambda.NecSuf.KacWard
