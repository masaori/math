import Mathlib

/-!
「自己双対点より低温側での分配多項式の両側評価」（`claim_low_temperature_partition_bounds`）の必要十分版。

具体版 `Ising2DLambda.KacWard.lowTemperaturePartitionBounds` と同じ手順で示す:
`Z = ½ Σ f`、最大 `M` はある `f i₀`、下界は `½ M = ½ f i₀ ≤ ½ Σ f`、上界は `½ Σ f ≤ ½ Σ M = ½ · 4 · M`。

使うのは次だけである。
* 係数の体 `K` は線型順序体（`Field`・`LinearOrder`・`IsStrictOrderedRing`）。`½` を書くのに `2` の逆元が、
  `½` を掛けても不等号が保たれるのに `0 ≤ ½` が要る。最大 `sup'` を取るのに線型順序が要る。
* 添字集合 `ι` は空でない有限集合で、元の個数が `4`（`hcard`）。`hcard` は上界の `Σ M = 4 M` だけに使う。
* 下界には各 `f i` が非負であること（`hnn`）だけを使う。具体版が引く「四つの値は正」は、
  この段では非負性しか使われていない。上界は `f` の符号を使わない。
* `2 Z = Σ f`（`hZ`）。有限トーラス公式の評価である。

住処: 一般の線型順序体。実数体・複素数体は現れない。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版: `2 Z = Σ_i f i`、`f ≥ 0`、`|ι| = 4` なら `½ max f ≤ Z ≤ 2 max f`。 -/
theorem half_sum_two_sided_bounds_necSuf {K ι : Type*} [Field K] [LinearOrder K]
    [IsStrictOrderedRing K] [Fintype ι] (hne : (Finset.univ : Finset ι).Nonempty)
    (hcard : Fintype.card ι = 4) (f : ι → K) (hnn : ∀ i, 0 ≤ f i) (Z : K)
    (hZ : 2 * Z = ∑ i, f i) :
    Finset.univ.sup' hne f / 2 ≤ Z ∧ Z ≤ 2 * Finset.univ.sup' hne f := by
  obtain ⟨i₀, -, hi₀⟩ := Finset.exists_mem_eq_sup' hne f
  have hZ' : Z = (1 / 2) * ∑ i, f i := by
    rw [← hZ]
    ring
  constructor
  · calc Finset.univ.sup' hne f / 2
        = (1 / 2) * f i₀ := by
          rw [hi₀]
          ring
      _ ≤ (1 / 2) * ∑ i, f i := by
          gcongr
          exact Finset.single_le_sum (fun i _ => hnn i) (Finset.mem_univ i₀)
      _ = Z := hZ'.symm
  · calc Z = (1 / 2) * ∑ i, f i := hZ'
      _ ≤ (1 / 2) * ∑ _i : ι, Finset.univ.sup' hne f := by
          gcongr with i
          exact Finset.le_sup' f (Finset.mem_univ i)
      _ = 2 * Finset.univ.sup' hne f := by
          rw [Finset.sum_const, Finset.card_univ, hcard, nsmul_eq_mul]
          norm_num
          ring

end Ising2DLambda.NecSuf.KacWard
