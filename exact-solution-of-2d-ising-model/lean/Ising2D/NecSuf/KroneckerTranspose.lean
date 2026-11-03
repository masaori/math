/-
# クロネッカー積の転置（必要十分版）

具体版: `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerTranspose.lean`
（人手 `kronecker_transpose`）。具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerTransposeFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `siteProd_transpose_apply` の 4 段（転置の定義 → クロネッカー積の定義 → 各因子の転置の定義 → クロネッカー積の定義） | `kroneckerProdOf_transpose_apply` の 4 段（同じ並び） |
| `siteProd_transpose`（全ての成分が一致する） | `kroneckerProdOf_transpose` |

## 何が効いているか / 効いていないか

- 係数の型 `R` に置いたのは `CommMonoid` だけである。これはクロネッカー積の成分 `∏_k (A_k)_{s_k t_k}` を書くのに
  `Finset.prod` が要求するもので、鎖の 4 段のどれも積の可換性・結合性・単位元を**引いていない**（3 段目は各因子の
  成分を転置の定義で書き換えるだけで、積の並びは変えない）。したがって**係数の演算は何も効いていない**。
  加法・零元・符号反転・スカラー倍は主張にも鎖にも現れない。
- 因子の添字 `α`・`β` は任意の型で、**正方であることも 2 次であることも効いていない**（転置で `α`・`β` が入れ替わるだけ）。
- サイトの添字 `ι` に置いたのは `Fintype` だけで、これも `Finset.prod` の要求である。`Fin M` の順序は効いていない。
- 具体版の「`ν` が全単射」は、添字を `ι → α` のまま扱うので現れない。
-/
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι α β R : Type*} [Fintype ι] [CommMonoid R]

/-- 成分ごとの積で作るクロネッカー積 `(A_1⊠⋯⊠A_M)_{s,t} := ∏_k (A_k)_{s_k t_k}`（具体版の `siteProd` の成分の式）。 -/
def kroneckerProdOf (x : ι → Matrix α β R) : Matrix (ι → α) (ι → β) R :=
  fun s t => ∏ k, x k (s k) (t k)

/-- **成分の鎖**（具体版 `siteProd_transpose_apply`）。 -/
theorem kroneckerProdOf_transpose_apply (x : ι → Matrix α β R) (s : ι → β) (t : ι → α) :
    (kroneckerProdOf x)ᵀ s t = kroneckerProdOf (fun k => (x k)ᵀ) s t :=
  calc (kroneckerProdOf x)ᵀ s t
      = kroneckerProdOf x t s := rfl                                         -- 転置の定義
    _ = ∏ k, x k (t k) (s k) := rfl                                          -- クロネッカー積の定義
    _ = ∏ k, (x k)ᵀ (s k) (t k) := rfl                                       -- 各因子の転置の定義
    _ = kroneckerProdOf (fun k => (x k)ᵀ) s t := rfl                         -- クロネッカー積の定義

/-- **`(A_1⊠⋯⊠A_M)^⊤ = A_1^⊤⊠⋯⊠A_M^⊤`**（具体版 `siteProd_transpose`）。 -/
theorem kroneckerProdOf_transpose (x : ι → Matrix α β R) :
    (kroneckerProdOf x)ᵀ = kroneckerProdOf (fun k => (x k)ᵀ) :=
  Matrix.ext (kroneckerProdOf_transpose_apply x)   -- 全ての成分が一致する

end Ising2D.NecSuf
