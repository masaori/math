/-
人手の定義「虚数単位を足した元の一次式の値の全体と共役」
（ラベル `def_imaginary_unit_extension_conjugate`）、
「虚数単位を足した体を係数とする多項式の係数の共役」
（ラベル `def_imaginary_unit_extension_conjugate_polynomial`）と、
主張「虚数単位を足した体を係数とする多項式と係数の共役の積は部分体係数である」
（ラベル `claim_imaginary_unit_extension_conjugate_product_subfield_coefficient`）の具体版。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionUniqueRepresentation
import Ising2DLambda.FisherZero.SubfieldCoefficientPolynomials
import Mathlib.Algebra.BigOperators.NatAntidiagonal
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `def_imaginary_unit_extension_conjugate` の集合 `Lin_F(ω) = {u + vω | u, v ∈ F}`。 -/
def imaginaryUnitLinearValues (F : Subfield Qbar) (omega : Qbar) : Set Qbar :=
  {z | ∃ u v : Qbar, u ∈ F ∧ v ∈ F ∧ z = u + v * omega}

/-- `def_imaginary_unit_extension_conjugate` の共役 `cj_ω`。人手の定義は `Lin_F(ω)` の上だけで
`cj_ω(a + bω) := a - bω` と定める。Lean では全域の関数にするため、`Lin_F(ω)` の元では
表示を一つ選んで `a - bω` を返し、外の元ではその元自身を返す（外の値は使わない）。
選んだ表示に依らないことは `imaginaryUnitConj_apply` が表示の一意性から示す。 -/
noncomputable def imaginaryUnitConj (F : Subfield Qbar) (omega : Qbar) (z : Qbar) : Qbar := by
  classical
  exact if h : z ∈ imaginaryUnitLinearValues F omega then
    h.choose - h.choose_spec.choose * omega
  else z

/-- `def_imaginary_unit_extension_conjugate` の well-defined 性: 任意の表示 `z = a + bω`
（`a, b ∈ F`）について `cj_ω(z) = a - bω`。`claim_imaginary_unit_extension_unique_representation`
（`imaginaryUnitExtension_unique_representation`）で、選んだ表示が `(a, b)` に一致する。 -/
theorem imaginaryUnitConj_apply
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1)
    (a b : Qbar) (ha : a ∈ F) (hb : b ∈ F) :
    imaginaryUnitConj F omega (a + b * omega) = a - b * omega := by
  classical
  have hmem : a + b * omega ∈ imaginaryUnitLinearValues F omega := ⟨a, b, ha, hb, rfl⟩
  unfold imaginaryUnitConj
  rw [dif_pos hmem]
  obtain ⟨hu, hv, hrep⟩ := hmem.choose_spec.choose_spec
  obtain ⟨hau, hbv⟩ := imaginaryUnitExtension_unique_representation F C hC omega homega
    a hmem.choose b hmem.choose_spec.choose ha hu hb hv hrep
  exact congrArg₂ (fun x y => x - y * omega) hau.symm hbv.symm

/-- `def_imaginary_unit_extension_conjugate` の `cj_ω(0) = 0`（`0 = 0 + 0ω` と well-defined 性）。 -/
theorem imaginaryUnitConj_zero
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) :
    imaginaryUnitConj F omega 0 = 0 := by
  calc imaginaryUnitConj F omega 0 = imaginaryUnitConj F omega (0 + 0 * omega) := by ring_nf
    _ = 0 - 0 * omega := imaginaryUnitConj_apply F C hC omega homega 0 0 F.zero_mem F.zero_mem
    _ = 0 := by ring

/-- `def_imaginary_unit_extension_conjugate_polynomial` の具体版。係数ごとに `cj_ω` を施した多項式
`cjp_ω(g)`。台（係数が零でない番号）の上の単項式の有限和として作る。 -/
noncomputable def imaginaryUnitConjPoly (F : Subfield Qbar) (omega : Qbar) (g : QbarPoly) :
    QbarPoly :=
  g.support.sum (fun n => Polynomial.monomial n (imaginaryUnitConj F omega (g.coeff n)))

/-- `def_imaginary_unit_extension_conjugate_polynomial` の係数: `ac_k(cjp_ω(g)) = cj_ω(ac_k(g))`。
台の外の番号では両辺とも零である（`cj_ω(0) = 0`）。 -/
theorem imaginaryUnitConjPoly_coeff
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (g : QbarPoly) (k : ℕ) :
    (imaginaryUnitConjPoly F omega g).coeff k = imaginaryUnitConj F omega (g.coeff k) := by
  classical
  unfold imaginaryUnitConjPoly
  rw [Polynomial.finsetSum_coeff]
  simp only [Polynomial.coeff_monomial]
  rw [Finset.sum_ite_eq']
  split_ifs with hk
  · rfl
  · rw [Polynomial.notMem_support_iff.mp hk, imaginaryUnitConj_zero F C hC omega homega]

/-- `claim_imaginary_unit_extension_conjugate_product_subfield_coefficient` の具体版。
人手証明の段: 各番号 `i` の係数を `ac_i(g) = a_i + b_i ω`（`a_i, b_i ∈ F`）と取り、
`ac_k(g · cjp_ω(g)) = Σ ac_i(g) ac_{k-i}(cjp_ω(g))`（積の係数）
`= Σ (a_i + b_i ω)(a_{k-i} - b_{k-i} ω)`（表示と共役の係数）
`= Σ ((a_i a_{k-i} + b_i b_{k-i}) + (b_i a_{k-i} - a_i b_{k-i}) ω)`（人手の四行: 分配法則、積の交換・結合法則、
`ω·ω = -1`、加法の並べ替え。Lean では各項の `linear_combination` 一つで、`ω·ω = -1` は係数 `-b_i b_{k-i}` で使う）
`= Σ (a_i a_{k-i} + b_i b_{k-i}) + (Σ b_i a_{k-i} - Σ a_i b_{k-i}) ω`（有限和の分配）
`= Σ (a_i a_{k-i} + b_i b_{k-i}) + (Σ b_i a_{k-i} - Σ b_{k-i} a_i) ω`（積の交換法則）
`= Σ (a_i a_{k-i} + b_i b_{k-i}) + (Σ b_i a_{k-i} - Σ b_i a_{k-i}) ω`（番号の付け替え `i ↦ k - i`。
Lean では反対角線の成分の入れ替え `Finset.Nat.sum_antidiagonal_swap`）
`= Σ (a_i a_{k-i} + b_i b_{k-i})`（四則）で、右辺の各項は `F` に属し、有限和も `F` に属する。 -/
theorem imaginaryUnitExtension_conjugateProduct_subfieldCoefficient
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (g : QbarPoly)
    (hg : ∀ k : ℕ, g.coeff k ∈ imaginaryUnitLinearValues F omega) :
    g * imaginaryUnitConjPoly F omega g ∈ subfieldCoefficientPolynomials F := by
  choose a b ha hb hab using hg
  intro k
  have hsum : (g * imaginaryUnitConjPoly F omega g).coeff k
      = ∑ x ∈ Finset.antidiagonal k, (a x.1 * a x.2 + b x.1 * b x.2) := by
    calc (g * imaginaryUnitConjPoly F omega g).coeff k
        = ∑ x ∈ Finset.antidiagonal k,
            g.coeff x.1 * (imaginaryUnitConjPoly F omega g).coeff x.2 :=
          Polynomial.coeff_mul g _ k
      _ = ∑ x ∈ Finset.antidiagonal k,
            (a x.1 + b x.1 * omega) * (a x.2 - b x.2 * omega) := by
          refine Finset.sum_congr rfl (fun x _ => ?_)
          rw [imaginaryUnitConjPoly_coeff F C hC omega homega, hab x.1, hab x.2,
            imaginaryUnitConj_apply F C hC omega homega _ _ (ha x.2) (hb x.2)]
      _ = ∑ x ∈ Finset.antidiagonal k,
            ((a x.1 * a x.2 + b x.1 * b x.2) + (b x.1 * a x.2 - a x.1 * b x.2) * omega) := by
          refine Finset.sum_congr rfl (fun x _ => ?_)
          linear_combination (-(b x.1 * b x.2)) * homega
      _ = ∑ x ∈ Finset.antidiagonal k, (a x.1 * a x.2 + b x.1 * b x.2)
            + (∑ x ∈ Finset.antidiagonal k, b x.1 * a x.2
                - ∑ x ∈ Finset.antidiagonal k, a x.1 * b x.2) * omega := by
          rw [Finset.sum_add_distrib, ← Finset.sum_mul, Finset.sum_sub_distrib]
      _ = ∑ x ∈ Finset.antidiagonal k, (a x.1 * a x.2 + b x.1 * b x.2)
            + (∑ x ∈ Finset.antidiagonal k, b x.1 * a x.2
                - ∑ x ∈ Finset.antidiagonal k, b x.2 * a x.1) * omega := by
          congr 3
          exact Finset.sum_congr rfl (fun x _ => mul_comm _ _)
      _ = ∑ x ∈ Finset.antidiagonal k, (a x.1 * a x.2 + b x.1 * b x.2)
            + (∑ x ∈ Finset.antidiagonal k, b x.1 * a x.2
                - ∑ x ∈ Finset.antidiagonal k, b x.1 * a x.2) * omega := by
          congr 3
          exact Finset.Nat.sum_antidiagonal_swap (f := fun y => b y.1 * a y.2)
      _ = ∑ x ∈ Finset.antidiagonal k, (a x.1 * a x.2 + b x.1 * b x.2) := by ring
  rw [hsum]
  -- 各項は F に属し、有限和は項の個数についての帰納法で F に属する。
  induction (Finset.antidiagonal k) using Finset.induction_on with
  | empty => rw [Finset.sum_empty]; exact F.zero_mem
  | insert x s hx ih =>
      rw [Finset.sum_insert hx]
      exact F.add_mem (F.add_mem (F.mul_mem (ha x.1) (ha x.2)) (F.mul_mem (hb x.1) (hb x.2))) ih

end Ising2DLambda.FisherZero
