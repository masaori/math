/-
# 族の最大値は一つしかない（**必要十分版**）

対応する人手証明のラベル: `maximum_value_of_real_family_is_unique`（`structured-latex/content/000_calculation_formulae_00_09.ts`）。
具体版は `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/DefinitionMaximumValueOfRealFamily.lean` の
`maximum_value_of_real_family_is_unique`、特殊化は同じフォルダの `DefinitionMaximumValueOfRealFamilyFromNecSuf.lean`。

## 効いているもの / 効いていないもの

具体版と同じ手順（`m = x_{i₀} ≤ m'`、`m' = x_{i₀'} ≤ m` の 2 本の鎖と、反対称律の 1 段）のまま、値の集合を
関係 `≤` だけを持つ `α` に上げる。

- 関係 `≤`（`LE`）: 最大値の定義の (2) を述べるため。
- 反対称律（明示の仮定 `hanti`）: 人手の「ℝ の順序の反対称律」の段。これを外すと、`m ≤ m'` と `m' ≤ m` から
  `m = m'` が出ない（例えば全ての元どうしが `≤` で結ばれる関係では、全ての値が最大値になる）。

効いていないもの: 反射律、推移律（2 本の鎖は等号と `≤` を 1 回ずつつなぐだけで、`≤` を 2 回つながない）、
順序が全順序であること、和・積との両立、完備性、実数であること、添字の集合が有限であること・空でないこと。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- 族 `x` の最大値（人手 `def_maximum_value_of_real_family` を関係 `≤` だけを持つ `α` で述べたもの）。 -/
def IsMaxValueOfFamily' {S α : Type*} [LE α] (x : S → α) (m : α) : Prop :=
  (∃ i₀ : S, x i₀ = m) ∧ ∀ i : S, x i ≤ m

/-- **人手 `maximum_value_of_real_family_is_unique` の核**: `≤` が反対称なら、族の最大値は一つしかない。 -/
theorem maximum_value_of_family_is_unique' {S α : Type*} [LE α]
    (hanti : ∀ a b : α, a ≤ b → b ≤ a → a = b) (x : S → α) {m m' : α}
    (hm : IsMaxValueOfFamily' x m) (hm' : IsMaxValueOfFamily' x m') : m = m' := by
  obtain ⟨i₀, hi₀⟩ := hm.1
  obtain ⟨i₀', hi₀'⟩ := hm'.1
  have h1 : m ≤ m' :=
    calc m = x i₀ := hi₀.symm                     -- `i₀` の取り方
      _ ≤ m' := hm'.2 i₀                          -- `m'` について定義の (2) を `i = i₀` で使う
  have h2 : m' ≤ m :=
    calc m' = x i₀' := hi₀'.symm                  -- `i₀'` の取り方
      _ ≤ m := hm.2 i₀'                           -- `m` について定義の (2) を `i = i₀'` で使う
  exact hanti m m' h1 h2                          -- 反対称律

end Ising2D.NecSuf
