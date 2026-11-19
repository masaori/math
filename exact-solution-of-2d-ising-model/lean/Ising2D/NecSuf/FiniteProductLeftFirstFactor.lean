/-
# 左から掛ける有限積から先頭の因子を外へ出せる（**必要十分版**）

具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfRealNumbersSplitsOffFirstFactor.lean`
（人手 `finite_product_of_real_numbers_splits_off_first_factor`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfRealNumbersSplitsOffFirstFactorFromNecSuf.lean`。

有限積は `NecSuf.finProdLeft`（`FiniteProductLeft.lean`。人手 `def_finite_product_of_real_numbers` の 2 つの式がそのまま 2 つの節）である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `m = 1`（定義の帰納の式 → 定義の `Π^{1}` → 同じ式を右辺から左辺へ） | `finProdLeft_succ_first` の `0` の節（同じ並び） |
| `m → m + 1`（定義の帰納の式 → 帰納法の仮定 → 乗法の結合則 → 定義の帰納の式を右辺から左辺へ） | `finProdLeft_succ_first` の `m + 1` の節（同じ並び） |

## 何が効いているか / 効いていないか

- 有限積の定義に要るのは二項演算 `*` だけである（`Mul R`）。
- 証明に効くのは、乗法の結合則 `(ab)c = a(bc)`（仮定 `hassoc`）だけである。具体版はこれを ℝ の `mul_assoc` で受ける。
  乗法の可換則、単位元、逆元、和、順序は効いていない。
  `hassoc` は主張そのものから出てくるので削れない: 主張を因子が 3 つの場合（Lean の `m = 1`）に `A = ![a, b, c]` で当てると、
  左辺は `finProdLeft 2 A = (ab)c`、右辺は `a(bc)` で、主張は結合則 `(ab)c = a(bc)` そのものになる。
-/
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D.NecSuf

/-- **`finite_product_of_real_numbers_splits_off_first_factor`** の必要十分版:
`hassoc`（乗法の結合則）の下で、`Π_{j=1}^{m+2} A_j = A_1(Π_{j=1}^{m+1} A_{j+1})`（人手の `m` は Lean の `m + 1`）。 -/
theorem finProdLeft_succ_first {R : Type*} [Mul R]
    (hassoc : ∀ a b c : R, (a * b) * c = a * (b * c)) :
    ∀ (m : ℕ) (A : Fin (m + 2) → R), finProdLeft (m + 1) A = A 0 * finProdLeft m (fun j => A j.succ)
  | 0, A =>
    calc finProdLeft 1 A
        = finProdLeft 0 (fun j => A (Fin.castSucc j)) * A (Fin.last 1) := finProdLeft_succ 0 _
                                                                              -- 定義の帰納の式
      _ = A 0 * A 1 := by rw [finProdLeft_zero]; rfl                         -- 定義の `Π^{1}`
      _ = A 0 * finProdLeft 0 (fun j => A j.succ) := by rw [finProdLeft_zero]; rfl
                                                                              -- 同じ式を右辺から左辺へ
  | m + 1, A =>
    calc finProdLeft (m + 2) A
        = finProdLeft (m + 1) (fun j => A (Fin.castSucc j)) * A (Fin.last (m + 2)) := finProdLeft_succ (m + 1) _
                                                                              -- 定義の帰納の式
      _ = (A 0 * finProdLeft m (fun j => A j.succ.castSucc)) * A (Fin.last (m + 2)) := by
          rw [finProdLeft_succ_first hassoc m (fun j => A (Fin.castSucc j))]
          rfl                                                                 -- 帰納法の仮定
      _ = A 0 * (finProdLeft m (fun j => A j.succ.castSucc) * A (Fin.last (m + 2))) := hassoc _ _ _
                                                                              -- 乗法の結合則
      _ = A 0 * finProdLeft (m + 1) (fun j => A j.succ) := by
          rw [finProdLeft_succ m (fun j : Fin (m + 2) => A j.succ)]
          rfl                                                                 -- 定義の帰納の式を右辺から左辺へ

end Ising2D.NecSuf
