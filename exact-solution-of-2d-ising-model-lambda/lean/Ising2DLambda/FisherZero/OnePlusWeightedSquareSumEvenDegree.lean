/-
節「正錐を係数とする平方和に一を足した多項式は偶数次である」の具体版。

  人手証明                                                  このファイル
  零でない元の平方は正錐に属する                            `mul_self_mem_of_isSubfieldPositiveCone`
  （`claim_subfield_positive_cone_contains_nonzero_squares`）
  係数の上界の二倍の番号の、平方の係数                      `qbarPolySquareTopCoeff`
  （`claim_qbar_poly_square_top_coefficient`）
  主張（`claim_one_plus_weighted_square_sum_polynomial_even_degree`）
    零か正錐の元である項の和の段                            `sum_mem_of_zero_or_mem`
    全ての g(i) が零の場合                                  `onePlusWeightedSquareSum_evenDegree` の前半
    m を最大の次数に取る場合                                `onePlusWeightedSquareSum_evenDegree` の後半

本文の「零でない多項式 f の係数が零でない番号の最大値」は `Polynomial.natDegree`
（定義の対応。`Polynomial.coeff_eq_zero_of_natDegree_lt` と `Polynomial.leadingCoeff_ne_zero`）で読む。
積の係数は `def_qbar_polynomial_ring` の約束（`Polynomial.coeff_mul`）。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.PositiveWeightedSquareSums
import Ising2DLambda.FisherZero.SubfieldCoefficientPolynomials
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyProductCoeffBound

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_subfield_positive_cone_contains_nonzero_squares` の具体版。`a ∈ F`、`a ≠ 0` なら
三分法により `a ∈ C` か `-a ∈ C` で、どちらでも積の条件から `a · a ∈ C`。 -/
theorem mul_self_mem_of_isSubfieldPositiveCone (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) (a : Qbar) (ha : a ∈ F) (ha0 : a ≠ 0) :
    a * a ∈ CF := by
  obtain ⟨hone, _⟩ := hCF.trichotomy a ha
  rcases hone with h0 | h1 | hm1
  · exact absurd h0 ha0
  · exact hCF.mul_mem _ _ h1 h1
  · have h := hCF.mul_mem _ _ hm1 hm1
    rw [neg_mul_neg] at h
    exact h

/-- `claim_qbar_poly_square_top_coefficient` の具体版。`k > m` で係数が零の `f` について、
`ac_{2m}(f·f) = ac_m(f)·ac_m(f)`。積の係数の和のうち、番号の組 `(m, m)` 以外の項は、
第一成分が `m` より大きいか、第二成分が `m` より大きいので零である。 -/
theorem qbarPolySquareTopCoeff (f : QbarPoly) (m : ℕ) (hf : ∀ k, m < k → f.coeff k = 0) :
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

/-- 本文の段「零か `C` の元である項の有限和は、零か `C` の元である」（項の個数についての帰納法）。 -/
theorem sum_mem_of_zero_or_mem (CF : Set Qbar)
    (hadd : ∀ a b : Qbar, a ∈ CF → b ∈ CF → a + b ∈ CF)
    {ι : Type} (s : Finset ι) (u : ι → Qbar) (hu : ∀ i ∈ s, u i = 0 ∨ u i ∈ CF) :
    (∑ i ∈ s, u i) = 0 ∨ (∑ i ∈ s, u i) ∈ CF := by
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

/-- `claim_one_plus_weighted_square_sum_polynomial_even_degree` の具体版。
`P = 1 + ∑ ĉ(i)·(g(i)·g(i))` は零でなく、ある `m` について `ac_{2m}(P) ∈ C_F` かつ
`k > 2m` で `ac_k(P) = 0`。 -/
theorem onePlusWeightedSquareSum_evenDegree (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) {ι : Type} [Fintype ι] (c : ι → Qbar) (g : ι → QbarPoly)
    (hc : ∀ i, c i ∈ CF) (hg : ∀ i, g i ∈ subfieldCoefficientPolynomials F) :
    (1 + ∑ i, qbarConst (c i) * (g i * g i)) ≠ 0 ∧
      ∃ m : ℕ, (1 + ∑ i, qbarConst (c i) * (g i * g i)).coeff (2 * m) ∈ CF ∧
        ∀ k : ℕ, 2 * m < k → (1 + ∑ i, qbarConst (c i) * (g i * g i)).coeff k = 0 := by
  classical
  -- 係数の式: ac_k(P) = ac_k(1) + ∑ c(i)·ac_k(g(i)·g(i))（和の係数、定数多項式との積の係数）
  have hcoeff : ∀ k : ℕ, (1 + ∑ i, qbarConst (c i) * (g i * g i)).coeff k =
      (1 : QbarPoly).coeff k + ∑ i, c i * (g i * g i).coeff k := by
    intro k
    rw [Polynomial.coeff_add, Polynomial.finsetSum_coeff]
    simp only [qbarConst, Polynomial.coeff_C_mul]
  -- 1 ∈ C_F（`claim_subfield_positive_cone_contains_nonzero_squares` を a = 1 に当てる）
  have h1C : (1 : Qbar) ∈ CF := by
    have h := mul_self_mem_of_isSubfieldPositiveCone F CF hCF 1 F.one_mem one_ne_zero
    rw [mul_one] at h
    exact h
  -- 正錐の元は零でない（三分法の排他性）
  have hne : ∀ z : Qbar, z ∈ CF → z ≠ 0 := by
    intro z hz h0
    exact (hCF.trichotomy z (hCF.subset z hz)).2.1 ⟨h0, hz⟩
  -- 結論の前半は後半から従う
  suffices hmain : ∃ m : ℕ, (1 + ∑ i, qbarConst (c i) * (g i * g i)).coeff (2 * m) ∈ CF ∧
      ∀ k : ℕ, 2 * m < k → (1 + ∑ i, qbarConst (c i) * (g i * g i)).coeff k = 0 by
    obtain ⟨m, hm, hz⟩ := hmain
    refine ⟨?_, m, hm, hz⟩
    intro hP
    rw [hP, Polynomial.coeff_zero] at hm
    exact hne 0 hm rfl
  by_cases hall : ∀ i, g i = 0
  · -- 全ての g(i) が零: P の係数は ac_k(1) で、m = 0
    refine ⟨0, ?_, ?_⟩
    · rw [hcoeff, mul_zero, Polynomial.coeff_one_zero]
      simp only [hall, mul_zero, Polynomial.coeff_zero, Finset.sum_const_zero, add_zero]
      exact h1C
    · intro k hk
      rw [hcoeff, Polynomial.coeff_one, if_neg (by omega)]
      simp only [hall, mul_zero, Polynomial.coeff_zero, Finset.sum_const_zero, add_zero]
  · -- 零でない g(i) がある: m を零でない g(i) の次数の最大値に取る
    push Not at hall
    obtain ⟨i0, hi0⟩ := hall
    set J : Finset ι := Finset.univ.filter (fun i => g i ≠ 0) with hJ
    have hJne : J.Nonempty := ⟨i0, by rw [hJ, Finset.mem_filter]; exact ⟨Finset.mem_univ _, hi0⟩⟩
    set m : ℕ := J.sup' hJne (fun i => (g i).natDegree) with hm
    -- 任意の i と k > m で ac_k(g(i)) = 0
    have hbound : ∀ i, ∀ k : ℕ, m < k → (g i).coeff k = 0 := by
      intro i k hk
      by_cases hgi : g i = 0
      · rw [hgi, Polynomial.coeff_zero]
      · have hiJ : i ∈ J := by rw [hJ, Finset.mem_filter]; exact ⟨Finset.mem_univ _, hgi⟩
        have hle : (g i).natDegree ≤ m := Finset.le_sup' (fun i => (g i).natDegree) hiJ
        exact Polynomial.coeff_eq_zero_of_natDegree_lt (by omega)
    -- 最大値を取る j: g(j) ≠ 0 かつ deg g(j) = m なので ac_m(g(j)) ≠ 0
    obtain ⟨j, hjJ, hjm⟩ := Finset.exists_mem_eq_sup' hJne (fun i => (g i).natDegree)
    have hgj : g j ≠ 0 := (Finset.mem_filter.mp hjJ).2
    have hajm : (g j).coeff m ≠ 0 := by
      rw [hm, hjm]
      exact Polynomial.leadingCoeff_ne_zero.mpr hgj
    refine ⟨m, ?_, ?_⟩
    · -- ac_{2m}(P) = ac_{2m}(1) + ∑ c(i)·(ac_m(g(i))·ac_m(g(i)))
      rw [hcoeff]
      simp only [fun i => qbarPolySquareTopCoeff (g i) m (hbound i)]
      -- 各項は零か C_F の元
      have hterm : ∀ i ∈ (Finset.univ : Finset ι),
          c i * ((g i).coeff m * (g i).coeff m) = 0 ∨
            c i * ((g i).coeff m * (g i).coeff m) ∈ CF := by
        intro i _
        by_cases hai : (g i).coeff m = 0
        · left; rw [hai, mul_zero, mul_zero]
        · right
          exact hCF.mul_mem _ _ (hc i)
            (mul_self_mem_of_isSubfieldPositiveCone F CF hCF _ (hg i m) hai)
      have hjC : c j * ((g j).coeff m * (g j).coeff m) ∈ CF :=
        hCF.mul_mem _ _ (hc j) (mul_self_mem_of_isSubfieldPositiveCone F CF hCF _ (hg j m) hajm)
      -- j の項と残りの和に分ける
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j)]
      have hrest := sum_mem_of_zero_or_mem CF hCF.add_mem ((Finset.univ : Finset ι).erase j)
        (fun i => c i * ((g i).coeff m * (g i).coeff m))
        (fun i hi => hterm i (Finset.mem_of_mem_erase hi))
      have hsum : c j * ((g j).coeff m * (g j).coeff m) +
          ∑ i ∈ (Finset.univ : Finset ι).erase j, c i * ((g i).coeff m * (g i).coeff m) ∈ CF := by
        rcases hrest with h0 | h1
        · rw [h0, add_zero]; exact hjC
        · exact hCF.add_mem _ _ hjC h1
      -- ac_{2m}(1) は零か 1
      rw [Polynomial.coeff_one]
      by_cases h2m : 2 * m = 0
      · rw [if_pos h2m]; exact hCF.add_mem _ _ h1C hsum
      · rw [if_neg h2m, zero_add]; exact hsum
    · -- k > 2m: ac_k(1) = 0、ac_k(g(i)·g(i)) = 0（`claim_qbar_poly_product_coeff_bound`）
      intro k hk
      rw [hcoeff, Polynomial.coeff_one, if_neg (by omega), zero_add]
      apply Finset.sum_eq_zero
      intro i _
      rw [qbarPolyProductCoeffBound (g i) (g i) m m (hbound i) (hbound i) k (by omega), mul_zero]

end Ising2DLambda.FisherZero
