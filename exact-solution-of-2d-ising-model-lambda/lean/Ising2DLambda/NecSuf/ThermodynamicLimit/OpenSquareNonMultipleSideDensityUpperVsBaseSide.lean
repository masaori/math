/-
「倍数でない辺の密度の基準辺の密度による上からの評価（q は 1 以下）」の必要十分版。

具体版の本体が使うのは、関係 `le` の (1) 推移律、(2) 右から同じ元を足しても保たれること、
(3) 加法の交換則、だけである。上からの評価 `ψ ≤ B + C` と末尾の項の比較 `C ≤ C'` から
`ψ ≤ B + C'` を得る。係数・有理数倍・`Λ_ℚ`・符号は本体には入らない（それらは具体版の準備であり、
`C ≤ C'` の形で受け取る）。交換則が要るのは、右加法の単調性を末尾の項へ当てるためである。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [AddCommMagma X]

/-- 上からの評価の末尾の項を、比較で取り替える。 -/
theorem upper_bound_enlarge_last_term_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (ψ B C C' : X) (hup : le ψ (B + C)) (hC : le C C') :
    le ψ (B + C') := by
  have h := hadd B hC
  rw [add_comm C B, add_comm C' B] at h
  exact htrans hup h

end Ising2DLambda.NecSuf.ThermodynamicLimit
