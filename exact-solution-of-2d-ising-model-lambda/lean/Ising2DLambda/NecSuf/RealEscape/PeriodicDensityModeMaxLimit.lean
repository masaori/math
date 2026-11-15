import Mathlib

/-!
「周期境界の自由エネルギー密度は分散因子の積分に等しい」（`theorem_periodic_density_onsager_integral`）のうち、
四つのモード和の最大値を `M^abs` の実対数と同定し、各成分の共通極限から最大値の極限を得る段の必要十分版。

具体版 `Ising2DLambda.RealEscape.tendsto_scaledLogAbsMax_of_modeLimits` と同じ手順で示す:
各 `L ≥ 1` で、最大値は成分のどれか一つの値なので、`P_L` の上で単調な `φ_L` と最大値は入れ替わる
（`φ_L(a_{L,s}) ≤ φ_L(max a_L)` と、最大値を与える成分 `s₀` での `φ_L(max a_L) = φ_L(a_{L,s₀}) ≤ max φ_L(a_L)`）。
有限集合上の最大値は各成分の共通極限へ収束し、`L ≥ 1` で `w_L` と一致するので `w_L → I`。

使うのは次だけである。
* 添字集合 `A` は空でない有限集合（最大値が成分のどれか一つの値であることに使う）。
  具体版では四元集合 `𝒮` だが、元の個数は使わない。
* 成分の値の集合 `α` と行き先 `β` は線型順序（最大値を取るため）。`α` の演算は使わない。
* `φ_L` は成分の値を含む集合 `P_L` の上で単調（`hmono`、`hP`）。具体版では `P_L = ℚ_{>0}`、
  `φ_L(x) = L^{-2} log_ℝ ι(x)` で、被対数が正であること（`hP`）が実対数の単調性を使える条件になる。
  狭義単調性・連続性は使わない。
* `β` の位相は順序位相（最大値の連続性に使う）。実数であること・完備性は使わない。

住処: 一般の線型順序。実数体への脱出: 具体版では実対数と実数列の極限。
-/

namespace Ising2DLambda.NecSuf.RealEscape

open Filter Topology

/-- 必要十分版: 成分の値を含む集合の上で単調な写像は、空でない有限集合上の最大値と入れ替わる。 -/
theorem sup'_comp_eq_of_monotoneOn_necSuf {S α β : Type*} [LinearOrder α] [LinearOrder β]
    (A : Finset S) (hA : A.Nonempty) (a : S → α) (P : Set α) (φ : α → β)
    (hP : ∀ s ∈ A, a s ∈ P) (hmono : MonotoneOn φ P) :
    A.sup' hA (fun s => φ (a s)) = φ (A.sup' hA a) := by
  -- 最大値は成分のどれか一つの値
  obtain ⟨s₀, hs₀A, hs₀⟩ := Finset.exists_mem_eq_sup' hA a
  apply le_antisymm
  · -- 各成分: a_s ≤ max a、単調性
    refine Finset.sup'_le _ _ (fun s hs => ?_)
    rw [hs₀]
    exact hmono (hP s hs) (hP s₀ hs₀A) (hs₀ ▸ Finset.le_sup' a hs)
  · -- φ(max a) = φ(a_{s₀}) ≤ max φ(a)
    rw [hs₀]
    exact Finset.le_sup' (fun s => φ (a s)) hs₀A

/-- 必要十分版: `L ≥ 1` で `w_L = φ_L(max a_L)`、各成分 `φ_L(a_{L,s}) → I` なら `w_L → I`。 -/
theorem tendsto_of_componentLimits_necSuf {S α β : Type*} [LinearOrder α] [LinearOrder β]
    [TopologicalSpace β] [OrderTopology β]
    (A : Finset S) (hA : A.Nonempty) (a : ℕ → S → α) (P : ℕ → Set α) (φ : ℕ → α → β)
    (w : ℕ → β) (I : β)
    (hP : ∀ L : ℕ, 1 ≤ L → ∀ s ∈ A, a L s ∈ P L)
    (hmono : ∀ L : ℕ, 1 ≤ L → MonotoneOn (φ L) (P L))
    (hw : ∀ L : ℕ, 1 ≤ L → w L = φ L (A.sup' hA (a L)))
    (hmode : ∀ s ∈ A, Tendsto (fun L => φ L (a L s)) atTop (𝓝 I)) :
    Tendsto w atTop (𝓝 I) := by
  -- 有限集合上の最大値は各成分の共通極限へ収束する
  have h := Tendsto.finset_sup'_nhds_apply (s := A) (f := fun s L => φ L (a L s))
    (g := fun _ => I) hA hmode
  rw [Finset.sup'_const] at h
  refine h.congr' (eventually_atTop.2 ⟨1, fun L hL => ?_⟩)
  -- L ≥ 1 で最大値と φ_L が入れ替わる
  rw [hw L hL]
  exact sup'_comp_eq_of_monotoneOn_necSuf A hA (a L) (P L) (φ L) (hP L hL) (hmono L hL)

end Ising2DLambda.NecSuf.RealEscape
