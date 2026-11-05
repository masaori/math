/-
# 符号付きの項は、並べ替えた積の像になる（**必要十分版**）

対応する人手証明: `trace_of_epsilon_V_plus_via_check_eigenvalues` の Step 3（正本は
`structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）。
具体版は `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusViaCheckEigenvalues.lean` の
`VPlusData.eta_mul_checkLambda_eq_checkT_mul_checkH`（7 行の calc）で、その特殊化
`VPlusData.eta_mul_checkLambda_eq_checkT_mul_checkH_of_necSuf` を同じファイルに置く。

| 具体版の行 | 必要十分版 |
| --- | --- |
| 1 行目 `epsilon_eigenvalue_on_check_Q` (3) | `hη` で `ηε` を書き換える行 |
| 2 行目 Step 2 の `k = M_col` の式を右辺から左辺へ | `hu` を右辺から左辺へ |
| 3 行目 `ȟ` の取り方 `ȟ_ℂ = η_{(1,…,1)}` を右辺から左辺へ | `hh` を右辺から左辺へ |
| 4 行目・5 行目 `real_inclusion_preserves_product` | `hf` |
| 6 行目 ℝ で `(ab)c = (bc)a`（乗法の交換則と結合則） | `mul_assoc`・`mul_comm`（`CommSemigroup R`） |
| 7 行目 `ť_ε` の置き方 | 無い（`ť_ε` は具体版の定義） |

具体版の包含 `(·)_ℂ` が `f`、`η_ε` が `ηε`、`η_{(1,…,1)}` が `η1`、`(−1_ℂ)^{M_col−|ε|}` が `q`、
`ȟ` が `h`、`Π_μ ǔ^{(ε_μ)}` が `u`、`Λ̌_ε` が `l` である。

## 何が効いているか / 効いていないか

- 効くのは、`f` が積を積へ送ること（`hf`。具体版の `real_inclusion_preserves_product`）と、`R` の積の結合則と
  可換則（6 行目の `(ab)c = (bc)a`）だけである。6 行目は結合則（`(hu)l = h(ul)`）と可換則（`h(ul) = (ul)h`）を
  1 回ずつ使うので、`CommSemigroup R` から削れない。
- `S` は積の記号 `Mul S` を持つだけで、結合則・可換則・単位元は効かない。
- **`q` が `−1` の冪であること、`η1`・`h` が `±1` であることは効かない。** 1〜3 行目は等式 `hη`・`hu`・`hh` で
  書き換えるだけである。`R` の単位元・加法、`f(1) = 1` も使わない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **必要十分版**（`trace_of_epsilon_V_plus_via_check_eigenvalues` Step 3 の 7 行のうち、`ť_ε` の置き方を除く 6 行）:
`ηε = η1 q`, `f(u) = q`, `f(h) = η1` なら `ηε f(l) = f((ul)h)`。 -/
theorem signed_term_eq_map_mul' {R S : Type*} [CommSemigroup R] [Mul S] (f : R → S)
    (hf : ∀ a b : R, f a * f b = f (a * b)) {ηε η1 q : S} {h u l : R}
    (hη : ηε = η1 * q) (hu : f u = q) (hh : f h = η1) :
    ηε * f l = f ((u * l) * h) :=
  calc ηε * f l
      = (η1 * q) * f l := by rw [hη]                  -- 具体版の 1 行目（`epsilon_eigenvalue_on_check_Q` (3)）
    _ = (η1 * f u) * f l := by rw [hu]                -- 具体版の 2 行目（Step 2 を右辺から左辺へ）
    _ = (f h * f u) * f l := by rw [hh]               -- 具体版の 3 行目（`ȟ` の取り方を右辺から左辺へ）
    _ = f (h * u) * f l := by rw [hf]                 -- 具体版の 4 行目（`real_inclusion_preserves_product`）
    _ = f ((h * u) * l) := hf _ _                     -- 具体版の 5 行目（`real_inclusion_preserves_product`）
    _ = f ((u * l) * h) := by rw [mul_assoc, mul_comm] -- 具体版の 6 行目（`R` の乗法の交換則と結合則）

end Ising2D.NecSuf
