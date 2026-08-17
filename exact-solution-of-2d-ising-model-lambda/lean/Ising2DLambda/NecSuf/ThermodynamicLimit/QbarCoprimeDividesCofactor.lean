/-
「互いに素な一次因子の冪による整除は、もう一方の冪を落とした因子へ遺伝する」の必要十分版。

一次因子・冪・多項式環は本質でない。効いているのは
「Bezout 恒等式 `P·A + Q·B = 1` で結ばれた二元について、`B ∣ A·g` なら `B ∣ g`」
というユークリッドの補題型の事実だけであり、必要なのは可換環である。
体・多項式環・代数閉性・零因子の非存在は要らない。
-/
import Mathlib.Algebra.Ring.Basic
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

theorem coprime_divides_cofactor_necSuf {R : Type*} [CommRing R] (A B g : R)
    (hbez : ∃ P Q : R, P * A + Q * B = 1) (hdvd : B ∣ A * g) : B ∣ g := by
  obtain ⟨P, Q, hPQ⟩ := hbez
  obtain ⟨h, hh⟩ := hdvd
  refine ⟨P * h + Q * g, ?_⟩
  calc g = (P * A + Q * B) * g := by rw [hPQ, one_mul]
    _ = P * (A * g) + Q * (B * g) := by ring
    _ = P * (B * h) + Q * (B * g) := by rw [hh]
    _ = B * (P * h + Q * g) := by ring

end Ising2DLambda.NecSuf.ThermodynamicLimit
