/-
# 全ての因子で可換ならクロネッカー積は可換（具体版）

正本: `structured-latex/content/006_Z_Y_anticommutation.ts`
（`Z_Y_anticommutation_claim_tensor_commutation_from_all_sites`、ラベル **`tensor_commutation_from_all_sites`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `X, Y` の定義 | `siteProd M x`・`siteProd M y`（主張の左辺そのもの） |
| `= (x_1y_1)⊠⋯⊠(x_My_M)`（`kronecker_product_rule` (1)） | `siteProd_mul` の左右を入れ替えたもの（`siteProd_mul` は (1) を右辺から左辺へ書いた形） |
| `= (y_1x_1)⊠⋯⊠(y_Mx_M)`（仮定 `y_ix_i = x_iy_i` を右辺から左辺へ、全ての `i` へ同時に適用） | `funext` と仮定 `h` |
| `= YX`（`kronecker_product_rule` (1) を右辺から左辺へ） | `siteProd_mul` |

- 人手の `M ∈ ℤ_{≥1}` に対し、Lean は `M : ℕ` で `0` も許す（主張はそのまま成り立つ）。
- 必要十分版は `Ising2D/NecSuf/SitewiseCommute.lean` の `commute_of_sitewise_commute`、導出は
  `ClaimTensorCommutationFromAllSitesFromNecSuf.lean`。
-/
import Ising2D.Representation

namespace Ising2D

/-- **人手 `tensor_commutation_from_all_sites`**: 全ての `i` で `y_ix_i = x_iy_i` なら `XY = YX`
（`X := x_1⊠⋯⊠x_M`、`Y := y_1⊠⋯⊠y_M`）。 -/
theorem siteProd_commute_of_sitewise_commute {M : ℕ} (x y : Fin M → Matrix (Fin 2) (Fin 2) ℂ)
    (h : ∀ i, y i * x i = x i * y i) :
    siteProd M x * siteProd M y = siteProd M y * siteProd M x :=
  calc siteProd M x * siteProd M y
      = siteProd M (x * y) := (siteProd_mul M x y).symm                 -- `kronecker_product_rule` (1)
    _ = siteProd M (y * x) := congrArg (siteProd M) (funext fun i => (h i).symm)
                                                                        -- 仮定 `y_ix_i = x_iy_i` を右辺から左辺へ、全ての `i` へ同時に適用
    _ = siteProd M y * siteProd M x := siteProd_mul M y x               -- `kronecker_product_rule` (1) を右辺から左辺へ

end Ising2D
