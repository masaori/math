/-
「辺部分集合の横（縦）切断線の偶奇は巻き付き偶奇に等しい」の必要十分版。

具体版と同じ手順（一辺ごとの等式 → 有限和の交換 → 一点の指示子の和）を、
辺の集合 `E` と、二種類の辺への一意な分解 `φ : (I × J) ⊕ K ≃ E` だけで行う。
指示子 `c` は、一種類目の辺のうち第二座標が `j₀` のものだけで一、それ以外で零であればよい。
格子・剰余類・方向の個数・二で割った余りは使わない（等式は ℕ でそのまま成り立つ）。
分解が全単射であることは両方向に要る: 全射は各辺の場合分けに、単射は一点の指示子の和に使う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open Finset

theorem line_indicator_sum_eq_line_count {E I J K : Type*} [Fintype I] [DecidableEq E]
    [DecidableEq J] (φ : (I × J) ⊕ K ≃ E) (j₀ : J) (c : E → ℕ)
    (hc₁ : ∀ i j, c (φ (Sum.inl (i, j))) = if j = j₀ then 1 else 0)
    (hc₂ : ∀ k, c (φ (Sum.inr k)) = 0) (A : Finset E) :
    ∑ e ∈ A, c e = ∑ i : I, if φ (Sum.inl (i, j₀)) ∈ A then 1 else 0 := by
  classical
  -- 一辺ごとの等式
  have hsingle (e : E) : c e = ∑ i : I, if e = φ (Sum.inl (i, j₀)) then 1 else 0 := by
    rcases φ.surjective e with ⟨w, rfl⟩
    cases w with
    | inl p =>
        rcases p with ⟨r, j⟩
        have heq (i : I) : (φ (Sum.inl (r, j)) = φ (Sum.inl (i, j₀))) ↔ r = i ∧ j = j₀ := by
          rw [φ.apply_eq_iff_eq]
          simp
        rw [hc₁, Finset.sum_congr rfl (fun i _ => if_congr (heq i) rfl rfl)]
        by_cases hj : j = j₀
        · simp only [hj, and_true]
          rw [Finset.sum_ite_eq]
          simp
        · simp [hj]
    | inr k =>
        have hneq (i : I) : φ (Sum.inr k) ≠ φ (Sum.inl (i, j₀)) := by
          rw [Ne, φ.apply_eq_iff_eq]
          simp
        simp [hc₂, hneq]
  calc ∑ e ∈ A, c e
      = ∑ e ∈ A, ∑ i : I, if e = φ (Sum.inl (i, j₀)) then 1 else 0 :=
        Finset.sum_congr rfl (fun e _ => hsingle e)
    _ = ∑ i : I, ∑ e ∈ A, if e = φ (Sum.inl (i, j₀)) then 1 else 0 := Finset.sum_comm
    _ = ∑ i : I, if φ (Sum.inl (i, j₀)) ∈ A then 1 else 0 := by
        simp only [Finset.sum_ite_eq']

end Ising2DLambda.NecSuf.KacWard
