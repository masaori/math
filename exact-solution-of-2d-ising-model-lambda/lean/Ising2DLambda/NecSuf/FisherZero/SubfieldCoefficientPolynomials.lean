/-
「代数的数の部分体は有理数をすべて含む」と「各代数的数は部分体を係数とする零でない多項式の根である」の必要十分版。

有理数の所属: 具体版の証明が部分集合 `S` について使うのは、零元・単位元を含むこと、和と符号反転と
商（零でない元で割ること）で閉じることだけである。積の閉性は使わない（商で足りる）。
台は除法環であれば足り、可換性も標数零も使わない（`q = num / den` の表示は任意の除法環で成り立つ）。

零化多項式の存在: 使うのは、係数の環 `R` から `K` への写像が単射であること（零でないことの保存）と、
その像が `S` に含まれること、`α` が `R` 上代数的であることだけである。`S` が部分体であることも、
`R` が体であることも使わない。
-/
import Mathlib.Algebra.Polynomial.AlgebraMap
import Mathlib.RingTheory.Algebraic.Defs

namespace Ising2DLambda.NecSuf.FisherZero

theorem natCast_mem_necSuf {K : Type*} [DivisionRing K] (S : Set K)
    (h0 : (0 : K) ∈ S) (h1 : (1 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (n : ℕ) : (n : K) ∈ S := by
  induction n with
  | zero => rw [Nat.cast_zero]; exact h0
  | succ n ih => rw [Nat.cast_succ]; exact hadd _ _ ih h1

theorem intCast_mem_necSuf {K : Type*} [DivisionRing K] (S : Set K)
    (h0 : (0 : K) ∈ S) (h1 : (1 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hneg : ∀ a : K, a ∈ S → -a ∈ S) (m : ℤ) : (m : K) ∈ S := by
  cases m with
  | ofNat n => rw [Int.ofNat_eq_natCast, Int.cast_natCast]; exact natCast_mem_necSuf S h0 h1 hadd n
  | negSucc n =>
    rw [Int.cast_negSucc]
    exact hneg _ (by exact_mod_cast natCast_mem_necSuf S h0 h1 hadd (n + 1))

/-- 具体版と同じ段（自然数、整数、`num / den`）で示す。 -/
theorem ratCast_mem_necSuf {K : Type*} [DivisionRing K] (S : Set K)
    (h0 : (0 : K) ∈ S) (h1 : (1 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hneg : ∀ a : K, a ∈ S → -a ∈ S) (hdiv : ∀ a b : K, a ∈ S → b ∈ S → a / b ∈ S)
    (q : ℚ) : (q : K) ∈ S := by
  rw [Rat.cast_def]
  exact hdiv _ _ (intCast_mem_necSuf S h0 h1 hadd hneg q.num) (natCast_mem_necSuf S h0 h1 hadd q.den)

/-- 具体版と同じ段（係数を送った多項式、係数の所属、単射性による非零、値の一致）で示す。 -/
theorem vanishingPolynomial_exists_necSuf {R K : Type*} [CommRing R] [CommRing K] [Algebra R K]
    (hinj : Function.Injective (algebraMap R K)) (S : Set K)
    (hS : ∀ r : R, algebraMap R K r ∈ S) (α : K) (halg : IsAlgebraic R α) :
    ∃ f : Polynomial K, (∀ k : ℕ, f.coeff k ∈ S) ∧ f ≠ 0 ∧ f.eval α = 0 := by
  obtain ⟨p, hp0, hpα⟩ := halg
  refine ⟨p.map (algebraMap R K), ?_, ?_, ?_⟩
  · intro k
    rw [Polynomial.coeff_map]
    exact hS _
  · exact (Polynomial.map_ne_zero_iff hinj).mpr hp0
  · rw [Polynomial.eval_map_algebraMap]
    exact hpα

end Ising2DLambda.NecSuf.FisherZero
