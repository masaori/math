/-
「非正の元の有理数倍は係数の大小で比較できる（向きが逆）」の必要十分版。

具体版が使うのは `smul_le_smul_of_le_of_nonneg_necSuf`（非負の元の版）と同じで、
係数の住処 `K` について `r ≤ s` から `0 ≤ s − r`（順序付き加法群。`sub_nonneg`）と
`(s − r) + r = s`（加法群）、元の住処 `X` について作用が零を零へ送り（`smul_zero`）、
係数の加法に分配し（`add_smul`）、零が加法の単位元であること（`zero_add`）、そして関係 `le` について
(1) 非負係数の作用が `le` を保つこと、(2) 右から同じ元を足しても `le` が保たれること、だけである。
違いは (1) を `λ := ν`、`μ := 0` の向きで読む点だけで、仮定は一つも増えない。
`le` の推移律・反射律・反対称性、`Λ_ℚ` や共通分母の中身は使わない。
-/
import Mathlib.Algebra.Order.Group.Defs
import Mathlib.Algebra.Module.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {K X : Type*} [Ring K] [PartialOrder K] [IsOrderedAddMonoid K]
  [AddCommGroup X] [Module K X]

/-- 非正の元 `ν`（`le ν 0`）について、係数 `r ≤ s` から `le (s • ν) (r • ν)`。 -/
theorem smul_le_smul_of_le_of_nonpos_necSuf (le : X → X → Prop)
    (hsmul : ∀ (c : K), 0 ≤ c → ∀ x y : X, le x y → le (c • x) (c • y))
    (hadd : ∀ x y z : X, le x y → le (x + z) (y + z))
    {r s : K} (hrs : r ≤ s) {ν : X} (hν : le ν 0) :
    le (s • ν) (r • ν) := by
  -- c := s − r、0 ≤ c
  have hc : 0 ≤ s - r := sub_nonneg.mpr hrs
  -- (1): c·ν ≤ c·0、そして c·0 = 0
  have h1 : le ((s - r) • ν) ((s - r) • (0 : X)) := hsmul (s - r) hc ν 0 hν
  rw [smul_zero] at h1
  -- (2): c·ν + r·ν ≤ 0 + r·ν
  have h2 := hadd ((s - r) • ν) 0 (r • ν) h1
  -- 鎖: s·ν = (c+r)·ν = c·ν + r·ν ≤ 0 + r·ν = r·ν
  rw [zero_add, ← add_smul, sub_add_cancel] at h2
  exact h2

end Ising2DLambda.NecSuf.ThermodynamicLimit
