/-
人手証明の定義「代数的数の部分体の正錐」（ラベル `def_subfield_positive_cone`）と
「部分体の正錐の延長」（ラベル `def_positive_cone_extension`）の具体版。

部分体は Qbar の部分体、正錐は Qbar の部分集合として、本文の条件をそのまま並べる。
住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.RealClosedSubfield

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `def_subfield_positive_cone` の具体版。本文の四条件（`F` に含まれること、和で閉じること、
積で閉じること、`F` の各元についての三分法）をそのまま並べる。 -/
structure IsSubfieldPositiveCone (F : Subfield Qbar) (C : Set Qbar) : Prop where
  subset : ∀ z : Qbar, z ∈ C → z ∈ F
  add_mem : ∀ a b : Qbar, a ∈ C → b ∈ C → a + b ∈ C
  mul_mem : ∀ a b : Qbar, a ∈ C → b ∈ C → a * b ∈ C
  trichotomy : ∀ z : Qbar, z ∈ F → ExactlyOneOfThree (z = 0) (z ∈ C) (-z ∈ C)

/-- `def_positive_cone_extension` の具体版。`F ⊆ E` の部分体と、それぞれの正錐
`CF`・`CE` について、`CE` と `F` の共通部分が `CF` に等しいこと。 -/
structure ExtendsPositiveCone (F E : Subfield Qbar) (CF CE : Set Qbar) : Prop where
  subfield_le : ∀ z : Qbar, z ∈ F → z ∈ E
  cone_F : IsSubfieldPositiveCone F CF
  cone_E : IsSubfieldPositiveCone E CE
  inter_eq : ∀ z : Qbar, (z ∈ CE ∧ z ∈ F) ↔ z ∈ CF

end Ising2DLambda.FisherZero
