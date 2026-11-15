import Ising2DLambda.NecSuf.KacWard.PartitionLogOrderTransfer

/-!
「分配多項式の両側評価を対数順序群の鎖へ移す」（`claim_partition_log_order_bounds`）の必要十分版。

具体版 `Ising2DLambda.KacWard.partitionLogOrderBounds` と同じ手順で示す:
1. `q² + 2q − 1 ≠ 0`（零なら `(q+1)·(q+1) = 2` で、`K` に `2` の平方根が無いことに反する）、
2. 符号による二場合。負の場合は各値 `f i` が正なので `max |f| = max f` で、低温側の評価
   `max f / 2 ≤ Z ≤ 2 max f` から `max |f| / 4 ≤ Z ≤ 2 max |f|`。正の場合は高温側の評価がそれを与える、
3. `Z > 0` と上界から `max |f| > 0`、
4. 有理数での両側評価から対数の鎖を得る段 `log_order_transfer_of_two_sided_bounds_necSuf`。

使うのは次だけである。
* 係数の体 `K` は線型順序体。符号の二場合に全順序を、`max` と絶対値に順序を使う。
* `K` に `2` の平方根が無いこと（`hsq`）。これを外すと `q² + 2q − 1 = 0` の場合が残り、
  どちらの評価も引けない（実数体では `q = √2 − 1` がそれに当たる）。
* 低温側の仮定（`hposLow`・`hlowLow`・`hupLow`）と高温側の仮定（`hHigh`）は、それぞれの符号の下でだけ使う。
  低温側の下界は `max f / 2 ≤ Z` を `max f / 4 ≤ Z` に弱めて使う。
* `Z > 0`（`hZ`）。`max |f| > 0` を上界から得るのと、対数の段の正値性に使う。
* 対数の段の仮定（`hiff`・`hmul`・`hadd`）。`log_order_transfer_of_two_sided_bounds_necSuf` と同じ。

住処: 一般の線型順序体と可換加法群。実数体・複素数体・実対数は現れない。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版: 符号の二場合の評価を合わせ、対数の鎖を得る。 -/
theorem partition_log_order_bounds_necSuf {K G ι : Type*} [Field K] [LinearOrder K]
    [IsStrictOrderedRing K] [AddCommGroup G] [Fintype ι]
    (hne : (Finset.univ : Finset ι).Nonempty)
    (hsq : ∀ r : K, r * r ≠ 2)
    (le : G → G → Prop) (lg : K → G)
    (hiff : ∀ {a b : K}, 0 < a → 0 < b → a ≤ b → le (lg a) (lg b))
    (hmul : ∀ {a b : K}, 0 < a → 0 < b → lg (a * b) = lg a + lg b)
    (hadd : ∀ {x y : G}, le x y → ∀ n : G, le (x + n) (y + n))
    (q Z : K) (f : ι → K) (hZ : 0 < Z)
    (hposLow : q ^ 2 + 2 * q - 1 < 0 → ∀ i, 0 < f i)
    (hlowLow : q ^ 2 + 2 * q - 1 < 0 → Finset.univ.sup' hne f / 2 ≤ Z)
    (hupLow : q ^ 2 + 2 * q - 1 < 0 → Z ≤ 2 * Finset.univ.sup' hne f)
    (hHigh : 0 < q ^ 2 + 2 * q - 1 →
      Finset.univ.sup' hne (fun i => |f i|) / 4 ≤ Z ∧
        Z ≤ 2 * Finset.univ.sup' hne (fun i => |f i|)) :
    le (lg (Finset.univ.sup' hne (fun i => |f i|)) - 2 • lg 2) (lg Z) ∧
      le (lg Z) (lg (Finset.univ.sup' hne (fun i => |f i|)) + lg 2) := by
  set Mabs := Finset.univ.sup' hne (fun i => |f i|) with hMabs
  -- `q² + 2q − 1 ≠ 0`
  have hc : q ^ 2 + 2 * q - 1 ≠ 0 := by
    intro h
    exact hsq (q + 1) (by linear_combination h)
  -- 符号による二場合
  have hbounds : Mabs / 4 ≤ Z ∧ Z ≤ 2 * Mabs := by
    rcases lt_or_gt_of_ne hc with hneg | hpos
    · have hp := hposLow hneg
      have heq : Mabs = Finset.univ.sup' hne f := by
        rw [hMabs]
        congr 1
        funext i
        exact abs_of_pos (hp i)
      have hlow := hlowLow hneg
      have hup := hupLow hneg
      rw [← heq] at hlow hup
      have hM : 0 < Mabs := by
        rw [heq]
        obtain ⟨i₀, -⟩ := hne
        exact lt_of_lt_of_le (hp i₀) (Finset.le_sup' f (Finset.mem_univ i₀))
      exact ⟨by linarith, hup⟩
    · exact hHigh hpos
  obtain ⟨hlow, hup⟩ := hbounds
  -- `Z > 0` と上界から `max |f| > 0`
  have hM : 0 < Mabs := by linarith
  exact log_order_transfer_of_two_sided_bounds_necSuf le lg hiff hmul hadd Mabs Z hM hZ hlow hup

end Ising2DLambda.NecSuf.KacWard
