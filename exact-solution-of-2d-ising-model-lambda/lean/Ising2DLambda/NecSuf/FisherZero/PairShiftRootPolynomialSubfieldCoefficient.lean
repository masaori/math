/-
節「根の対の整数倍のずらしを根とする多項式」の三つの主張の必要十分版。

具体版（`Ising2DLambda.FisherZero.qbarMvValue_qbarMvSubst`・`qbarMvValue_mem_subfield`・
`pairShiftRootPolynomial_mem_subfieldCoefficientPolynomials`）と同じ段
（代入を有限和に開いて値を通す、値を有限和に開いて各項の所属を見る、係数の上界と Vieta と
代入してから値を取ることと対称式の基本定理の式鎖）で示し、各段が実際に使う性質だけを仮定に置く。

- 代入してから値を取る主張は、係数が可換半環 `K` でよい。変数の集合 `σ` は有限であることを使う
  （代入を全変数の有限積に開く段）。値を取る側の変数の集合 `τ` は有限でなくてよい。
- 値の所属の主張は、部分体 `F` の代わりに、零元・単位元を含み和と積で閉じた部分集合 `S` でよい。
  零元は空和に、単位元は空積と零乗に、和と積は各項に要る。符号反転・逆元は使わない。
- 本体の主張は、係数が可換環 `K` でよい。符号反転が要るのは Vieta の符号 `(-1)^j` と、対称式の基本定理の
  必要十分版が可換環を要るため。体であること・零因子が無いことは使わない。係数の集合は
  `0`・`1`・`−1` を含み和と積で閉じた `S` でよい（`−1` は符号と対称式の基本定理に要る）。
  逆元で閉じていることは使わない。
-/
import Ising2DLambda.NecSuf.FisherZero.PairShiftElementarySymmetric
import Ising2DLambda.NecSuf.FisherZero.LinearFactorProductElementarySymmetric
import Ising2DLambda.NecSuf.FisherZero.SymmetricPolynomialFundamentalTheorem
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorProductCoeffBound

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

/-- `claim_qbar_multivariate_point_value_of_substitution` の必要十分版（具体版と同じ段）。 -/
theorem aeval_aeval_necSuf {K : Type} [CommSemiring K] {σ τ : Type} [Fintype σ]
    (y : σ → MvPolynomial τ K) (α : τ → K) (P : MvPolynomial σ K) :
    aeval α (aeval y P) = aeval (fun r => aeval α (y r)) P := by
  -- 第一の等号: 代入の定義。
  have hinner : aeval y P =
      ∑ a ∈ P.support, algebraMap K (MvPolynomial τ K) (coeff a P) * ∏ r, y r ^ a r := by
    rw [aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']
  rw [hinner]
  -- 第二の等号: 値は有限和・積・有限積・冪を保つ。
  rw [map_sum]
  simp_rw [map_mul, map_prod, map_pow]
  -- 第三の等号: 値は定数をその元へ送る。
  simp_rw [AlgHom.commutes]
  -- 第四の等号: 点での値の定義。
  conv_rhs => rw [aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']

/-- 冪の所属（単位元を含み積で閉じた集合）。 -/
theorem pow_mem_of_closed_necSuf {K : Type} [CommSemiring K] {S : Set K} (h1 : (1 : K) ∈ S)
    (hmul : ∀ x y : K, x ∈ S → y ∈ S → x * y ∈ S) {x : K} (hx : x ∈ S) :
    ∀ e : ℕ, x ^ e ∈ S
  | 0 => by simpa using h1
  | e + 1 => by
      rw [pow_succ]
      exact hmul _ _ (pow_mem_of_closed_necSuf h1 hmul hx e) hx

/-- `claim_subfield_coefficient_multivariate_point_value_mem` の必要十分版（具体版と同じ段）。 -/
theorem aeval_mem_of_coeffIn_necSuf {K : Type} [CommSemiring K] {S : Set K} {σ : Type} [Fintype σ]
    (h0 : (0 : K) ∈ S) (h1 : (1 : K) ∈ S)
    (hadd : ∀ x y : K, x ∈ S → y ∈ S → x + y ∈ S) (hmul : ∀ x y : K, x ∈ S → y ∈ S → x * y ∈ S)
    {P : MvPolynomial σ K} (hP : P ∈ coeffIn S σ) {α : σ → K} (hα : ∀ k, α k ∈ S) :
    aeval α P ∈ S := by
  rw [aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']
  refine Finset.sum_induction _ (· ∈ S) hadd h0 fun a _ => hmul _ _ (by simpa using hP a) ?_
  exact Finset.prod_induction _ (· ∈ S) hmul h1 fun k _ =>
    pow_mem_of_closed_necSuf h1 hmul (hα k) _

/-- 基本対称式の点での値は、部分集合にわたる積の和である。 -/
theorem aeval_esNecSuf {K : Type} [CommRing K] {n : ℕ} (α : Fin n → K) (j : ℕ) :
    aeval α (esNecSuf (K := K) n j) =
      ∑ T ∈ Finset.powersetCard j (Finset.univ : Finset (Fin n)), ∏ k ∈ T, α k := by
  simp [esNecSuf, map_sum, map_prod]

/-- `claim_pair_shift_root_polynomial_subfield_coefficient` の必要十分版（具体版と同じ段）。 -/
theorem pairShiftRootPolynomial_coeff_mem_necSuf {K : Type} [CommRing K] {S : Set K}
    (h0 : (0 : K) ∈ S) (h1 : (1 : K) ∈ S) (hneg : (-1 : K) ∈ S)
    (hadd : ∀ x y : K, x ∈ S → y ∈ S → x + y ∈ S) (hmul : ∀ x y : K, x ∈ S → y ∈ S → x * y ∈ S)
    {d N : ℕ} (α : ℕ → K)
    (hf : ∀ m : ℕ, (∏ i ∈ Finset.range d, (Polynomial.X - Polynomial.C (α i))).coeff m ∈ S)
    {c : K} (hc : c ∈ S) (π : Fin N ≃ OrderedPair (Fin d)) (β : ℕ → K)
    (hβ : ∀ r : Fin N, β r = α (π r).1.1 + α (π r).1.2 + c * α (π r).1.1 * α (π r).1.2) :
    ∀ m : ℕ, (∏ r ∈ Finset.range N, (Polynomial.X - Polynomial.C (β r))).coeff m ∈ S := by
  set α' : Fin d → K := fun k => α k
  -- 第一の準備。
  have hval : (fun r : Fin N => β r) = fun r : Fin N => aeval α' (pairShiftValuesNecSuf c π r) := by
    funext r
    rw [hβ r]
    simp [pairShiftValuesNecSuf, α']
  -- 第二の準備。
  have hes : ∀ i : Fin d, aeval α' (esValuesNecSuf (K := K) d i) ∈ S := by
    intro i
    have hv := linearFactorProduct_coeff_elementarySymmetric_necSuf α d (i.val + 1) i.isLt
    have heq : aeval α' (esValuesNecSuf (K := K) d i) =
        (-1) ^ (i.val + 1) *
          (∏ i ∈ Finset.range d, (Polynomial.X - Polynomial.C (α i))).coeff (d - (i.val + 1)) := by
      rw [hv, ← mul_assoc, ← pow_add, ← two_mul, pow_mul, neg_one_sq, one_pow, one_mul]
      exact aeval_esNecSuf α' (i.val + 1)
    rw [heq]
    exact hmul _ _ (pow_mem_of_closed_necSuf h1 hmul hneg _) (hf _)
  intro m
  rcases Nat.lt_or_ge N m with hm | hm
  · rw [Ising2DLambda.NecSuf.AlgebraicEigenvalue.poly_linear_factor_product_coeff_bound_necSuf
      β N m hm]
    exact h0
  · obtain ⟨k, hk, rfl⟩ : ∃ k, k ≤ N ∧ m = N - k := ⟨N - m, by omega, by omega⟩
    obtain ⟨Q, hQ, hPQ, -⟩ := symmetricPolynomialFundamental_necSuf h0 h1 hneg hadd hmul d _
      (pairShiftElementarySymmetric_mem_coeffIn_necSuf h0 h1 hadd hmul hc π k)
      (fun e => pairShiftElementarySymmetric_equivInvariant_necSuf c π e k)
    have hchain :
        (∏ r ∈ Finset.range N, (Polynomial.X - Polynomial.C (β r))).coeff (N - k) =
          (-1) ^ k * aeval (fun i => aeval α' (esValuesNecSuf (K := K) d i)) Q := by
      calc (∏ r ∈ Finset.range N, (Polynomial.X - Polynomial.C (β r))).coeff (N - k)
          -- 第一の等号: Vieta。
          = (-1) ^ k * aeval (fun r : Fin N => β r) (esNecSuf (K := K) N k) := by
            rw [linearFactorProduct_coeff_elementarySymmetric_necSuf β N k hk, aeval_esNecSuf]
          -- 第二の等号: 第一の準備。
        _ = (-1) ^ k * aeval (fun r : Fin N => aeval α' (pairShiftValuesNecSuf c π r))
              (esNecSuf (K := K) N k) := by rw [hval]
          -- 第三の等号: 代入してから値を取る。
        _ = (-1) ^ k * aeval α' (aeval (pairShiftValuesNecSuf c π) (esNecSuf (K := K) N k)) := by
            rw [aeval_aeval_necSuf]
          -- 第四の等号: 対称式の基本定理。
        _ = (-1) ^ k * aeval α' (seNecSuf d Q) := by
            rw [← hPQ]
            rfl
          -- 第五・第六の等号: 基本対称式への代入の定義と、代入してから値を取る。
        _ = (-1) ^ k * aeval (fun i => aeval α' (esValuesNecSuf (K := K) d i)) Q := by
            rw [seNecSuf, aeval_aeval_necSuf]
    rw [hchain]
    exact hmul _ _ (pow_mem_of_closed_necSuf h1 hmul hneg _)
      (aeval_mem_of_coeffIn_necSuf h0 h1 hadd hmul hQ hes)

end Ising2DLambda.NecSuf.FisherZero
