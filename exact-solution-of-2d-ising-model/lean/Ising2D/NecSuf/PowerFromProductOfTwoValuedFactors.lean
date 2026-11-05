/-
# 二値の因子の有限積の像は、一方の値の像の冪になる（**必要十分版**）

対応する人手証明: `trace_of_epsilon_V_plus_via_check_eigenvalues` の Step 2（正本は
`structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）。
具体版は `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusViaCheckEigenvalues.lean` の
`checkU_prod_eq_neg_one_pow`（`k` の帰納法）で、その特殊化 `checkU_prod_eq_neg_one_pow_of_necSuf` を同じファイルに置く。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 準備の数え上げ `\|ε\|_1 = ε_1`・`\|ε\|_{k+1} = \|ε\|_k + ε_{k+1}`・`\|ε\|_k ≤ k` | `wordCount_one'`・`wordCount_castSucc'`・`wordCount_le'`（代数を含まない） |
| `k = 1`・`ε_1 = 1` の 5 行 | `map_prod_two_valued_eq_pow'` の `0` の節の `1` の場合の 5 行 |
| `k = 1`・`ε_1 = 0` の 7 行 | 同じ節の `0` の場合の 7 行 |
| `k → k+1`・`ε_{k+1} = 1` の 6 行 | `n + 1` の節の `1` の場合の 6 行 |
| `k → k+1`・`ε_{k+1} = 0` の 6 行 | 同じ節の `0` の場合の 6 行 |

具体版の `ǔ^{(e)}` が `u e`、包含 `(·)_ℂ` が `f`、`−1_ℂ` が `s` である。人手の `k` は Lean の `n + 1` で、
`|ε|_k` は長さ `k` の語（`ε` の先頭の `k` 成分）の `1` の個数である。

## 何が効いているか / 効いていないか

- 効くのは、`f` が積を積へ送ること（`hf`。具体版の `real_inclusion_preserves_product`）、`f(u(1)) = 1`・`f(u(0)) = s`
  （具体版の `ǔ^{(1)} := 1`・`ǔ^{(0)} := −1` と包含の略記）、`S` の単位元（`1z = z`・`z1 = z`）と冪の定義
  （`z^0 = 1`・`z^{m+1} = z^m z`）だけである。`S` の積の結合則は効かない。`Monoid S` は mathlib の冪 `^`
  （`Monoid.npow`）を使うためだけに要る。
- **`s = −1` であることは効かない。** `(−1)(−1) = 1` も `S` の積の可換則も使わない。`f` が `1` を `1` へ送ることも使わない。
- `R` は積の記号 `Mul R` を持つだけで、結合則・単位元・可換則は効かない。人手の有限積（`def_finite_product_of_real_numbers`）は
  左から掛ける有限積 `finProdLeft` で、定義の 2 つの式は `finProdLeft_zero`・`finProdLeft_succ` である
  （具体版の `Finset.prod` との一致は `real_finset_prod_eq_finProdLeft`）。
-/
import Ising2D.NecSuf.FiniteProductLeft
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D.NecSuf

/-- 長さ `n` の語 `ε` の `1` の個数 `#{μ | ε_μ = 1}`。 -/
def wordCount' {n : ℕ} (ε : Fin n → Fin 2) : ℕ := (Finset.univ.filter fun μ => ε μ = 1).card

/-- `{0,1}` の元は `0` か `1`。 -/
theorem fin_two_eq_one_or_zero' : ∀ e : Fin 2, e = 1 ∨ e = 0 := by decide

/-- `1` の個数を数える項 `[e = 1]` は `e` の値に等しい。 -/
theorem ite_eq_one_eq_val' (e : Fin 2) : (if e = 1 then 1 else 0) = e.val := by
  rcases fin_two_eq_one_or_zero' e with rfl | rfl <;> rfl

/-- 準備の `|ε|_1 = ε_1`（長さ 1 の語）。 -/
theorem wordCount_one' (ε : Fin 1 → Fin 2) : wordCount' ε = (ε 0).val := by
  unfold wordCount'
  rw [Finset.card_filter, Fin.sum_univ_one, ite_eq_one_eq_val']

/-- 準備の `|ε|_{k+1} = |ε|_k + ε_{k+1}`（`|ε|_k` は先頭の `k` 成分の語の個数）。 -/
theorem wordCount_castSucc' {n : ℕ} (ε : Fin (n + 1) → Fin 2) :
    wordCount' ε = wordCount' (fun μ : Fin n => ε (Fin.castSucc μ)) + (ε (Fin.last n)).val := by
  unfold wordCount'
  rw [Finset.card_filter, Finset.card_filter, Fin.sum_univ_castSucc]
  rw [ite_eq_one_eq_val']

/-- 準備の `0 ≤ |ε|_k ≤ k`。 -/
theorem wordCount_le' {n : ℕ} (ε : Fin n → Fin 2) : wordCount' ε ≤ n :=
  (Finset.card_filter_le _ _).trans (by rw [Finset.card_univ, Fintype.card_fin])

/-- **Step 2 の必要十分版**: `f(ab) = f(a)f(b)`、`f(u(1)) = 1`、`f(u(0)) = s` なら、長さ `n + 1` の語 `ε` について
`f(Π_μ u(ε_μ)) = s^{(n+1) − |ε|}`。 -/
theorem map_prod_two_valued_eq_pow' {R S : Type*} [Mul R] [Monoid S]
    (f : R → S) (hf : ∀ a b, f (a * b) = f a * f b) (u : Fin 2 → R) (s : S)
    (h1 : f (u 1) = 1) (h0 : f (u 0) = s) :
    ∀ (n : ℕ) (ε : Fin (n + 1) → Fin 2), f (finProdLeft n (fun μ => u (ε μ))) = s ^ ((n + 1) - wordCount' ε)
  | 0, ε => by
    rcases fin_two_eq_one_or_zero' (ε 0) with he | he
    · -- `ε_1 = 1`: `|ε|_1 = 1`
      have hc : wordCount' ε = 1 := by rw [wordCount_one', he]; rfl
      calc f (finProdLeft _ (fun μ => u (ε μ)))
          = f (u (ε 0)) := by rw [finProdLeft_zero]               -- `def_finite_product_of_real_numbers`
        _ = f (u 1) := by rw [he]                                 -- `ε_1 = 1`
        _ = 1 := h1                                               -- `u(1)` の像
        _ = s ^ 0 := (pow_zero s).symm                            -- `z^0 := 1` を右辺から左辺へ
        _ = s ^ ((0 + 1) - wordCount' ε) := by rw [hc]            -- `|ε|_1 = 1`
    · -- `ε_1 = 0`: `|ε|_1 = 0`
      have hc : wordCount' ε = 0 := by rw [wordCount_one', he]; rfl
      calc f (finProdLeft _ (fun μ => u (ε μ)))
          = f (u (ε 0)) := by rw [finProdLeft_zero]               -- `def_finite_product_of_real_numbers`
        _ = f (u 0) := by rw [he]                                 -- `ε_1 = 0`
        _ = s := h0                                               -- `u(0)` の像
        _ = 1 * s := (one_mul s).symm                             -- `1` は単位元
        _ = s ^ 0 * s := by rw [pow_zero]                         -- `z^0 := 1` を右辺から左辺へ
        _ = s ^ 1 := (pow_succ s 0).symm                          -- `z^{m+1} := z^m z`（`m → 0`）を右辺から左辺へ
        _ = s ^ ((0 + 1) - wordCount' ε) := by rw [hc]            -- `|ε|_1 = 0`
  | n + 1, ε => by
    have ih := map_prod_two_valued_eq_pow' f hf u s h1 h0 n (fun μ => ε (Fin.castSucc μ))
                                                                  -- 帰納法の仮定（先頭の `k` 成分の語に当てる）
    have hcount := wordCount_castSucc' ε                          -- `|ε|_{k+1} = |ε|_k + ε_{k+1}`
    have hle := wordCount_le' (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))
                                                                  -- `|ε|_k ≤ k`
    rcases fin_two_eq_one_or_zero' (ε (Fin.last (n + 1))) with he | he
    · -- `ε_{k+1} = 1`: `(k+1) − |ε|_{k+1} = k − |ε|_k`
      have hk : (n + 1 + 1) - wordCount' ε
          = (n + 1) - wordCount' (fun μ : Fin (n + 1) => ε (Fin.castSucc μ)) := by
        rw [hcount, he]; simp only [Fin.val_one]; omega
      calc f (finProdLeft _ (fun μ => u (ε μ)))
          = f (finProdLeft n (fun μ : Fin (n + 1) => u (ε (Fin.castSucc μ))) * u (ε (Fin.last (n + 1)))) := by
            rw [finProdLeft_succ]                                 -- `def_finite_product_of_real_numbers`
        _ = f (finProdLeft n (fun μ : Fin (n + 1) => u (ε (Fin.castSucc μ)))) * f (u (ε (Fin.last (n + 1)))) :=
            hf _ _                                                -- 積を積へ送る
        _ = s ^ ((n + 1) - wordCount' (fun μ : Fin (n + 1) => ε (Fin.castSucc μ)))
              * f (u (ε (Fin.last (n + 1)))) := by rw [ih]        -- 帰納法の仮定
        _ = s ^ ((n + 1) - wordCount' (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))) * 1 := by
            rw [he, h1]                                           -- `ε_{k+1} = 1` と `u(1)` の像
        _ = s ^ ((n + 1) - wordCount' (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))) :=
            mul_one _                                             -- `1` は単位元
        _ = s ^ ((n + 1 + 1) - wordCount' ε) := by rw [hk]        -- `(k+1) − |ε|_{k+1} = k − |ε|_k`
    · -- `ε_{k+1} = 0`: `(k+1) − |ε|_{k+1} = (k − |ε|_k) + 1`
      have hk : (n + 1 + 1) - wordCount' ε
          = ((n + 1) - wordCount' (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))) + 1 := by
        rw [hcount, he]; simp only [Fin.val_zero, add_zero]; omega
      calc f (finProdLeft _ (fun μ => u (ε μ)))
          = f (finProdLeft n (fun μ : Fin (n + 1) => u (ε (Fin.castSucc μ))) * u (ε (Fin.last (n + 1)))) := by
            rw [finProdLeft_succ]                                 -- `def_finite_product_of_real_numbers`
        _ = f (finProdLeft n (fun μ : Fin (n + 1) => u (ε (Fin.castSucc μ)))) * f (u (ε (Fin.last (n + 1)))) :=
            hf _ _                                                -- 積を積へ送る
        _ = s ^ ((n + 1) - wordCount' (fun μ : Fin (n + 1) => ε (Fin.castSucc μ)))
              * f (u (ε (Fin.last (n + 1)))) := by rw [ih]        -- 帰納法の仮定
        _ = s ^ ((n + 1) - wordCount' (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))) * s := by
            rw [he, h0]                                           -- `ε_{k+1} = 0` と `u(0)` の像
        _ = s ^ (((n + 1) - wordCount' (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))) + 1) :=
            (pow_succ s _).symm                                   -- `z^{m+1} := z^m z` を右辺から左辺へ
        _ = s ^ ((n + 1 + 1) - wordCount' ε) := by rw [hk]        -- `(k+1) − |ε|_{k+1} = (k − |ε|_k) + 1`

end Ising2D.NecSuf
