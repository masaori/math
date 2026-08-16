/-
「倍数辺の部分正方形による密度の挟み込みの誤差評価（q は 1 以下）」の必要十分版。

具体版の本体が使うのは、関係 `le` の (1) 推移律、(2) 右から同じ元を足しても保たれること、
(3) 加法の交換則（第二項へ (2) を当てるために当てる項を先頭へ寄せる）だけである。
両側の挟み込み `A' + C ≤ ψ ≤ B1 + B2 + C` と、項ごとの比較 `A ≤ A'`、`B1 ≤ B1'`、`B2 ≤ B2'` から
`A + C ≤ ψ ≤ B1' + B2' + C` を得る。係数・有理数倍・`Λ_ℚ`・共通分母・符号は本体には入らない
（それらは具体版の準備であり、`A ≤ A'` 等の形で受け取る）。加法の結合則は要らない
（`B1 + B2 + C` は `(B1 + B2) + C` の形のまま二回右から足す）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [AddCommMagma X]

/-- 両側の挟み込みの外側の項を、項ごとの比較で取り替える。 -/
theorem twoSided_bounds_enlarge_coefficients_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (A A' C ψ B1 B1' B2 B2' : X)
    (hlow : le (A' + C) ψ) (hup : le ψ (B1 + B2 + C))
    (hA : le A A') (hB1 : le B1 B1') (hB2 : le B2 B2') :
    le (A + C) ψ ∧ le ψ (B1' + B2' + C) := by
  refine ⟨?_, ?_⟩
  · -- 左: 加法単調性で第一項を取り替え、推移律
    exact htrans (hadd C hA) hlow
  · -- 右: 第一項を二回右から足して取り替え、交換則で第二項を先頭へ寄せて同じく取り替え、推移律
    have hmid1 : le (B1 + B2 + C) (B1' + B2 + C) := hadd C (hadd B2 hB1)
    have hmid2 : le (B1' + B2 + C) (B1' + B2' + C) := by
      rw [add_comm B1' B2, add_comm B1' B2']
      exact hadd C (hadd B1' hB2)
    exact htrans hup (htrans hmid1 hmid2)

end Ising2DLambda.NecSuf.ThermodynamicLimit
