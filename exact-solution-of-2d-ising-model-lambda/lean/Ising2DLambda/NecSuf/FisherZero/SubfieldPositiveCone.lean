/-
「代数的数の部分体の正錐」「部分体の正錐の延長」の必要十分版。

定義が実際に使うのは、零元・加法・乗法・符号反転と、部分集合への所属だけである。
台が体であること、`F` が部分体であること（和・積・逆元で閉じること）、代数閉性、
可算性は、定義を述べるのに要らない。部分体であることは、正錐を使う主張の側の仮定である。
-/
import Mathlib.Data.Set.Basic

namespace Ising2DLambda.NecSuf.FisherZero

/-- 零元・加法・乗法・符号反転を持つ型の部分集合 `F` の上の正錐。 -/
structure IsPositiveConeOn {K : Type} [Zero K] [Add K] [Mul K] [Neg K]
    (F C : Set K) : Prop where
  subset : ∀ z : K, z ∈ C → z ∈ F
  add_mem : ∀ a b : K, a ∈ C → b ∈ C → a + b ∈ C
  mul_mem : ∀ a b : K, a ∈ C → b ∈ C → a * b ∈ C
  trichotomy : ∀ z : K, z ∈ F →
    ((z = 0 ∨ z ∈ C ∨ -z ∈ C) ∧ ¬(z = 0 ∧ z ∈ C) ∧ ¬(z = 0 ∧ -z ∈ C) ∧
      ¬(z ∈ C ∧ -z ∈ C))

/-- 部分集合 `F ⊆ E` の上の正錐 `CF`・`CE` について、`CE` と `F` の共通部分が `CF` であること。 -/
structure ExtendsPositiveConeOn {K : Type} [Zero K] [Add K] [Mul K] [Neg K]
    (F E CF CE : Set K) : Prop where
  subset_le : ∀ z : K, z ∈ F → z ∈ E
  cone_F : IsPositiveConeOn F CF
  cone_E : IsPositiveConeOn E CE
  inter_eq : ∀ z : K, (z ∈ CE ∧ z ∈ F) ↔ z ∈ CF

end Ising2DLambda.NecSuf.FisherZero
