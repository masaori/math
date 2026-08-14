/-
具体版が必要十分版の特殊化として得られることの明示。

辺の有限型を有限二部後続系の辺、二つの端点写像を `endpoint0` / `endpoint1`、
二色塗り分けを系の `color`、値の反転を整数 ±1 の符号反転に取る。
具体版で使った符号反転の三性質（対合、反転後の不一致と反転前の一致の同値の両向き）だけを
必要十分版へ渡す。後続写像とその単射性は渡さない（必要十分版が要求しないため）。

住処: 有限型、`Finset`、`Nat`、`Bool`、整数 ±1 のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.StructuralCore.BipartiteSuccessorPalindrome
import Ising3DCut.NecSuf.StructuralCore.BipartiteSuccessorPalindrome

namespace Ising3DCut.StructuralCore

open Ising3DCut.NullModel

variable {V I : Type} [Fintype V] [Fintype I] [DecidableEq V] [DecidableEq I]

/-- `claim_structural_palindrome` の具体版を必要十分版から導いたもの。 -/
theorem multiplicity_palindrome_from_necSuf (S : BipartiteSuccessorSystem V I)
    {m : ℕ} (h : m ≤ Fintype.card (StructuralEdge S)) :
    multiplicity S m = multiplicity S (Fintype.card (StructuralEdge S) - m) := by
  exact NecSuf.StructuralCore.multiplicity_palindrome
    (endpoint0 S) (endpoint1 S) S.color negSpin
    (fun e => S.color_diff e.1.2 e.1.1 e.2)
    negSpin_negSpin negSpin_ne_iff_eq ne_negSpin_iff_eq h

end Ising3DCut.StructuralCore
