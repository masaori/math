/-
章「固有値の代数性」の主張「互換の反復合成が基点の反復に与える値」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_transposition_composite_values`）に対応する。

  人手証明                                          このファイル
  準備（r ≠ j ならば S^[r](τ₀) ≠ S^[j](τ₀)）        rowShiftIterate_ne_of_ne_of_lt_period
  主張（Ψ_k(S^[r](τ₀)) の 3 つの場合）              orbitTranspositionComposite_apply_rowShiftIterate

人手証明どおり `k` についての帰納法であり、一歩では `r < k` / `r = k` / `r = k+1` /
`r > k+1` の 4 つの場合に分ける。各場合で、互換 `t^O_{τ₀,S^[k+1](τ₀)}` の 3 つの場合の
どれに入るかを準備で判定する。

住処: 人手証明のこのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは行配位とその部分集合、その上の写像と相等、および ℕ だけ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowShiftIterateDistinct

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の準備。`r < e(τ₀)`、`j < e(τ₀)`、`r ≠ j` ならば `S^[r](τ₀) ≠ S^[j](τ₀)` である。

`claim_row_shift_iterate_distinct_below_period` の対偶そのものである。 -/
theorem rowShiftIterate_ne_of_ne_of_lt_period {τ₀ : RowConfig L} {r j : ℕ}
    (hr : r < rowShiftMinimalPeriod L τ₀) (hj : j < rowShiftMinimalPeriod L τ₀) (hne : r ≠ j) :
    rowShiftIterate L r τ₀ ≠ rowShiftIterate L j τ₀ :=
  fun h => hne (rowShiftIterate_index_eq_of_lt_period hr hj h)

/-- 人手証明の主張。`k < e(τ₀)` と `r < e(τ₀)` のとき

    Ψ^{O,τ₀}_k(S^[r](τ₀)) = S^[r+1](τ₀)  (r < k)
                          = τ₀           (r = k)
                          = S^[r](τ₀)    (r > k)

である。人手証明どおり `k` についての帰納法で、`r` は各段で任意に取り直す。 -/
theorem orbitTranspositionComposite_apply_rowShiftIterate {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) :
    ∀ {k : ℕ}, k < rowShiftMinimalPeriod L τ₀ → ∀ {r : ℕ}, r < rowShiftMinimalPeriod L τ₀ →
      (orbitTranspositionComposite hO hτ₀ k
          ⟨rowShiftIterate L r τ₀, rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ r⟩).1
        = if r < k then rowShiftIterate L (r + 1) τ₀
          else if r = k then τ₀ else rowShiftIterate L r τ₀ := by
  intro k
  induction k with
  | zero =>
      -- k = 0 の場合。Ψ_0 = id_O なので、値は S^[r](τ₀) そのものである。
      intro _ r _
      -- r < 0 は起こらない。r = 0 のときは S^[0](τ₀) = τ₀、r > 0 のときは S^[r](τ₀)。
      rcases Nat.eq_zero_or_pos r with hr0 | hrpos
      · subst hr0
        simp [orbitTranspositionComposite, rowShiftIterate]
      · simp [orbitTranspositionComposite, Nat.pos_iff_ne_zero.mp hrpos]
  | succ k ih =>
      intro hk1 r hr
      -- k < k+1 < e(τ₀) なので帰納法の仮定が使える。
      have hk : k < rowShiftMinimalPeriod L τ₀ := Nat.lt_of_succ_lt hk1
      -- t の第 2 の点 S^[k+1](τ₀) は τ₀ = S^[0](τ₀) と相異なる（準備による）。
      have hzero : (0 : ℕ) < rowShiftMinimalPeriod L τ₀ := Nat.zero_lt_of_lt hk1
      have hk1ne : rowShiftIterate L (k + 1) τ₀ ≠ τ₀ := by
        have := rowShiftIterate_ne_of_ne_of_lt_period (τ₀ := τ₀) hk1 hzero (Nat.succ_ne_zero k)
        simpa [rowShiftIterate] using this
      -- Ψ_{k+1} = t^O_{τ₀,S^[k+1](τ₀)} ∘ Ψ_k を展開してから帰納法の仮定を当てる。
      have hstep : (orbitTranspositionComposite hO hτ₀ (k + 1)
          ⟨rowShiftIterate L r τ₀, rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ r⟩).1
          = orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀)
              ((orbitTranspositionComposite hO hτ₀ k
                ⟨rowShiftIterate L r τ₀, rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ r⟩).1) := rfl
      rw [hstep, ih hk hr]
      rcases Nat.lt_trichotomy r k with hlt | heq | hgt
      · -- r < k の場合。Ψ_k の値は S^[r+1](τ₀) で、互換の第 3 の場合に入る。
        have hr1 : r + 1 < rowShiftMinimalPeriod L τ₀ := Nat.lt_of_le_of_lt hlt hk
        have hne0 : rowShiftIterate L (r + 1) τ₀ ≠ τ₀ := by
          have := rowShiftIterate_ne_of_ne_of_lt_period (τ₀ := τ₀) hr1 hzero (Nat.succ_ne_zero r)
          simpa [rowShiftIterate] using this
        have hnek : rowShiftIterate L (r + 1) τ₀ ≠ rowShiftIterate L (k + 1) τ₀ :=
          rowShiftIterate_ne_of_ne_of_lt_period hr1 hk1 (by omega)
        rw [if_pos hlt]
        simp [orbitTransposition, hne0, hnek, Nat.lt_succ_of_lt hlt]
      · -- r = k の場合。Ψ_k の値は τ₀ で、互換の第 1 の場合に入る。
        subst heq
        rw [if_neg (Nat.lt_irrefl r), if_pos rfl]
        simp [orbitTransposition, Nat.lt_succ_self r]
      · -- r > k の場合。Ψ_k の値は S^[r](τ₀) である。r = k+1 か r > k+1 かでさらに分ける。
        rw [if_neg (Nat.not_lt.mpr (Nat.le_of_lt hgt)), if_neg (by omega)]
        rcases Nat.lt_or_ge (k + 1) r with hgt1 | hle1
        · -- r > k+1 の場合。互換の第 3 の場合に入る。
          have hne0 : rowShiftIterate L r τ₀ ≠ τ₀ := by
            have := rowShiftIterate_ne_of_ne_of_lt_period (τ₀ := τ₀) hr hzero (by omega)
            simpa [rowShiftIterate] using this
          have hnek : rowShiftIterate L r τ₀ ≠ rowShiftIterate L (k + 1) τ₀ :=
            rowShiftIterate_ne_of_ne_of_lt_period hr hk1 (by omega)
          simp [orbitTransposition, hne0, hnek, Nat.not_lt.mpr (Nat.le_of_lt hgt1),
            Nat.ne_of_gt hgt1]
        · -- r = k+1 の場合。互換の第 2 の場合に入る（S^[k+1](τ₀) ≠ τ₀ は上で見た）。
          have hrk : r = k + 1 := by omega
          subst hrk
          simp [orbitTransposition, hk1ne]

end Ising2DLambda.AlgebraicEigenvalue
