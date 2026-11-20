/-
節「虚数単位を足した体に根を持つこと」の具体版。
人手証明の正本は `claim_positive_natural_two_power_odd_decomposition` と
`claim_subfield_polynomial_root_in_imaginary_unit_extension` である。

  人手証明                                                          このファイル
  一以上の自然数は 2 の冪と奇数の積（強い帰納法）                    `positiveNatural_twoPowerOddDecomposition`
    ℕ の元は j + j か j + j + 1（ℕ についての帰納法）                 `nat_eq_add_self_or_add_self_add_one`
    d = j + j + 1 の場合の式鎖、d = j + j の場合の五行の式鎖          `inr`・`inl` の場合の calc
  言明 P(k) の帰納法                                                  `subfieldPolynomialRoot_twoPowerOdd`
    出発点: ac_{m'}(Π) の三行の式鎖（`claim_linear_factor_product_coefficient_elementary_symmetric`、j = 0）
                                                                      `hlead`
    出発点: 係数の上界（`claim_qbar_poly_linear_factor_product_coeff_bound`）  `qbarPolyLinearFactorProductCoeffBound`
    出発点: 奇数次の多項式の根の仮定                                   `hodd`
    出発点: 根は因子の根（`claim_qbar_linear_factor_product_root_is_listed_root`）
                                                                      `qbarLinearFactorProductRootIsListedRoot`
    一歩: `claim_subfield_polynomial_root_induction_step`（指数 k + 1）  `subfieldPolynomialRoot_inductionStep`
  主張: 分解（`claim_positive_natural_two_power_odd_decomposition`）、
        一次因子の積（`claim_qbar_monic_polynomial_linear_factor_product`）、P(k)
                                                                      `subfieldPolynomialRoot_inImaginaryUnitExtension`
    aev_z(f) の七行の式鎖（第二〜第四の等号は `qbarPolyEvalLinearFactorProduct`）  末尾の calc

本文の K = F(ω) は `Subfield.closure (F ∪ {ω})`。本文の奇数（ある j で n = j + j + 1）は、
奇数次の多項式の仮定 `hodd` だけ mathlib の `Odd n`（ある j で n = 2·j + 1）で受ける
（`claim_maximal_ordered_subfield_odd_degree_root` の具体版がその形で結論するため）。

住処: Qbar（分解は ℕ）。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SubfieldPolynomialRootInductionStep
import Ising2DLambda.FisherZero.LinearFactorProductElementarySymmetric
import Ising2DLambda.FisherZero.QbarLinearFactorProductRootIsListedRoot
import Ising2DLambda.FisherZero.QbarMonicPolynomialLinearFactorProduct

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- ℕ の任意の元は、ある j について j + j か j + j + 1 に等しい（ℕ についての帰納法）。 -/
theorem nat_eq_add_self_or_add_self_add_one (d : ℕ) : ∃ j : ℕ, d = j + j ∨ d = j + j + 1 := by
  induction d with
  | zero => exact ⟨0, Or.inl rfl⟩
  | succ d ih =>
      obtain ⟨j, hj | hj⟩ := ih
      · -- (j + j) + 1 = j + j + 1
        exact ⟨j, Or.inr (by rw [hj])⟩
      · -- (j + j + 1) + 1 = (j + 1) + (j + 1)
        exact ⟨j + 1, Or.inl (by rw [hj]; ring)⟩

/-- `claim_positive_natural_two_power_odd_decomposition` の具体版（強い帰納法）。 -/
theorem positiveNatural_twoPowerOddDecomposition :
    ∀ d : ℕ, 1 ≤ d → ∃ k m : ℕ, (∃ j : ℕ, m = j + j + 1) ∧ d = 2 ^ k * m := by
  intro d
  induction d using Nat.strong_induction_on with
  | _ d ih =>
      intro hd
      obtain ⟨j, hj | hj⟩ := nat_eq_add_self_or_add_self_add_one d
      · -- d = j + j の場合。j = 0 なら d = 0 で d ≥ 1 に反する。
        have hj1 : 1 ≤ j := by
          rcases Nat.eq_zero_or_pos j with h0 | hpos
          · exfalso
            rw [hj, h0] at hd
            exact absurd hd (by decide)
          · exact hpos
        have hjd : j < d := by rw [hj]; exact Nat.lt_add_of_pos_right hj1
        obtain ⟨k', m', hm', hjeq⟩ := ih j hjd hj1
        refine ⟨k' + 1, m', hm', ?_⟩
        calc d = j + j := hj
          _ = 2 ^ k' * m' + 2 ^ k' * m' := by rw [hjeq]
          _ = (2 ^ k' + 2 ^ k') * m' := (Nat.add_mul _ _ _).symm
          _ = (2 ^ k' * 2) * m' := by rw [Nat.mul_two]
          _ = 2 ^ (k' + 1) * m' := by rw [Nat.pow_succ]
      · -- d = j + j + 1 の場合。k := 0、m := d。
        refine ⟨0, d, ⟨j, hj⟩, ?_⟩
        calc d = 1 * d := (Nat.one_mul d).symm
          _ = 2 ^ 0 * d := by rw [Nat.pow_zero]

/-- 本文の言明 P(k) を k についての帰納法で示す。 -/
theorem subfieldPolynomialRoot_twoPowerOdd
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (hodd : ∀ (n : ℕ) (g : QbarPoly), g ∈ subfieldCoefficientPolynomials F → Odd n →
      g.coeff n ≠ 0 → (∀ k : ℕ, n < k → g.coeff k = 0) →
      ∃ z : Qbar, z ∈ F ∧ qbarPolyEval z g = 0)
    (omega : Qbar) (homega : omega * omega = -1) :
    ∀ k m' : ℕ, (∃ j : ℕ, m' = j + j + 1) → ∀ β : ℕ → Qbar,
      (∏ r ∈ Finset.range (2 ^ k * m'), (Polynomial.X - qbarConst (β r))) ∈
        subfieldCoefficientPolynomials F →
      ∃ r : ℕ, r < 2 ^ k * m' ∧
        β r ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)) := by
  intro k
  induction k with
  | zero =>
      intro m' hm' β hprod
      rw [Nat.pow_zero, Nat.one_mul] at hprod ⊢
      -- ac_{m'}(Π) = ac_{m'-0}(Π) = (-1)^0·mev(es_{m',0}) = 1
      have hlead : (∏ r ∈ Finset.range m', (Polynomial.X - qbarConst (β r))).coeff m' = 1 := by
        calc (∏ r ∈ Finset.range m', (Polynomial.X - qbarConst (β r))).coeff m'
            = (∏ r ∈ Finset.range m', (Polynomial.X - qbarConst (β r))).coeff (m' - 0) := by
              rw [Nat.sub_zero]
          _ = (-1) ^ 0 * qbarMvValue (fun k : Fin m' => β k) (qbarElementarySymmetric m' 0) :=
              linearFactorProduct_coeff_elementarySymmetric β m' 0 (Nat.zero_le m')
          _ = 1 := by simp [qbarElementarySymmetric]
      have hodd' : Odd m' := by
        obtain ⟨j, hj⟩ := hm'
        exact ⟨j, by rw [hj]; ring⟩
      obtain ⟨z, hzF, hz⟩ := hodd m' _ hprod hodd' (by rw [hlead]; exact one_ne_zero)
        (qbarPolyLinearFactorProductCoeffBound β m')
      obtain ⟨r, hr, hzr⟩ := qbarLinearFactorProductRootIsListedRoot m' β z hz
      refine ⟨r, hr, ?_⟩
      rw [← hzr]
      exact Subfield.subset_closure (Or.inl hzF)
  | succ k ih =>
      intro m' hm' β hprod
      -- `claim_subfield_polynomial_root_induction_step` を指数 k + 1 へ当てる。帰納法の仮定は P(k)。
      exact subfieldPolynomialRoot_inductionStep F C hC hpositive omega homega (k + 1) m'
        (2 ^ (k + 1) * m') (Nat.succ_le_succ (Nat.zero_le k)) hm' rfl
        (by
          intro m'' hm'' β' hβ'
          rw [Nat.add_sub_cancel] at hβ' ⊢
          exact ih m'' hm'' β' hβ')
        β hprod

/-- `claim_subfield_polynomial_root_in_imaginary_unit_extension` の具体版。 -/
theorem subfieldPolynomialRoot_inImaginaryUnitExtension
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (hodd : ∀ (n : ℕ) (g : QbarPoly), g ∈ subfieldCoefficientPolynomials F → Odd n →
      g.coeff n ≠ 0 → (∀ k : ℕ, n < k → g.coeff k = 0) →
      ∃ z : Qbar, z ∈ F ∧ qbarPolyEval z g = 0)
    (omega : Qbar) (homega : omega * omega = -1)
    (d : ℕ) (hd : 1 ≤ d) (f : QbarPoly) (hf : f ∈ subfieldCoefficientPolynomials F)
    (hbound : ∀ k : ℕ, d < k → f.coeff k = 0) (hlead : f.coeff d = 1) :
    ∃ z : Qbar, z ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)) ∧
      qbarPolyEval z f = 0 := by
  obtain ⟨k, m, hm, hdkm⟩ := positiveNatural_twoPowerOddDecomposition d hd
  obtain ⟨α, hα⟩ := qbarMonicPolynomialLinearFactorProduct d f hbound hlead
  have hprod : (∏ r ∈ Finset.range (2 ^ k * m), (Polynomial.X - qbarConst (α r))) ∈
      subfieldCoefficientPolynomials F := by
    rw [← hdkm, ← hα]
    exact hf
  obtain ⟨i, hi, hαi⟩ :=
    subfieldPolynomialRoot_twoPowerOdd F C hC hpositive hodd omega homega k m hm α hprod
  have hid : i < d := by rw [hdkm]; exact hi
  refine ⟨α i, hαi, ?_⟩
  calc qbarPolyEval (α i) f
      = qbarPolyEval (α i) (∏ r ∈ Finset.range d, (Polynomial.X - qbarConst (α r))) :=
        congrArg (qbarPolyEval (α i)) hα
    -- 第二〜第四の等号: aev は積・単位元・和・加法の逆元を保ち、aev(t) = z、aev(â) = a。
    _ = ∏ r ∈ Finset.range d, (α i - α r) := qbarPolyEvalLinearFactorProduct d α (α i)
    -- 有限積から番号 i の因子を分ける。
    _ = (α i - α i) * ∏ r ∈ (Finset.range d).erase i, (α i - α r) :=
        (Finset.mul_prod_erase _ _ (Finset.mem_range.mpr hid)).symm
    _ = 0 * ∏ r ∈ (Finset.range d).erase i, (α i - α r) := by rw [sub_self]
    _ = 0 := zero_mul _

end Ising2DLambda.FisherZero
