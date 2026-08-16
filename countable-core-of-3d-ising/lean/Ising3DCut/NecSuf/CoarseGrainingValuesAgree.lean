import Mathlib.Logic.Function.Basic

/-!
人手証明「粗視化の値の一致から $Z_L$ の等式へ」の Lean 必要十分版。

具体版が使ったのは「$\varepsilon_{L,q}=\mathrm{ev}_q\circ\kappa_L$」という合成の等式と
「$\kappa_L(\mathcal Z_L)=Z_L$」という一点での値だけであり、環構造・多項式環・
有理数は使っていない。したがって主張は任意の型の間の写像の合成として述べられる。
-/

namespace Ising3DCut.NecSuf

variable {C A B : Type*}

/-- 合成 `e = v ∘ κ` と `κ z = Z` から `e z = v Z`。 -/
theorem apply_eq_of_eq_comp (e : C → B) (v : A → B) (κ : C → A) (h : e = v ∘ κ)
    (z : C) (Z : A) (hz : κ z = Z) : e z = v Z := by
  rw [h, Function.comp_apply, hz]

/-- 二つの写像 `e₁ = v₁ ∘ κ`, `e₂ = v₂ ∘ κ` の `z` での値が一致すれば、
`v₁`, `v₂` の `Z = κ z` での値が一致する。 -/
theorem values_eq_of_comp_values_eq (e₁ e₂ : C → B) (v₁ v₂ : A → B) (κ : C → A)
    (h₁ : e₁ = v₁ ∘ κ) (h₂ : e₂ = v₂ ∘ κ) (z : C) (Z : A) (hz : κ z = Z)
    (h : e₁ z = e₂ z) : v₁ Z = v₂ Z := by
  rw [← apply_eq_of_eq_comp e₁ v₁ κ h₁ z Z hz, ← apply_eq_of_eq_comp e₂ v₂ κ h₂ z Z hz]
  exact h

end Ising3DCut.NecSuf
