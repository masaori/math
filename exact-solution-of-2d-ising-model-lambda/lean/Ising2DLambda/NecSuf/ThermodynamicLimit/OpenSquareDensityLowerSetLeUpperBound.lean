/-
「開境界正方形の密度の下組の元は密度の上からの評価以下である」の必要十分版。

具体版が使うのは、(1) 関係 `le` の推移律、(2) 右から同じ元を足しても保たれること（加法単調性）、
(3) 単位元 `0 + x = x`、(4) 加法の交換則 `x + y = y + x`、(5) 列の項が添字 1 以上で上界 `B` 以下であること、
だけである。加法は `Add X` で足り（結合則・逆元は使わない）、`Zero X` は `0 ≤ ε` と単位元を述べる名前として要る。
順序の線形性・有理数倍・`Λ_ℚ` は使わない。証人の `ε ≠ 0` も使わない。
証明手順は具体版と同じ（証人 ε, N を取り、L := N で読み、単位元・加法単調性・交換則・証人の性質・上界を推移律で結ぶ）。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupSequenceLowerSet
import Mathlib.Order.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [Add X] [Zero X]

/-- 下組の元は、添字 1 以上での列の上界 `B` 以下である。 -/
theorem le_bound_of_mem_lowerSetOfSequence_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (hzero_add : ∀ x : X, 0 + x = x)
    (hcomm : ∀ x y : X, x + y = y + x)
    (l : ℕ → X) (B : X) (hB : ∀ L : ℕ, 1 ≤ L → le (l L) B)
    {μ : X} (hμ : μ ∈ lowerSetOfSequence le l) : le μ B := by
  obtain ⟨ε, hε0, _, N, hN1, hN⟩ := hμ
  -- 一段目・二段目: μ = 0 + μ ≤ ε + μ
  have h12 : le μ (ε + μ) := by
    have h := hadd μ hε0
    rwa [hzero_add] at h
  -- 三段目: ε + μ = μ + ε
  rw [hcomm ε μ] at h12
  -- 四段目: μ + ε ≤ l N（証人の性質を L := N で読む）
  have h4 : le (μ + ε) (l N) := hN N (Nat.le_refl N)
  -- 五段目: l N ≤ B（N ≥ 1）
  have h5 : le (l N) B := hB N hN1
  exact htrans (htrans h12 h4) h5

end Ising2DLambda.NecSuf.ThermodynamicLimit
