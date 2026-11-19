/-
節「基本対称式への代入」（対称性の部分）の主張の必要十分版。

具体版（`Ising2DLambda.FisherZero` の `qbarMvSubst_comp`・`elementarySymmetric_isQbarSymmetric`・
`elementarySymmetricSubst_isQbarSymmetric`）と同じ段で示し、各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい。体であること・零因子が無いこと・符号反転はどの段でも使わない。
- 代入の合成: 外側・内側の変数の集合 `τ`・`υ` は有限でなくてよい。内側の代入を全変数にわたる
  有限積で書く段（`MvPolynomial.eval₂_eq'`）で、最初の変数の集合 `σ` が有限であることだけを使う。
- 基本対称式の不変性: 添字集合 `σ` の上の一つの全単射 `ϱ` について成り立つ。全単射であることは、
  `S ↦ ϱ(S)` が `j` 元部分集合の全単射になる段で使う（単射で `|ϱ(S)| = |S|`、逆写像で全射）。
- 代入した多項式の不変性: 基本対称式であることも、置換による代入であることも要らない。
  外側の代入 `y` が内側で代入する値 `e(k)` を一つずつ固定すれば、代入した多項式も `y` で固定される。
  具体版では `y` が変数の置換、`e(k)` が基本対称式で、固定することが基本対称式の対称性である。
-/
import Mathlib.Algebra.MvPolynomial.Eval
import Mathlib.Data.Finset.Powerset

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

/-- `claim_qbar_multivariate_substitution_composition` の必要十分版（具体版と同じ段）。 -/
theorem mvSubst_comp_necSuf {σ τ υ : Type} [Fintype σ] (e : σ → MvPolynomial τ K)
    (y : τ → MvPolynomial υ K) (Q : MvPolynomial σ K) :
    aeval y (aeval e Q) = aeval (fun k => aeval y (e k)) Q := by
  -- 第一の等号: 内側の代入の定義。
  have hinner : aeval e Q =
      ∑ d ∈ Q.support, algebraMap K (MvPolynomial τ K) (coeff d Q) * ∏ i, e i ^ d i := by
    rw [aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']
  rw [hinner]
  -- 第二の等号: 外側の代入は有限和・積・有限積・冪を保つ。
  rw [map_sum]
  simp_rw [map_mul, map_prod, map_pow]
  -- 第三の等号: 外側の代入は定数を保つ。
  simp_rw [AlgHom.commutes]
  -- 第四・第五の等号: 合成の定義と代入の定義。
  conv_rhs => rw [aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']

/-- `claim_qbar_elementary_symmetric_is_symmetric` の必要十分版（具体版と同じ段）。
一つの全単射 `ϱ : σ ≃ σ` について、`j` 次の基本対称式は変数の付け替えで不変。 -/
theorem elementarySymmetric_equivInvariant_necSuf {σ : Type} [Fintype σ] [DecidableEq σ]
    (ϱ : σ ≃ σ) (j : ℕ) :
    aeval (fun k => (X (ϱ k) : MvPolynomial σ K))
        (∑ S ∈ Finset.powersetCard j (Finset.univ : Finset σ), ∏ k ∈ S, (X k : MvPolynomial σ K)) =
      ∑ S ∈ Finset.powersetCard j (Finset.univ : Finset σ), ∏ k ∈ S, (X k : MvPolynomial σ K) := by
  -- 第二の等号: 代入は有限和と有限積を保つ。
  rw [map_sum]
  simp_rw [map_prod]
  -- 第三の等号: 変数の値。
  simp_rw [aeval_X]
  -- 第四の等号: 第一の準備（積の添字を ϱ で付け替える）。
  have hterm : ∀ S : Finset σ, ∏ k ∈ S, (X (ϱ k) : MvPolynomial σ K) =
      ∏ i ∈ S.map ϱ.toEmbedding, X i := by
    intro S
    rw [Finset.prod_map]
    rfl
  simp_rw [hterm]
  -- 第五の等号: 第二の準備（S ↦ ϱ(S) は j 元部分集合の全単射）。
  refine Finset.sum_nbij' (fun S => S.map ϱ.toEmbedding) (fun T => T.map ϱ.symm.toEmbedding)
    ?_ ?_ ?_ ?_ ?_
  · intro S hS
    simp only [Finset.mem_powersetCard, Finset.subset_univ, true_and] at hS ⊢
    rw [Finset.card_map, hS]
  · intro T hT
    simp only [Finset.mem_powersetCard, Finset.subset_univ, true_and] at hT ⊢
    rw [Finset.card_map, hT]
  · intro S _
    ext k
    simp
  · intro T _
    ext i
    simp
  · intro S _
    rfl

/-- `claim_elementary_symmetric_substitution_symmetric` の必要十分版（具体版と同じ段）。
外側の代入 `y` が各値 `e(k)` を固定すれば、`e` を代入した多項式も `y` で固定される。 -/
theorem mvSubst_fixed_of_values_fixed_necSuf {σ τ : Type} [Fintype σ] (e : σ → MvPolynomial τ K)
    (y : τ → MvPolynomial τ K) (hfix : ∀ k : σ, aeval y (e k) = e k) (Q : MvPolynomial σ K) :
    aeval y (aeval e Q) = aeval e Q := by
  calc aeval y (aeval e Q)
      = aeval (fun k => aeval y (e k)) Q := mvSubst_comp_necSuf e y Q
    _ = aeval e Q := by rw [show (fun k => aeval y (e k)) = e from funext hfix]

end Ising2DLambda.NecSuf.FisherZero
