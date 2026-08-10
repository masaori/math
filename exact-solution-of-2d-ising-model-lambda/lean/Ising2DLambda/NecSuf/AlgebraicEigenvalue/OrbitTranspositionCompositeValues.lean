/-
主張「互換の反復合成が基点の反復に与える値」の必要十分版。

具体版は `Ising2DLambda/AlgebraicEigenvalue/OrbitTranspositionCompositeValues.lean`。
証明手順は具体版と同じ（`k` についての帰納法、一歩で 4 つの場合に分け、
互換の 3 つの場合のどれに入るかを点の相異なることで判定する）であり、
仮定だけを、具体版の証明が実際に使っている性質まで落としてある。

具体版が持っていて、ここで落としたもの:

* 行配位・巡回シフト・軌道・最小周期。使っていない。現れるのは型 `α` と、
  `ℕ` で番号づけられた点の族 `pt : ℕ → α` だけである。
* 反復合成が全単射であること、互換が 2 回合成すると恒等写像であること。使っていない
  （値の計算しかしていない）。
* 台が有限であること、台の上の順序 `≺`。使っていない。

残した仮定と、それが必要な理由:

* `DecidableEq α` — 互換 `swapAt` が場合分けで定義されているので要る。
* `hinj` — 番号が `n` 未満の範囲で点が相異なること。互換の 3 つの場合のどれに入るかを
  判定するのはこれだけである。これが無いと、`S^[r](τ₀)` が `τ₀` や `S^[k+1](τ₀)` と
  一致してしまう場合を排除できない。
* `hF0` / `hFs` — 反復合成の再帰の 2 式。具体版の `Ψ_k` が満たすものであり、
  この段が `Ψ` について使うのはこの 2 式だけである（構成の仕方には依存しない）。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 具体版の互換 `t_{a,b}` に対応する。3 つの場合による定義も具体版と同じである。 -/
def swapAt {α : Type*} [DecidableEq α] (a b x : α) : α :=
  if x = a then b else if x = b then a else x

/-- 具体版の主張に対応する。`n` 未満の番号の点が相異なる族 `pt` と、互換の反復合成の
再帰 2 式を満たす写像の族 `F` について、`k < n` と `r < n` のとき

    F k (pt r) = pt (r+1)  (r < k)
               = pt 0      (r = k)
               = pt r      (r > k)

である。具体版と同じく `k` についての帰納法で、一歩で 4 つの場合に分ける。 -/
theorem composite_apply_of_rec {α : Type*} [DecidableEq α] {pt : ℕ → α} {n : ℕ}
    (hinj : ∀ {r j : ℕ}, r < n → j < n → pt r = pt j → r = j)
    {F : ℕ → α → α} (hF0 : ∀ x, F 0 x = x)
    (hFs : ∀ (k : ℕ) (x : α), F (k + 1) x = swapAt (pt 0) (pt (k + 1)) (F k x)) :
    ∀ {k : ℕ}, k < n → ∀ {r : ℕ}, r < n →
      F k (pt r) = if r < k then pt (r + 1) else if r = k then pt 0 else pt r := by
  have hne : ∀ {r j : ℕ}, r < n → j < n → r ≠ j → pt r ≠ pt j :=
    fun hr hj hrj h => hrj (hinj hr hj h)
  intro k
  induction k with
  | zero =>
      -- k = 0 の場合。F 0 = id なので値は pt r そのものである。
      intro _ r _
      rcases Nat.eq_zero_or_pos r with hr0 | hrpos
      · subst hr0
        simp [hF0]
      · simp [hF0, Nat.pos_iff_ne_zero.mp hrpos]
  | succ k ih =>
      intro hk1 r hr
      have hk : k < n := Nat.lt_of_succ_lt hk1
      have hzero : (0 : ℕ) < n := Nat.zero_lt_of_lt hk1
      have hk1ne : pt (k + 1) ≠ pt 0 := hne hk1 hzero (Nat.succ_ne_zero k)
      rw [hFs, ih hk hr]
      rcases Nat.lt_trichotomy r k with hlt | heq | hgt
      · -- r < k の場合。互換の第 3 の場合に入る。
        have hr1 : r + 1 < n := Nat.lt_of_le_of_lt hlt hk
        have hne0 : pt (r + 1) ≠ pt 0 := hne hr1 hzero (Nat.succ_ne_zero r)
        have hnek : pt (r + 1) ≠ pt (k + 1) := hne hr1 hk1 (by omega)
        rw [if_pos hlt]
        simp [swapAt, hne0, hnek, Nat.lt_succ_of_lt hlt]
      · -- r = k の場合。互換の第 1 の場合に入る。
        subst heq
        rw [if_neg (Nat.lt_irrefl r), if_pos rfl]
        simp [swapAt, Nat.lt_succ_self r]
      · -- r > k の場合。r = k+1 か r > k+1 かでさらに分ける。
        rw [if_neg (Nat.not_lt.mpr (Nat.le_of_lt hgt)), if_neg (by omega)]
        rcases Nat.lt_or_ge (k + 1) r with hgt1 | hle1
        · -- r > k+1 の場合。互換の第 3 の場合に入る。
          have hne0 : pt r ≠ pt 0 := hne hr hzero (by omega)
          have hnek : pt r ≠ pt (k + 1) := hne hr hk1 (by omega)
          simp [swapAt, hne0, hnek, Nat.not_lt.mpr (Nat.le_of_lt hgt1), Nat.ne_of_gt hgt1]
        · -- r = k+1 の場合。互換の第 2 の場合に入る。
          have hrk : r = k + 1 := by omega
          subst hrk
          simp [swapAt, hk1ne]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
