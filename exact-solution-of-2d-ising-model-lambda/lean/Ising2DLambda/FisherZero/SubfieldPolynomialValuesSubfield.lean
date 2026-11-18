/-
節「部分体に元を代入した値の全体は部分体である」の具体版。

  人手証明                                                    このファイル
  不定元を掛けた多項式の係数の段                              `indeterminateMulCoeff`
  定数項と不定元で割った残りへの分解                          `qbarPolyConstantTermShift`
    （ラベル `claim_qbar_poly_constant_term_shift_decomposition`）
  部分体係数の多項式は和・積・符号反転で閉じる                `subfieldCoefficientPolynomials_add_mem` ほか
    （ラベル `claim_subfield_coefficient_polynomials_ring_closed`）
  部分体は代入した値の全体に含まれる                          `subfield_subset_subfieldPolynomialValues`
    （ラベル `claim_subfield_polynomial_values_contains_subfield`）
  代入した元は代入した値の全体に属する                        `element_mem_subfieldPolynomialValues`
    （ラベル `claim_subfield_polynomial_values_contains_element`）
  代入した値の全体は和・積・符号反転で閉じる                  `subfieldPolynomialValues_add_mem` ほか
    （ラベル `claim_subfield_polynomial_values_ring_closed`）
  代入した値の全体の元を部分体係数の多項式へ代入した値       `subfieldPolynomialValues_eval_mem`
    （ラベル `claim_subfield_polynomial_values_evaluation_closed`）
  零でない元の最小次数の零化多項式の定数項は零でない          `minimalVanishingPolynomial_constantTerm_ne_zero`
    （ラベル `claim_minimal_vanishing_polynomial_constant_term_nonzero`）
  代入した値の全体は部分体である                              `subfieldPolynomialValues_inv_mem`、
    （ラベル `claim_subfield_polynomial_values_is_subfield`）     `subfieldPolynomialValuesSubfield`

不定元で割った残り `p'` は mathlib の `Polynomial.divX` を証人に取る（係数の対応
`Polynomial.coeff_divX` は定義の橋渡し）。代入が和と積を保つことは `def_qbar_poly_evaluation` の約束
（`Polynomial.eval_add`・`eval_mul`）。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.MinimalVanishingPolynomialDivides

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 不定元を掛けた多項式の係数の段。`ac_k(t·q)` は `k = 0` なら零元、`k ≥ 1` なら `ac_{k-1}(q)`。 -/
theorem indeterminateMulCoeff (q : QbarPoly) (k : ℕ) :
    (Polynomial.X * q).coeff k = if k = 0 then 0 else q.coeff (k - 1) := by
  -- 積の係数の式 `ac_k(t·q) = Σ_{i=0}^{k} ac_i(t) ac_{k-i}(q)`。
  rw [Polynomial.coeff_mul]
  rcases k with _ | k
  · -- k = 0: 唯一の項 ac_0(t) ac_0(q) = 0 · ac_0(q) = 0。
    rw [if_pos rfl, Finset.sum_eq_single ((0, 0) : ℕ × ℕ)]
    · rw [Polynomial.coeff_X_zero, zero_mul]
    · intro b hb hne
      have hb' : b.1 + b.2 = 0 := Finset.mem_antidiagonal.mp hb
      exact absurd (Prod.ext (by omega) (by omega)) hne
    · intro h
      exact absurd (Finset.mem_antidiagonal.mpr (by simp : (0 : ℕ) + 0 = 0)) h
  · -- k + 1: i = 1 の項 ac_1(t) ac_k(q) = ac_k(q) だけが残る。
    rw [if_neg (Nat.succ_ne_zero k), Nat.add_sub_cancel, Finset.sum_eq_single ((1, k) : ℕ × ℕ)]
    · rw [Polynomial.coeff_X_one, one_mul]
    · intro b hb hne
      have hb' : b.1 + b.2 = k + 1 := Finset.mem_antidiagonal.mp hb
      have hb1 : b.1 ≠ 1 := by
        intro h1
        exact hne (Prod.ext h1 (by simp only; omega))
      rw [Polynomial.coeff_X_of_ne_one hb1, zero_mul]
    · intro h
      exact absurd (Finset.mem_antidiagonal.mpr (by omega)) h

/-- `claim_qbar_poly_constant_term_shift_decomposition` の具体版。`ac_k(p') = ac_{k+1}(p)` を満たす
`p'` があり、`p = \widehat{ac_0(p)} + t·p'`。 -/
theorem qbarPolyConstantTermShift (p : QbarPoly) :
    ∃ p' : QbarPoly, (∀ k : ℕ, p'.coeff k = p.coeff (k + 1)) ∧
      p = qbarConst (p.coeff 0) + Polynomial.X * p' := by
  refine ⟨Polynomial.divX p, fun k => Polynomial.coeff_divX, ?_⟩
  -- 係数が全て等しい二つの多項式は等しい。
  apply Polynomial.ext
  intro k
  rw [Polynomial.coeff_add, indeterminateMulCoeff, qbarConst, Polynomial.coeff_C]
  rcases k with _ | k
  · -- k = 0: ac_0(p) = ac_0(p) + 0。
    rw [if_pos rfl, if_pos rfl, add_zero]
  · -- k + 1: ac_{k+1}(p) = 0 + ac_k(p') = ac_{k+1}(p)。
    rw [if_neg (Nat.succ_ne_zero k), if_neg (Nat.succ_ne_zero k), zero_add, Nat.add_sub_cancel,
      Polynomial.coeff_divX]

/-- `claim_subfield_coefficient_polynomials_ring_closed` の具体版（和）。 -/
theorem subfieldCoefficientPolynomials_add_mem (F : Subfield Qbar) (f g : QbarPoly)
    (hf : f ∈ subfieldCoefficientPolynomials F) (hg : g ∈ subfieldCoefficientPolynomials F) :
    f + g ∈ subfieldCoefficientPolynomials F := by
  intro k
  rw [Polynomial.coeff_add]
  exact F.add_mem (hf k) (hg k)

/-- `claim_subfield_coefficient_polynomials_ring_closed` の具体版（符号反転）。 -/
theorem subfieldCoefficientPolynomials_neg_mem (F : Subfield Qbar) (f : QbarPoly)
    (hf : f ∈ subfieldCoefficientPolynomials F) : -f ∈ subfieldCoefficientPolynomials F := by
  intro k
  rw [Polynomial.coeff_neg]
  exact F.neg_mem (hf k)

/-- `claim_subfield_coefficient_polynomials_ring_closed` の具体版（積）。各項が `F` に属し、
有限和は項の個数についての帰納法で `F` に属する。 -/
theorem subfieldCoefficientPolynomials_mul_mem (F : Subfield Qbar) (f g : QbarPoly)
    (hf : f ∈ subfieldCoefficientPolynomials F) (hg : g ∈ subfieldCoefficientPolynomials F) :
    f * g ∈ subfieldCoefficientPolynomials F := by
  intro k
  rw [Polynomial.coeff_mul]
  -- 有限和: 零元を含み和で閉じるので、項の個数についての帰納法で閉じる。
  induction (Finset.antidiagonal k) using Finset.induction_on with
  | empty => rw [Finset.sum_empty]; exact F.zero_mem
  | insert a s ha ih =>
      rw [Finset.sum_insert ha]
      exact F.add_mem (F.mul_mem (hf a.1) (hg a.2)) ih

/-- `claim_subfield_polynomial_values_contains_subfield` の具体版。 -/
theorem subfield_subset_subfieldPolynomialValues (F : Subfield Qbar) (α c : Qbar) (hc : c ∈ F) :
    c ∈ subfieldPolynomialValues F α := by
  refine ⟨qbarConst c, ?_, ?_⟩
  · -- ac_0(ĉ) = c ∈ F、k ≥ 1 で ac_k(ĉ) = 0 ∈ F。
    intro k
    rw [qbarConst, Polynomial.coeff_C]
    split_ifs
    · exact hc
    · exact F.zero_mem
  · -- aev_α(ĉ) = c。
    rw [qbarPolyEval_eq_eval, qbarConst, Polynomial.eval_C]

/-- `claim_subfield_polynomial_values_contains_element` の具体版。 -/
theorem element_mem_subfieldPolynomialValues (F : Subfield Qbar) (α : Qbar) :
    α ∈ subfieldPolynomialValues F α := by
  refine ⟨Polynomial.X, ?_, ?_⟩
  · -- ac_1(t) = 1 ∈ F、j ≠ 1 で ac_j(t) = 0 ∈ F。
    intro k
    rw [Polynomial.coeff_X]
    split_ifs
    · exact F.one_mem
    · exact F.zero_mem
  · -- aev_α(t) = α。
    rw [qbarPolyEval_eq_eval, Polynomial.eval_X]

/-- `claim_subfield_polynomial_values_ring_closed` の具体版（和）。 -/
theorem subfieldPolynomialValues_add_mem (F : Subfield Qbar) (α y z : Qbar)
    (hy : y ∈ subfieldPolynomialValues F α) (hz : z ∈ subfieldPolynomialValues F α) :
    y + z ∈ subfieldPolynomialValues F α := by
  obtain ⟨g, hg, hgy⟩ := hy
  obtain ⟨h, hh, hhz⟩ := hz
  refine ⟨g + h, subfieldCoefficientPolynomials_add_mem F g h hg hh, ?_⟩
  -- aev_α(g + h) = aev_α(g) + aev_α(h) = y + z。
  rw [← hgy, ← hhz, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval,
    Polynomial.eval_add]

/-- `claim_subfield_polynomial_values_ring_closed` の具体版（積）。 -/
theorem subfieldPolynomialValues_mul_mem (F : Subfield Qbar) (α y z : Qbar)
    (hy : y ∈ subfieldPolynomialValues F α) (hz : z ∈ subfieldPolynomialValues F α) :
    y * z ∈ subfieldPolynomialValues F α := by
  obtain ⟨g, hg, hgy⟩ := hy
  obtain ⟨h, hh, hhz⟩ := hz
  refine ⟨g * h, subfieldCoefficientPolynomials_mul_mem F g h hg hh, ?_⟩
  -- aev_α(g · h) = aev_α(g) · aev_α(h) = y · z。
  rw [← hgy, ← hhz, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval,
    Polynomial.eval_mul]

/-- `claim_subfield_polynomial_values_ring_closed` の具体版（符号反転）。 -/
theorem subfieldPolynomialValues_neg_mem (F : Subfield Qbar) (α y : Qbar)
    (hy : y ∈ subfieldPolynomialValues F α) : -y ∈ subfieldPolynomialValues F α := by
  obtain ⟨g, hg, hgy⟩ := hy
  refine ⟨-g, subfieldCoefficientPolynomials_neg_mem F g hg, ?_⟩
  -- aev_α(-g) = -aev_α(g) = -y。
  rw [← hgy, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, Polynomial.eval_neg]

/-- `claim_subfield_polynomial_values_evaluation_closed` の具体版。`y ∈ Val_F(α)`、`h ∈ F[t]` なら
`aev_y(h) ∈ Val_F(α)`。 -/
theorem subfieldPolynomialValues_eval_mem (F : Subfield Qbar) (α y : Qbar)
    (hy : y ∈ subfieldPolynomialValues F α) (h : QbarPoly)
    (hh : h ∈ subfieldCoefficientPolynomials F) :
    qbarPolyEval y h ∈ subfieldPolynomialValues F α := by
  -- 冪: y^0 = 1 ∈ Val_F(α)、y^{k+1} = y^k · y ∈ Val_F(α)（k についての帰納法）。
  have hpow : ∀ k : ℕ, y ^ k ∈ subfieldPolynomialValues F α := by
    intro k
    induction k with
    | zero => rw [pow_zero]; exact subfield_subset_subfieldPolynomialValues F α 1 F.one_mem
    | succ k ih =>
        rw [pow_succ]
        exact subfieldPolynomialValues_mul_mem F α _ _ ih hy
  -- aev_y(h) = Σ_{k : ac_k(h) ≠ 0} ac_k(h) · y^k。各項は Val_F(α) に属し、有限和は項の個数についての
  -- 帰納法で Val_F(α) に属する。
  rw [qbarPolyEval]
  induction h.support using Finset.induction_on with
  | empty =>
      rw [Finset.sum_empty]
      exact subfield_subset_subfieldPolynomialValues F α 0 F.zero_mem
  | insert a s ha ih =>
      rw [Finset.sum_insert ha]
      exact subfieldPolynomialValues_add_mem F α _ _
        (subfieldPolynomialValues_mul_mem F α _ _
          (subfield_subset_subfieldPolynomialValues F α _ (hh a)) (hpow a)) ih

/-- `claim_minimal_vanishing_polynomial_constant_term_nonzero` の具体版。 -/
theorem minimalVanishingPolynomial_constantTerm_ne_zero (F : Subfield Qbar) (y : Qbar) (hy0 : y ≠ 0)
    (p : QbarPoly) (hp : p ∈ subfieldCoefficientPolynomials F) (hp0 : p ≠ 0)
    (htop : ∀ k : ℕ, degreeOverSubfield F y < k → p.coeff k = 0) (hpy : qbarPolyEval y p = 0) :
    p.coeff 0 ≠ 0 := by
  intro hc
  -- 分解 p = \widehat{ac_0(p)} + t·p'。
  obtain ⟨p', hp'coeff, hpeq⟩ := qbarPolyConstantTermShift p
  -- p' ∈ F[t]。
  have hp'F : p' ∈ subfieldCoefficientPolynomials F := by
    intro k
    rw [hp'coeff]
    exact hp (k + 1)
  -- p = t·p'。
  have hpeq' : p = Polynomial.X * p' := by
    rw [hpeq, hc, qbarConst, Polynomial.C_0, zero_add]
  -- y · aev_y(p') = aev_y(t·p') = aev_y(p) = 0。
  have hprod : y * qbarPolyEval y p' = 0 := by
    calc y * qbarPolyEval y p'
        = qbarPolyEval y (Polynomial.X * p') := by
          rw [qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, Polynomial.eval_mul, Polynomial.eval_X]
      _ = qbarPolyEval y p := by rw [← hpeq']
      _ = 0 := hpy
  -- y ≠ 0 なので aev_y(p') = 0。
  have hp'y : qbarPolyEval y p' = 0 := by
    calc qbarPolyEval y p'
        = y⁻¹ * (y * qbarPolyEval y p') := by rw [← mul_assoc, inv_mul_cancel₀ hy0, one_mul]
      _ = y⁻¹ * 0 := by rw [hprod]
      _ = 0 := mul_zero _
  -- k ≥ deg_F(y) で ac_k(p') = ac_{k+1}(p) = 0。
  have hp'z : ∀ k : ℕ, degreeOverSubfield F y ≤ k → p'.coeff k = 0 := by
    intro k hk
    rw [hp'coeff]
    exact htop (k + 1) (by omega)
  -- 次数以上の係数が零の零化多項式は零なので p' = 0、したがって p = t·0 = 0。
  have hp'0 : p' = 0 := vanishingPolynomial_below_degree_eq_zero F y p' hp'F hp'y hp'z
  exact hp0 (by rw [hpeq', hp'0, mul_zero])

/-- `claim_subfield_polynomial_values_is_subfield` の具体版（零でない元の逆元）。 -/
theorem subfieldPolynomialValues_inv_mem (F : Subfield Qbar) (α y : Qbar)
    (hy : y ∈ subfieldPolynomialValues F α) (hy0 : y ≠ 0) :
    y⁻¹ ∈ subfieldPolynomialValues F α := by
  -- deg_F(y) ∈ D_F(y) の証人 p。
  obtain ⟨p, hp, hp0, htop, hpy⟩ := degreeOverSubfield_spec F y
  -- c := ac_0(p) は F に属し、零でない。
  have hcF : p.coeff 0 ∈ F := hp 0
  have hc0 : p.coeff 0 ≠ 0 :=
    minimalVanishingPolynomial_constantTerm_ne_zero F y hy0 p hp hp0 htop hpy
  -- 分解 p = ĉ + t·p'、p' ∈ F[t]。
  obtain ⟨p', hp'coeff, hpeq⟩ := qbarPolyConstantTermShift p
  have hp'F : p' ∈ subfieldCoefficientPolynomials F := by
    intro k
    rw [hp'coeff]
    exact hp (k + 1)
  -- 0 = aev_y(p) = aev_y(ĉ + t·p') = c + y · aev_y(p')。
  have hval : p.coeff 0 + y * qbarPolyEval y p' = 0 := by
    calc p.coeff 0 + y * qbarPolyEval y p'
        = qbarPolyEval y (qbarConst (p.coeff 0) + Polynomial.X * p') := by
          rw [qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, Polynomial.eval_add, Polynomial.eval_mul,
            qbarConst, Polynomial.eval_C, Polynomial.eval_X]
      _ = qbarPolyEval y p := by rw [← hpeq]
      _ = 0 := hpy
  -- z := -(c⁻¹) · aev_y(p') について y · z = 1。
  have hyz : y * (-(p.coeff 0)⁻¹ * qbarPolyEval y p') = 1 := by
    calc y * (-(p.coeff 0)⁻¹ * qbarPolyEval y p')
        = -(p.coeff 0)⁻¹ * (y * qbarPolyEval y p') := by ring
      _ = -(p.coeff 0)⁻¹ * (-(p.coeff 0)) := by rw [eq_neg_of_add_eq_zero_right hval]
      _ = (p.coeff 0)⁻¹ * p.coeff 0 := by ring
      _ = 1 := inv_mul_cancel₀ hc0
  -- y⁻¹ = y⁻¹ · (y · z) = (y⁻¹ · y) · z = z。
  have hinv : y⁻¹ = -(p.coeff 0)⁻¹ * qbarPolyEval y p' := by
    calc y⁻¹ = y⁻¹ * (y * (-(p.coeff 0)⁻¹ * qbarPolyEval y p')) := by rw [hyz, mul_one]
      _ = (y⁻¹ * y) * (-(p.coeff 0)⁻¹ * qbarPolyEval y p') := by rw [mul_assoc]
      _ = -(p.coeff 0)⁻¹ * qbarPolyEval y p' := by rw [inv_mul_cancel₀ hy0, one_mul]
  -- 所属: -(c⁻¹) ∈ F ⊆ Val_F(α)、aev_y(p') ∈ Val_F(α)、積で閉じる。
  rw [hinv]
  exact subfieldPolynomialValues_mul_mem F α _ _
    (subfield_subset_subfieldPolynomialValues F α _ (F.neg_mem (F.inv_mem hcF)))
    (subfieldPolynomialValues_eval_mem F α y hy p' hp'F)

/-- `claim_subfield_polynomial_values_is_subfield` の具体版。`Val_F(α)` を台とする `Qbar` の部分体。
零元の逆元は mathlib の約束で零元なので、零元の場合だけ `inv_zero` で受ける。 -/
noncomputable def subfieldPolynomialValuesSubfield (F : Subfield Qbar) (α : Qbar) : Subfield Qbar where
  carrier := subfieldPolynomialValues F α
  zero_mem' := subfield_subset_subfieldPolynomialValues F α 0 F.zero_mem
  one_mem' := subfield_subset_subfieldPolynomialValues F α 1 F.one_mem
  add_mem' := fun {y z} hy hz => subfieldPolynomialValues_add_mem F α y z hy hz
  mul_mem' := fun {y z} hy hz => subfieldPolynomialValues_mul_mem F α y z hy hz
  neg_mem' := fun {y} hy => subfieldPolynomialValues_neg_mem F α y hy
  inv_mem' := fun y hy => by
    by_cases hy0 : y = 0
    · rw [hy0, inv_zero]
      exact subfield_subset_subfieldPolynomialValues F α 0 F.zero_mem
    · exact subfieldPolynomialValues_inv_mem F α y hy hy0

/-- 台が `Val_F(α)` であること。 -/
theorem subfieldPolynomialValuesSubfield_coe (F : Subfield Qbar) (α : Qbar) :
    (subfieldPolynomialValuesSubfield F α : Set Qbar) = subfieldPolynomialValues F α := rfl

end Ising2DLambda.FisherZero
