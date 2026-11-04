/-
# 実数の族の最大値は一つしかない（具体版を必要十分版から導く）

具体版 `DefinitionMaximumValueOfRealFamily.lean` の `maximum_value_of_real_family_is_unique` の主張を、必要十分版
`Ising2D/NecSuf/MaximumValueOfFamilyIsUnique.lean` の `NecSuf.maximum_value_of_family_is_unique'` の `α := ℝ`
（反対称律は `le_antisymm`）の特殊化として得る。人手のラベルは `maximum_value_of_real_family_is_unique`。
具体版の `IsMaxValueOfRealFamily` と必要十分版の `IsMaxValueOfFamily'` は、`α := ℝ` で定義が一致する（`Iff.rfl`）。
-/
import Ising2D.NecSuf.MaximumValueOfFamilyIsUnique
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.DefinitionMaximumValueOfRealFamily

namespace Ising2D

/-- 具体版の最大値の定義は、必要十分版の定義の `α := ℝ` の場合である。 -/
theorem isMaxValueOfRealFamily_iff_necSuf {S : Type*} (x : S → ℝ) (m : ℝ) :
    IsMaxValueOfRealFamily x m ↔ NecSuf.IsMaxValueOfFamily' x m :=
  Iff.rfl

/-- `maximum_value_of_real_family_is_unique` を `NecSuf.maximum_value_of_family_is_unique'`（`α := ℝ`）の特殊化として得る。 -/
theorem maximum_value_of_real_family_is_unique_of_necSuf {S : Type*} (x : S → ℝ) {m m' : ℝ}
    (hm : IsMaxValueOfRealFamily x m) (hm' : IsMaxValueOfRealFamily x m') : m = m' :=
  NecSuf.maximum_value_of_family_is_unique' (fun a b h1 h2 => le_antisymm h1 h2) x
    ((isMaxValueOfRealFamily_iff_necSuf x m).1 hm) ((isMaxValueOfRealFamily_iff_necSuf x m').1 hm')

end Ising2D
