/-
節「正錐を係数とする平方和に一を足した多項式は偶数次である」の必要十分版。

具体版と同じ段で示し、各段が実際に使う性質だけを仮定に置く。

- 零でない元の平方: 三分法のうち「零か `C` か符号反転が `C`」の被覆だけを使い、排他性は使わない。
  `C` の和の閉性も使わず、積の閉性だけを使う。符号反転どうしの積のために台は `Ring`（可換でなくてよい）。
- 係数の上界の二倍の番号の平方の係数: 台は `Semiring` でよい（可換性も符号反転も使わない）。
- 主張: 台は `Semiring` でよい。`C` について、和と積で閉じること、単位元を含むこと（全ての `g(i)` が
  零の場合と `m = 0` の場合の定数項）、零元を含まないこと（`P ≠ 0` を出す段）、係数の集合 `S` の零でない元の
  平方を含むこと（具体版では三分法から出す前段）だけを使う。`S` の和・積の閉性は使わない。
-/
import Mathlib.Algebra.Polynomial.Degree.Operations
import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.FisherZero

open Polynomial

/-- 零でない元の平方は `C` に属する（具体版 `mul_self_mem_of_isSubfieldPositiveCone` と同じ段）。 -/
theorem mul_self_mem_of_cover_necSuf {K : Type*} [Ring K] (C : Set K)
    (hmul : ∀ a b : K, a ∈ C → b ∈ C → a * b ∈ C) (a : K)
    (hcover : a = 0 ∨ a ∈ C ∨ -a ∈ C) (ha0 : a ≠ 0) : a * a ∈ C := by
  rcases hcover with h0 | h1 | hm1
  · exact absurd h0 ha0
  · exact hmul _ _ h1 h1
  · have h := hmul _ _ hm1 hm1
    rw [neg_mul_neg] at h
    exact h

/-- 係数の上界の二倍の番号の平方の係数（具体版 `qbarPolySquareTopCoeff` と同じ段）。 -/
theorem squareTopCoeff_necSuf {K : Type*} [Semiring K] (f : K[X]) (m : ℕ)
    (hf : ∀ k, m < k → f.coeff k = 0) :
    (f * f).coeff (2 * m) = f.coeff m * f.coeff m := by
  rw [Polynomial.coeff_mul, Finset.sum_eq_single ((m, m) : ℕ × ℕ)]
  · intro b hb hne
    have hb' : b.1 + b.2 = 2 * m := Finset.mem_antidiagonal.mp hb
    rcases lt_or_ge m b.1 with h1 | h1
    · rw [hf b.1 h1, zero_mul]
    · have h2 : m < b.2 := by
        rcases Nat.eq_or_lt_of_le h1 with h | h
        · exact absurd (Prod.ext h (by omega)) hne
        · omega
      rw [hf b.2 h2, mul_zero]
  · intro h
    exact absurd (Finset.mem_antidiagonal.mpr (by omega)) h

/-- 係数の上界の和より上の番号で積の係数は零（具体版の `qbarPolyProductCoeffBound` の、`P = Q` の場合と同じ段）。 -/
theorem squareCoeffBound_necSuf {K : Type*} [Semiring K] (f : K[X]) (m : ℕ)
    (hf : ∀ k, m < k → f.coeff k = 0) : ∀ k, 2 * m < k → (f * f).coeff k = 0 := by
  intro k hk
  rw [Polynomial.coeff_mul]
  apply Finset.sum_eq_zero
  intro b hb
  have hb' : b.1 + b.2 = k := Finset.mem_antidiagonal.mp hb
  rcases lt_or_ge m b.1 with h1 | h1
  · rw [hf b.1 h1, zero_mul]
  · rw [hf b.2 (by omega), mul_zero]

/-- 零か `C` の元である項の有限和は、零か `C` の元である。 -/
theorem sum_mem_of_zero_or_mem_necSuf {K : Type*} [AddCommMonoid K] (C : Set K)
    (hadd : ∀ a b : K, a ∈ C → b ∈ C → a + b ∈ C)
    {ι : Type*} (s : Finset ι) (u : ι → K) (hu : ∀ i ∈ s, u i = 0 ∨ u i ∈ C) :
    (∑ i ∈ s, u i) = 0 ∨ (∑ i ∈ s, u i) ∈ C := by
  classical
  induction s using Finset.induction_on with
  | empty => left; rw [Finset.sum_empty]
  | insert a s ha ih =>
    rw [Finset.sum_insert ha]
    have ih' := ih (fun i hi => hu i (Finset.mem_insert_of_mem hi))
    rcases hu a (Finset.mem_insert_self a s) with h0 | h1
    · rw [h0, zero_add]; exact ih'
    · rcases ih' with h0' | h1'
      · rw [h0', add_zero]; right; exact h1
      · right; exact hadd _ _ h1 h1'

/-- 主張の必要十分版（具体版 `onePlusWeightedSquareSum_evenDegree` と同じ段）。 -/
theorem onePlusWeightedSquareSum_evenDegree_necSuf {K : Type*} [Semiring K] (S C : Set K)
    (hadd : ∀ a b : K, a ∈ C → b ∈ C → a + b ∈ C)
    (hmul : ∀ a b : K, a ∈ C → b ∈ C → a * b ∈ C)
    (h1C : (1 : K) ∈ C) (h0C : (0 : K) ∉ C)
    (hsq : ∀ a : K, a ∈ S → a ≠ 0 → a * a ∈ C)
    {ι : Type*} [Fintype ι] (c : ι → K) (g : ι → K[X])
    (hc : ∀ i, c i ∈ C) (hg : ∀ i, ∀ k, (g i).coeff k ∈ S) :
    (1 + ∑ i, Polynomial.C (c i) * (g i * g i)) ≠ 0 ∧
      ∃ m : ℕ, (1 + ∑ i, Polynomial.C (c i) * (g i * g i)).coeff (2 * m) ∈ C ∧
        ∀ k : ℕ, 2 * m < k → (1 + ∑ i, Polynomial.C (c i) * (g i * g i)).coeff k = 0 := by
  classical
  have hcoeff : ∀ k : ℕ, (1 + ∑ i, Polynomial.C (c i) * (g i * g i)).coeff k =
      (1 : K[X]).coeff k + ∑ i, c i * (g i * g i).coeff k := by
    intro k
    rw [Polynomial.coeff_add, Polynomial.finsetSum_coeff]
    simp only [Polynomial.coeff_C_mul]
  suffices hmain : ∃ m : ℕ, (1 + ∑ i, Polynomial.C (c i) * (g i * g i)).coeff (2 * m) ∈ C ∧
      ∀ k : ℕ, 2 * m < k → (1 + ∑ i, Polynomial.C (c i) * (g i * g i)).coeff k = 0 by
    obtain ⟨m, hm, hz⟩ := hmain
    refine ⟨?_, m, hm, hz⟩
    intro hP
    rw [hP, Polynomial.coeff_zero] at hm
    exact h0C hm
  by_cases hall : ∀ i, g i = 0
  · refine ⟨0, ?_, ?_⟩
    · rw [hcoeff, mul_zero, Polynomial.coeff_one_zero]
      simp only [hall, mul_zero, Polynomial.coeff_zero, Finset.sum_const_zero, add_zero]
      exact h1C
    · intro k hk
      rw [hcoeff, Polynomial.coeff_one, if_neg (by omega)]
      simp only [hall, mul_zero, Polynomial.coeff_zero, Finset.sum_const_zero, add_zero]
  · push Not at hall
    obtain ⟨i0, hi0⟩ := hall
    set J : Finset ι := Finset.univ.filter (fun i => g i ≠ 0) with hJ
    have hJne : J.Nonempty := ⟨i0, by rw [hJ, Finset.mem_filter]; exact ⟨Finset.mem_univ _, hi0⟩⟩
    set m : ℕ := J.sup' hJne (fun i => (g i).natDegree) with hm
    have hbound : ∀ i, ∀ k : ℕ, m < k → (g i).coeff k = 0 := by
      intro i k hk
      by_cases hgi : g i = 0
      · rw [hgi, Polynomial.coeff_zero]
      · have hiJ : i ∈ J := by rw [hJ, Finset.mem_filter]; exact ⟨Finset.mem_univ _, hgi⟩
        have hle : (g i).natDegree ≤ m := Finset.le_sup' (fun i => (g i).natDegree) hiJ
        exact Polynomial.coeff_eq_zero_of_natDegree_lt (by omega)
    obtain ⟨j, hjJ, hjm⟩ := Finset.exists_mem_eq_sup' hJne (fun i => (g i).natDegree)
    have hgj : g j ≠ 0 := (Finset.mem_filter.mp hjJ).2
    have hajm : (g j).coeff m ≠ 0 := by
      rw [hm, hjm]
      exact Polynomial.leadingCoeff_ne_zero.mpr hgj
    refine ⟨m, ?_, ?_⟩
    · rw [hcoeff]
      simp only [fun i => squareTopCoeff_necSuf (g i) m (hbound i)]
      have hterm : ∀ i ∈ (Finset.univ : Finset ι),
          c i * ((g i).coeff m * (g i).coeff m) = 0 ∨
            c i * ((g i).coeff m * (g i).coeff m) ∈ C := by
        intro i _
        by_cases hai : (g i).coeff m = 0
        · left; rw [hai, mul_zero, mul_zero]
        · right
          exact hmul _ _ (hc i) (hsq _ (hg i m) hai)
      have hjC : c j * ((g j).coeff m * (g j).coeff m) ∈ C :=
        hmul _ _ (hc j) (hsq _ (hg j m) hajm)
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j)]
      have hrest := sum_mem_of_zero_or_mem_necSuf C hadd ((Finset.univ : Finset ι).erase j)
        (fun i => c i * ((g i).coeff m * (g i).coeff m))
        (fun i hi => hterm i (Finset.mem_of_mem_erase hi))
      have hsum : c j * ((g j).coeff m * (g j).coeff m) +
          ∑ i ∈ (Finset.univ : Finset ι).erase j, c i * ((g i).coeff m * (g i).coeff m) ∈ C := by
        rcases hrest with h0 | h1
        · rw [h0, add_zero]; exact hjC
        · exact hadd _ _ hjC h1
      rw [Polynomial.coeff_one]
      by_cases h2m : 2 * m = 0
      · rw [if_pos h2m]; exact hadd _ _ h1C hsum
      · rw [if_neg h2m, zero_add]; exact hsum
    · intro k hk
      rw [hcoeff, Polynomial.coeff_one, if_neg (by omega), zero_add]
      apply Finset.sum_eq_zero
      intro i _
      rw [squareCoeffBound_necSuf (g i) m (hbound i) k hk, mul_zero]

end Ising2DLambda.NecSuf.FisherZero
