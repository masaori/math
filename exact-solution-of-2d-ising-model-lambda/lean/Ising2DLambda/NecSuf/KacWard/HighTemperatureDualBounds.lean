import Mathlib

/-!
「自己双対点より高温側での分配多項式の両側評価」（`claim_high_temperature_partition_bounds`）のうち、
自己双対変換の符号を引かずに済む段の必要十分版。

具体版 `Ising2DLambda.KacWard.highTemperatureDualBounds` と同じ手順で示す:
下界は `c/(4d) · M = c/(2d) · (M/2) ≤ c/(2d) · Zt = c/d · G₀₀ ≤ c/d · (G₀₀+G₀₁+G₁₀+G₁₁) = Z`、
上界は `Z = ½ Σ f ≤ ½ Σ |f| ≤ ½ Σ max|f| = 2 max|f|`。

使うのは次だけである。
* 係数の体 `K` は線型順序体（`Field`・`LinearOrder`・`IsStrictOrderedRing`）。割り算に `d ≠ 0` と `2 ≠ 0` が、
  不等号に正の数を掛けてよいことが、絶対値と最大 `sup'` に線型順序が要る。
* 双対因数分解 `d · Z = c · (G₀₀ + G₀₁ + G₁₀ + G₁₁)`（`hfac`）で、`d > 0`（`hd`）、`c ≥ 0`（`hc`）。
  `c ≥ 0` は不等号に `c/d` 倍を掛けるのに要る。
* 自明セクターの項 `G₀₀` を除く三項が非負であること（`h01`・`h10`・`h11`）。`G₀₀` 自身の符号は使わない。
* 双対点の分配関数の値が `Zt = 2 G₀₀`（`htriv`）で、低温側の下界 `M/2 ≤ Zt`（`hlow`）。
  `M` が四つの値の最大であることも、`M` の符号も、この段では使わない。
* 上界には `2 Z = Σ f`（`hZ`）と、添字集合が空でなく元の個数が `4`（`hcard`）であることだけを使う。
  `f` の符号は使わない。

住処: 一般の線型順序体。実数体・複素数体は現れない。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版: 双対因数分解・三項の非負性・`Zt = 2 G₀₀`・`M/2 ≤ Zt` から
`c/(d·4) · M ≤ Z`、`2 Z = Σ f`・`|ι| = 4` から `Z ≤ 2 max |f|`。 -/
theorem high_temperature_dual_bounds_necSuf {K ι : Type*} [Field K] [LinearOrder K]
    [IsStrictOrderedRing K] [Fintype ι] (hne : (Finset.univ : Finset ι).Nonempty)
    (hcard : Fintype.card ι = 4) (f : ι → K) (Z Zt M c d G₀₀ G₀₁ G₁₀ G₁₁ : K)
    (hd : 0 < d) (hc : 0 ≤ c) (hfac : d * Z = c * (G₀₀ + G₀₁ + G₁₀ + G₁₁))
    (h01 : 0 ≤ G₀₁) (h10 : 0 ≤ G₁₀) (h11 : 0 ≤ G₁₁) (htriv : Zt = 2 * G₀₀)
    (hlow : M / 2 ≤ Zt) (hZ : 2 * Z = ∑ i, f i) :
    c / (d * 4) * M ≤ Z ∧ Z ≤ 2 * Finset.univ.sup' hne (fun i => |f i|) := by
  have hdne : d ≠ 0 := ne_of_gt hd
  constructor
  · calc c / (d * 4) * M
        = c / (d * 2) * (M / 2) := by
          field_simp
          ring
      _ ≤ c / (d * 2) * Zt := by
          gcongr
      _ = c / d * G₀₀ := by
          rw [htriv]
          field_simp
      _ ≤ c / d * (G₀₀ + G₀₁ + G₁₀ + G₁₁) := by
          gcongr
          linarith
      _ = Z := by
          rw [div_mul_eq_mul_div, ← hfac]
          field_simp
  · have hZ' : Z = (1 / 2) * ∑ i, f i := by
      rw [← hZ]
      ring
    calc Z = (1 / 2) * ∑ i, f i := hZ'
      _ ≤ (1 / 2) * ∑ i, |f i| := by
          gcongr with i
          exact le_abs_self _
      _ ≤ (1 / 2) * ∑ _i : ι, Finset.univ.sup' hne (fun i => |f i|) := by
          gcongr with i
          exact Finset.le_sup' (fun i => |f i|) (Finset.mem_univ i)
      _ = 2 * Finset.univ.sup' hne (fun i => |f i|) := by
          rw [Finset.sum_const, Finset.card_univ, hcard, nsmul_eq_mul]
          norm_num
          ring

end Ising2DLambda.NecSuf.KacWard
