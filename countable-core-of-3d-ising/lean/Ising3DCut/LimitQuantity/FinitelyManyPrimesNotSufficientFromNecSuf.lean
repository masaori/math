/-
具体版「有限個の素数での指数だけを見る粗視化は箱サイズ極限の一致に十分でない」が、
必要十分版 `Ising3DCut.NecSuf.finite_coordinate_truncation_not_sufficient` の
特殊化として得られることの導出。

添字を自然数、座標データを整数値の付値の族、値を作る写像を付値の族から正の実数を
組み立てる写像として取り、述語を「素数である」と取る。
-/
import Ising3DCut.LimitQuantity.FinitelyManyPrimesNotSufficient
import Ising3DCut.NecSuf.FinitePrimeTruncationNotSufficient
import Mathlib.Algebra.BigOperators.Finprod

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 付値の族から正の実数を組み立てる写像（有限台の積）。 -/
noncomputable def realOfExponents (g : ℕ → ℤ) : ℝ := ∏ᶠ p : ℕ, ((p : ℝ) ^ (g p))

/-- `1` の付値の族（すべての素数で 0）からは 1 が戻る。 -/
theorem realOfExponents_zero : realOfExponents (fun _ => 0) = 1 := by
  unfold realOfExponents
  simp

/-- 素数 `r` の付値の族（`r` でだけ 1、他は 0）からは `r` が戻る。 -/
theorem realOfExponents_single (r : ℕ) (hr : r.Prime) :
    realOfExponents (fun p => if p = r then 1 else 0) = (r : ℝ) := by
  unfold realOfExponents
  rw [finprod_eq_single _ r]
  · simp
  · intro p hp
    simp [hp]

/-- 具体版の反例が、必要十分版の特殊化として得られる。 -/
theorem finitely_many_primes_are_not_sufficient_for_limit_quantity_fromNecSuf
    (S : Finset ℕ) (hS : ∀ p ∈ S, p.Prime) :
    ∃ r, r.Prime ∧ r ∉ S ∧
      (∀ p ∈ S, (fun _ : ℕ => (0 : ℤ)) p = (fun p => if p = r then (1 : ℤ) else 0) p) ∧
      Tendsto (fun _ : ℕ => realOfExponents (fun _ => 0)) atTop
        (𝓝 (realOfExponents (fun _ => 0))) ∧
      Tendsto (fun _ : ℕ => realOfExponents (fun p => if p = r then 1 else 0)) atTop
        (𝓝 (realOfExponents (fun p => if p = r then 1 else 0))) ∧
      realOfExponents (fun _ => 0) ≠ realOfExponents (fun p => if p = r then 1 else 0) := by
  exact NecSuf.finite_coordinate_truncation_not_sufficient S Nat.Prime
    (exists_prime_not_mem S) (fun _ => (0 : ℤ)) (fun r p => if p = r then 1 else 0)
    realOfExponents
    (by
      -- 具体版の「`p ∈ S` では両方の付値が 0 で一致する」の段。
      intro r _ hrS p hp
      have hpr : p ≠ r := fun h => hrS (h ▸ hp)
      simp [hpr])
    (by
      -- 具体版の「`1 ≠ r`」の段。
      intro r hr _
      rw [realOfExponents_zero, realOfExponents_single r hr]
      have : (1 : ℕ) < r := hr.one_lt
      exact_mod_cast Nat.ne_of_lt this)

end Ising3DCut.LimitQuantity
