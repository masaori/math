/-
# 実数の族の最大値と記号 max（**具体版**）

対応する人手証明のラベル: `def_maximum_value_of_real_family`, `maximum_value_of_real_family_is_unique`,
`def_max_of_real_family`（`structured-latex/content/000_calculation_formulae_00_09.ts` の
`calc_formulae_definition_maximum_value_of_real_family`, `calc_formulae_claim_maximum_value_of_real_family_is_unique`,
`calc_formulae_definition_max_of_real_family`）。

## 人手証明との対応

* 人手の集合 `S` と族 `(x_i)_{i ∈ S}` は、Lean では型 `S` と写像 `x : S → ℝ` で書く。
* `IsMaxValueOfRealFamily x m` は人手の定義の (1)（`∃ i₀, x i₀ = m`）と (2)（`∀ i, x i ≤ m`）の連言である。
* `maximum_value_of_real_family_is_unique` は人手の 2 本の 2 行の鎖（`m = x_{i₀} ≤ m'`・`m' = x_{i₀'} ≤ m`）と
  反対称律の 1 段（`le_antisymm`）である。
* `maxOfRealFamily x h` は、最大値の存在 `h` から最大値を一つ取り出したもの（`Classical.choose`）で、人手の記号
  `max_{i ∈ S} x_i` に当たる。人手の「最大値は一つしかないので、この記号は一つの実数を指す」は
  `maxOfRealFamily_eq`（取り出した値は、どの最大値とも等しい）である。

**必要十分版**: `maximum_value_of_real_family_is_unique` は `Ising2D/NecSuf/MaximumValueOfFamilyIsUnique.lean`
（関係 `≤` と反対称律だけ。反射律・推移律・全順序性・実数であることは効かない）。具体版をその系として導くのは
`DefinitionMaximumValueOfRealFamilyFromNecSuf.lean`。2 つの定義は計算を含まないので、必要十分版の定義
`NecSuf.IsMaxValueOfFamily'` を添えるだけにする。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `def_maximum_value_of_real_family`**: `m` は族 `x` の最大値である。 -/
def IsMaxValueOfRealFamily {S : Type*} (x : S → ℝ) (m : ℝ) : Prop :=
  (∃ i₀ : S, x i₀ = m) ∧ ∀ i : S, x i ≤ m

/-- **人手 `maximum_value_of_real_family_is_unique`**: 族の最大値は一つしかない。 -/
theorem maximum_value_of_real_family_is_unique {S : Type*} (x : S → ℝ) {m m' : ℝ}
    (hm : IsMaxValueOfRealFamily x m) (hm' : IsMaxValueOfRealFamily x m') : m = m' := by
  obtain ⟨i₀, hi₀⟩ := hm.1
  obtain ⟨i₀', hi₀'⟩ := hm'.1
  have h1 : m ≤ m' :=
    calc m = x i₀ := hi₀.symm                     -- `i₀` の取り方
      _ ≤ m' := hm'.2 i₀                          -- `m'` について定義の (2) を `i = i₀` で使う
  have h2 : m' ≤ m :=
    calc m' = x i₀' := hi₀'.symm                  -- `i₀'` の取り方
      _ ≤ m := hm.2 i₀'                           -- `m` について定義の (2) を `i = i₀'` で使う
  exact le_antisymm h1 h2                         -- `ℝ` の順序の反対称律

/-- **人手 `def_max_of_real_family`**: 最大値をもつ族の最大値 `max_{i ∈ S} x_i`。 -/
noncomputable def maxOfRealFamily {S : Type*} (x : S → ℝ) (h : ∃ m, IsMaxValueOfRealFamily x m) : ℝ :=
  Classical.choose h

/-- **人手 `def_max_of_real_family`** の「この記号は一つの実数を指す」:
`max_{i ∈ S} x_i` は、族のどの最大値とも等しい（`maximum_value_of_real_family_is_unique`）。 -/
theorem maxOfRealFamily_eq {S : Type*} (x : S → ℝ) (h : ∃ m, IsMaxValueOfRealFamily x m) {m : ℝ}
    (hm : IsMaxValueOfRealFamily x m) : maxOfRealFamily x h = m :=
  maximum_value_of_real_family_is_unique x (Classical.choose_spec h) hm

end Ising2D
