/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版に α := RowConfig L、s := O を代入すると、具体版の定義と 3 主張が出る。
代入する仮定は `a ∈ O` と `b ∈ O` の 2 つだけである。

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・`O` が軌道であること・行配位の上の順序 ≺・型の有限性。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTransposition
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTransposition

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の `orbitTransposition` が、必要十分版の `transpositionOn` の特殊化であること。

`rfl` ではなく各点の等式として述べる（具体版の定義が `noncomputable` で置かれており、
決定可能性の実例が別々に選ばれうるため）。 -/
theorem orbitTransposition_eq_necSuf (a b τ : RowConfig L) :
    orbitTransposition L a b τ = NecSuf.AlgebraicEigenvalue.transpositionOn a b τ := by
  unfold orbitTransposition NecSuf.AlgebraicEigenvalue.transpositionOn
  by_cases hτa : τ = a
  · simp [hτa]
  · by_cases hτb : τ = b
    · simp [hτa, hτb]
    · simp [hτa, hτb]

/-- 第一の主張を、必要十分版から導いたもの。 -/
theorem orbitTransposition_involutive_from_necSuf (a b τ : RowConfig L) :
    orbitTransposition L a b (orbitTransposition L a b τ) = τ := by
  rw [orbitTransposition_eq_necSuf, orbitTransposition_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.transpositionOn_involutive a b τ

/-- 第二の主張を、必要十分版から導いたもの。渡す仮定は `a ∈ O` と `b ∈ O` の 2 つだけである。 -/
theorem orbitTransposition_mem_from_necSuf {O : Finset (RowConfig L)} {a b : RowConfig L}
    (ha : a ∈ O) (hb : b ∈ O) {τ : RowConfig L} (hτ : τ ∈ O) :
    orbitTransposition L a b τ ∈ O := by
  rw [orbitTransposition_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.transpositionOn_mem ha hb hτ

/-- 第三の主張を、必要十分版から導いたもの（値が具体版の制限と一致すること）。 -/
theorem orbitTranspositionRestriction_eq_necSuf (O : Finset (RowConfig L))
    {a b : RowConfig L} (ha : a ∈ O) (hb : b ∈ O) (τ : {τ : RowConfig L // τ ∈ O}) :
    (orbitTranspositionRestriction O ha hb τ).1
      = (NecSuf.AlgebraicEigenvalue.transpositionOnRestriction ha hb τ).1 :=
  orbitTransposition_eq_necSuf a b τ.1

end Ising2DLambda.AlgebraicEigenvalue
