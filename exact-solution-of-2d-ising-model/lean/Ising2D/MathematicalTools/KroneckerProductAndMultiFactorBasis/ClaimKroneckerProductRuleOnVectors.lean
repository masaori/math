/-
# クロネッカー積の積の規則の (3): `(A_1⊠⋯⊠A_M)(v_1⊠⋯⊠v_M) = (A_1v_1)⊠⋯⊠(A_Mv_M)`（**具体版**）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_000b_claim_kronecker_product_rule`、ラベル **`kronecker_product_rule`** の (3) と、証明の準備
「多重添字についての和を、各因子ごとの和の積へ直すこと」）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備の `M = 1`（両辺とも `c_1(1) + c_1(2)`） | `sum_over_multi_index_of_product_eq_product_of_sums` の `0` の節の `calc` の 2 段 |
| 準備の `M → M+1` の 4 行（最後の成分で場合分けした有限和の分割 → 分配律 → 帰納法の仮定 → 有限積の最後の因子を戻す） | 同じく `M + 1` の節の `calc` の 4 段（1 段目は `sum_conf_succ_eq_sum_last_sum_init`） |
| (3) の 6 行（行列と数ベクトルの積の定義 → `ν` は全単射・`⊠` の定義 → 複素数の積の可換律・結合律 → 準備を `c_k(t) = (A_k)_{i_kt}(v_k)_t` に適用 → 行列と数ベクトルの積の定義 → `⊠` の定義） | `kronecker_product_rule_mulVec` の `calc` の 6 段 |

- 人手の `M ∈ ℤ_{≥1}` は Lean の `M + 1` である（添字は 0 始まりで、人手の `k` は `k - 1`、成分の番号 `1, 2` は `0, 1`）。
- 人手の `𝓘_M = {1,2}^M` は Lean の `Conf M = Fin M → Fin 2`、人手の `(K, t)`（`K ∈ 𝓘_M`、最後の成分 `t`）は `Fin.snoc K t` である。
- 人手は多重添字 `I` を番号 `ν(I)` と同一視して成分を並べ、(3) の 2 行目で和の変数 `p ∈ {1, …, 2^M}` を `p = ν(K)` と書き換える
  （`ν` は全単射）。Lean の添字型は `Conf M` そのものなので、和は初めから `K : Conf M` の上にあり、この段は `rfl` である
  （`DefinitionKroneckerProductOfVectors.lean` の注記と同じ）。
- 人手の行列のクロネッカー積 `A_1⊠⋯⊠A_M`（`def_kronecker` (2)）は `siteProd`（`Ising2D/Representation.lean`、成分は `siteProd_apply` で `rfl`）、
  数ベクトルのクロネッカー積（(1)）は `vecKron`（`DefinitionKroneckerProductOfVectors.lean`）、行列と数ベクトルの積（`mat_mult`）は
  `Matrix.mulVec`（成分 `Σ_j B_{ij}x_j` は `rfl`）である。
- 「複素数の積の可換律・結合律」の段（`(Π a_k)(Π b_k) = Π (a_k b_k)`）は mathlib の `Finset.prod_mul_distrib`、
  「分配律」の段は `Finset.mul_sum`・`Finset.sum_mul`、有限和の分割は `Fin.snocEquiv` による和の付け替えと
  `Fintype.sum_prod_type` で読む。いずれも人手が名前で引く操作そのもので、本文に対応するブロックは無い。

必要十分版は `Ising2D/NecSuf/KroneckerProductRuleOnVectors.lean`、具体版をその系として導くのは
`ClaimKroneckerProductRuleOnVectorsFromNecSuf.lean`。段の対応: 準備の 2 つの節は必要十分版
`NecSuf.sum_pi_finProdLeft_eq_finProdLeft_sum` の 2 つの節（同じ並び）、(3) の 6 段は `NecSuf.matKron'_mulVec_vecKron'` の 6 段
（3 段目の可換律・結合律が必要十分版の仮定 `hmed` を `finProdLeft_mul'` へ渡す段）に当たる。
-/
import Ising2D.Representation
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionKroneckerProductOfVectors
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Fin.Tuple.Basic

namespace Ising2D

open Matrix

/-- 人手の準備の `M → M+1` の 1 行目「最後の成分 `t_{M+1} = t` で場合分けした有限和の分割」:
`Σ_{(t_1,…,t_{M+1}) ∈ 𝓘_{M+1}} Π_{k=1}^{M+1} c_k(t_k) = Σ_{t=1}^{2} Σ_{K ∈ 𝓘_M} (Π_{k=1}^{M} c_k(t_k)) c_{M+1}(t)`
（人手の `M` は Lean の `M + 1`）。 -/
theorem sum_conf_succ_eq_sum_last_sum_init (M : ℕ) (c : Fin (M + 2) → Fin 2 → ℂ) :
    ∑ K : Conf (M + 2), ∏ k, c k (K k)
      = ∑ t : Fin 2, ∑ K : Conf (M + 1),
          (∏ k : Fin (M + 1), c (Fin.castSucc k) (K k)) * c (Fin.last (M + 1)) t := by
  rw [← Fintype.sum_prod_type (f := fun p : Fin 2 × Conf (M + 1) =>
      (∏ k : Fin (M + 1), c (Fin.castSucc k) (p.2 k)) * c (Fin.last (M + 1)) p.1)]
  refine Fintype.sum_equiv (Fin.snocEquiv (fun _ => Fin 2)).symm _ _ fun K => ?_
  simp only [Fin.snocEquiv_symm_apply, Fin.init]
  exact Fin.prod_univ_castSucc _

/-- **人手 `kronecker_product_rule` の証明の準備**（多重添字の和を各因子ごとの和の積へ直すこと）:
`Σ_{K ∈ 𝓘_M} Π_{k=1}^{M} c_k(t_k) = Π_{k=1}^{M} (Σ_{t=1}^{2} c_k(t))`（人手の `M` は Lean の `M + 1`）。 -/
theorem sum_over_multi_index_of_product_eq_product_of_sums :
    ∀ (M : ℕ) (c : Fin (M + 1) → Fin 2 → ℂ),
      ∑ K : Conf (M + 1), ∏ k, c k (K k) = ∏ k, ∑ t : Fin 2, c k t
  | 0, c =>
    calc ∑ K : Conf 1, ∏ k, c k (K k)
        = c 0 0 + c 0 1 := by                                                 -- 左辺は `c_1(1) + c_1(2)`
          rw [Fintype.sum_equiv (Equiv.funUnique (Fin 1) (Fin 2)) _ (fun t => c 0 t)
            (fun K => Fin.prod_univ_one _)]
          exact Fin.sum_univ_two _
      _ = ∏ k, ∑ t : Fin 2, c k t := by                                       -- 右辺も `c_1(1) + c_1(2)`
          rw [Fin.prod_univ_one, Fin.sum_univ_two]
  | M + 1, c =>
    calc ∑ K : Conf (M + 2), ∏ k, c k (K k)
        = ∑ t : Fin 2, ∑ K : Conf (M + 1),
            (∏ k : Fin (M + 1), c (Fin.castSucc k) (K k)) * c (Fin.last (M + 1)) t :=
          sum_conf_succ_eq_sum_last_sum_init M c                              -- 最後の成分で場合分けした有限和の分割
      _ = (∑ K : Conf (M + 1), ∏ k : Fin (M + 1), c (Fin.castSucc k) (K k))
            * ∑ t : Fin 2, c (Fin.last (M + 1)) t := by
          rw [Finset.mul_sum]
          exact Finset.sum_congr rfl fun t _ => (Finset.sum_mul _ _ _).symm   -- 分配律
      _ = (∏ k : Fin (M + 1), ∑ s : Fin 2, c (Fin.castSucc k) s)
            * ∑ t : Fin 2, c (Fin.last (M + 1)) t := by
          rw [sum_over_multi_index_of_product_eq_product_of_sums M (fun k => c (Fin.castSucc k))]
                                                                              -- 帰納法の仮定
      _ = ∏ k, ∑ t : Fin 2, c k t :=
          (Fin.prod_univ_castSucc (fun k => ∑ t : Fin 2, c k t)).symm         -- 有限積の最後の因子を戻した（積の定義）

/-- **人手 `kronecker_product_rule` (3)**: `(A_1⊠⋯⊠A_M)(v_1⊠⋯⊠v_M) = (A_1v_1)⊠⋯⊠(A_Mv_M)`
（人手の `M` は Lean の `M + 1`）。 -/
theorem kronecker_product_rule_mulVec (M : ℕ) (A : Fin (M + 1) → Matrix (Fin 2) (Fin 2) ℂ)
    (v : Fin (M + 1) → Fin 2 → ℂ) :
    siteProd (M + 1) A *ᵥ vecKron (M + 1) v = vecKron (M + 1) (fun k => A k *ᵥ v k) := by
  funext I
  calc (siteProd (M + 1) A *ᵥ vecKron (M + 1) v) I
      = ∑ p, siteProd (M + 1) A I p * vecKron (M + 1) v p := rfl            -- 行列と数ベクトルの積の定義
    _ = ∑ K : Conf (M + 1), (∏ k, A k (I k) (K k)) * (∏ k, v k (K k)) := rfl
                                                                              -- `ν` は全単射、`⊠` の定義
    _ = ∑ K : Conf (M + 1), ∏ k, (A k (I k) (K k) * v k (K k)) :=
          Finset.sum_congr rfl fun K _ => Finset.prod_mul_distrib.symm        -- 複素数の積の可換律・結合律
    _ = ∏ k, ∑ t : Fin 2, A k (I k) t * v k t :=
          sum_over_multi_index_of_product_eq_product_of_sums M (fun k t => A k (I k) t * v k t)
                                                                              -- 準備を `c_k(t) = (A_k)_{i_kt}(v_k)_t` に適用
    _ = ∏ k, (A k *ᵥ v k) (I k) := rfl                                        -- 行列と数ベクトルの積の定義
    _ = vecKron (M + 1) (fun k => A k *ᵥ v k) I := rfl                        -- `⊠` の定義

end Ising2D
