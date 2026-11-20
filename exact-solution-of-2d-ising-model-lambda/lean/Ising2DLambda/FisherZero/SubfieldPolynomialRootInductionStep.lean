/-
節「虚数単位を足した体に根を持つことの帰納法の一歩」の具体版。
人手証明の正本は `claim_subfield_polynomial_root_induction_step` である。

  人手証明                                                          このファイル
  準備: K := F(ω) は F と ω を含む                                  `hFK`・`homegaK`
  準備: d ≥ 1                                                        `hd1`
  準備: N := |Pr_d|、全単射 ν（`def_cardinality_notation`）            `N`・`π`
  `claim_root_index_pair_count`                                       `rootIndexPairCount`
  `claim_pair_count_two_adic_valuation_decrease`                     `pairCountTwoAdicValuationDecrease`
  各 c ∈ ℕ_{<N+1} で g_c ∈ F[t]（`claim_pair_shift_root_polynomial_subfield_coefficient`）
                                                                      `pairShiftRootPolynomial_mem_subfieldCoefficientPolynomials`
  帰納法の仮定を g_c へ当てて r_c を選ぶ                              `hshift`・`choose`
  `claim_pigeonhole_one_more_than_cardinality`                       `pigeonhole_one_more_than_cardinality`
  `claim_two_shifted_values_determine_sum_and_product`               `add_mem_and_mul_mem_of_two_shifted_mem`
  `claim_imaginary_unit_extension_quadratic_root`（e = 1）           `imaginaryUnitExtension_quadraticRoot`
  根 r が K に入ること                                               `hrK`
  二次式の値の式鎖                                                    `hvanish`
  `claim_sum_in_subfield_root_gives_both_numbers`                    `mem_and_mem_of_sum_mem_of_root_mem`

本文の K = F(ω) は `Subfield.closure (F ∪ {ω})`、ν は `π : Fin N ≃ RootIndexPair d`、
ずらしの値の列 β_c は `pairShiftRootSequence α π c`（番号 N 以上では 0 を置く。本文の β_c も同じ）。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionQuadraticRoot
import Ising2DLambda.FisherZero.PairShiftRootPolynomialSubfieldCoefficient
import Ising2DLambda.FisherZero.TwoShiftedValuesSumProduct
import Ising2DLambda.FisherZero.SumInSubfieldRootGivesBothNumbers
import Ising2DLambda.FisherZero.RootIndexPairCount
import Ising2DLambda.FisherZero.PairCountTwoAdicValuationDecrease

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 本文の β_c。`r < N` なら `ν(r) = (i,j)` の `α(i) + α(j) + c·α(i)·α(j)`、それ以外は 0。 -/
noncomputable def pairShiftRootSequence {d N : ℕ} (α : ℕ → Qbar) (π : Fin N ≃ RootIndexPair d)
    (c : Qbar) : ℕ → Qbar :=
  fun r => if h : r < N then
      α (π ⟨r, h⟩).1.1 + α (π ⟨r, h⟩).1.2 + c * α (π ⟨r, h⟩).1.1 * α (π ⟨r, h⟩).1.2
    else 0

/-- β_c の `r < N` での値（本文の β_c の置き方）。 -/
theorem pairShiftRootSequence_apply {d N : ℕ} (α : ℕ → Qbar) (π : Fin N ≃ RootIndexPair d)
    (c : Qbar) (r : Fin N) :
    pairShiftRootSequence α π c r =
      α (π r).1.1 + α (π r).1.2 + c * α (π r).1.1 * α (π r).1.2 := by
  simp [pairShiftRootSequence, r.isLt]

/-- `claim_subfield_polynomial_root_induction_step` の具体版。
次数の 2 の冪の指数が `k - 1` の部分体係数の一次因子の積が K に根を持つなら、指数が `k`（`k ≥ 1`）の
`∏_{i<d}(t - α̂(i)) ∈ F[t]` も、ある `i < d` で `α(i) ∈ K` を持つ。 -/
theorem subfieldPolynomialRoot_inductionStep
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (omega : Qbar) (homega : omega * omega = -1)
    (k m d : ℕ) (hk : 1 ≤ k) (hm : ∃ j : ℕ, m = j + j + 1) (hd : d = 2 ^ k * m)
    (hIH : ∀ m' : ℕ, (∃ j : ℕ, m' = j + j + 1) → ∀ β : ℕ → Qbar,
      (∏ r ∈ Finset.range (2 ^ (k - 1) * m'), (Polynomial.X - qbarConst (β r))) ∈
        subfieldCoefficientPolynomials F →
      ∃ r : ℕ, r < 2 ^ (k - 1) * m' ∧
        β r ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)))
    (α : ℕ → Qbar)
    (hf : (∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α i))) ∈
      subfieldCoefficientPolynomials F) :
    ∃ i : ℕ, i < d ∧ α i ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)) := by
  set K := Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)) with hKdef
  -- 準備: K は F と ω を含む。
  have hFK : ∀ x : Qbar, x ∈ F → x ∈ K := fun x hx => Subfield.subset_closure (Or.inl hx)
  have homegaK : omega ∈ K := Subfield.subset_closure (Or.inr rfl)
  -- 準備: d ≥ 1（2^k ≥ 1 と m = j + j + 1 ≥ 1）。
  have hd1 : 1 ≤ d := by
    obtain ⟨j, hj⟩ := hm
    have hm1 : 1 ≤ m := by rw [hj]; exact Nat.le_add_left 1 (j + j)
    rw [hd]
    calc 1 = 1 * 1 := (Nat.mul_one 1).symm
      _ ≤ 2 ^ k * m := Nat.mul_le_mul Nat.one_le_two_pow hm1
  -- 準備: N := |Pr_d| と全単射 ν。
  set N := Fintype.card (RootIndexPair d) with hNdef
  let π : Fin N ≃ RootIndexPair d := (Fintype.equivFin (RootIndexPair d)).symm
  -- 対の個数とその 2 進付値。
  have hN : N + N = d * (d - 1) := rootIndexPairCount d N hd1 π
  obtain ⟨hNeq, hodd⟩ := pairCountTwoAdicValuationDecrease k m d N hk hm hd hN
  -- 各 c ∈ ℕ_{<N+1} で、ある r_c ∈ ℕ_{<N} のずらしの値が K に入る。
  have hshift : ∀ c : Fin (N + 1), ∃ r : Fin N,
      α (π r).1.1 + α (π r).1.2 + (c.val : Qbar) * α (π r).1.1 * α (π r).1.2 ∈ K := by
    intro c
    have hg := pairShiftRootPolynomial_mem_subfieldCoefficientPolynomials F α hf
      (natCast_mem_subfield F c.val) π (pairShiftRootSequence α π c.val)
      (pairShiftRootSequence_apply α π c.val)
    have hg' : (∏ r ∈ Finset.range (2 ^ (k - 1) * (m * (d - 1))),
        (Polynomial.X - qbarConst (pairShiftRootSequence α π c.val r))) ∈
          subfieldCoefficientPolynomials F := by
      rw [← hNeq]
      exact hg
    obtain ⟨r, hr, hmem⟩ := hIH (m * (d - 1)) hodd _ hg'
    have hrN : r < N := by rw [hNeq]; exact hr
    refine ⟨⟨r, hrN⟩, ?_⟩
    rw [← pairShiftRootSequence_apply α π c.val ⟨r, hrN⟩]
    exact hmem
  choose ρ hρ using hshift
  -- 鳩の巣: c < c' で同じ対へ行く。
  obtain ⟨c, c', hlt, heq⟩ :=
    pigeonhole_one_more_than_cardinality (P := RootIndexPair d) (fun c => π (ρ c))
  -- 二つのずらしの値（整数倍の形へ書き直す）。
  have hu : α (π (ρ c)).1.1 + α (π (ρ c)).1.2 +
      ((c.val : ℤ) : Qbar) * (α (π (ρ c)).1.1 * α (π (ρ c)).1.2) ∈ K := by
    have h := hρ c
    rw [Int.cast_natCast, ← mul_assoc]
    exact h
  have hu' : α (π (ρ c)).1.1 + α (π (ρ c)).1.2 +
      ((c'.val : ℤ) : Qbar) * (α (π (ρ c)).1.1 * α (π (ρ c)).1.2) ∈ K := by
    have h := hρ c'
    rw [show π (ρ c') = π (ρ c) from heq.symm] at h
    rw [Int.cast_natCast, ← mul_assoc]
    exact h
  have hne : (c.val : ℤ) ≠ (c'.val : ℤ) := by
    have hlt' : c.val < c'.val := hlt
    omega
  obtain ⟨hsum, hprod⟩ :=
    add_mem_and_mul_mem_of_two_shifted_mem K _ _ _ _ hne hu hu'
  -- 二次式 t^2 - (a+b)t + ab の根 r ∈ K（e = 1）。
  obtain ⟨r, x, y, hx, hy, hr, hquad⟩ :=
    imaginaryUnitExtension_quadraticRoot F C hC hpositive omega 1
      (-(α (π (ρ c)).1.1 + α (π (ρ c)).1.2)) (α (π (ρ c)).1.1 * α (π (ρ c)).1.2) homega
      one_ne_zero K.one_mem (K.neg_mem hsum) hprod
  have hrK : r ∈ K := by
    rw [hr]
    exact K.add_mem (hFK x hx) (K.mul_mem (hFK y hy) homegaK)
  have hvanish : r * r - (α (π (ρ c)).1.1 + α (π (ρ c)).1.2) * r +
      α (π (ρ c)).1.1 * α (π (ρ c)).1.2 = 0 := by
    calc r * r - (α (π (ρ c)).1.1 + α (π (ρ c)).1.2) * r +
          α (π (ρ c)).1.1 * α (π (ρ c)).1.2
        = 1 * (r * r) + -(α (π (ρ c)).1.1 + α (π (ρ c)).1.2) * r +
          α (π (ρ c)).1.1 * α (π (ρ c)).1.2 := by ring
      _ = 0 := hquad
  obtain ⟨ha, -⟩ := mem_and_mem_of_sum_mem_of_root_mem K _ _ r hsum hrK hvanish
  exact ⟨(π (ρ c)).1.1.val, (π (ρ c)).1.1.isLt, ha⟩

end Ising2DLambda.FisherZero
