/-
固有空間たちが全体を張る段の必要十分版。
この組み立てが使うのは、候補の各項が指定集合に属することと、その有限和が元へ戻ることだけである。
-/
import Mathlib.Data.Set.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 所属する候補と復元等式があれば、求める族が存在する。 -/
theorem finite_family_spans_necSuf
    {ι V : Type*} (E : ι → Set V) (sum : (ι → V) → V) (v : V)
    (u : ι → V) (hu : ∀ i, u i ∈ E i) (hreconstruct : sum u = v) :
    ∃ w : ι → V, (∀ i, w i ∈ E i) ∧ sum w = v := by
  exact ⟨u, hu, hreconstruct⟩

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
