/-
# 複素共役は有限和・積を保つ: 添字 `Fin n`・`Finset.range`・`Conf M` への読み替え（具体版）

対応する人手証明（正本は `structured-latex/content/005_exp_conjugation_proof.ts`）:
- `exp_conjugation_claim_complex_conjugate_of_sum`（ラベル `complex_conjugate_of_sum`）
- `exp_conjugation_claim_complex_conjugate_of_product`（ラベル `complex_conjugate_of_product`）

`complex_conjugate_star_finite_sum` は人手 `complex_conjugate_of_sum`（`m ∈ ℤ_{≥0}`）の主の具体版で、`n = 0` の段が人手の `m = 0` の 6 行、
`n = m + 1` の段が `complex_conjugate_of_finite_sum_succ` である。ほかの宣言は新しい主張を立てない。2 つの主張の
`ClaimComplexConjugateOfSumProductDifference.lean` の具体版は、有限和の添字が `Fin (m + 1)` で、積は 2 因子である。使う側の和の添字は `Fin n`（`n = 0` を含む）・`Finset.range N`・`Conf M`、
積は `M` 個の因子なので、使う側がそのまま当てられる形へ読み替える。

| 人手 | Lean |
| --- | --- |
| `complex_conjugate_of_sum` の `m = n` | `complex_conjugate_star_finite_sum`（`n = m + 1` で `complex_conjugate_of_finite_sum_succ`） |
| `complex_conjugate_of_sum` の `m = N`（添字 `0, …, N − 1`） | `complex_conjugate_star_sum_range`（添字の付け替え `Finset.sum_range` と `complex_conjugate_star_finite_sum`） |
| `complex_conjugate_of_sum` の `m = 2^M`（添字 `Conf M`） | `complex_conjugate_star_sum_conf`（添字の付け替え `finFunctionFinEquiv` と `complex_conjugate_star_finite_sum`） |
| `complex_conjugate_of_product` の反復適用（`M` 個の因子の有限積） | `complex_conjugate_star_finite_prod`（`def_finite_product_of_complex_numbers` で末尾の因子を外し、1 段ごとに `complex_conjugate_of_product_eq` を 1 回） |

- 人手の `m ∈ ℤ_{≥0}` の `m = 0` の 6 行は、`complex_conjugate_star_finite_sum` の `n = 0` の段で、空の和の式
  `Σ_{j=1}^{0} z_j := 0_ℂ`（`finset_sum_fin_complex_eq_finite_sum_of_complex_numbers` の一つ目の式）と `\overline{0_ℂ} = 0_ℂ`（`complex_conjugate_star_zero`）で閉じる。
  `complex_conjugate_star_zero` は `complex_conjugate_of_neg_one` の 4 行と同じ段の並び（`inclusion_rr_to_cc` の `r_ℂ = (r, 0)`、
  `def_complex_conjugate`、`real_negation_of_zero_is_zero`、`inclusion_rr_to_cc`）で `r = 0` について示す。
  有限積も同じく、`n = 0`（両辺とも空の積）は人手証明の外で、空の積 `∏_{j ∈ ∅} = 1_ℂ`（mathlib の `Fin.prod_univ_zero`）と
  `\overline{1_ℂ} = 1_ℂ`（`complex_conjugate_star_one`。`complex_conjugate_star_zero` と同じ段の並びで `r = 1`）で閉じる。
  `\overline{0_ℂ} = 0_ℂ`・`\overline{1_ℂ} = 1_ℂ` は人手 `complex_conjugate_of_real_inclusion` の `r = 0`・`r = 1` でもあるが、その具体版
  （`TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealSymmetricMatrixIsHermitian.lean`）をこのフォルダから import すると
  章の向きが逆になるので、ここで書く。
- 有限積 `∏_{j=1}^{m} z_j` は人手 `def_finite_product_of_complex_numbers`（`∏_{j=1}^{1} z_j := z_1`、
  `∏_{j=1}^{m+1} z_j := (∏_{j=1}^{m} z_j) z_{m+1}`）で、Lean の `Fin m` の積との行き来は `Fin.prod_univ_one`・`Fin.prod_univ_castSucc`
  で行う（`finite_product_of_real_inclusions_is_real` と同じ）。
- 人手の添字 `0, …, N` の和（`def_exp` の部分和）は、`Finset.range (N + 1)` の和である（`complex_conjugate_star_sum_range` の `N → N + 1`）。`def_finite_sum_of_complex_numbers` の
  添字 `1, …, m` の和（Lean の `Fin (m + 1)` の和）との行き来は、mathlib の `Finset.sum_range`（`Σ_{m ∈ range n} f m = Σ_{i : Fin n} f i`）
  で行う（添字の付け方そのものは状態台帳の「有限和の添字の付け方」の件）。
- `TensorPow M` の行列の添字 `Conf M`（`Fin M → Fin 2`）の和は、`Conf M` から `Fin (2^M)` への全単射 `finFunctionFinEquiv`
  （`toFinPowAlgEquiv M`（`Representation.lean`）の添字の付け替えと同じもの）で `Fin (2^M)` の和へ移してから当て、戻す。
  主張の添字は `Conf M` の中身 `Fin M → Fin 2` で書く（`Conf M` は略記なので、使う側はそのまま当てられる）。
  移す段と戻す段は人手の行ではない（`ClaimTraceEpsilonVPlusReduction.lean` の `Φ` と同じ扱い）。結論は付け替えの選び方によらない。

`complex_conjugate_star_finite_sum` の必要十分版は `NecSuf/AdditiveMapPreservesFiniteSum.lean` の
`NecSuf.map_finSumLeftFromEmpty_of_map_add_of_map_zero'`（導出は `ClaimComplexConjugateOfSumFromNecSuf.lean`）。
ほかの宣言は読み替えの段だけなので、必要十分版を置かない。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionComplexConjugate
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfSumProductDifference
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionFiniteSumOverIndexSet
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Logic.Equiv.Fin.Basic

namespace Ising2D

/-- `\overline{0_ℂ} = 0_ℂ`（空の和の段だけで使う。`complex_conjugate_of_neg_one` の 4 行と同じ段の並びで `r = 0`）。 -/
theorem complex_conjugate_star_zero : star (0 : ℂ) = 0 :=
  calc star (0 : ℂ)
      = star (((0 : ℝ)) : ℂ) := rfl                             -- `0_ℂ` を `(0)_ℂ` と読む
    _ = star (⟨0, 0⟩ : ℂ) := rfl                     -- `inclusion_rr_to_cc` の `r_ℂ = (r, 0)`（`r = 0`）
    _ = (⟨0, -0⟩ : ℂ) := complex_star_mk _ _
                                                                -- `def_complex_conjugate`
    _ = (⟨0, 0⟩ : ℂ) := by rw [real_negation_of_zero_is_zero]   -- `real_negation_of_zero_is_zero`
    _ = (((0 : ℝ)) : ℂ) := rfl                                  -- `inclusion_rr_to_cc` の `r_ℂ = (r, 0)`（`r = 0`）
    _ = 0 := rfl                                                -- `(0)_ℂ` を `0_ℂ` と書く

/-- `\overline{1_ℂ} = 1_ℂ`（空の積の段だけで使う。`complex_conjugate_star_zero` と同じ段の並びで `r = 1`）。 -/
theorem complex_conjugate_star_one : star (1 : ℂ) = 1 :=
  calc star (1 : ℂ)
      = star (((1 : ℝ)) : ℂ) := rfl                             -- `1_ℂ` を `(1)_ℂ` と読む
    _ = star (⟨1, 0⟩ : ℂ) := rfl                     -- `inclusion_rr_to_cc` の `r_ℂ = (r, 0)`（`r = 1`）
    _ = (⟨1, -0⟩ : ℂ) := complex_star_mk _ _
                                                                -- `def_complex_conjugate`
    _ = (⟨1, 0⟩ : ℂ) := by rw [real_negation_of_zero_is_zero]   -- `real_negation_of_zero_is_zero`
    _ = (((1 : ℝ)) : ℂ) := rfl                                  -- `inclusion_rr_to_cc` の `r_ℂ = (r, 0)`（`r = 1`）
    _ = 1 := rfl                                                -- `(1)_ℂ` を `1_ℂ` と書く

/-- 添字 `Fin n` の `\overline{∏_j z_j} = ∏_j \overline{z_j}`（人手 `complex_conjugate_of_product` の反復適用）。
`n + 2` の段は、`def_finite_product_of_complex_numbers` で末尾の因子と残りの積に分けて `complex_conjugate_of_product` を 1 回当て、
残りの積に同じ主張（`n + 1`）を当てる。`n = 1` は `def_finite_product_of_complex_numbers` の `m = 1`、
`n = 0`（両辺とも空の積）は人手証明の外の段。 -/
theorem complex_conjugate_star_finite_prod : ∀ (n : ℕ) (z : Fin n → ℂ), star (∏ j, z j) = ∏ j, star (z j)
  | 0, z =>
    calc star (∏ j : Fin 0, z j)
        = star (1 : ℂ) := by rw [Fin.prod_univ_zero]            -- 空の積は `1_ℂ`
      _ = 1 := complex_conjugate_star_one                        -- `\overline{1_ℂ} = 1_ℂ`
      _ = ∏ j : Fin 0, star (z j) := (Fin.prod_univ_zero _).symm -- 空の積は `1_ℂ`
  | 1, z =>
    calc star (∏ j : Fin 1, z j)
        = star (z 0) := by rw [Fin.prod_univ_one]               -- `def_finite_product_of_complex_numbers`（`m = 1`）
      _ = ∏ j : Fin 1, star (z j) :=
          (Fin.prod_univ_one (fun j => star (z j))).symm        -- `def_finite_product_of_complex_numbers`（`m = 1`）
  | n + 2, z =>
    calc star (∏ j : Fin (n + 2), z j)
        = star ((∏ j : Fin (n + 1), z (Fin.castSucc j)) * z (Fin.last (n + 1))) := by
          rw [Fin.prod_univ_castSucc]                           -- `def_finite_product_of_complex_numbers`（`m → n + 1`）
      _ = star (∏ j : Fin (n + 1), z (Fin.castSucc j)) * star (z (Fin.last (n + 1))) :=
          complex_conjugate_of_product_eq _ _                        -- `complex_conjugate_of_product`
      _ = (∏ j : Fin (n + 1), star (z (Fin.castSucc j))) * star (z (Fin.last (n + 1))) := by
          rw [complex_conjugate_star_finite_prod (n + 1)]       -- 残りの積に同じ主張（`n + 1`）
      _ = ∏ j : Fin (n + 2), star (z j) :=
          (Fin.prod_univ_castSucc (fun j => star (z j))).symm   -- `def_finite_product_of_complex_numbers`（`m → n + 1`）、右辺から左辺へ

/-- 添字 `Fin n` の `\overline{Σ_j z_j} = Σ_j \overline{z_j}`（人手 `complex_conjugate_of_sum`、`m ∈ ℤ_{≥0}` の `m = n`）。
`n = 0` の段は人手の `m = 0` の 6 行、`n = m + 1` は具体版 `complex_conjugate_of_finite_sum_succ`。 -/
theorem complex_conjugate_star_finite_sum : ∀ (n : ℕ) (z : Fin n → ℂ), star (∑ j, z j) = ∑ j, star (z j)
  | 0, z =>
    calc star (∑ j : Fin 0, z j)
        = star (0 : ℂ) := by
          rw [finset_sum_fin_complex_eq_finite_sum_of_complex_numbers.1 z]
                                                                -- `def_finite_sum_of_complex_numbers` の `Σ_{j=1}^{0} z_j := 0_ℂ`
      _ = 0 := complex_conjugate_star_zero                       -- 人手の 2〜5 行（`inclusion_rr_to_cc`・`def_complex_conjugate`・`real_negation_of_zero_is_zero`・`inclusion_rr_to_cc` を右辺から左辺へ）
      _ = ∑ j : Fin 0, star (z j) :=
          (finset_sum_fin_complex_eq_finite_sum_of_complex_numbers.1 _).symm
                                                                -- `def_finite_sum_of_complex_numbers` の `Σ_{j=1}^{0} z_j := 0_ℂ`（`z_j → \overline{z_j}`）を右辺から左辺へ
  | m + 1, z =>
    complex_conjugate_of_finite_sum_succ m z                    -- `complex_conjugate_of_sum` の `m → m + 1`

/-- 添字 `0, …, N − 1` の `\overline{Σ_{m=0}^{N-1} z_m} = Σ_{m=0}^{N-1} \overline{z_m}`
（人手 `complex_conjugate_of_sum` の `m = N`。添字を `Fin N` へ付け替えて当てる）。 -/
theorem complex_conjugate_star_sum_range (N : ℕ) (z : ℕ → ℂ) :
    star (∑ m ∈ Finset.range N, z m) = ∑ m ∈ Finset.range N, star (z m) :=
  calc star (∑ m ∈ Finset.range N, z m)
      = star (∑ i : Fin N, z i) := by rw [Finset.sum_range]       -- 添字 `0, …, N − 1` を `Fin N` へ付け替える
    _ = ∑ i : Fin N, star (z i) :=
        complex_conjugate_star_finite_sum N (fun i => z i)        -- `complex_conjugate_of_sum` の `m = N`
    _ = ∑ m ∈ Finset.range N, star (z m) :=
        (Finset.sum_range (fun m => star (z m))).symm             -- 添字を `0, …, N − 1` へ戻す

/-- 添字 `Conf M` の `\overline{Σ_s z_s} = Σ_s \overline{z_s}`（人手 `complex_conjugate_of_sum` の `m = 2^M`）。
添字を全単射 `finFunctionFinEquiv : Conf M ≃ Fin (2^M)` で `Fin (2^M)` へ移して当て、戻す。 -/
theorem complex_conjugate_star_sum_conf (M : ℕ) (z : (Fin M → Fin 2) → ℂ) :
    star (∑ s, z s) = ∑ s, star (z s) :=
  calc star (∑ s, z s)
      = star (∑ i : Fin (2 ^ M), z (finFunctionFinEquiv.symm i)) := by
        rw [Equiv.sum_comp finFunctionFinEquiv.symm z]          -- 添字 `Conf M` を `Fin (2^M)` へ移す
    _ = ∑ i : Fin (2 ^ M), star (z (finFunctionFinEquiv.symm i)) :=
        complex_conjugate_star_finite_sum (2 ^ M) _               -- `complex_conjugate_of_sum` の `m = 2^M`
    _ = ∑ s, star (z s) :=
        Equiv.sum_comp finFunctionFinEquiv.symm (fun s => star (z s)) -- 添字を `Conf M` へ戻す

end Ising2D
