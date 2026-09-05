/-
固有空間たちが全体を張る段の必要十分版。
像の所属、固定スカラー倍による所属の保存、規格化した像の和による復元だけを使う。
加法群や体の公理はこの合成段では使わず、それぞれの入力補題が担う。
-/
import Mathlib.Data.Set.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 射影像を規格化して、指定集合に属し元を復元する族を構成する。 -/
theorem finite_family_spans_necSuf
    {ι V : Type*} (E : ι → Set V) (sum : (ι → V) → V) (v : V)
    (projector : ι → V) (scale : V → V)
    (hprojector : ∀ i, projector i ∈ E i)
    (hscale : ∀ i x, x ∈ E i → scale x ∈ E i)
    (hreconstruct : sum (fun i => scale (projector i)) = v) :
    ∃ w : ι → V, (∀ i, w i ∈ E i) ∧ sum w = v := by
  let u : ι → V := fun i => scale (projector i)
  refine ⟨u, ?_, ?_⟩
  · intro i
    exact hscale i (projector i) (hprojector i)
  · exact hreconstruct

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
