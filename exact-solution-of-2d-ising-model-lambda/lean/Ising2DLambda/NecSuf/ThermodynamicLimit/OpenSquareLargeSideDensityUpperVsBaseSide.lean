/-
「基準辺の平方以上の辺の密度の基準辺の密度による一様な上からの評価（q は 1 以下）」の必要十分版。

具体版の本体が使うのは、関係 `le` の (1) 推移律、(2) 右から同じ元を足しても保たれること、
(3) 加法の交換則、だけである。上端 `ψ ≤ (A + B) + Ψ` と、最初の二つの項の比較 `A ≤ A'`、`B ≤ B'` から
`ψ ≤ (A' + B') + Ψ` を得る。結合則・単位元・係数・有理数倍・`Λ_ℚ`・符号は本体には入らない
（それらは具体版の準備であり、`A ≤ A'`、`B ≤ B'` の形で受け取る）。
`AddCommMagma` で足りる（結合則を使わないので `AddCommSemigroup` も要らない）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [AddCommMagma X]

/-- 上端の最初の二つの項をそれぞれ大きくする。 -/
theorem upper_bound_enlarge_first_two_terms_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (ψ A A' B B' Ψ : X)
    (hup : le ψ (A + B + Ψ)) (hA : le A A') (hB : le B B') :
    le ψ (A' + B' + Ψ) := by
  -- (1) A ≤ A' に B を足し、さらに Ψ を足す
  have h1 : le (A + B + Ψ) (A' + B + Ψ) := hadd Ψ (hadd B hA)
  -- (2) B ≤ B' に A' を足し（交換則で先頭へ寄せる）、さらに Ψ を足す
  have h2' := hadd A' hB
  rw [add_comm B A', add_comm B' A'] at h2'
  have h2 : le (A' + B + Ψ) (A' + B' + Ψ) := hadd Ψ h2'
  exact htrans hup (htrans h1 h2)

end Ising2DLambda.NecSuf.ThermodynamicLimit
