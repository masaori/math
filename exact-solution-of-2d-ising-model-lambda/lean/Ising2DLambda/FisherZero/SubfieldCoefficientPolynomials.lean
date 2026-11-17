/-
人手証明の主張「代数的数の部分体は有理数をすべて含む」（ラベル `claim_subfield_contains_rationals`）、
定義「部分体を係数とする多項式」（ラベル `def_subfield_coefficient_polynomials`）、
主張「各代数的数は部分体を係数とする零でない多項式の根である」
（ラベル `claim_subfield_coefficient_vanishing_polynomial_exists`）、
定義「代数的数の部分体上の次数」（ラベル `def_degree_over_subfield`）の具体版。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalIndeterminatePow
import Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_subfield_contains_rationals` の段 1: 自然数 `n` の像は `F` の元である（`n` についての帰納法）。 -/
theorem natCast_mem_subfield (F : Subfield Qbar) (n : ℕ) : (n : Qbar) ∈ F := by
  induction n with
  | zero => rw [Nat.cast_zero]; exact F.zero_mem
  | succ n ih => rw [Nat.cast_succ]; exact F.add_mem ih F.one_mem

/-- `claim_subfield_contains_rationals` の段 2: 整数 `m` の像は `F` の元である
（`m ≥ 0` なら段 1、`m < 0` なら `m = -(n+1)` と段 1 と符号反転）。 -/
theorem intCast_mem_subfield (F : Subfield Qbar) (m : ℤ) : (m : Qbar) ∈ F := by
  cases m with
  | ofNat n => rw [Int.ofNat_eq_natCast, Int.cast_natCast]; exact natCast_mem_subfield F n
  | negSucc n =>
    rw [Int.cast_negSucc]
    exact F.neg_mem (by exact_mod_cast natCast_mem_subfield F (n + 1))

/-- `claim_subfield_contains_rationals` の具体版。`q = q.num / q.den`（分母は零でない自然数）と段 1・段 2・商の閉性。 -/
theorem ratCast_mem_subfield (F : Subfield Qbar) (q : ℚ) : (q : Qbar) ∈ F := by
  rw [Rat.cast_def]
  exact F.div_mem (intCast_mem_subfield F q.num) (natCast_mem_subfield F q.den)

/-- `def_subfield_coefficient_polynomials` の具体版。全ての係数が `F` に属する `Qbar[t]` の元の全体 `F[t]`。 -/
def subfieldCoefficientPolynomials (F : Subfield Qbar) : Set QbarPoly :=
  {f | ∀ k : ℕ, f.coeff k ∈ F}

/-- `claim_subfield_coefficient_vanishing_polynomial_exists` の具体版。
`def_algebraic_numbers` の第三条件（有理係数の零でない多項式 `p` の根であること）から、`p` の係数を
`Qbar` へ送った多項式 `f` を取る。`f` の係数は有理数の像なので `F` に属し（`ratCast_mem_subfield`）、
有理数の包含は単射なので `f ≠ 0`、値は `p` の値に等しく零である。 -/
theorem subfieldCoefficientVanishingPolynomial_exists (F : Subfield Qbar) (α : Qbar) :
    ∃ f : QbarPoly, f ∈ subfieldCoefficientPolynomials F ∧ f ≠ 0 ∧ qbarPolyEval α f = 0 := by
  -- 第三条件: 有理係数の零でない多項式 p で α が根であるもの
  obtain ⟨p, hp0, hpα⟩ := Algebra.IsAlgebraic.isAlgebraic (R := ℚ) α
  refine ⟨p.map (algebraMap ℚ Qbar), ?_, ?_, ?_⟩
  · -- 係数 ac_k(f) = ι(ac_k(p)) は有理数の像なので F の元
    intro k
    rw [Polynomial.coeff_map, eq_ratCast]
    exact ratCast_mem_subfield F _
  · -- 有理数の包含は単射なので f ≠ 0
    exact (Polynomial.map_ne_zero_iff (algebraMap ℚ Qbar).injective).mpr hp0
  · -- aev_α(f) は p の α での値に等しく、零である
    rw [qbarPolyEval_eq_eval, Polynomial.eval_map_algebraMap]
    exact hpα

/-- `def_degree_over_subfield` の集合 `D_F(α)` が空でないこと（存在の主張と、係数の上界として
`f` の次数を取れること）。 -/
theorem degreeOverSubfield_set_nonempty (F : Subfield Qbar) (α : Qbar) :
    ∃ d : ℕ, ∃ f : QbarPoly, f ∈ subfieldCoefficientPolynomials F ∧ f ≠ 0 ∧
      (∀ k : ℕ, d < k → f.coeff k = 0) ∧ qbarPolyEval α f = 0 := by
  obtain ⟨f, hf, hf0, hfα⟩ := subfieldCoefficientVanishingPolynomial_exists F α
  exact ⟨f.natDegree, f, hf, hf0, fun k hk => Polynomial.coeff_eq_zero_of_natDegree_lt hk, hfα⟩

/-- `def_degree_over_subfield` の具体版。`D_F(α)` の最小元 `deg_F(α)`。 -/
noncomputable def degreeOverSubfield (F : Subfield Qbar) (α : Qbar) : ℕ := by
  classical
  exact Nat.find (degreeOverSubfield_set_nonempty F α)

/-- `deg_F(α)` は `D_F(α)` に属する。 -/
theorem degreeOverSubfield_spec (F : Subfield Qbar) (α : Qbar) :
    ∃ f : QbarPoly, f ∈ subfieldCoefficientPolynomials F ∧ f ≠ 0 ∧
      (∀ k : ℕ, degreeOverSubfield F α < k → f.coeff k = 0) ∧ qbarPolyEval α f = 0 := by
  classical
  exact Nat.find_spec (degreeOverSubfield_set_nonempty F α)

/-- `deg_F(α)` は `D_F(α)` の任意の元以下である。 -/
theorem degreeOverSubfield_le (F : Subfield Qbar) (α : Qbar) (d : ℕ) (f : QbarPoly)
    (hf : f ∈ subfieldCoefficientPolynomials F) (hf0 : f ≠ 0)
    (hbound : ∀ k : ℕ, d < k → f.coeff k = 0) (hfα : qbarPolyEval α f = 0) :
    degreeOverSubfield F α ≤ d := by
  classical
  exact Nat.find_min' (degreeOverSubfield_set_nonempty F α) ⟨f, hf, hf0, hbound, hfα⟩

end Ising2DLambda.FisherZero
