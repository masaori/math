/-
節「虚数単位を足した体に根を持つこと」の必要十分版。具体版と同じ段を、段が実際に使う仮定だけの上で行う。

一以上の自然数の分解（`positiveNatural_twoPowerOddDecomposition_necSuf`）に要るのは次だけである。
- 可換半環 `R`（j + j = 2^{k'}·m' + 2^{k'}·m' = 2^{k'+1}·m' の分配則と冪の指数法則、0 + 0 = 0）。
- `R` 上の整礎な関係 `lt`（強い帰納法）。
- 任意の元が、ある j で j + j か j + j + 1 に等しいこと（`hpar`）。
- 零でない j について `lt j (j + j)`（`hlt`。帰納法の仮定を j へ当てる段）。
「1 ≤ d」は「d ≠ 0」で受ける。全順序・減法・自然数であることは使わない。

言明 P(k) の帰納法（`subfieldPolynomialRoot_twoPowerOdd_necSuf`）と主張に要るのは次だけである。
- 台 `L` は零因子の無い非自明な可換環（根が因子の根であること、1 ≠ 0）。逆元は使わない。
- 係数の部分集合 `S`（具体版の F）と根の部分集合 `T`（具体版の K）で `S ⊂ T`。
  S・T の演算での閉性は使わない（演算の閉性は帰納法の一歩の側が使う）。
- 奇数次の多項式が `S` に根を持つこと（`hodd`）。具体版はこれを仮定で受ける。
- 帰納法の一歩の結論（`hstep`）。具体版は `claim_subfield_polynomial_root_induction_step` で得る。
  正錐・平方根・ω はこの一歩の中でだけ使い、合成は使わない。
- 主張の f が一次因子の積に分解されること（`hα`）。具体版は代数閉性から
  `claim_qbar_monic_polynomial_linear_factor_product` で得る。合成が使うのはこの f の分解だけで、
  `L` が代数閉であることは使わない。
-/
import Ising2DLambda.NecSuf.FisherZero.LinearFactorProductElementarySymmetric
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorProductCoeffBound
import Ising2DLambda.NecSuf.FisherZero.QbarLinearFactorProductRootIsListedRoot

namespace Ising2DLambda.NecSuf.FisherZero

/-- `claim_positive_natural_two_power_odd_decomposition` の必要十分版（強い帰納法）。 -/
theorem positiveNatural_twoPowerOddDecomposition_necSuf {R : Type*} [CommSemiring R]
    (lt : R → R → Prop) (hwf : WellFounded lt)
    (hpar : ∀ d : R, ∃ j : R, d = j + j ∨ d = j + j + 1)
    (hlt : ∀ j : R, j ≠ 0 → lt j (j + j)) :
    ∀ d : R, d ≠ 0 → ∃ (k : ℕ) (m : R), (∃ j : R, m = j + j + 1) ∧ d = 2 ^ k * m := by
  intro d
  refine hwf.induction d (C := fun d => d ≠ 0 →
    ∃ (k : ℕ) (m : R), (∃ j : R, m = j + j + 1) ∧ d = 2 ^ k * m) ?_
  intro d ih hd
  obtain ⟨j, hj | hj⟩ := hpar d
  · have hj0 : j ≠ 0 := by
      intro h
      apply hd
      rw [hj, h, add_zero]
    obtain ⟨k', m', hm', hjeq⟩ := ih j (by rw [hj]; exact hlt j hj0) hj0
    refine ⟨k' + 1, m', hm', ?_⟩
    calc d = j + j := hj
      _ = 2 ^ k' * m' + 2 ^ k' * m' := by rw [hjeq]
      _ = (2 ^ k' + 2 ^ k') * m' := (add_mul _ _ _).symm
      _ = (2 ^ k' * 2) * m' := by rw [mul_two]
      _ = 2 ^ (k' + 1) * m' := by rw [pow_succ]
  · refine ⟨0, d, ⟨j, hj⟩, ?_⟩
    calc d = 1 * d := (one_mul d).symm
      _ = 2 ^ 0 * d := by rw [pow_zero]

/-- 言明 P(k) の必要十分版（具体版と同じ k についての帰納法）。 -/
theorem subfieldPolynomialRoot_twoPowerOdd_necSuf {L : Type*} [CommRing L] [IsDomain L]
    (S T : Set L) (hST : ∀ x : L, x ∈ S → x ∈ T)
    (hodd : ∀ (n : ℕ) (g : Polynomial L), (∀ k : ℕ, g.coeff k ∈ S) → Odd n →
      g.coeff n ≠ 0 → (∀ k : ℕ, n < k → g.coeff k = 0) → ∃ z : L, z ∈ S ∧ g.eval z = 0)
    (hstep : ∀ k m : ℕ, 1 ≤ k → (∃ j : ℕ, m = j + j + 1) →
      (∀ m' : ℕ, (∃ j : ℕ, m' = j + j + 1) → ∀ β : ℕ → L,
        (∀ n : ℕ, (∏ r ∈ Finset.range (2 ^ (k - 1) * m'),
          (Polynomial.X - Polynomial.C (β r))).coeff n ∈ S) →
        ∃ r : ℕ, r < 2 ^ (k - 1) * m' ∧ β r ∈ T) →
      ∀ α : ℕ → L, (∀ n : ℕ, (∏ i ∈ Finset.range (2 ^ k * m),
        (Polynomial.X - Polynomial.C (α i))).coeff n ∈ S) →
      ∃ i : ℕ, i < 2 ^ k * m ∧ α i ∈ T) :
    ∀ k m' : ℕ, (∃ j : ℕ, m' = j + j + 1) → ∀ β : ℕ → L,
      (∀ n : ℕ, (∏ r ∈ Finset.range (2 ^ k * m'),
        (Polynomial.X - Polynomial.C (β r))).coeff n ∈ S) →
      ∃ r : ℕ, r < 2 ^ k * m' ∧ β r ∈ T := by
  intro k
  induction k with
  | zero =>
      intro m' hm' β hprod
      rw [pow_zero, one_mul] at hprod ⊢
      have hlead : (∏ r ∈ Finset.range m', (Polynomial.X - Polynomial.C (β r))).coeff m' = 1 := by
        calc (∏ r ∈ Finset.range m', (Polynomial.X - Polynomial.C (β r))).coeff m'
            = (∏ r ∈ Finset.range m', (Polynomial.X - Polynomial.C (β r))).coeff (m' - 0) := by
              rw [Nat.sub_zero]
          _ = (-1) ^ 0 * ∑ s ∈ Finset.powersetCard 0 (Finset.univ : Finset (Fin m')),
                ∏ k ∈ s, β k :=
              linearFactorProduct_coeff_elementarySymmetric_necSuf β m' 0 (Nat.zero_le m')
          _ = 1 := by simp
      have hodd' : Odd m' := by
        obtain ⟨j, hj⟩ := hm'
        exact ⟨j, by rw [hj]; ring⟩
      obtain ⟨z, hzS, hz⟩ := hodd m' _ hprod hodd' (by rw [hlead]; exact one_ne_zero)
        (Ising2DLambda.NecSuf.AlgebraicEigenvalue.poly_linear_factor_product_coeff_bound_necSuf β m')
      obtain ⟨r, hr, hzr⟩ := linear_factor_product_root_is_listed_root_necSuf
        (Polynomial.evalRingHom z).toMonoidHom (fun r => Polynomial.X - Polynomial.C (β r)) β z
        (fun r => by simp) m' hz
      refine ⟨r, hr, ?_⟩
      rw [← hzr]
      exact hST z hzS
  | succ k ih =>
      intro m' hm' β hprod
      exact hstep (k + 1) m' (Nat.succ_le_succ (Nat.zero_le k)) hm'
        (by
          intro m'' hm'' β' hβ'
          rw [Nat.add_sub_cancel] at hβ' ⊢
          exact ih m'' hm'' β' hβ')
        β hprod

/-- `claim_subfield_polynomial_root_in_imaginary_unit_extension` の必要十分版。 -/
theorem subfieldPolynomialRoot_inImaginaryUnitExtension_necSuf {L : Type*} [CommRing L]
    [IsDomain L] (S T : Set L) (hST : ∀ x : L, x ∈ S → x ∈ T)
    (hodd : ∀ (n : ℕ) (g : Polynomial L), (∀ k : ℕ, g.coeff k ∈ S) → Odd n →
      g.coeff n ≠ 0 → (∀ k : ℕ, n < k → g.coeff k = 0) → ∃ z : L, z ∈ S ∧ g.eval z = 0)
    (hstep : ∀ k m : ℕ, 1 ≤ k → (∃ j : ℕ, m = j + j + 1) →
      (∀ m' : ℕ, (∃ j : ℕ, m' = j + j + 1) → ∀ β : ℕ → L,
        (∀ n : ℕ, (∏ r ∈ Finset.range (2 ^ (k - 1) * m'),
          (Polynomial.X - Polynomial.C (β r))).coeff n ∈ S) →
        ∃ r : ℕ, r < 2 ^ (k - 1) * m' ∧ β r ∈ T) →
      ∀ α : ℕ → L, (∀ n : ℕ, (∏ i ∈ Finset.range (2 ^ k * m),
        (Polynomial.X - Polynomial.C (α i))).coeff n ∈ S) →
      ∃ i : ℕ, i < 2 ^ k * m ∧ α i ∈ T)
    (d : ℕ) (hd : 1 ≤ d) (f : Polynomial L) (hf : ∀ n : ℕ, f.coeff n ∈ S)
    (α : ℕ → L) (hα : f = ∏ i ∈ Finset.range d, (Polynomial.X - Polynomial.C (α i))) :
    ∃ z : L, z ∈ T ∧ f.eval z = 0 := by
  obtain ⟨k, m, hm, hdkm⟩ := positiveNatural_twoPowerOddDecomposition_necSuf (R := ℕ)
    (· < ·) wellFounded_lt (fun d => ⟨d / 2, by omega⟩) (fun j hj => by omega) d
    (Nat.one_le_iff_ne_zero.mp hd)
  have hprod : ∀ n : ℕ, (∏ r ∈ Finset.range (2 ^ k * m),
      (Polynomial.X - Polynomial.C (α r))).coeff n ∈ S := by
    rw [← hdkm, ← hα]
    exact hf
  obtain ⟨i, hi, hαi⟩ := subfieldPolynomialRoot_twoPowerOdd_necSuf S T hST hodd hstep k m hm α hprod
  have hid : i < d := by rw [hdkm]; exact hi
  refine ⟨α i, hαi, ?_⟩
  calc f.eval (α i)
      = (∏ r ∈ Finset.range d, (Polynomial.X - Polynomial.C (α r))).eval (α i) := by rw [hα]
    _ = ∏ r ∈ Finset.range d, (α i - α r) := by simp [Polynomial.eval_prod]
    _ = (α i - α i) * ∏ r ∈ (Finset.range d).erase i, (α i - α r) :=
        (Finset.mul_prod_erase _ _ (Finset.mem_range.mpr hid)).symm
    _ = 0 * ∏ r ∈ (Finset.range d).erase i, (α i - α r) := by rw [sub_self]
    _ = 0 := zero_mul _

end Ising2DLambda.NecSuf.FisherZero
