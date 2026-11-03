/-
# クロネッカー積の転置（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_000d_claim_kronecker_transpose`、ラベル **`kronecker_transpose`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 成分の鎖の 4 行（`def_matrix_transpose`（`m = n = 2^M`） → `def_kronecker` → `def_matrix_transpose`（`m = n = 2`、各 `k`） → `def_kronecker`） | `siteProd_transpose_apply` の `calc` の 4 段 |
| 「`ν` は全単射で、どの成分の番号も `ν(I)` の形に書ける」から両辺が等しい | `siteProd_transpose` の `Matrix.ext` |

- 人手のクロネッカー積 `A_1⊠⋯⊠A_M` は Lean の `siteProd M x` である。Lean の添字は `Conf M = Fin M → Fin 2` で、
  人手の `I = (i_1, …, i_M) ∈ 𝓘_M` をそのまま添字にするので、番号付け `ν` は Lean には現れない。
- 1 段目（`2^M` 次の行列の転置）は、添字が `Conf M` なので `Fin m` の添字で述べた `matrix_transpose_apply`
  （`def_matrix_transpose`）ではなく、mathlib の転置の定義そのもの `Matrix.transpose_apply` で閉じる。3 段目（2 次の行列の転置）は
  `matrix_transpose_apply` を各 `k` に引く。

必要十分版は `Ising2D/NecSuf/KroneckerTranspose.lean`、具体版をその特殊化として得るのは
`ClaimKroneckerTransposeFromNecSuf.lean` である。
-/
import Ising2D.Representation
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手 `kronecker_transpose` の成分の鎖**: `((A_1⊠⋯⊠A_M)^⊤)_{I,J} = (A_1^⊤⊠⋯⊠A_M^⊤)_{I,J}`。 -/
theorem siteProd_transpose_apply (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (s t : Conf M) :
    (siteProd M x)ᵀ s t = siteProd M (fun k => (x k)ᵀ) s t :=
  calc (siteProd M x)ᵀ s t
      = siteProd M x t s := Matrix.transpose_apply _ _ _                    -- `def_matrix_transpose`（`m = n = 2^M`）
    _ = ∏ k : Fin M, x k (t k) (s k) := siteProd_apply M x t s              -- `def_kronecker` を `A_1, …, A_M` に適用
    _ = ∏ k : Fin M, (x k)ᵀ (s k) (t k) :=
        Finset.prod_congr rfl fun k _ => (matrix_transpose_apply (x k) (s k) (t k)).symm
                                                                             -- `def_matrix_transpose`（`m = n = 2`）を各 `k` に適用
    _ = siteProd M (fun k => (x k)ᵀ) s t :=
        (siteProd_apply M (fun k => (x k)ᵀ) s t).symm                       -- `def_kronecker` を `A_1^⊤, …, A_M^⊤` に適用

/-- **人手 `kronecker_transpose`**: `(A_1⊠⋯⊠A_M)^⊤ = A_1^⊤⊠⋯⊠A_M^⊤`。 -/
theorem siteProd_transpose (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    (siteProd M x)ᵀ = siteProd M (fun k => (x k)ᵀ) :=
  Matrix.ext (siteProd_transpose_apply x)   -- 両辺のすべての成分が一致する

end Ising2D
