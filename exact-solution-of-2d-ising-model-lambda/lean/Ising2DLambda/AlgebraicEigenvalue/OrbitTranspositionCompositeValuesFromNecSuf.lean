/-
具体版が必要十分版の特殊化として得られることを示す（導出）。

具体版 `orbitTranspositionComposite_apply_rowShiftIterate` は、必要十分版
`composite_apply_of_rec` の型 `α` に軌道 `O`（部分型として持つ）、点の族 `pt` に
`r ↦ S^[r](τ₀)`、上界 `n` に最小周期 `e(τ₀)`、写像の族 `F` に `Ψ^{O,τ₀}` を取ったものである。

* 点が相異なることは `rowShiftIterate_index_eq_of_lt_period`（部分型の相等へ移す）。
* 再帰の 2 式のうち第 1 の式は定義そのもの、第 2 の式は互換の `O` への制限が
  必要十分版の `swapAt` と各点で一致することによる（値の側で 3 つの場合が一致する）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionCompositeValues
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTranspositionCompositeValues

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の主張が、必要十分版の特殊化として得られること。 -/
theorem orbitTranspositionComposite_apply_rowShiftIterate_from_necSuf
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O)
    {k : ℕ} (hk : k < rowShiftMinimalPeriod L τ₀) {r : ℕ} (hr : r < rowShiftMinimalPeriod L τ₀) :
    (orbitTranspositionComposite hO hτ₀ k
        ⟨rowShiftIterate L r τ₀, rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ r⟩).1
      = if r < k then rowShiftIterate L (r + 1) τ₀
        else if r = k then τ₀ else rowShiftIterate L r τ₀ := by
  classical
  -- 点の族: pt r = S^[r](τ₀)（O の元として）
  set pt : ℕ → {τ : RowConfig L // τ ∈ O} :=
    fun r => ⟨rowShiftIterate L r τ₀, rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ r⟩ with hpt
  have hzero : pt 0 = ⟨τ₀, hτ₀⟩ := Subtype.ext (by simp [hpt, rowShiftIterate])
  -- 点が相異なること（部分型の相等は値の相等である）
  have hinj : ∀ {a b : ℕ}, a < rowShiftMinimalPeriod L τ₀ → b < rowShiftMinimalPeriod L τ₀ →
      pt a = pt b → a = b := by
    intro a b ha hb h
    exact rowShiftIterate_index_eq_of_lt_period ha hb (congrArg Subtype.val h)
  -- 再帰の第 2 式。互換の O への制限が swapAt と一致すること（値の側の 3 つの場合の一致）
  have hFs : ∀ (j : ℕ) (x : {τ : RowConfig L // τ ∈ O}),
      orbitTranspositionComposite hO hτ₀ (j + 1) x
        = NecSuf.AlgebraicEigenvalue.swapAt (pt 0) (pt (j + 1))
            (orbitTranspositionComposite hO hτ₀ j x) := by
    intro j x
    set y := orbitTranspositionComposite hO hτ₀ j x with hy
    have hcomp : orbitTranspositionComposite hO hτ₀ (j + 1) x
        = orbitTranspositionRestriction O hτ₀
            (rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ (j + 1)) y := rfl
    rw [hcomp]
    unfold NecSuf.AlgebraicEigenvalue.swapAt
    by_cases h0 : y = pt 0
    · -- 第 1 の場合。y = τ₀ なので互換の値は S^[j+1](τ₀) である。
      rw [if_pos h0]
      apply Subtype.ext
      have hv : y.1 = τ₀ := by rw [h0, hzero]
      simp [orbitTranspositionRestriction, orbitTransposition, hv, hpt]
    · rw [if_neg h0]
      have hne0 : y.1 ≠ τ₀ := fun hv => h0 (Subtype.ext (by rw [hv, hzero]))
      by_cases hk1 : y = pt (j + 1)
      · -- 第 2 の場合。y = S^[j+1](τ₀) かつ y ≠ τ₀ なので互換の値は τ₀ である。
        rw [if_pos hk1]
        apply Subtype.ext
        have hv : y.1 = rowShiftIterate L (j + 1) τ₀ := by rw [hk1]
        have hne1 : rowShiftIterate L (j + 1) τ₀ ≠ τ₀ := hv ▸ hne0
        simp [orbitTranspositionRestriction, orbitTransposition, hv, hne1, hpt, rowShiftIterate]
      · -- 第 3 の場合。どちらとも相異なるので互換は y を動かさない。
        rw [if_neg hk1]
        apply Subtype.ext
        have hnek : y.1 ≠ rowShiftIterate L (j + 1) τ₀ :=
          fun hv => hk1 (Subtype.ext (by rw [hv]))
        simp [orbitTranspositionRestriction, orbitTransposition, hne0, hnek]
  have hmain := NecSuf.AlgebraicEigenvalue.composite_apply_of_rec
    (pt := pt) (n := rowShiftMinimalPeriod L τ₀) hinj
    (F := fun j => orbitTranspositionComposite hO hτ₀ j)
    (fun x => rfl) hFs hk hr
  -- 3 つの場合それぞれで、部分型の等式を値の等式へ移す
  rcases lt_trichotomy r k with h | h | h
  · rw [if_pos h] at hmain
    rw [if_pos h]
    exact congrArg Subtype.val hmain
  · subst h
    rw [if_neg (Nat.lt_irrefl r), if_pos rfl, hzero] at hmain
    rw [if_neg (Nat.lt_irrefl r), if_pos rfl]
    exact congrArg Subtype.val hmain
  · have h1 : ¬ r < k := Nat.not_lt.mpr (Nat.le_of_lt h)
    have h2 : r ≠ k := Nat.ne_of_gt h
    rw [if_neg h1, if_neg h2] at hmain
    rw [if_neg h1, if_neg h2]
    exact congrArg Subtype.val hmain

end Ising2DLambda.AlgebraicEigenvalue
