/-
「一側閉包は終点を除いて頂点を繰り返さない」の必要十分版。

四部分を共有端点が重複しない半開区間で連結すると、本質は各部分の単射性と、
異なる二部分の像が交わらないことだけである。点の型には構造も有限性も要らない。
-/
import Ising2DLambda.NecSuf.KacWard.OneSidedPeriodicLiftClosure
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 四部分が各々単射で相互に交わらなければ、終点を除く連結路は単射である。 -/
theorem one_sided_four_segment_path_injective_necSuf
    {X : Type*} (first second third fourth : ℕ → X) (a b c : ℕ)
    (hfirst : ∀ i < a, ∀ j < a, first i = first j → i = j)
    (hsecond : ∀ i < b, ∀ j < b, second i = second j → i = j)
    (hthird : ∀ i < c, ∀ j < c, third i = third j → i = j)
    (hfourth : ∀ i, 0 < i → i ≤ b → ∀ j, 0 < j → j ≤ b →
      fourth i = fourth j → i = j)
    (h12 : ∀ i < a, ∀ j < b, first i ≠ second j)
    (h13 : ∀ i < a, ∀ j < c, first i ≠ third j)
    (h14 : ∀ i < a, ∀ j, 0 < j → j ≤ b → first i ≠ fourth j)
    (h23 : ∀ i < b, ∀ j < c, second i ≠ third j)
    (h24 : ∀ i < b, ∀ j, 0 < j → j ≤ b → second i ≠ fourth j)
    (h34 : ∀ i < c, ∀ j, 0 < j → j ≤ b → third i ≠ fourth j) :
    ∀ i < a + 2 * b + c, ∀ j < a + 2 * b + c,
      oneSidedFourSegmentPath first second third fourth a b c i =
        oneSidedFourSegmentPath first second third fourth a b c j → i = j := by
  intro i hi j hj hij
  by_cases hia : i < a
  · by_cases hja : j < a
    · have heq : first i = first j := by
        simpa [oneSidedFourSegmentPath, hia, hja] using hij
      exact hfirst i hia j hja heq
    · by_cases hjab : j < a + b
      · have heq : first i = second (j - a) := by
          simp [oneSidedFourSegmentPath, hia, hja, hjab] at hij
          exact hij
        exact False.elim (h12 i hia (j - a) (by omega) heq)
      · by_cases hjabc : j < a + b + c
        · have heq : first i = third (j - a - b) := by
            simp [oneSidedFourSegmentPath, hia, hja, hjab, hjabc] at hij
            exact hij
          exact False.elim (h13 i hia (j - a - b) (by omega) heq)
        · have heq : first i = fourth (a + 2 * b + c - j) := by
            simp [oneSidedFourSegmentPath, hia, hja, hjab, hjabc] at hij
            exact hij
          exact False.elim (h14 i hia (a + 2 * b + c - j)
            (by omega) (by omega) heq)
  · by_cases hiab : i < a + b
    · by_cases hja : j < a
      · have heq : first j = second (i - a) := by
          simp [oneSidedFourSegmentPath, hia, hiab, hja] at hij
          exact hij.symm
        exact False.elim (h12 j hja (i - a) (by omega) heq)
      · by_cases hjab : j < a + b
        · have heq : second (i - a) = second (j - a) := by
            simp [oneSidedFourSegmentPath, hia, hiab, hja, hjab] at hij
            exact hij
          have hsub := hsecond (i - a) (by omega) (j - a) (by omega) heq
          omega
        · by_cases hjabc : j < a + b + c
          · have heq : second (i - a) = third (j - a - b) := by
              simp [oneSidedFourSegmentPath, hia, hiab, hja, hjab, hjabc] at hij
              exact hij
            exact False.elim (h23 (i - a) (by omega) (j - a - b) (by omega) heq)
          · have heq : second (i - a) = fourth (a + 2 * b + c - j) := by
              simp [oneSidedFourSegmentPath, hia, hiab, hja, hjab, hjabc] at hij
              exact hij
            exact False.elim (h24 (i - a) (by omega) (a + 2 * b + c - j)
              (by omega) (by omega) heq)
    · by_cases hiabc : i < a + b + c
      · by_cases hja : j < a
        · have heq : first j = third (i - a - b) := by
            simp [oneSidedFourSegmentPath, hia, hiab, hiabc, hja] at hij
            exact hij.symm
          exact False.elim (h13 j hja (i - a - b) (by omega) heq)
        · by_cases hjab : j < a + b
          · have heq : second (j - a) = third (i - a - b) := by
              simp [oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab] at hij
              exact hij.symm
            exact False.elim (h23 (j - a) (by omega) (i - a - b) (by omega) heq)
          · by_cases hjabc : j < a + b + c
            · have heq : third (i - a - b) = third (j - a - b) := by
                simp [oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab, hjabc] at hij
                exact hij
              have hsub := hthird (i - a - b) (by omega) (j - a - b) (by omega) heq
              omega
            · have heq : third (i - a - b) = fourth (a + 2 * b + c - j) := by
                simp [oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab, hjabc] at hij
                exact hij
              exact False.elim (h34 (i - a - b) (by omega)
                (a + 2 * b + c - j) (by omega) (by omega) heq)
      · by_cases hja : j < a
        · have heq : first j = fourth (a + 2 * b + c - i) := by
            simp [oneSidedFourSegmentPath, hia, hiab, hiabc, hja] at hij
            exact hij.symm
          exact False.elim (h14 j hja (a + 2 * b + c - i)
            (by omega) (by omega) heq)
        · by_cases hjab : j < a + b
          · have heq : second (j - a) = fourth (a + 2 * b + c - i) := by
              simp [oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab] at hij
              exact hij.symm
            exact False.elim (h24 (j - a) (by omega) (a + 2 * b + c - i)
              (by omega) (by omega) heq)
          · by_cases hjabc : j < a + b + c
            · have heq : third (j - a - b) = fourth (a + 2 * b + c - i) := by
                simp [oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab, hjabc] at hij
                exact hij.symm
              exact False.elim (h34 (j - a - b) (by omega)
                (a + 2 * b + c - i) (by omega) (by omega) heq)
            · have heq : fourth (a + 2 * b + c - i) =
                  fourth (a + 2 * b + c - j) := by
                simp [oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab, hjabc] at hij
                exact hij
              have hsub := hfourth (a + 2 * b + c - i) (by omega) (by omega)
                (a + 2 * b + c - j) (by omega) (by omega) heq
              omega

end Ising2DLambda.NecSuf.KacWard
