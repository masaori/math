/-
節「変数の置換と対称多項式」の主張の必要十分版。

具体版（`Ising2DLambda.FisherZero.variablePermutation_coeff`）と同じ段
（代入の定義 → 項の積を全単射で添字を付け替えて単項式に書く → 和の係数 → 各項の係数 → 係数が残る指数は一つ）で示し、
各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい。体であること・零因子が無いこと・符号反転は使わない
  （定数と単項式の積の係数は `monomialProd_mul_coeff_necSuf` から得るので、そこと同じ仮定で済む）。
- 変数の付け替えは、置換（同じ添字集合の上の全単射）でなくてよい。二つの有限集合 `σ`・`τ` の間の全単射 `e : σ ≃ τ` で、
  `σ` の変数 `X_k` に `τ` の変数 `X_{e(k)}` を代入する写像について同じ式が成り立つ。
  全単射であることは、項の積の添字を `e` で付け替える段（`Equiv.prod_comp`）と、
  `b ∘ e^{-1} = a ⟺ b = a ∘ e` の段で使う。単射だけでは前者が、全射だけでは後者が崩れる。
- 添字集合が有限であることは、代入を全変数にわたる有限積で書く段（`MvPolynomial.eval₂_eq'`）と、
  単項式を全変数にわたる有限積で書く段で使う。
-/
import Ising2DLambda.NecSuf.FisherZero.MonomialAndLastVariableZeroCoefficient

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

variable {σ τ : Type} [Fintype σ] [DecidableEq σ] [Fintype τ] [DecidableEq τ]

/-- 指数の合成 `a ∘ e`。 -/
noncomputable def exponentCompEquiv (a : τ →₀ ℕ) (e : σ ≃ τ) : σ →₀ ℕ :=
  Finsupp.equivMapDomain e.symm a

omit [Fintype σ] [DecidableEq σ] [Fintype τ] [DecidableEq τ] in
theorem exponentCompEquiv_apply (a : τ →₀ ℕ) (e : σ ≃ τ) (k : σ) :
    exponentCompEquiv a e k = a (e k) := by
  simp [exponentCompEquiv, Finsupp.equivMapDomain_apply]

omit [DecidableEq σ] [DecidableEq τ] in
/-- 準備の一つ目（具体版 `variablePermutation_term` と同じ段）。 -/
theorem equivVariable_term (e : σ ≃ τ) (b : σ →₀ ℕ) :
    ∏ k, (X (e k) : MvPolynomial τ K) ^ b k = monomialProd (exponentCompEquiv b e.symm) := by
  unfold monomialProd
  rw [← Equiv.prod_comp e (fun j => (X j : MvPolynomial τ K) ^ (exponentCompEquiv b e.symm) j)]
  refine Finset.prod_congr rfl (fun k _ => ?_)
  rw [exponentCompEquiv_apply, Equiv.symm_apply_apply]

omit [Fintype σ] [DecidableEq σ] in
/-- 準備の二つ目（具体版 `qbarConst_mul_monomial_coeff` と同じ段）。 -/
theorem const_mul_monomialProd_coeff (d : K) (e a : τ →₀ ℕ) :
    coeff a (C d * monomialProd e) = if e = a then d else 0 := by
  classical
  rw [mul_comm, monomialProd_mul_coeff_necSuf]
  split_ifs with hle heq heq
  · rw [coeff_C, if_pos]
    rw [heq, tsub_self]
  · rw [coeff_C, if_neg]
    intro h0
    exact heq (le_antisymm hle (tsub_eq_zero_iff_le.mp h0.symm))
  · exact absurd (heq ▸ le_refl a) hle
  · rfl

omit [DecidableEq σ] in
/-- `claim_qbar_variable_permutation_coefficient` の必要十分版（具体版 `variablePermutation_coeff` と同じ段）。
`mco_a(ms_{X ∘ e}(P)) = mco_{a ∘ e}(P)`。 -/
theorem equivVariable_coeff_necSuf (e : σ ≃ τ) (P : MvPolynomial σ K) (a : τ →₀ ℕ) :
    coeff a (aeval (fun k => (X (e k) : MvPolynomial τ K)) P) = coeff (exponentCompEquiv a e) P := by
  classical
  rw [aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']
  simp_rw [equivVariable_term]
  rw [coeff_sum]
  simp_rw [MvPolynomial.algebraMap_eq, const_mul_monomialProd_coeff]
  have hiff : ∀ b : σ →₀ ℕ, exponentCompEquiv b e.symm = a ↔ b = exponentCompEquiv a e := by
    intro b
    constructor
    · intro h
      ext k
      rw [exponentCompEquiv_apply, ← h, exponentCompEquiv_apply, Equiv.symm_apply_apply]
    · intro h
      ext j
      rw [exponentCompEquiv_apply, h, exponentCompEquiv_apply, Equiv.apply_symm_apply]
  rw [Finset.sum_eq_single (exponentCompEquiv a e)]
  · rw [if_pos ((hiff _).mpr rfl)]
  · intro b _ hne
    rw [if_neg]
    intro h
    exact hne ((hiff b).mp h)
  · intro hnot
    rw [if_pos ((hiff _).mpr rfl)]
    by_contra hcoeff
    exact hnot (mem_support_iff.mpr hcoeff)

end Ising2DLambda.NecSuf.FisherZero
