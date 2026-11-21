/-
# 因子が `±1` 倍として働くなら積は符号の冪倍として働く（**必要十分版**）

対応する人手証明: `epsilon_eigenvalue_on_check_Q` (4) の前半（正本は
`structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）。
具体版は `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonEigenvalueOnCheckQ.lean` の
`CheckFermi.parityFactor_mul_Qproj`（共通の 6 行）・`parityFactor_mul_Qproj_of_mem`（`ε(μ) = 1` の 4 行）・
`parityFactor_mul_Qproj_of_notMem`（`ε(μ) = 0` の 3 行）・`CheckFermi.finProdLeft_mul_Qproj`（`P_k` の帰納法）で、
その特殊化 `*_of_necSuf` を同じファイルに置く。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `(I − 2ň_μ)Q̌_ε = Q̌_ε − 2(ň_μQ̌_ε)` の 6 行 | `one_sub_smul_mul_eq_sub_smul_mul'` の 6 行（同じ並び） |
| `ε(μ) = 1` の 4 行 `… = Q̌_ε − 2Q̌_ε = 1Q̌_ε − 2Q̌_ε = (1 − 2)Q̌_ε = (−1)Q̌_ε` | `sub_smul_mul_eq_smul_of_mul_eq'` の 4 行（同じ並び） |
| `ε(μ) = 0` の 3 行 `… = Q̌_ε − 2O = Q̌_ε − O = Q̌_ε` | `sub_smul_mul_eq_self_of_mul_eq_zero'` の 3 行（同じ並び） |
| `P_1Q̌_ε` の `ε(1) = 1` の 6 行・`ε(1) = 0` の 5 行 | `finProdLeft_mul_eq_pow_smul'` の `0` の節の 2 つの場合（同じ並び） |
| `P_{k+1}Q̌_ε` の `ε(k+1) = 1` の 9 行・`ε(k+1) = 0` の 5 行 | 同じく `r + 1` の節の 2 つの場合（同じ並び） |

具体版の `−1_ℂ` が `s`、`|ε|_k` が `wordCount'`（長さ `k` の語の `1` の個数。`NecSuf/PowerFromProductOfTwoValuedFactors.lean`）である。

## 何が効いているか / 効いていないか

- 共通の 6 行に効くのは、`x − y = x + (−y)`、左因子の和への分配、符号反転が左因子から外へ出ること、
  `1` が積の左単位元であること、スカラー倍が左因子から外へ出ること（`IsScalarTower 𝕜 R R`）だけである
  （`R` は `NonAssocRing`）。係数の `2` は効かない（一般の `c`）。
- `ε(μ) = 1` の 4 行に効くのは、`nQ = Q`、`1x = x`、`ax − bx = (a − b)x`（`Module 𝕜 R`）と `1 − c = d` だけである。
  具体版の `1 − 2 = −1` を仮定 `hd` に置く。`ε(μ) = 0` の 3 行に効くのは、`nQ = 0`、`a0 = 0`、`x − 0 = x` だけである。
  どちらも `n` の冪等性、`n` が個数演算子であることは効かない。
- `P_k` の帰納法に効くのは、積の結合律（`Semigroup R`）、スカラー倍が右因子から外へ出ること（`SMulCommClass 𝕜 R R`）、
  `a(bx) = (ab)x` と `1x = x`（`MulAction 𝕜 R`）、`𝕜` の単位元と冪の定義（`z^0 = 1`・`z^{m+1} = z^m z`）だけである。
  人手の「積の可換律」の行で使うのは `s` と `s^k` が交換することだけで、これは任意のモノイドで成り立つ（`pow_mul_comm'`）。
  **`𝕜` の可換律と `s = −1` であることは効いていない**（`s·s = 1` も使わない）。
  `R` の加法・単位元、因子どうしの可換性、因子が `I − 2ň_μ` の形であることは効かない。
-/
import Ising2D.NecSuf.FiniteProductLeft
import Ising2D.NecSuf.PowerFromProductOfTwoValuedFactors
import Mathlib.Algebra.Module.Defs

namespace Ising2D.NecSuf

/-- **`(I − 2ň_μ)Q̌_ε = Q̌_ε − 2(ň_μQ̌_ε)` の 6 行の鎖の必要十分版**: `(1 − cn)Q = Q − c(nQ)`。
具体版の `2` が `c`、`ň_μ` が `n` である。 -/
theorem one_sub_smul_mul_eq_sub_smul_mul' {𝕜 R : Type*} [NonAssocRing R] [SMul 𝕜 R] [IsScalarTower 𝕜 R R]
    (c : 𝕜) (n Q : R) :
    (1 - c • n) * Q = Q - c • (n * Q) :=
  calc (1 - c • n) * Q
      = (1 + -(c • n)) * Q := by rw [sub_eq_add_neg]          -- `x − y = x + (−y)`
    _ = 1 * Q + -(c • n) * Q := add_mul _ _ _                  -- 左因子の和への分配
    _ = 1 * Q + -((c • n) * Q) := by rw [neg_mul]             -- 符号反転は左因子から外へ出る
    _ = 1 * Q - (c • n) * Q := (sub_eq_add_neg _ _).symm       -- `x − y = x + (−y)`
    _ = Q - (c • n) * Q := by rw [one_mul]                    -- `1` は左単位元
    _ = Q - c • (n * Q) := by rw [smul_mul_assoc]             -- スカラー倍は左因子から外へ出る

/-- **`ε(μ) = 1` の場合の 4 行の鎖の必要十分版**: `nQ = Q` なら `Q − c(nQ) = dQ`（`1 − c = d`）。 -/
theorem sub_smul_mul_eq_smul_of_mul_eq' {𝕜 R : Type*} [Ring 𝕜] [NonUnitalNonAssocRing R] [Module 𝕜 R]
    (c d : 𝕜) (hd : 1 - c = d) {n Q : R} (h : n * Q = Q) :
    Q - c • (n * Q) = d • Q :=
  calc Q - c • (n * Q)
      = Q - c • Q := by rw [h]                                -- 仮定 `nQ = Q`
    _ = (1 : 𝕜) • Q - c • Q := by rw [one_smul]               -- `1x = x`
    _ = (1 - c) • Q := (sub_smul _ _ _).symm                  -- `ax − bx = (a − b)x`
    _ = d • Q := by rw [hd]                                   -- 仮定 `1 − c = d`

/-- **`ε(μ) = 0` の場合の 3 行の鎖の必要十分版**: `nQ = 0` なら `Q − c(nQ) = Q`。 -/
theorem sub_smul_mul_eq_self_of_mul_eq_zero' {𝕜 R : Type*} [NonUnitalNonAssocRing R] [SMulZeroClass 𝕜 R]
    (c : 𝕜) {n Q : R} (h : n * Q = 0) :
    Q - c • (n * Q) = Q :=
  calc Q - c • (n * Q)
      = Q - c • (0 : R) := by rw [h]                          -- 仮定 `nQ = 0`
    _ = Q - 0 := by rw [smul_zero]                            -- `a0 = 0`
    _ = Q := sub_zero Q                                       -- `x − 0 = x`

/-- **`P_kQ̌_ε = (−1)^{|ε|_k}Q̌_ε` の帰納法の必要十分版**: 語 `e` について、`e_j = 1` の因子が `A_jQ = sQ`、
`e_j = 0` の因子が `A_jQ = Q` なら、左から掛ける有限積（`finProdLeft`）は `(∏_j A_j)Q = s^{|e|}Q`。
人手の `k` が Lean の `r + 1`、`|ε|_k` が `wordCount' e` である。 -/
theorem finProdLeft_mul_eq_pow_smul' {𝕜 R : Type*} [Monoid 𝕜] [Semigroup R] [MulAction 𝕜 R]
    [SMulCommClass 𝕜 R R] (Q : R) (s : 𝕜) :
    ∀ (r : ℕ) (A : Fin (r + 1) → R) (e : Fin (r + 1) → Fin 2),
      (∀ j, e j = 1 → A j * Q = s • Q) → (∀ j, e j = 0 → A j * Q = Q) →
      finProdLeft r A * Q = s ^ wordCount' e • Q
  | 0, A, e, h1, h0 => by
    rcases fin_two_eq_one_or_zero' (e 0) with he | he
    · -- `ε(1) = 1`: `|ε|_1 = 1`
      have hc : wordCount' e = 1 := by rw [wordCount_one', he]; rfl
      calc finProdLeft 0 A * Q
          = A 0 * Q := rfl                                     -- 有限積の定義（1 因子）
        _ = s • Q := h1 0 he                                   -- `ε(μ) = 1` の場合の鎖（`μ → 1`）
        _ = (1 * s) • Q := by rw [one_mul]                     -- `1` は単位元
        _ = (s ^ 0 * s) • Q := by rw [pow_zero]                -- `z^0 := 1` を右辺から左辺へ
        _ = s ^ 1 • Q := by rw [← pow_succ]                    -- `z^{m+1} := z^m z`（`m → 0`）を右辺から左辺へ
        _ = s ^ wordCount' e • Q := by rw [hc]                 -- `|ε|_1 = 1`
    · -- `ε(1) = 0`: `|ε|_1 = 0`
      have hc : wordCount' e = 0 := by rw [wordCount_one', he]; rfl
      calc finProdLeft 0 A * Q
          = A 0 * Q := rfl                                     -- 有限積の定義（1 因子）
        _ = Q := h0 0 he                                       -- `ε(μ) = 0` の場合の鎖（`μ → 1`）
        _ = (1 : 𝕜) • Q := (one_smul _ _).symm                 -- `1x = x` を右辺から左辺へ
        _ = s ^ 0 • Q := by rw [pow_zero]                      -- `z^0 := 1` を右辺から左辺へ
        _ = s ^ wordCount' e • Q := by rw [hc]                 -- `|ε|_1 = 0`
  | r + 1, A, e, h1, h0 => by
    have ih := finProdLeft_mul_eq_pow_smul' Q s r (fun j => A (Fin.castSucc j)) (fun j => e (Fin.castSucc j))
      (fun j hj => h1 (Fin.castSucc j) hj) (fun j hj => h0 (Fin.castSucc j) hj)
                                                               -- 帰納法の仮定（先頭の `k` 成分の語に当てる）
    have hcount := wordCount_castSucc' e                       -- `|ε|_{k+1}` の数え上げ
    rcases fin_two_eq_one_or_zero' (e (Fin.last (r + 1))) with he | he
    · -- `ε(k+1) = 1`: `|ε|_{k+1} = |ε|_k + 1`
      have hk : wordCount' e = wordCount' (fun j : Fin (r + 1) => e (Fin.castSucc j)) + 1 := by
        rw [hcount, he]; rfl
      calc finProdLeft (r + 1) A * Q
          = (finProdLeft r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1))) * Q := rfl
                                                               -- 有限積の定義
        _ = finProdLeft r (fun j => A (Fin.castSucc j)) * (A (Fin.last (r + 1)) * Q) := mul_assoc _ _ _
                                                               -- 積の結合律
        _ = finProdLeft r (fun j => A (Fin.castSucc j)) * (s • Q) := by rw [h1 _ he]
                                                               -- `ε(μ) = 1` の場合の鎖（`μ → k+1`）
        _ = s • (finProdLeft r (fun j => A (Fin.castSucc j)) * Q) := mul_smul_comm _ _ _
                                                               -- スカラー倍は右因子から外へ出る
        _ = s • (s ^ wordCount' (fun j : Fin (r + 1) => e (Fin.castSucc j)) • Q) := by rw [ih]
                                                               -- 帰納法の仮定
        _ = (s * s ^ wordCount' (fun j : Fin (r + 1) => e (Fin.castSucc j))) • Q := (mul_smul _ _ _).symm
                                                               -- `a(bx) = (ab)x`
        _ = (s ^ wordCount' (fun j : Fin (r + 1) => e (Fin.castSucc j)) * s) • Q := by
            rw [pow_mul_comm']                               -- `s` と `s^k` は交換する（人手の積の可換律の行）
        _ = s ^ (wordCount' (fun j : Fin (r + 1) => e (Fin.castSucc j)) + 1) • Q := by rw [← pow_succ]
                                                               -- `z^{m+1} := z^m z` を右辺から左辺へ
        _ = s ^ wordCount' e • Q := by rw [hk]                 -- `|ε|_{k+1} = |ε|_k + 1`
    · -- `ε(k+1) = 0`: `|ε|_{k+1} = |ε|_k`
      have hk : wordCount' e = wordCount' (fun j : Fin (r + 1) => e (Fin.castSucc j)) := by
        rw [hcount, he]; rfl
      calc finProdLeft (r + 1) A * Q
          = (finProdLeft r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1))) * Q := rfl
                                                               -- 有限積の定義
        _ = finProdLeft r (fun j => A (Fin.castSucc j)) * (A (Fin.last (r + 1)) * Q) := mul_assoc _ _ _
                                                               -- 積の結合律
        _ = finProdLeft r (fun j => A (Fin.castSucc j)) * Q := by rw [h0 _ he]
                                                               -- `ε(μ) = 0` の場合の鎖（`μ → k+1`）
        _ = s ^ wordCount' (fun j : Fin (r + 1) => e (Fin.castSucc j)) • Q := ih
                                                               -- 帰納法の仮定
        _ = s ^ wordCount' e • Q := by rw [hk]                 -- `|ε|_{k+1} = |ε|_k`

end Ising2D.NecSuf
