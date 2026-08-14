/-
人手証明「正の実数での分配多項式の値は正である」の具体版。

人手証明と同じく、全て正の配位を一つ選び、その項を有限和から分離する。
冪の正値性も指数についての帰納法で示す。実数の完備性・極限・対数は使わない。

住処: この章で初めて ℝ へ脱出する。指数と有限和の添字は ℕ 側に留まる。
-/
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Algebra.Polynomial.AlgebraMap
import Mathlib.Data.Real.Basic
import Ising2DLambda.PartitionPolynomial.Basic

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 人手証明の定数配位 `σ₊`。 -/
def allPlusConfig : Config L := fun _ => ⟨1, Or.inl rfl⟩

/-- 代入は有限和と冪を保つ。 -/
lemma eval_partitionPolynomial_real (t : ℝ) :
    Polynomial.aeval t (partitionPolynomial L) = ∑ σ : Config L, t ^ brokenBondCount L σ := by
  rw [partitionPolynomial, map_sum]
  exact sum_congr rfl fun σ _ => by rw [map_pow, Polynomial.aeval_X]

/-- 正の実数の自然数冪は正である。人手証明どおり指数について帰納する。 -/
lemma pow_pos_by_induction {t : ℝ} (ht : 0 < t) : ∀ n : ℕ, 0 < t ^ n
  | 0 => by simpa using (show (0 : ℝ) < 1 from zero_lt_one)
  | n + 1 => by
      rw [pow_succ]
      exact mul_pos (pow_pos_by_induction ht n) ht

/-- 正の実数での分配多項式の値は正である。 -/
theorem partitionPolynomial_eval_real_pos {t : ℝ} (ht : 0 < t) :
    0 < Polynomial.aeval t (partitionPolynomial L) := by
  rw [eval_partitionPolynomial_real L t]
  let σplus : Config L := allPlusConfig L
  have hσplus : σplus ∈ (univ : Finset (Config L)) := mem_univ σplus
  have hrest : 0 ≤ ∑ σ ∈ (univ : Finset (Config L)).erase σplus,
      t ^ brokenBondCount L σ := by
    exact sum_nonneg fun σ _ => (pow_pos_by_induction ht (brokenBondCount L σ)).le
  calc
    0 < t ^ brokenBondCount L σplus := pow_pos_by_induction ht _
    _ ≤ t ^ brokenBondCount L σplus +
        ∑ σ ∈ (univ : Finset (Config L)).erase σplus, t ^ brokenBondCount L σ :=
      le_add_of_nonneg_right hrest
    _ = ∑ σ : Config L, t ^ brokenBondCount L σ := by
      rw [add_comm, sum_erase_add _ _ hσplus]

end Ising2DLambda.ThermodynamicLimit
