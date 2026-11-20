/-
節「根の対の整数倍のずらしを根とする多項式」の具体版。

  人手証明                                                          このファイル
  主張 `claim_qbar_multivariate_point_value_of_substitution`         `qbarMvValue_qbarMvSubst`
  主張 `claim_subfield_coefficient_multivariate_point_value_mem`     `qbarMvValue_mem_subfield`
  主張 `claim_pair_shift_root_polynomial_subfield_coefficient`       `pairShiftRootPolynomial_mem_subfieldCoefficientPolynomials`
    第一の準備（mev_{d,α_{<d}}(ps(r)) = β(r)）                       `pairShiftValues_qbarMvValue`
    第二の準備（mev_{d,α_{<d}}(ee_d(i)) ∈ F）                        `elementarySymmetricValues_qbarMvValue_mem`
    番号が N より大きい係数                                         `qbarPolyLinearFactorProductCoeffBound`
    式鎖の第一の等号（Vieta）                                       `linearFactorProduct_coeff_elementarySymmetric`
    式鎖の第三・第六の等号（代入してから値を取る）                  `qbarMvValue_qbarMvSubst`
    式鎖の第四の等号（対称式の基本定理）                            `symmetricPolynomialFundamental`
    式鎖の所属（値は F に入る）                                     `qbarMvValue_mem_subfield`

本文の全単射 `ν : ℕ_{<N} → Pr_d` は `π : Fin N ≃ RootIndexPair d`、`α_{<d}` は `fun k : Fin d => α k`。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.PairShiftElementarySymmetric
import Ising2DLambda.FisherZero.LinearFactorProductElementarySymmetric
import Ising2DLambda.FisherZero.SymmetricPolynomialFundamentalTheorem
import Ising2DLambda.FisherZero.SubfieldCoefficientPolynomials

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `claim_qbar_multivariate_point_value_of_substitution` の具体版。
`mev_{m,α}(ms_y(P)) = mev_{n, mev_{m,α} ∘ y}(P)`。人手証明の式鎖: 代入の定義で有限和に開く →
値は有限和・積・有限積・冪を保つ → 値は定数をその元へ送る → 点での値の定義。 -/
theorem qbarMvValue_qbarMvSubst {n m : ℕ} (y : Fin n → QbarMvPoly m) (α : Fin m → Qbar)
    (P : QbarMvPoly n) :
    qbarMvValue α (qbarMvSubst y P) = qbarMvValue (fun r => qbarMvValue α (y r)) P := by
  -- 第一の等号: 代入の定義。
  have hinner : qbarMvSubst y P =
      ∑ a ∈ P.support, algebraMap Qbar (QbarMvPoly m) (coeff a P) * ∏ r, y r ^ a r := by
    rw [qbarMvSubst, aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']
  rw [hinner]
  -- 第二の等号: 値は有限和・積・有限積・冪を保つ。
  rw [map_sum]
  simp_rw [map_mul, map_prod, map_pow]
  -- 第三の等号: 値は定数をその元へ送る。
  simp_rw [AlgHom.commutes]
  -- 第四の等号: 点での値の定義。
  conv_rhs => rw [qbarMvValue, aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']

/-- `claim_subfield_coefficient_multivariate_point_value_mem` の具体版。
`P ∈ F[X_{<n}]` で各 `α(k) ∈ F` なら `mev_{n,α}(P) ∈ F`。値を有限和に開き、各項の係数・因子の所属と、
部分体が積・冪・有限積・有限和で閉じることを使う。 -/
theorem qbarMvValue_mem_subfield (F : Subfield Qbar) {n : ℕ} {P : QbarMvPoly n}
    (hP : P ∈ subfieldCoefficientMvPolys F n) {α : Fin n → Qbar} (hα : ∀ k, α k ∈ F) :
    qbarMvValue α P ∈ F := by
  rw [qbarMvValue, aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']
  refine F.sum_mem fun a _ => F.mul_mem ?_ (F.prod_mem fun k _ => F.pow_mem (hα k) _)
  simpa using hP a

/-- `claim_pair_shift_root_polynomial_subfield_coefficient` の第一の準備。
`mev_{d,α_{<d}}(ps_{c,ν}(r)) = α(i) + α(j) + c·α(i)·α(j)`（`ν(r) = (i,j)`）。 -/
theorem pairShiftValues_qbarMvValue {d N : ℕ} (α : ℕ → Qbar) (c : Qbar)
    (π : Fin N ≃ RootIndexPair d) (r : Fin N) :
    qbarMvValue (fun k : Fin d => α k) (pairShiftValues c π r) =
      α (π r).1.1 + α (π r).1.2 + c * α (π r).1.1 * α (π r).1.2 := by
  simp [qbarMvValue, pairShiftValues]

/-- `claim_pair_shift_root_polynomial_subfield_coefficient` の第二の準備。
`∏_{i<d}(t - α̂(i)) ∈ F[t]` なら `mev_{d,α_{<d}}(es_{d,i+1}) = (-1)^{i+1}·ac_{d-(i+1)}(∏_{i<d}(t - α̂(i))) ∈ F`。 -/
theorem elementarySymmetricValues_qbarMvValue_mem (F : Subfield Qbar) {d : ℕ} (α : ℕ → Qbar)
    (hf : (∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α i))) ∈
      subfieldCoefficientPolynomials F) (i : Fin d) :
    qbarMvValue (fun k : Fin d => α k) (elementarySymmetricValues d i) ∈ F := by
  have hv := linearFactorProduct_coeff_elementarySymmetric α d (i.val + 1) i.isLt
  have heq : qbarMvValue (fun k : Fin d => α k) (elementarySymmetricValues d i) =
      (-1) ^ (i.val + 1) *
        (∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α i))).coeff (d - (i.val + 1)) := by
    rw [hv, ← mul_assoc, ← pow_add, ← two_mul, pow_mul, neg_one_sq, one_pow, one_mul]
    rfl
  rw [heq]
  exact F.mul_mem (F.pow_mem (F.neg_mem F.one_mem) _) (hf _)

/-- `claim_pair_shift_root_polynomial_subfield_coefficient` の具体版。
`∏_{i<d}(t - α̂(i)) ∈ F[t]`、`c ∈ F`、`r < N` で `β(r) = α(i)+α(j)+c·α(i)·α(j)`（`ν(r) = (i,j)`）なら
`∏_{r<N}(t - β̂(r)) ∈ F[t]`。 -/
theorem pairShiftRootPolynomial_mem_subfieldCoefficientPolynomials (F : Subfield Qbar)
    {d N : ℕ} (α : ℕ → Qbar)
    (hf : (∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α i))) ∈
      subfieldCoefficientPolynomials F)
    {c : Qbar} (hc : c ∈ F) (π : Fin N ≃ RootIndexPair d) (β : ℕ → Qbar)
    (hβ : ∀ r : Fin N, β r = α (π r).1.1 + α (π r).1.2 + c * α (π r).1.1 * α (π r).1.2) :
    (∏ r ∈ Finset.range N, (Polynomial.X - qbarConst (β r))) ∈
      subfieldCoefficientPolynomials F := by
  -- 第一の準備を写像の等式にしたもの。
  have hval : (fun r : Fin N => β r) =
      fun r : Fin N => qbarMvValue (fun k : Fin d => α k) (pairShiftValues c π r) := by
    funext r
    rw [hβ r, pairShiftValues_qbarMvValue]
  intro m
  rcases Nat.lt_or_ge N m with hm | hm
  · -- 番号が N より大きい係数は零。
    rw [qbarPolyLinearFactorProductCoeffBound β N m hm]
    exact F.zero_mem
  · obtain ⟨k, hk, rfl⟩ : ∃ k, k ≤ N ∧ m = N - k := ⟨N - m, by omega, by omega⟩
    -- 対称式の基本定理から Q ∈ F[X_{<d}]、ms_ps(es_{N,k}) = se_d(Q)。
    obtain ⟨Q, hQ, hPQ, -⟩ := symmetricPolynomialFundamental F d _
      (pairShiftElementarySymmetric_mem_subfieldCoefficientMvPolys F hc π k)
      (pairShiftElementarySymmetric_isQbarSymmetric c π k)
    have hchain :
        (∏ r ∈ Finset.range N, (Polynomial.X - qbarConst (β r))).coeff (N - k) =
          (-1) ^ k * qbarMvValue
            (fun i => qbarMvValue (fun k : Fin d => α k) (elementarySymmetricValues d i)) Q := by
      calc (∏ r ∈ Finset.range N, (Polynomial.X - qbarConst (β r))).coeff (N - k)
          -- 第一の等号: Vieta。
          = (-1) ^ k * qbarMvValue (fun r : Fin N => β r) (qbarElementarySymmetric N k) :=
            linearFactorProduct_coeff_elementarySymmetric β N k hk
          -- 第二の等号: 第一の準備。
        _ = (-1) ^ k * qbarMvValue
              (fun r : Fin N => qbarMvValue (fun k : Fin d => α k) (pairShiftValues c π r))
              (qbarElementarySymmetric N k) := by rw [hval]
          -- 第三の等号: 代入してから値を取る。
        _ = (-1) ^ k * qbarMvValue (fun k : Fin d => α k)
              (qbarMvSubst (pairShiftValues c π) (qbarElementarySymmetric N k)) := by
            rw [qbarMvValue_qbarMvSubst]
          -- 第四の等号: 対称式の基本定理。
        _ = (-1) ^ k * qbarMvValue (fun k : Fin d => α k) (elementarySymmetricSubst d Q) := by
            rw [← hPQ]
          -- 第五の等号: 基本対称式への代入の定義。
        _ = (-1) ^ k * qbarMvValue (fun k : Fin d => α k)
              (qbarMvSubst (elementarySymmetricValues d) Q) := rfl
          -- 第六の等号: 代入してから値を取る。
        _ = (-1) ^ k * qbarMvValue
              (fun i => qbarMvValue (fun k : Fin d => α k) (elementarySymmetricValues d i)) Q := by
            rw [qbarMvValue_qbarMvSubst]
    rw [hchain]
    exact F.mul_mem (F.pow_mem (F.neg_mem F.one_mem) _)
      (qbarMvValue_mem_subfield F hQ (elementarySymmetricValues_qbarMvValue_mem F α hf))

end Ising2DLambda.FisherZero
