/-
節「部分体を係数とする多変数多項式と全次数」の主張の必要十分版。

具体版（`Ising2DLambda.FisherZero.allOnesShift_mem_subfieldCoefficientMvPolys`・
`Ising2DLambda.FisherZero.symmetricVanishing_allOnesShift_totalDegree`・
`Ising2DLambda.FisherZero.symmetricVanishing_divisible_by_elementarySymmetric`）と同じ段で示し、
各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい（使う係数の主張 `swapInvariantVanishing_coeff_eq_zero_necSuf` と同じ仮定）。
- 係数の所属の主張で、部分体であることは使わない。係数が任意の部分集合 `S ⊆ K` に属するなら、
  `sd(P)` の係数も `S` に属する（`sd(P)` の係数は `P` の係数の一つだから）。
- 全次数の主張で対称性は要らない。使うのは各互換 `(k n)` についての不変性と `lz_n(P) = 0` で、
  そこから取り出すのは「台の元 `c` は `1 ≤ c` を満たす」ことだけである。
  `P ≠ 0` は削れない: `P = 0` なら両辺は `0 + (n+1)` と `0` で一致しない。
- まとめの主張では、商の対称性を言うために全ての置換についての不変性を仮定に残す。
-/
import Ising2DLambda.NecSuf.FisherZero.AllOnesShiftSymmetry

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

/-- 指数の総和。 -/
def exponentTotalNecSuf {σ : Type} [Fintype σ] (a : σ →₀ ℕ) : ℕ :=
  ∑ k, a k

/-- 全次数（台の上の指数の総和の上限。空なら 0）。 -/
noncomputable def totalDegreeNecSuf {σ : Type} [Fintype σ] (P : MvPolynomial σ K) : ℕ :=
  P.support.sup exponentTotalNecSuf

/-- `claim_qbar_all_ones_shift_subfield_coefficient` の必要十分版（具体版と同じ段）。 -/
theorem allOnesShift_coeff_mem_necSuf {σ : Type} [Fintype σ] (S : Set K) (P : MvPolynomial σ K)
    (hP : ∀ a : σ →₀ ℕ, coeff a P ∈ S) (d : σ →₀ ℕ) : coeff d (allOnesShiftNecSuf P) ∈ S := by
  rw [allOnesShiftNecSuf_coeff]
  exact hP (d + allOnesExponent σ)

/-- 第一の準備（具体版 `exponentTotal_add_allOnes` と同じ段）。 -/
theorem exponentTotal_add_allOnes_necSuf {n : ℕ} (d : Fin (n + 1) →₀ ℕ) :
    exponentTotalNecSuf (d + allOnesExponent (Fin (n + 1))) = exponentTotalNecSuf d + (n + 1) := by
  calc exponentTotalNecSuf (d + allOnesExponent (Fin (n + 1)))
      = ∑ k, (d + allOnesExponent (Fin (n + 1))) k := rfl
    _ = ∑ k, (d k + allOnesExponent (Fin (n + 1)) k) :=
        Finset.sum_congr rfl fun k _ => Finsupp.add_apply _ _ _
    _ = ∑ k : Fin (n + 1), (d k + 1) :=
        Finset.sum_congr rfl fun k _ => by rw [allOnesExponent_apply]
    _ = ∑ k, d k + ∑ _k : Fin (n + 1), 1 := Finset.sum_add_distrib
    _ = exponentTotalNecSuf d + ∑ _k : Fin (n + 1), 1 := rfl
    _ = exponentTotalNecSuf d + (n + 1) := by
        rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul, mul_one]

/-- 第二の準備（具体版 `symmetricVanishing_support_shift` と同じ段）。 -/
theorem swapInvariantVanishing_support_shift_necSuf {n : ℕ} (P : MvPolynomial (Fin (n + 1)) K)
    (hswap : ∀ k : Fin (n + 1),
      aeval (fun i => (X (Equiv.swap k (Fin.last n) i) : MvPolynomial (Fin (n + 1)) K)) P = P)
    (hlz : lastVariableZeroNecSuf n P = 0) (c : Fin (n + 1) →₀ ℕ) (hc : coeff c P ≠ 0) :
    allOnesExponent (Fin (n + 1)) ≤ c ∧
      coeff (c - allOnesExponent (Fin (n + 1))) (allOnesShiftNecSuf P) ≠ 0 := by
  have hle : allOnesExponent (Fin (n + 1)) ≤ c := by
    by_contra h
    obtain ⟨k, hk⟩ := exists_eq_zero_of_not_allOnes_le c h
    exact hc (swapInvariantVanishing_coeff_eq_zero_necSuf P c k (hswap k) hlz hk)
  refine ⟨hle, ?_⟩
  have heq : coeff (c - allOnesExponent (Fin (n + 1))) (allOnesShiftNecSuf P) = coeff c P :=
    calc coeff (c - allOnesExponent (Fin (n + 1))) (allOnesShiftNecSuf P)
        = coeff (c - allOnesExponent (Fin (n + 1)) + allOnesExponent (Fin (n + 1))) P :=
          allOnesShiftNecSuf_coeff _ _
      _ = coeff c P := by rw [tsub_add_cancel_of_le hle]
  rw [heq]
  exact hc

/-- `claim_symmetric_vanishing_last_variable_shift_total_degree` の必要十分版（具体版と同じ段）。
仮定は各互換 `(k n)` についての不変性・`lz_n(P) = 0`・`P ≠ 0`。 -/
theorem allOnesShift_totalDegree_necSuf {n : ℕ} (P : MvPolynomial (Fin (n + 1)) K)
    (hswap : ∀ k : Fin (n + 1),
      aeval (fun i => (X (Equiv.swap k (Fin.last n) i) : MvPolynomial (Fin (n + 1)) K)) P = P)
    (hlz : lastVariableZeroNecSuf n P = 0) (hP : P ≠ 0) :
    totalDegreeNecSuf (allOnesShiftNecSuf P) + (n + 1) = totalDegreeNecSuf P := by
  have hupper : totalDegreeNecSuf P ≤ totalDegreeNecSuf (allOnesShiftNecSuf P) + (n + 1) := by
    apply Finset.sup_le
    intro c hcmem
    obtain ⟨hle, hd⟩ := swapInvariantVanishing_support_shift_necSuf P hswap hlz c (mem_support_iff.mp hcmem)
    calc exponentTotalNecSuf c
        = exponentTotalNecSuf (c - allOnesExponent (Fin (n + 1)) + allOnesExponent (Fin (n + 1))) := by
          rw [tsub_add_cancel_of_le hle]
      _ = exponentTotalNecSuf (c - allOnesExponent (Fin (n + 1))) + (n + 1) :=
          exponentTotal_add_allOnes_necSuf _
      _ ≤ totalDegreeNecSuf (allOnesShiftNecSuf P) + (n + 1) :=
          Nat.add_le_add_right (Finset.le_sup (mem_support_iff.mpr hd)) _
  have hlower : totalDegreeNecSuf (allOnesShiftNecSuf P) + (n + 1) ≤ totalDegreeNecSuf P := by
    obtain ⟨c₀, hc₀⟩ := MvPolynomial.ne_zero_iff.mp hP
    obtain ⟨d, hdmem, hdeq⟩ := Finset.exists_mem_eq_sup (allOnesShiftNecSuf P).support
      ⟨_, mem_support_iff.mpr (swapInvariantVanishing_support_shift_necSuf P hswap hlz c₀ hc₀).2⟩
      exponentTotalNecSuf
    have hd : coeff (d + allOnesExponent (Fin (n + 1))) P ≠ 0 := by
      rw [← allOnesShiftNecSuf_coeff]
      exact mem_support_iff.mp hdmem
    calc totalDegreeNecSuf (allOnesShiftNecSuf P) + (n + 1)
        = exponentTotalNecSuf d + (n + 1) := by rw [totalDegreeNecSuf, hdeq]
      _ = exponentTotalNecSuf (d + allOnesExponent (Fin (n + 1))) :=
          (exponentTotal_add_allOnes_necSuf d).symm
      _ ≤ totalDegreeNecSuf P := Finset.le_sup (mem_support_iff.mpr hd)
  exact le_antisymm hlower hupper

/-- `claim_symmetric_vanishing_last_variable_divisible_by_product` の必要十分版（具体版と同じ段）。
係数の集合 `S` は任意の部分集合でよい。 -/
theorem symmetricVanishing_divisible_by_product_necSuf (S : Set K) {n : ℕ}
    (P : MvPolynomial (Fin (n + 1)) K) (hS : ∀ a : Fin (n + 1) →₀ ℕ, coeff a P ∈ S)
    (hsym : ∀ e : Fin (n + 1) ≃ Fin (n + 1),
      aeval (fun k => (X (e k) : MvPolynomial (Fin (n + 1)) K)) P = P)
    (hlz : lastVariableZeroNecSuf n P = 0) :
    ∃ Q : MvPolynomial (Fin (n + 1)) K, (∀ a : Fin (n + 1) →₀ ℕ, coeff a Q ∈ S) ∧
      (∀ e : Fin (n + 1) ≃ Fin (n + 1),
        aeval (fun k => (X (e k) : MvPolynomial (Fin (n + 1)) K)) Q = Q) ∧
      P = (∑ T ∈ Finset.powersetCard (n + 1) (Finset.univ : Finset (Fin (n + 1))), ∏ k ∈ T, X k) * Q ∧
      (P ≠ 0 → totalDegreeNecSuf Q + (n + 1) = totalDegreeNecSuf P) :=
  ⟨allOnesShiftNecSuf P, allOnesShift_coeff_mem_necSuf S P hS,
    fun e => allOnesShift_equivInvariant_necSuf e P (hsym e),
    swapInvariantVanishing_eq_monomialProd_mul_allOnesShift_necSuf P
      (fun k => hsym (Equiv.swap k (Fin.last n))) hlz,
    fun hP => allOnesShift_totalDegree_necSuf P (fun k => hsym (Equiv.swap k (Fin.last n))) hlz hP⟩

end Ising2DLambda.NecSuf.FisherZero
