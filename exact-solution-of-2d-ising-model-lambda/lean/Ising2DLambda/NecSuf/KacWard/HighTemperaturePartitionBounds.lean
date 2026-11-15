import Ising2DLambda.NecSuf.KacWard.HighTemperatureDualBounds

/-!
「自己双対点より高温側での分配多項式の両側評価」（`claim_high_temperature_partition_bounds`）の必要十分版。

具体版 `Ising2DLambda.KacWard.highTemperaturePartitionBounds` と同じ手順で示す:
1. 各添字で `k · g i = ± f i`（符号を除いた自己双対性）と `g i > 0` から `k · g i = |f i|`、
2. `k > 0` なので `k · max g = max |f|`、
3. 符号に依存しない段 `high_temperature_dual_bounds_necSuf` の下界 `c/(d·4) · max g ≤ Z` を
   `k = c/d` で書き直して `max |f| / 4 ≤ Z`、上界はそのまま。

使うのは次だけである。
* 係数の体 `K` は線型順序体。`k = c/d` の割り算と、絶対値・最大 `sup'` に要る。
* 符号を除いた自己双対性 `c · g i = d · f i ∨ c · g i = −(d · f i)`（`hdual`）。符号の値は使わない。
* 双対点の値が正であること `0 < g i`（`hg`）。`k · g i` が正であることから絶対値を選ぶのに要る。
  `c > 0` も同じ理由で要る（`c ≥ 0` だけでは `k · g i = 0` の場合に絶対値を選べない）。
* 符号に依存しない段の仮定（`hfac`・`h01`・`h10`・`h11`・`htriv`・`hlow`・`hZ`・`hcard`）。
  `hlow` の `M` は `g` の最大である（この段で `M` を `g` の最大に固定する）。

住処: 一般の線型順序体。実数体・複素数体は現れない。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版: 各添字で `k · g i = |f i|`。 -/
theorem duality_scaled_eq_abs_necSuf {K : Type*} [Field K] [LinearOrder K]
    [IsStrictOrderedRing K] {c d gi fi : K} (hc : 0 < c) (hd : 0 < d)
    (hdual : c * gi = d * fi ∨ c * gi = -(d * fi)) (hg : 0 < gi) :
    c / d * gi = |fi| := by
  have hdne : d ≠ 0 := ne_of_gt hd
  have hlhs : 0 < c / d * gi := by positivity
  rcases hdual with h | h
  · have heq : c / d * gi = fi := by
      field_simp
      linarith
    rw [heq] at hlhs ⊢
    exact (abs_of_pos hlhs).symm
  · have heq : c / d * gi = -fi := by
      field_simp
      linarith
    rw [heq] at hlhs ⊢
    exact (abs_of_neg (neg_pos.mp hlhs)).symm

/-- 必要十分版: `k > 0` なら `k · max g = max |f|`。 -/
theorem duality_scaled_max_eq_abs_max_necSuf {K ι : Type*} [Field K] [LinearOrder K]
    [IsStrictOrderedRing K] [Fintype ι] (hne : (Finset.univ : Finset ι).Nonempty)
    (f g : ι → K) {c d : K} (hc : 0 < c) (hd : 0 < d)
    (hdual : ∀ i, c * g i = d * f i ∨ c * g i = -(d * f i)) (hg : ∀ i, 0 < g i) :
    c / d * Finset.univ.sup' hne g = Finset.univ.sup' hne (fun i => |f i|) := by
  have hk : 0 < c / d := by positivity
  apply le_antisymm
  · obtain ⟨i₀, -, hi₀⟩ := Finset.exists_mem_eq_sup' hne g
    rw [hi₀, duality_scaled_eq_abs_necSuf hc hd (hdual i₀) (hg i₀)]
    exact Finset.le_sup' (fun i => |f i|) (Finset.mem_univ i₀)
  · apply Finset.sup'_le
    intro i _
    rw [← duality_scaled_eq_abs_necSuf hc hd (hdual i) (hg i)]
    gcongr
    exact Finset.le_sup' g (Finset.mem_univ i)

/-- 必要十分版: `max |f| / 4 ≤ Z ≤ 2 max |f|`。 -/
theorem high_temperature_partition_bounds_necSuf {K ι : Type*} [Field K] [LinearOrder K]
    [IsStrictOrderedRing K] [Fintype ι] (hne : (Finset.univ : Finset ι).Nonempty)
    (hcard : Fintype.card ι = 4) (f g : ι → K) (Z Zt c d G₀₀ G₀₁ G₁₀ G₁₁ : K)
    (hd : 0 < d) (hc : 0 < c) (hfac : d * Z = c * (G₀₀ + G₀₁ + G₁₀ + G₁₁))
    (h01 : 0 ≤ G₀₁) (h10 : 0 ≤ G₁₀) (h11 : 0 ≤ G₁₁) (htriv : Zt = 2 * G₀₀)
    (hlow : Finset.univ.sup' hne g / 2 ≤ Zt) (hZ : 2 * Z = ∑ i, f i)
    (hdual : ∀ i, c * g i = d * f i ∨ c * g i = -(d * f i)) (hg : ∀ i, 0 < g i) :
    Finset.univ.sup' hne (fun i => |f i|) / 4 ≤ Z ∧
      Z ≤ 2 * Finset.univ.sup' hne (fun i => |f i|) := by
  obtain ⟨hlower, hupper⟩ := high_temperature_dual_bounds_necSuf hne hcard f Z Zt
    (Finset.univ.sup' hne g) c d G₀₀ G₀₁ G₁₀ G₁₁ hd hc.le hfac h01 h10 h11 htriv hlow hZ
  have hmax := duality_scaled_max_eq_abs_max_necSuf hne f g hc hd hdual hg
  have hdne : d ≠ 0 := ne_of_gt hd
  refine ⟨?_, hupper⟩
  calc Finset.univ.sup' hne (fun i => |f i|) / 4
      = c / (d * 4) * Finset.univ.sup' hne g := by
        rw [← hmax]
        field_simp
    _ ≤ Z := hlower

end Ising2DLambda.NecSuf.KacWard
