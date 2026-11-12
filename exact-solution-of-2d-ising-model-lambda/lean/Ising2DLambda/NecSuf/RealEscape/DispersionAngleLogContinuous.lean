/-
「正の分散因子から角の対数関数の連続性を得る」の必要十分版。

具体版と同じ手順（`(q+1)(q+1) = q²+2q+1 = p+2 = 0+2 = 2` の矛盾から `p ≠ 0`、
`r²+2r−1 = j(p) ≠ 0` から `0 < (r²+2r−1)²`、`B − (r²+2r−1)²` の五行、
`2r(1−r²) > 0` と `1 − cⱼ ≥ 0` から `B ≥ (r²+2r−1)² > 0`、四則の連続性と対数の連続性の合成）を、
次の仮定だけで行う。

- `A`: 可換環（有理数体にあたる）。`2` が `A` の平方でないこと `noSquareTwo` だけを仮定する。
  順序も体であることも使わない。
- `K`: 線型順序を持つ狭義順序可換環で、四則が連続な位相を持つ（実数体にあたる）。
  線型順序は「零でない元の平方は正」で使う。体であること・完備性は使わない。
- `j : A →+* K` は単射な環準同型（`ι_{ℚ→ℝ}` にあたる）。単射性は `p ≠ 0 ⇒ j p ≠ 0` で使う。
  順序の保存は使わず、`0 < j q < 1` だけを仮定する（具体版はこれを順序の保存から得る）。
- `c₁, c₂ : X → K` は位相空間 `X` 上の連続関数で `cⱼ ≤ 1`（実余弦にあたる）。`−1 ≤ cⱼ` は使わない。
- `lg : K → K` は `K` の正の元の上で連続（実対数にあたる）。乗法を加法へ移すこと・単調性は使わない。
-/
import Mathlib.Topology.Algebra.Ring.Basic
import Mathlib.Topology.ContinuousOn
import Mathlib.Algebra.Order.Ring.Defs
import Mathlib.Tactic.Linarith

namespace Ising2DLambda.NecSuf.RealEscape

variable {A K X : Type*} [CommRing A] [CommRing K] [LinearOrder K] [IsStrictOrderedRing K]
  [TopologicalSpace K] [IsTopologicalRing K] [TopologicalSpace X]

/-- `B(x) := (1+r²)² − 2r(1−r²)(c₁(x)+c₂(x))`。 -/
def dispersionAngleArgumentNecSuf (r : K) (c₁ c₂ : X → K) (x : X) : K :=
  (1 + r ^ 2) ^ 2 - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x)

omit [LinearOrder K] [IsStrictOrderedRing K] [TopologicalSpace K] [IsTopologicalRing K]
  [TopologicalSpace X] in
/-- 五行: `B − (r²+2r−1)² = 2r(1−r²)((1−c₁)+(1−c₂))`。可換環の等式だけを使う。 -/
theorem dispersionAngleArgument_sub_lower_necSuf (r : K) (c₁ c₂ : X → K) (x : X) :
    dispersionAngleArgumentNecSuf r c₁ c₂ x - (r ^ 2 + 2 * r - 1) ^ 2 =
      2 * r * (1 - r ^ 2) * ((1 - c₁ x) + (1 - c₂ x)) := by
  calc dispersionAngleArgumentNecSuf r c₁ c₂ x - (r ^ 2 + 2 * r - 1) ^ 2
      = (1 + r ^ 2) ^ 2 - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x) - (r ^ 2 + 2 * r - 1) ^ 2 := rfl
    _ = ((1 + r ^ 2) - (r ^ 2 + 2 * r - 1)) * ((1 + r ^ 2) + (r ^ 2 + 2 * r - 1))
          - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x) := by ring
    _ = (2 - 2 * r) * (2 * r ^ 2 + 2 * r) - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x) := by ring
    _ = 4 * r * (1 - r ^ 2) - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x) := by ring
    _ = 2 * r * (1 - r ^ 2) * ((1 - c₁ x) + (1 - c₂ x)) := by ring

/-- 必要十分版の本体。`B` の正の下界 `(r²+2r−1)²`、`B` の正値性、`lg ∘ B` の連続性。 -/
theorem dispersion_angle_log_continuous_necSuf
    (noSquareTwo : ∀ s : A, s * s ≠ 2) (j : A →+* K) (hj : Function.Injective j)
    (q : A) (hr0 : 0 < j q) (hr1 : j q < 1)
    (c₁ c₂ : X → K) (hc₁ : Continuous c₁) (hc₂ : Continuous c₂)
    (hc₁1 : ∀ x, c₁ x ≤ 1) (hc₂1 : ∀ x, c₂ x ≤ 1)
    (lg : K → K) (hlg : ContinuousOn lg (Set.Ioi 0)) :
    0 < (j q ^ 2 + 2 * j q - 1) ^ 2 ∧
      (∀ x, (j q ^ 2 + 2 * j q - 1) ^ 2 ≤ dispersionAngleArgumentNecSuf (j q) c₁ c₂ x) ∧
      (∀ x, 0 < dispersionAngleArgumentNecSuf (j q) c₁ c₂ x) ∧
      Continuous (fun x => lg (dispersionAngleArgumentNecSuf (j q) c₁ c₂ x)) := by
  set r : K := j q
  -- p := q²+2q−1 ≠ 0
  have hp : q ^ 2 + 2 * q - 1 ≠ 0 := by
    intro hp0
    apply noSquareTwo (q + 1)
    calc (q + 1) * (q + 1) = q ^ 2 + 2 * q + 1 := by ring
      _ = (q ^ 2 + 2 * q - 1) + 2 := by ring
      _ = 0 + 2 := by rw [hp0]
      _ = 2 := by ring
  -- r²+2r−1 = j(p) ≠ 0（単射性）
  have hpr : r ^ 2 + 2 * r - 1 = j (q ^ 2 + 2 * q - 1) := by
    simp only [r, map_sub, map_add, map_mul, map_pow, map_one, map_ofNat]
  have hpr0 : r ^ 2 + 2 * r - 1 ≠ 0 := by
    rw [hpr]
    intro h
    exact hp (hj (h.trans (map_zero j).symm))
  -- 零でない元の平方は正（線型順序）
  have hlow : 0 < (r ^ 2 + 2 * r - 1) ^ 2 := by
    rw [sq]; exact mul_self_pos.2 hpr0
  -- 2r(1−r²) > 0
  have h1r : 0 < 1 - r ^ 2 := by
    have : 1 - r ^ 2 = (1 - r) * (1 + r) := by ring
    rw [this]
    exact mul_pos (by linarith) (by linarith)
  have hcoef : 0 < 2 * r * (1 - r ^ 2) := mul_pos (mul_pos two_pos hr0) h1r
  have hle : ∀ x, (r ^ 2 + 2 * r - 1) ^ 2 ≤ dispersionAngleArgumentNecSuf r c₁ c₂ x := by
    intro x
    have hcos : 0 ≤ (1 - c₁ x) + (1 - c₂ x) :=
      add_nonneg (sub_nonneg.2 (hc₁1 x)) (sub_nonneg.2 (hc₂1 x))
    have hdiff : 0 ≤ dispersionAngleArgumentNecSuf r c₁ c₂ x - (r ^ 2 + 2 * r - 1) ^ 2 := by
      rw [dispersionAngleArgument_sub_lower_necSuf]
      exact mul_nonneg hcoef.le hcos
    calc (r ^ 2 + 2 * r - 1) ^ 2 = 0 + (r ^ 2 + 2 * r - 1) ^ 2 := by ring
      _ ≤ (dispersionAngleArgumentNecSuf r c₁ c₂ x - (r ^ 2 + 2 * r - 1) ^ 2)
            + (r ^ 2 + 2 * r - 1) ^ 2 := add_le_add_left hdiff _
      _ = dispersionAngleArgumentNecSuf r c₁ c₂ x := by ring
  have hpos : ∀ x, 0 < dispersionAngleArgumentNecSuf r c₁ c₂ x :=
    fun x => lt_of_lt_of_le hlow (hle x)
  -- 四則の連続性から B は連続、lg の正の元の上での連続性と合成
  have hB : Continuous (fun x => dispersionAngleArgumentNecSuf r c₁ c₂ x) := by
    unfold dispersionAngleArgumentNecSuf
    exact continuous_const.sub (continuous_const.mul (hc₁.add hc₂))
  exact ⟨hlow, hle, hpos, hlg.comp_continuous hB fun x => hpos x⟩

end Ising2DLambda.NecSuf.RealEscape
