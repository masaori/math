/-
節「零代入で消える対称多項式を全変数の積で割る」の主張の必要十分版。

具体版（`Ising2DLambda.FisherZero.qbarElementarySymmetric_self_eq_monomial_allOnes`・
`Ising2DLambda.FisherZero.symmetricVanishing_eq_elementarySymmetric_mul_allOnesShift`）と同じ段で示し、
各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい。体であること・零因子が無いこと・符号反転は使わない
  （使う二つの係数の主張 `monomialProd_mul_coeff_necSuf`・`swapInvariantVanishing_coeff_eq_zero_necSuf` と同じ仮定）。
- 「変数の個数と同じ次数の基本対称式は全ての指数が一の単項式である」は、添字が `Fin n` である必要が無く、
  任意の有限集合 `σ` で成り立つ（使うのは、元の個数が全体と同じ部分集合は全体だけであることだけ）。
- 割り算の主張で対称性（全ての置換で不変）は要らない。使うのは、各 `k` と末尾 `n` を入れ替える互換
  `(k n)` についての不変性だけである（成分が零の添字ごとに一つ使う）。
-/
import Ising2DLambda.NecSuf.FisherZero.SymmetricVanishingCoefficientSupport

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

variable {σ : Type} [Fintype σ]

/-- 全ての成分が 1 の指数 `1`。 -/
noncomputable def allOnesExponent (σ : Type) [Fintype σ] : σ →₀ ℕ :=
  Finsupp.equivFunOnFinite.symm (fun _ => 1)

theorem allOnesExponent_apply (k : σ) : allOnesExponent σ k = 1 := rfl

/-- 全ての指数を一つ下げた多項式。係数の族を `d ↦ d + 1` で引き戻す。 -/
noncomputable def allOnesShiftNecSuf (P : MvPolynomial σ K) : MvPolynomial σ K :=
  AddMonoidAlgebra.ofCoeff
    (Finsupp.comapDomain (fun d : σ →₀ ℕ => d + allOnesExponent σ) (AddMonoidAlgebra.coeff P)
      ((add_left_injective (allOnesExponent σ)).injOn))

theorem allOnesShiftNecSuf_coeff (P : MvPolynomial σ K) (d : σ →₀ ℕ) :
    coeff d (allOnesShiftNecSuf P) = coeff (d + allOnesExponent σ) P := rfl

/-- `claim_qbar_full_elementary_symmetric_is_all_ones_monomial` の必要十分版（具体版と同じ段）。
任意の有限集合 `σ` で、`|σ|` 元部分集合にわたる積の和は全ての指数が一の単項式。 -/
theorem elementarySymmetricCard_eq_monomialProd_allOnes_necSuf :
    (∑ S ∈ Finset.powersetCard (Fintype.card σ) (Finset.univ : Finset σ), ∏ k ∈ S, X k
      : MvPolynomial σ K) = monomialProd (allOnesExponent σ) := by
  calc (∑ S ∈ Finset.powersetCard (Fintype.card σ) (Finset.univ : Finset σ), ∏ k ∈ S, X k
        : MvPolynomial σ K)
      = ∏ k ∈ (Finset.univ : Finset σ), (X k : MvPolynomial σ K) := by
        have hself := Finset.powersetCard_self (Finset.univ : Finset σ)
        rw [Finset.card_univ] at hself
        rw [hself, Finset.sum_singleton]
    _ = ∏ k, (X k : MvPolynomial σ K) ^ allOnesExponent σ k := by
        simp only [allOnesExponent_apply, pow_one]
    _ = monomialProd (allOnesExponent σ) := rfl

/-- 準備（具体版 `exists_eq_zero_of_not_allOnes_le` と同じ段）。 -/
theorem exists_eq_zero_of_not_allOnes_le (c : σ →₀ ℕ)
    (h : ¬ allOnesExponent σ ≤ c) : ∃ k, c k = 0 := by
  rw [Finsupp.le_def] at h
  simp only [not_forall, not_le] at h
  obtain ⟨k, hk⟩ := h
  rw [allOnesExponent_apply] at hk
  exact ⟨k, by omega⟩

/-- `claim_symmetric_vanishing_last_variable_shifted_quotient_product` の必要十分版（具体版と同じ段）。
仮定は各互換 `(k n)` についての不変性と `lz_n(P) = 0`。 -/
theorem swapInvariantVanishing_eq_monomialProd_mul_allOnesShift_necSuf {n : ℕ}
    (P : MvPolynomial (Fin (n + 1)) K)
    (hswap : ∀ k : Fin (n + 1),
      aeval (fun i => (X (Equiv.swap k (Fin.last n) i) : MvPolynomial (Fin (n + 1)) K)) P = P)
    (hlz : lastVariableZeroNecSuf n P = 0) :
    P = (∑ S ∈ Finset.powersetCard (n + 1) (Finset.univ : Finset (Fin (n + 1))), ∏ k ∈ S, X k)
      * allOnesShiftNecSuf P := by
  classical
  ext c
  symm
  calc coeff c ((∑ S ∈ Finset.powersetCard (n + 1) (Finset.univ : Finset (Fin (n + 1))), ∏ k ∈ S, X k)
        * allOnesShiftNecSuf P)
      = coeff c (monomialProd (allOnesExponent (Fin (n + 1))) * allOnesShiftNecSuf P) := by
        have h := elementarySymmetricCard_eq_monomialProd_allOnes_necSuf (K := K) (σ := Fin (n + 1))
        rw [Fintype.card_fin] at h
        rw [h]
    _ = if allOnesExponent (Fin (n + 1)) ≤ c
          then coeff (c - allOnesExponent (Fin (n + 1))) (allOnesShiftNecSuf P) else 0 :=
        monomialProd_mul_coeff_necSuf _ c _
    _ = if allOnesExponent (Fin (n + 1)) ≤ c
          then coeff (c - allOnesExponent (Fin (n + 1)) + allOnesExponent (Fin (n + 1))) P else 0 := by
        rw [allOnesShiftNecSuf_coeff]
    _ = if allOnesExponent (Fin (n + 1)) ≤ c then coeff c P else 0 := by
        split_ifs with h
        · rw [tsub_add_cancel_of_le h]
        · rfl
    _ = coeff c P := by
        split_ifs with h
        · rfl
        · obtain ⟨k, hk⟩ := exists_eq_zero_of_not_allOnes_le c h
          exact (swapInvariantVanishing_coeff_eq_zero_necSuf P c k (hswap k) hlz hk).symm

end Ising2DLambda.NecSuf.FisherZero
