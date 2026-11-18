/-
節「部分体に元を代入した値の全体は部分体である」の必要十分版。

具体版と同じ段で示す。係数の集合 `S ⊆ K` と、`S` を係数とする多項式に `α` を代入した値の全体
`polynomialValuesNecSuf S α` について、各段が実際に使う性質だけを仮定に置く。

- 定数項と不定元で割った残りへの分解: 台は可換でなくてよい（`Semiring`）。係数の集合は現れない。
- 係数の集合を係数とする多項式の和・積の閉性: `S` が零元を含み、和と積で閉じること。
  有限和の帰納法の基底に零元が要る。符号反転の閉性には `S` の符号反転の閉性と台の加法の逆元（`Ring`）が要る。
- 値の全体が係数の集合を含む: `S` が零元を含むこと（定数多項式の一次以上の係数）。
- 値の全体が `α` を含む: `S` が零元と単位元を含むこと（不定元の係数）。
- 値の全体の和・積の閉性: 上の閉性に加えて、代入が積を保つための台の積の可換性（`CommSemiring`）。
- 値の全体の元を代入した値: 冪の帰納法の基底に単位元、有限和の帰納法の基底に零元が要る。
- 定数項が零でない段: 最小性 `hmin`（具体版では `degreeOverSubfield_le`）と、`y · a = 0` から `a = 0` を
  出すための `y` の逆元（台が体）。`S` の閉性は使わない。
- 逆元: 定数項の逆元の符号反転が `S` に属すること（`S` の逆元と符号反転の閉性）。
-/
import Ising2DLambda.NecSuf.FisherZero.MinimalVanishingPolynomialDivides
import Mathlib.Algebra.Polynomial.Inductions

namespace Ising2DLambda.NecSuf.FisherZero

open Polynomial

/-- 係数の集合 `S` を係数とする多項式に `α` を代入した値の全体。 -/
def polynomialValuesNecSuf {K : Type*} [Semiring K] (S : Set K) (α : K) : Set K :=
  {y | ∃ g : K[X], (∀ k : ℕ, g.coeff k ∈ S) ∧ g.eval α = y}

/-- 不定元を掛けた多項式の係数の段（具体版 `indeterminateMulCoeff` と同じ段）。 -/
theorem indeterminateMulCoeff_necSuf {K : Type*} [Semiring K] (q : K[X]) (k : ℕ) :
    (X * q).coeff k = if k = 0 then 0 else q.coeff (k - 1) := by
  rw [Polynomial.coeff_mul]
  rcases k with _ | k
  · rw [if_pos rfl, Finset.sum_eq_single ((0, 0) : ℕ × ℕ)]
    · rw [Polynomial.coeff_X_zero, zero_mul]
    · intro b hb hne
      have hb' : b.1 + b.2 = 0 := Finset.mem_antidiagonal.mp hb
      exact absurd (Prod.ext (by omega) (by omega)) hne
    · intro h
      exact absurd (Finset.mem_antidiagonal.mpr (by simp : (0 : ℕ) + 0 = 0)) h
  · rw [if_neg (Nat.succ_ne_zero k), Nat.add_sub_cancel, Finset.sum_eq_single ((1, k) : ℕ × ℕ)]
    · rw [Polynomial.coeff_X_one, one_mul]
    · intro b hb hne
      have hb' : b.1 + b.2 = k + 1 := Finset.mem_antidiagonal.mp hb
      have hb1 : b.1 ≠ 1 := by
        intro h1
        exact hne (Prod.ext h1 (by simp only; omega))
      rw [Polynomial.coeff_X_of_ne_one hb1, zero_mul]
    · intro h
      exact absurd (Finset.mem_antidiagonal.mpr (by omega)) h

/-- 定数項と不定元で割った残りへの分解（具体版 `qbarPolyConstantTermShift` と同じ段）。 -/
theorem constantTermShift_necSuf {K : Type*} [Semiring K] (p : K[X]) :
    ∃ p' : K[X], (∀ k : ℕ, p'.coeff k = p.coeff (k + 1)) ∧ p = C (p.coeff 0) + X * p' := by
  refine ⟨Polynomial.divX p, fun k => Polynomial.coeff_divX, ?_⟩
  apply Polynomial.ext
  intro k
  rw [Polynomial.coeff_add, indeterminateMulCoeff_necSuf, Polynomial.coeff_C]
  rcases k with _ | k
  · rw [if_pos rfl, if_pos rfl, add_zero]
  · rw [if_neg (Nat.succ_ne_zero k), if_neg (Nat.succ_ne_zero k), zero_add, Nat.add_sub_cancel,
      Polynomial.coeff_divX]

/-- 和の閉性（具体版 `subfieldCoefficientPolynomials_add_mem` と同じ段）。 -/
theorem coefficientPolynomials_add_mem_necSuf {K : Type*} [Semiring K] (S : Set K)
    (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S) (f g : K[X])
    (hf : ∀ k : ℕ, f.coeff k ∈ S) (hg : ∀ k : ℕ, g.coeff k ∈ S) : ∀ k : ℕ, (f + g).coeff k ∈ S := by
  intro k
  rw [Polynomial.coeff_add]
  exact hadd _ _ (hf k) (hg k)

/-- 符号反転の閉性（具体版 `subfieldCoefficientPolynomials_neg_mem` と同じ段）。 -/
theorem coefficientPolynomials_neg_mem_necSuf {K : Type*} [Ring K] (S : Set K)
    (hneg : ∀ a : K, a ∈ S → -a ∈ S) (f : K[X]) (hf : ∀ k : ℕ, f.coeff k ∈ S) :
    ∀ k : ℕ, (-f).coeff k ∈ S := by
  intro k
  rw [Polynomial.coeff_neg]
  exact hneg _ (hf k)

/-- 積の閉性（具体版 `subfieldCoefficientPolynomials_mul_mem` と同じ段）。 -/
theorem coefficientPolynomials_mul_mem_necSuf {K : Type*} [Semiring K] (S : Set K) (h0 : (0 : K) ∈ S)
    (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S) (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (f g : K[X]) (hf : ∀ k : ℕ, f.coeff k ∈ S) (hg : ∀ k : ℕ, g.coeff k ∈ S) :
    ∀ k : ℕ, (f * g).coeff k ∈ S := by
  intro k
  rw [Polynomial.coeff_mul]
  induction (Finset.antidiagonal k) using Finset.induction_on with
  | empty => rw [Finset.sum_empty]; exact h0
  | insert a s ha ih =>
      rw [Finset.sum_insert ha]
      exact hadd _ _ (hmul _ _ (hf a.1) (hg a.2)) ih

/-- 値の全体は係数の集合を含む（具体版 `subfield_subset_subfieldPolynomialValues` と同じ段）。 -/
theorem subset_polynomialValues_necSuf {K : Type*} [Semiring K] (S : Set K) (h0 : (0 : K) ∈ S)
    (α c : K) (hc : c ∈ S) : c ∈ polynomialValuesNecSuf S α := by
  refine ⟨C c, ?_, Polynomial.eval_C⟩
  intro k
  rw [Polynomial.coeff_C]
  split_ifs
  · exact hc
  · exact h0

/-- 値の全体は `α` を含む（具体版 `element_mem_subfieldPolynomialValues` と同じ段）。 -/
theorem element_mem_polynomialValues_necSuf {K : Type*} [Semiring K] (S : Set K) (h0 : (0 : K) ∈ S)
    (h1 : (1 : K) ∈ S) (α : K) : α ∈ polynomialValuesNecSuf S α := by
  refine ⟨X, ?_, Polynomial.eval_X⟩
  intro k
  rw [Polynomial.coeff_X]
  split_ifs
  · exact h1
  · exact h0

/-- 値の全体の和の閉性（具体版 `subfieldPolynomialValues_add_mem` と同じ段）。 -/
theorem polynomialValues_add_mem_necSuf {K : Type*} [Semiring K] (S : Set K)
    (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S) (α y z : K)
    (hy : y ∈ polynomialValuesNecSuf S α) (hz : z ∈ polynomialValuesNecSuf S α) :
    y + z ∈ polynomialValuesNecSuf S α := by
  obtain ⟨g, hg, hgy⟩ := hy
  obtain ⟨h, hh, hhz⟩ := hz
  exact ⟨g + h, coefficientPolynomials_add_mem_necSuf S hadd g h hg hh, by
    rw [Polynomial.eval_add, hgy, hhz]⟩

/-- 値の全体の積の閉性（具体版 `subfieldPolynomialValues_mul_mem` と同じ段）。
代入が積を保つ段（`Polynomial.eval_mul`）に台の積の可換性が要る。 -/
theorem polynomialValues_mul_mem_necSuf {K : Type*} [CommSemiring K] (S : Set K) (h0 : (0 : K) ∈ S)
    (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S) (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (α y z : K) (hy : y ∈ polynomialValuesNecSuf S α) (hz : z ∈ polynomialValuesNecSuf S α) :
    y * z ∈ polynomialValuesNecSuf S α := by
  obtain ⟨g, hg, hgy⟩ := hy
  obtain ⟨h, hh, hhz⟩ := hz
  exact ⟨g * h, coefficientPolynomials_mul_mem_necSuf S h0 hadd hmul g h hg hh, by
    rw [Polynomial.eval_mul, hgy, hhz]⟩

/-- 値の全体の符号反転の閉性（具体版 `subfieldPolynomialValues_neg_mem` と同じ段）。 -/
theorem polynomialValues_neg_mem_necSuf {K : Type*} [Ring K] (S : Set K)
    (hneg : ∀ a : K, a ∈ S → -a ∈ S) (α y : K) (hy : y ∈ polynomialValuesNecSuf S α) :
    -y ∈ polynomialValuesNecSuf S α := by
  obtain ⟨g, hg, hgy⟩ := hy
  exact ⟨-g, coefficientPolynomials_neg_mem_necSuf S hneg g hg, by rw [Polynomial.eval_neg, hgy]⟩

/-- 値の全体の元を代入した値（具体版 `subfieldPolynomialValues_eval_mem` と同じ段）。 -/
theorem polynomialValues_eval_mem_necSuf {K : Type*} [CommSemiring K] (S : Set K) (h0 : (0 : K) ∈ S)
    (h1 : (1 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S) (α y : K) (hy : y ∈ polynomialValuesNecSuf S α)
    (h : K[X]) (hh : ∀ k : ℕ, h.coeff k ∈ S) : h.eval y ∈ polynomialValuesNecSuf S α := by
  have hpow : ∀ k : ℕ, y ^ k ∈ polynomialValuesNecSuf S α := by
    intro k
    induction k with
    | zero => rw [pow_zero]; exact subset_polynomialValues_necSuf S h0 α 1 h1
    | succ k ih =>
        rw [pow_succ]
        exact polynomialValues_mul_mem_necSuf S h0 hadd hmul α _ _ ih hy
  rw [Polynomial.eval_eq_sum, Polynomial.sum_def]
  induction h.support using Finset.induction_on with
  | empty => rw [Finset.sum_empty]; exact subset_polynomialValues_necSuf S h0 α 0 h0
  | insert a s ha ih =>
      rw [Finset.sum_insert ha]
      exact polynomialValues_add_mem_necSuf S hadd α _ _
        (polynomialValues_mul_mem_necSuf S h0 hadd hmul α _ _
          (subset_polynomialValues_necSuf S h0 α _ (hh a)) (hpow a)) ih

/-- 定数項が零でない段（具体版 `minimalVanishingPolynomial_constantTerm_ne_zero` と同じ段）。
`y · aev_y(p') = 0` から `aev_y(p') = 0` を出す段に `y` の逆元が要る。 -/
theorem minimalVanishingPolynomial_constantTerm_ne_zero_necSuf {K : Type*} [Field K] (S : Set K)
    (y : K) (hy0 : y ≠ 0) (n : ℕ)
    (hmin : ∀ (d : ℕ) (q : K[X]), (∀ k : ℕ, q.coeff k ∈ S) → q ≠ 0 →
      (∀ k : ℕ, d < k → q.coeff k = 0) → q.eval y = 0 → n ≤ d)
    (p : K[X]) (hp : ∀ k : ℕ, p.coeff k ∈ S) (hp0 : p ≠ 0)
    (htop : ∀ k : ℕ, n < k → p.coeff k = 0) (hpy : p.eval y = 0) : p.coeff 0 ≠ 0 := by
  intro hc
  obtain ⟨p', hp'coeff, hpeq⟩ := constantTermShift_necSuf p
  have hp'S : ∀ k : ℕ, p'.coeff k ∈ S := fun k => by rw [hp'coeff]; exact hp (k + 1)
  have hpeq' : p = X * p' := by rw [hpeq, hc, Polynomial.C_0, zero_add]
  have hprod : y * p'.eval y = 0 := by
    calc y * p'.eval y = (X * p').eval y := by rw [Polynomial.eval_mul, Polynomial.eval_X]
      _ = p.eval y := by rw [← hpeq']
      _ = 0 := hpy
  have hp'y : p'.eval y = 0 := by
    calc p'.eval y = y⁻¹ * (y * p'.eval y) := by rw [← mul_assoc, inv_mul_cancel₀ hy0, one_mul]
      _ = y⁻¹ * 0 := by rw [hprod]
      _ = 0 := mul_zero _
  have hp'z : ∀ k : ℕ, n ≤ k → p'.coeff k = 0 := fun k hk => by
    rw [hp'coeff]; exact htop (k + 1) (by omega)
  have hp'0 : p' = 0 := vanishingPolynomial_below_degree_eq_zero_necSuf S y n hmin p' hp'S hp'y hp'z
  exact hp0 (by rw [hpeq', hp'0, mul_zero])

/-- 逆元（具体版 `subfieldPolynomialValues_inv_mem` と同じ段）。最小性の証人 `p` は仮定で受ける
（具体版では `degreeOverSubfield_spec`）。 -/
theorem polynomialValues_inv_mem_necSuf {K : Type*} [Field K] (S : Set K) (h0 : (0 : K) ∈ S)
    (h1 : (1 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S) (hneg : ∀ a : K, a ∈ S → -a ∈ S)
    (hinv : ∀ a : K, a ∈ S → a⁻¹ ∈ S) (α y : K) (hy : y ∈ polynomialValuesNecSuf S α) (hy0 : y ≠ 0)
    (n : ℕ)
    (hmin : ∀ (d : ℕ) (q : K[X]), (∀ k : ℕ, q.coeff k ∈ S) → q ≠ 0 →
      (∀ k : ℕ, d < k → q.coeff k = 0) → q.eval y = 0 → n ≤ d)
    (p : K[X]) (hp : ∀ k : ℕ, p.coeff k ∈ S) (hp0 : p ≠ 0)
    (htop : ∀ k : ℕ, n < k → p.coeff k = 0) (hpy : p.eval y = 0) :
    y⁻¹ ∈ polynomialValuesNecSuf S α := by
  have hc0 : p.coeff 0 ≠ 0 :=
    minimalVanishingPolynomial_constantTerm_ne_zero_necSuf S y hy0 n hmin p hp hp0 htop hpy
  obtain ⟨p', hp'coeff, hpeq⟩ := constantTermShift_necSuf p
  have hp'S : ∀ k : ℕ, p'.coeff k ∈ S := fun k => by rw [hp'coeff]; exact hp (k + 1)
  have hval : p.coeff 0 + y * p'.eval y = 0 := by
    calc p.coeff 0 + y * p'.eval y = (C (p.coeff 0) + X * p').eval y := by
          rw [Polynomial.eval_add, Polynomial.eval_mul, Polynomial.eval_C, Polynomial.eval_X]
      _ = p.eval y := by rw [← hpeq]
      _ = 0 := hpy
  have hyz : y * (-(p.coeff 0)⁻¹ * p'.eval y) = 1 := by
    calc y * (-(p.coeff 0)⁻¹ * p'.eval y) = -(p.coeff 0)⁻¹ * (y * p'.eval y) := by ring
      _ = -(p.coeff 0)⁻¹ * (-(p.coeff 0)) := by rw [eq_neg_of_add_eq_zero_right hval]
      _ = (p.coeff 0)⁻¹ * p.coeff 0 := by ring
      _ = 1 := inv_mul_cancel₀ hc0
  have hinvEq : y⁻¹ = -(p.coeff 0)⁻¹ * p'.eval y := by
    calc y⁻¹ = y⁻¹ * (y * (-(p.coeff 0)⁻¹ * p'.eval y)) := by rw [hyz, mul_one]
      _ = (y⁻¹ * y) * (-(p.coeff 0)⁻¹ * p'.eval y) := by rw [mul_assoc]
      _ = -(p.coeff 0)⁻¹ * p'.eval y := by rw [inv_mul_cancel₀ hy0, one_mul]
  rw [hinvEq]
  exact polynomialValues_mul_mem_necSuf S h0 hadd hmul α _ _
    (subset_polynomialValues_necSuf S h0 α _ (hneg _ (hinv _ (hp 0))))
    (polynomialValues_eval_mem_necSuf S h0 h1 hadd hmul α y hy p' hp'S)

end Ising2DLambda.NecSuf.FisherZero
