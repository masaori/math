/-
# 因子がスカラー倍として働くなら積も働く（**必要十分版**）

対応する人手証明: `epsilon_eigenvalue_on_check_Q` (4) の前半（正本は
`structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）。
具体版は `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonEigenvalueOnCheckQ.lean` の
`CheckFermi.parityFactor_mul_Qproj`（10 行の鎖）・`CheckFermi.finProdLeft_mul_Qproj`（`P_k` の帰納法）で、
その特殊化 `*_of_necSuf` を同じファイルに置く。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `(I − 2ň_μ)Q̌_ε = (1 − 2ε_μ)Q̌_ε` の 10 行 | `one_sub_smul_mul_eq_smul'` の 10 行（同じ並び） |
| `P_1Q̌_ε = p_1Q̌_ε` の 3 行 | `finProdLeft_mul_eq_prod_smul'` の `0` の節（同じ並び） |
| `P_{k+1}Q̌_ε = p_{k+1}Q̌_ε` の 8 行 | 同じく `r + 1` の節（同じ並び） |

## 何が効いているか / 効いていないか

- 10 行の鎖に効くのは、`x − y = x + (−y)`、左因子の和への分配（`(x + y)z = xz + yz`）、符号反転が左因子から外へ出ること、
  `1` が積の左単位元であること、スカラー倍が左因子から外へ出ること（`IsScalarTower 𝕜 R R`）、`1x = x`、
  `a(bx) = (ab)x`、`ax − bx = (a − b)x` だけである（`R` は `NonAssocRing`、`𝕜` は `Ring` で `R` は `𝕜` 加群）。
  `R` の積の結合則は効かない。`NonAssocRing` には `1` が右単位元であることも入るが、鎖が使うのは左単位元だけである。
  係数の `2` と `ε_μ ∈ {0,1}`（`ň_μ` の固有値が `0, 1` であること、`ň_μ` の冪等性）は効かない。
  一般の係数 `c` と、`nQ = dQ` を満たす任意の `d` で通る。`𝕜` の可換則も効かない。
- `P_k` の帰納法に効くのは、積の結合則（`Semigroup R`）、スカラー倍が右因子から外へ出ること（`SMulCommClass 𝕜 R R`）、
  `a(bx) = (ab)x`（`SemigroupAction 𝕜 R`。`1x = x` は効かない）と、`𝕜` の乗法の交換則（人手の「乗法の交換則」の行）だけである。
  `R` の加法・単位元、因子どうしの可換性、因子が `I − 2ň_μ` の形であることは効かない。`𝕜` の単位元は、`∏` を
  `Finset.prod` で書くための `CommMonoid 𝕜` から入るだけで、鎖の行では使わない。
-/
import Ising2D.NecSuf.FiniteProductLeft
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Module.Defs

namespace Ising2D.NecSuf

/-- **`(I − 2ň_μ)Q̌_ε = (1 − 2ε_μ)Q̌_ε` の 10 行の鎖の必要十分版**: `nQ = dQ` なら `(1 − cn)Q = (1 − cd)Q`。
具体版の `2` が `c`、`ň_μ` が `n`、`ε_μ` が `d` である。 -/
theorem one_sub_smul_mul_eq_smul' {𝕜 R : Type*} [Ring 𝕜] [NonAssocRing R] [Module 𝕜 R] [IsScalarTower 𝕜 R R]
    (c d : 𝕜) (n Q : R) (h : n * Q = d • Q) :
    (1 - c • n) * Q = (1 - c * d) • Q :=
  calc (1 - c • n) * Q
      = (1 + -(c • n)) * Q := by rw [sub_eq_add_neg]          -- `x − y = x + (−y)`
    _ = 1 * Q + -(c • n) * Q := add_mul _ _ _                  -- 左因子の和への分配
    _ = 1 * Q + -((c • n) * Q) := by rw [neg_mul]             -- 符号反転は左因子から外へ出る
    _ = 1 * Q - (c • n) * Q := (sub_eq_add_neg _ _).symm       -- `x − y = x + (−y)`
    _ = Q - (c • n) * Q := by rw [one_mul]                    -- `1` は左単位元
    _ = Q - c • (n * Q) := by rw [smul_mul_assoc]             -- スカラー倍は左因子から外へ出る
    _ = Q - c • (d • Q) := by rw [h]                          -- 仮定
    _ = (1 : 𝕜) • Q - c • (d • Q) := by rw [one_smul]         -- `1x = x`
    _ = (1 : 𝕜) • Q - (c * d) • Q := by rw [smul_smul]        -- `a(bx) = (ab)x`
    _ = (1 - c * d) • Q := (sub_smul _ _ _).symm              -- `ax − bx = (a − b)x`

/-- **`P_kQ̌_ε = p_kQ̌_ε` の帰納法の必要十分版**: 各因子が `A_jQ = a_jQ` なら、左から掛ける有限積
（`finProdLeft`）も `(∏_j A_j)Q = (∏_j a_j)Q`。人手の `k` が Lean の `r + 1` である。 -/
theorem finProdLeft_mul_eq_prod_smul' {𝕜 R : Type*} [CommMonoid 𝕜] [Semigroup R] [SemigroupAction 𝕜 R]
    [SMulCommClass 𝕜 R R] (Q : R) :
    ∀ (r : ℕ) (A : Fin (r + 1) → R) (a : Fin (r + 1) → 𝕜), (∀ j, A j * Q = a j • Q) →
      finProdLeft r A * Q = (∏ j, a j) • Q
  | 0, A, a, h =>
    calc finProdLeft 0 A * Q
        = A 0 * Q := rfl                                       -- 有限積の定義（1 因子）
      _ = a 0 • Q := h 0                                       -- 仮定（`j = 1`）
      _ = (∏ j, a j) • Q := by rw [Fin.prod_univ_one]          -- 有限積の定義（1 因子）
  | r + 1, A, a, h =>
    calc finProdLeft (r + 1) A * Q
        = (finProdLeft r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1))) * Q := rfl
                                                               -- 有限積の定義
      _ = finProdLeft r (fun j => A (Fin.castSucc j)) * (A (Fin.last (r + 1)) * Q) := mul_assoc _ _ _
                                                               -- 積の結合則
      _ = finProdLeft r (fun j => A (Fin.castSucc j)) * (a (Fin.last (r + 1)) • Q) := by
          rw [h (Fin.last (r + 1))]                            -- 仮定（`j = k + 1`）
      _ = a (Fin.last (r + 1)) • (finProdLeft r (fun j => A (Fin.castSucc j)) * Q) := mul_smul_comm _ _ _
                                                               -- スカラー倍は右因子から外へ出る
      _ = a (Fin.last (r + 1)) • ((∏ j, a (Fin.castSucc j)) • Q) := by
          rw [finProdLeft_mul_eq_prod_smul' Q r _ _ (fun j => h (Fin.castSucc j))]
                                                               -- 帰納法の仮定
      _ = (a (Fin.last (r + 1)) * ∏ j, a (Fin.castSucc j)) • Q := (mul_smul _ _ _).symm
                                                               -- `a(bx) = (ab)x`
      _ = ((∏ j, a (Fin.castSucc j)) * a (Fin.last (r + 1))) • Q := by
          rw [mul_comm (a (Fin.last (r + 1)))]                 -- `𝕜` の乗法の交換則
      _ = (∏ j, a j) • Q := by rw [Fin.prod_univ_castSucc a]   -- 有限積の定義

end Ising2D.NecSuf
