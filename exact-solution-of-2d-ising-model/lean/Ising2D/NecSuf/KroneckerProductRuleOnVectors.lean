/-
# クロネッカー積の積の規則の (3) と、多重添字の和を各因子ごとの和の積へ直すこと（**必要十分版**）

具体版: `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerProductRuleOnVectors.lean`
（人手 `kronecker_product_rule` の (3) と証明の準備）と `DefinitionKroneckerProductOfVectors.lean`（人手 `def_kronecker` の (1)）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerProductRuleOnVectorsFromNecSuf.lean`。

人手の `M ∈ ℤ_{≥1}` は Lean の `M + 1` である。有限積は `NecSuf.finProdLeft`（`FiniteProductLeft.lean`。人手
`def_finite_product_of_complex_numbers` の 2 つの式がそのまま 2 つの節）、各因子の添字の集合 `{1,2}` は任意の有限型 `ι` である。
`vecKron' M v` は人手の `v_1⊠⋯⊠v_M`、`matKron' M A` は人手の `A_1⊠⋯⊠A_M`（`def_kronecker` の (1)・(2) の成分の式）である。
行列のクロネッカー積には `kroneckerProdOf`（`KroneckerTranspose.lean`）もあるが、成分を `Finset.prod` で書くので係数に `CommMonoid` を要求する。
ここでは準備が積の可換則・結合則を使わないことを示すため、左から掛ける `finProdLeft` で書いた `matKron'` を別に置く。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 準備の `M = 1` の 2 段（左辺・右辺とも `c_1(1) + c_1(2)`） | `sum_pi_finProdLeft_eq_finProdLeft_sum` の `0` の節の 2 段（左辺・右辺とも `Σ_t c_1(t)`） |
| 準備の `M → M+1` の 4 段（有限和の分割 → 分配律 → 帰納法の仮定 → 有限積の最後の因子を戻す） | 同じく `M + 1` の節の 4 段（同じ並び。1 段目は `sum_pi_succ_eq_sum_last_sum_init`） |
| (3) の 6 段（積の定義 → `⊠` の定義 → 可換律・結合律 → 準備 → 積の定義 → `⊠` の定義） | `matKron'_mulVec_vecKron'` の 6 段（同じ並び。3 段目は `finProdLeft_mul'` に仮定 `hmed` を渡す） |

## 何が効いているか / 効いていないか

- 準備（`sum_pi_finProdLeft_eq_finProdLeft_sum`）に効くのは、和が可換モノイドであること（有限和 `Σ` を述べるのに要る）と、
  二つの分配律と `0·0 = 0` だけである。積の結合則・可換則・単位元は効いていない
  （有限積は左から掛ける `finProdLeft` で、`(Π^{M}) · c_{M+1}` の形が定義そのものなので、因子を並べ替えも括弧を付け替えもしない）。
  `0·0 = 0` が要るのは `ι` が空のときで、このとき `Fin (M + 1) → ι` も空なので、分配律の段の両辺が `0` と `0·0` になる。
  `ι` が空でなければ二項の分配律だけで閉じる。仮定には零との積の両側の法則を含む `NonUnitalNonAssocSemiring` を置いたが、
  これは分配律の段で使う `Finset.mul_sum`・`Finset.sum_mul` の仮定であり、`a·0 = 0`・`0·a = 0` の一般の形は証明に効いていない。
  各因子の添字の集合が `{1,2}` であることは効いていない（有限型なら何でもよい）。
- (3)（`matKron'_mulVec_vecKron'`）に効くのは、準備の仮定に加えて `(ab)(cd) = (ac)(bd)`（仮定 `hmed`）だけである。具体版はこれを ℂ の
  `mul_mul_mul_comm`（乗法の可換則と結合則）で受ける。`hmed` を外すと通らない: 非可換な環 `R := Mat(2, ℂ)`、`α := ι := Unit`、人手の `M = 2`
  （Lean の `M = 1`）で、各 `A_k : Matrix Unit Unit R` の唯一の成分 `A_k () ()` と各 `v_k : Unit → R` の値 `v_k ()` を
  `A_1 () () = v_2 () = I`、`A_2 () () = E_{12}`、`v_1 () = E_{21}` と取ると、左辺の成分は `(A_1A_2)(v_1v_2) = E_{12}E_{21} = E_{11}`、
  右辺の成分は `(A_1v_1)(A_2v_2) = E_{21}E_{12} = E_{22}` で一致しない。
  可換則・結合則そのもの（`hmed` は二つから出るが、逆は出ない）、単位元、行列が正方であること（行の添字 `α` と列の添字 `ι` は別の型でよく、
  `Fintype` が要るのは和を取る列の添字 `ι` だけ）、添字が `Fin 2` であること、係数が ℂ であることは効いていない。
-/
import Ising2D.NecSuf.FiniteProductLeft
import Ising2D.NecSuf.FiniteProductOfProducts
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Data.Matrix.Mul

namespace Ising2D.NecSuf

open Matrix

variable {R α ι : Type*}

/-- **`def_kronecker` (1)** の必要十分版: `(v_1⊠⋯⊠v_{M+1})_I := Π_{k=1}^{M+1} (v_k)_{i_k}`（左から掛ける有限積）。 -/
def vecKron' [Mul R] (M : ℕ) (v : Fin (M + 1) → ι → R) : (Fin (M + 1) → ι) → R :=
  fun I => finProdLeft M (fun k => v k (I k))

/-- **`def_kronecker` (2)** の必要十分版: `(A_1⊠⋯⊠A_{M+1})_{I,J} := Π_{k=1}^{M+1} (A_k)_{i_kj_k}`（左から掛ける有限積）。 -/
def matKron' [Mul R] (M : ℕ) (A : Fin (M + 1) → Matrix α ι R) :
    Matrix (Fin (M + 1) → α) (Fin (M + 1) → ι) R :=
  Matrix.of fun I J => finProdLeft M (fun k => A k (I k) (J k))

/-- 準備の `M → M+1` の 1 段目（最後の成分で場合分けした有限和の分割）の必要十分版。 -/
theorem sum_pi_succ_eq_sum_last_sum_init [NonUnitalNonAssocSemiring R] [Fintype ι]
    (M : ℕ) (c : Fin (M + 2) → ι → R) :
    ∑ K : Fin (M + 2) → ι, finProdLeft (M + 1) (fun k => c k (K k))
      = ∑ t : ι, ∑ K : Fin (M + 1) → ι,
          finProdLeft M (fun k => c (Fin.castSucc k) (K k)) * c (Fin.last (M + 1)) t := by
  rw [← Fintype.sum_prod_type (f := fun p : ι × (Fin (M + 1) → ι) =>
      finProdLeft M (fun k => c (Fin.castSucc k) (p.2 k)) * c (Fin.last (M + 1)) p.1)]
  refine Fintype.sum_equiv (Fin.snocEquiv (fun _ => ι)).symm _ _ fun K => ?_
  simp only [Fin.snocEquiv_symm_apply, Fin.init]
  exact finProdLeft_succ M _

/-- **`kronecker_product_rule` の証明の準備**の必要十分版:
`Σ_{K} Π_{k=1}^{M+1} c_k(t_k) = Π_{k=1}^{M+1} (Σ_{t ∈ ι} c_k(t))`（積は左から掛ける）。 -/
theorem sum_pi_finProdLeft_eq_finProdLeft_sum [NonUnitalNonAssocSemiring R] [Fintype ι] :
    ∀ (M : ℕ) (c : Fin (M + 1) → ι → R),
      ∑ K : Fin (M + 1) → ι, finProdLeft M (fun k => c k (K k)) = finProdLeft M (fun k => ∑ t : ι, c k t)
  | 0, c =>
    calc ∑ K : Fin 1 → ι, finProdLeft 0 (fun k => c k (K k))
        = ∑ t : ι, c 0 t :=
          Fintype.sum_equiv (Equiv.funUnique (Fin 1) ι) _ (fun t => c 0 t)
            (fun K => finProdLeft_zero _)                                     -- 左辺は `Σ_t c_1(t)`
      _ = finProdLeft 0 (fun k => ∑ t : ι, c k t) :=
          (finProdLeft_zero (fun k => ∑ t : ι, c k t)).symm                   -- 右辺も `Σ_t c_1(t)`
  | M + 1, c =>
    calc ∑ K : Fin (M + 2) → ι, finProdLeft (M + 1) (fun k => c k (K k))
        = ∑ t : ι, ∑ K : Fin (M + 1) → ι,
            finProdLeft M (fun k => c (Fin.castSucc k) (K k)) * c (Fin.last (M + 1)) t :=
          sum_pi_succ_eq_sum_last_sum_init M c                                -- 最後の成分で場合分けした有限和の分割
      _ = (∑ K : Fin (M + 1) → ι, finProdLeft M (fun k => c (Fin.castSucc k) (K k)))
            * ∑ t : ι, c (Fin.last (M + 1)) t := by
          rw [Finset.mul_sum]
          exact Finset.sum_congr rfl fun t _ => (Finset.sum_mul _ _ _).symm   -- 分配律
      _ = finProdLeft M (fun k => ∑ s : ι, c (Fin.castSucc k) s)
            * ∑ t : ι, c (Fin.last (M + 1)) t := by
          rw [sum_pi_finProdLeft_eq_finProdLeft_sum M (fun k => c (Fin.castSucc k))]
                                                                              -- 帰納法の仮定
      _ = finProdLeft (M + 1) (fun k => ∑ t : ι, c k t) :=
          (finProdLeft_succ M (fun k => ∑ t : ι, c k t)).symm                 -- 有限積の最後の因子を戻した（積の定義）

/-- **`kronecker_product_rule` (3)** の必要十分版: `hmed`（`(ab)(cd) = (ac)(bd)`）の下で
`(A_1⊠⋯⊠A_{M+1})(v_1⊠⋯⊠v_{M+1}) = (A_1v_1)⊠⋯⊠(A_{M+1}v_{M+1})`。 -/
theorem matKron'_mulVec_vecKron' [NonUnitalNonAssocSemiring R] [Fintype ι]
    (hmed : ∀ a b c d : R, (a * b) * (c * d) = (a * c) * (b * d))
    (M : ℕ) (A : Fin (M + 1) → Matrix α ι R) (v : Fin (M + 1) → ι → R) :
    matKron' M A *ᵥ vecKron' M v = vecKron' M (fun k => A k *ᵥ v k) := by
  funext I
  calc (matKron' M A *ᵥ vecKron' M v) I
      = ∑ p, matKron' M A I p * vecKron' M v p := rfl                        -- 行列と数ベクトルの積の定義
    _ = ∑ K : Fin (M + 1) → ι,
          finProdLeft M (fun k => A k (I k) (K k)) * finProdLeft M (fun k => v k (K k)) := rfl
                                                                              -- `⊠` の定義
    _ = ∑ K : Fin (M + 1) → ι, finProdLeft M (fun k => A k (I k) (K k) * v k (K k)) :=
          Finset.sum_congr rfl fun K _ => (finProdLeft_mul' hmed M _ _).symm  -- `(ab)(cd) = (ac)(bd)`
    _ = finProdLeft M (fun k => ∑ t : ι, A k (I k) t * v k t) :=
          sum_pi_finProdLeft_eq_finProdLeft_sum M (fun k t => A k (I k) t * v k t)
                                                                              -- 準備を `c_k(t) = (A_k)_{i_kt}(v_k)_t` に適用
    _ = finProdLeft M (fun k => (A k *ᵥ v k) (I k)) := rfl                   -- 行列と数ベクトルの積の定義
    _ = vecKron' M (fun k => A k *ᵥ v k) I := rfl                            -- `⊠` の定義

end Ising2D.NecSuf
