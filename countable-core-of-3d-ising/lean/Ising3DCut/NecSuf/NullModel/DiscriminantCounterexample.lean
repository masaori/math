/-
「判別式だけでは多項式を決めない」の必要十分版。

具体版の証明で使う性質だけを残す。二つの対象を区別する観測、相異なる
二因子への分解を表す述語、判別式データだけを仮定する。多項式・整数・
係数公式は、これらを具体化する仕組みであって抽象版の論証には不要である。

証明順序は具体版と同じである。観測値から対象の相違を得て、二つの分解、
二つの判別式の値を並べ、同じ判別式を持つという結論を得る。
-/
import Mathlib

namespace Ising3DCut.NecSuf.NullModel

/-- 異なる観測値を持つ二対象は相異なり、同じ判別式データを持ち得る。 -/
theorem discriminant_does_not_determine_object
    {Object Observation Discriminant : Type*}
    (A B : Object)
    (observe : Object → Observation)
    (factorsIntoDistinctParts : Object → Prop)
    (discriminant : Object → Discriminant)
    (hobserve : observe A ≠ observe B)
    (hfactorA : factorsIntoDistinctParts A)
    (hfactorB : factorsIntoDistinctParts B)
    (hdiscriminant : discriminant A = discriminant B) :
    A ≠ B ∧
      factorsIntoDistinctParts A ∧
      factorsIntoDistinctParts B ∧
      discriminant A = discriminant B := by
  refine ⟨?_, hfactorA, hfactorB, hdiscriminant⟩
  intro h
  exact hobserve (congrArg observe h)

end Ising3DCut.NecSuf.NullModel
