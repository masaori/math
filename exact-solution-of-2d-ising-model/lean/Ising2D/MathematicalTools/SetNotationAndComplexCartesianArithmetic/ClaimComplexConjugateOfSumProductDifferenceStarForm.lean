/-
# 複素共役は有限和・積・差を保つ: `star` の形と添字 `Fin n`・`Finset.range`・`Conf M` への読み替え（具体版）

対応する人手証明（正本は `structured-latex/content/005_exp_conjugation_proof.ts`）:
- `exp_conjugation_claim_complex_conjugate_of_sum`（ラベル `complex_conjugate_of_sum`）
- `exp_conjugation_claim_complex_conjugate_of_product`（ラベル `complex_conjugate_of_product`）
- `exp_conjugation_claim_complex_conjugate_of_difference`（ラベル `complex_conjugate_of_difference`）

このファイルは新しい主張を立てない。3 つの主張の具体版（`ClaimComplexConjugateOfSumProductDifference.lean`）は
`starRingEnd ℂ` の形で、有限和の添字が `Fin (m + 1)` である。共役転置（`Matrix.conjTranspose`）の成分は `star` の形で、
和の添字は `Fin n`（`n = 0` を含む）・`Finset.range N`・`Conf M` なので、使う側がそのまま当てられる形へ読み替える。

| 人手 | Lean |
| --- | --- |
| `complex_conjugate_of_product` | `complex_conjugate_star_mul`（`star` の形への読み替えの段と、具体版 `complex_conjugate_of_product_eq`） |
| `complex_conjugate_of_sum` の `m = 2` | `complex_conjugate_star_add`（同じく `complex_conjugate_of_sum_two`） |
| `complex_conjugate_of_difference` | `complex_conjugate_star_sub`（同じく `complex_conjugate_of_difference_eq`） |
| `complex_conjugate_of_sum` の `m = n` | `complex_conjugate_star_finite_sum`（`n = m + 1` で `complex_conjugate_of_finite_sum_succ`） |
| `complex_conjugate_of_sum` の `m = N`（添字 `0, …, N − 1`） | `complex_conjugate_star_sum_range`（添字の付け替え `Finset.sum_range` と `complex_conjugate_star_finite_sum`） |
| `complex_conjugate_of_sum` の `m = 2^M`（添字 `Conf M`） | `complex_conjugate_star_sum_conf`（添字の付け替え `finFunctionFinEquiv` と `complex_conjugate_star_finite_sum`） |

- `star z` と `(starRingEnd ℂ) z` は定義で同じ値である（mathlib の `starRingEnd_apply` が `rfl`）。読み替えの段は `rfl`。
- 人手の `m ∈ ℤ_{≥1}` に対し、使う側の `Fin n` は `n = 0` を含む。`n = 0` の段（両辺とも空の和）は人手証明の外で、
  空の和 `Σ_{j ∈ ∅} = 0`（mathlib の `Fin.sum_univ_zero`）と `\overline{0_ℂ} = 0_ℂ`（`complex_conjugate_star_zero`）で閉じる。
  `complex_conjugate_star_zero` は `complex_conjugate_of_neg_one` の 4 行と同じ段の並び（`inclusion_rr_to_cc` の `r_ℂ = (r, 0)`、
  `def_complex_conjugate`、ℝ で `-0 = 0`、`inclusion_rr_to_cc`）で `r = 0` について示す。同じ値は人手 `complex_conjugate_of_real_inclusion`
  の `r = 0` でもあるが、その具体版（`TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealSymmetricMatrixIsHermitian.lean`）を
  このフォルダから import すると章の向きが逆になるので、ここで書く。
- 人手の添字 `0, …, N` の和（`def_exp` の部分和）は、`Finset.range (N + 1)` の和である（`complex_conjugate_star_sum_range` の `N → N + 1`）。`def_finite_sum_of_complex_numbers` の
  添字 `1, …, m` の和（Lean の `Fin (m + 1)` の和）との行き来は、mathlib の `Finset.sum_range`（`Σ_{m ∈ range n} f m = Σ_{i : Fin n} f i`）
  で行う（添字の付け方そのものは状態台帳の「有限和の添字の付け方」の件）。
- `TensorPow M` の行列の添字 `Conf M`（`Fin M → Fin 2`）の和は、`Conf M` から `Fin (2^M)` への全単射 `finFunctionFinEquiv`
  （`toFinPowAlgEquiv M`（`Representation.lean`）の添字の付け替えと同じもの）で `Fin (2^M)` の和へ移してから当て、戻す。
  主張の添字は `Conf M` の中身 `Fin M → Fin 2` で書く（`Conf M` は略記なので、使う側はそのまま当てられる）。
  移す段と戻す段は人手の行ではない（`ClaimTraceEpsilonVPlusReduction.lean` の `Φ` と同じ扱い）。結論は付け替えの選び方によらない。

必要十分版は置かない。新しい主張が無く、読み替えの段だけだからである（和の主張の必要十分版は
`NecSuf/AdditiveMapPreservesFiniteSum.lean`）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfSumProductDifference
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Logic.Equiv.Fin.Basic

namespace Ising2D

/-- `star` の形の `\overline{zw} = \overline{z}\,\overline{w}`（人手 `complex_conjugate_of_product`）。 -/
theorem complex_conjugate_star_mul (z w : ℂ) : star (z * w) = star z * star w :=
  calc star (z * w)
      = (starRingEnd ℂ) (z * w) := rfl                          -- `star` を `starRingEnd ℂ` と読む
    _ = (starRingEnd ℂ) z * (starRingEnd ℂ) w :=
        complex_conjugate_of_product_eq z w                    -- `complex_conjugate_of_product`
    _ = star z * star w := rfl                                  -- `starRingEnd ℂ` を `star` と読む

/-- `star` の形の `\overline{z + w} = \overline{z} + \overline{w}`（人手 `complex_conjugate_of_sum` の `m = 2`）。 -/
theorem complex_conjugate_star_add (z w : ℂ) : star (z + w) = star z + star w :=
  calc star (z + w)
      = (starRingEnd ℂ) (z + w) := rfl                          -- `star` を `starRingEnd ℂ` と読む
    _ = (starRingEnd ℂ) z + (starRingEnd ℂ) w :=
        complex_conjugate_of_sum_two z w                       -- `complex_conjugate_of_sum` の `m = 2`
    _ = star z + star w := rfl                                  -- `starRingEnd ℂ` を `star` と読む

/-- `star` の形の `\overline{z - w} = \overline{z} - \overline{w}`（人手 `complex_conjugate_of_difference`）。 -/
theorem complex_conjugate_star_sub (z w : ℂ) : star (z - w) = star z - star w :=
  calc star (z - w)
      = (starRingEnd ℂ) (z - w) := rfl                          -- `star` を `starRingEnd ℂ` と読む
    _ = (starRingEnd ℂ) z - (starRingEnd ℂ) w :=
        complex_conjugate_of_difference_eq z w                 -- `complex_conjugate_of_difference`
    _ = star z - star w := rfl                                  -- `starRingEnd ℂ` を `star` と読む

/-- `\overline{0_ℂ} = 0_ℂ`（空の和の段だけで使う。`complex_conjugate_of_neg_one` の 4 行と同じ段の並びで `r = 0`）。 -/
theorem complex_conjugate_star_zero : star (0 : ℂ) = 0 :=
  calc star (0 : ℂ)
      = (starRingEnd ℂ) (((0 : ℝ)) : ℂ) :=
        rfl                                                     -- `star` を `starRingEnd ℂ` と、`0_ℂ` を `(0)_ℂ` と読む
    _ = (starRingEnd ℂ) (⟨0, 0⟩ : ℂ) := rfl                     -- `inclusion_rr_to_cc` の `r_ℂ = (r, 0)`（`r = 0`）
    _ = (⟨0, -0⟩ : ℂ) := Complex.ext (Complex.conj_re _) (Complex.conj_im _)
                                                                -- `def_complex_conjugate`
    _ = (⟨0, 0⟩ : ℂ) := by rw [neg_zero]                        -- ℝ で `-0 = 0`
    _ = (((0 : ℝ)) : ℂ) := rfl                                  -- `inclusion_rr_to_cc` の `r_ℂ = (r, 0)`（`r = 0`）
    _ = 0 := rfl                                                -- `(0)_ℂ` を `0_ℂ` と書く

/-- `star` の形・添字 `Fin n` の `\overline{Σ_j z_j} = Σ_j \overline{z_j}`（人手 `complex_conjugate_of_sum` の `m = n`）。
`n = m + 1` は具体版 `complex_conjugate_of_finite_sum_succ`、`n = 0`（両辺とも空の和）は人手証明の外の段。 -/
theorem complex_conjugate_star_finite_sum : ∀ (n : ℕ) (z : Fin n → ℂ), star (∑ j, z j) = ∑ j, star (z j)
  | 0, z =>
    calc star (∑ j : Fin 0, z j)
        = star (0 : ℂ) := by rw [Fin.sum_univ_zero]             -- 空の和は `0_ℂ`
      _ = 0 := complex_conjugate_star_zero                       -- `\overline{0_ℂ} = 0_ℂ`
      _ = ∑ j : Fin 0, star (z j) := (Fin.sum_univ_zero _).symm  -- 空の和は `0_ℂ`
  | m + 1, z =>
    calc star (∑ j : Fin (m + 1), z j)
        = (starRingEnd ℂ) (∑ j : Fin (m + 1), z j) := rfl       -- `star` を `starRingEnd ℂ` と読む
      _ = ∑ j : Fin (m + 1), (starRingEnd ℂ) (z j) :=
          complex_conjugate_of_finite_sum_succ m z              -- `complex_conjugate_of_sum` の `m → m + 1`
      _ = ∑ j : Fin (m + 1), star (z j) := rfl                  -- `starRingEnd ℂ` を `star` と読む（各項へ）

/-- `star` の形・添字 `0, …, N − 1` の `\overline{Σ_{m=0}^{N-1} z_m} = Σ_{m=0}^{N-1} \overline{z_m}`
（人手 `complex_conjugate_of_sum` の `m = N`。添字を `Fin N` へ付け替えて当てる）。 -/
theorem complex_conjugate_star_sum_range (N : ℕ) (z : ℕ → ℂ) :
    star (∑ m ∈ Finset.range N, z m) = ∑ m ∈ Finset.range N, star (z m) :=
  calc star (∑ m ∈ Finset.range N, z m)
      = star (∑ i : Fin N, z i) := by rw [Finset.sum_range]       -- 添字 `0, …, N − 1` を `Fin N` へ付け替える
    _ = ∑ i : Fin N, star (z i) :=
        complex_conjugate_star_finite_sum N (fun i => z i)        -- `complex_conjugate_of_sum` の `m = N`
    _ = ∑ m ∈ Finset.range N, star (z m) :=
        (Finset.sum_range (fun m => star (z m))).symm             -- 添字を `0, …, N − 1` へ戻す

/-- `star` の形・添字 `Conf M` の `\overline{Σ_s z_s} = Σ_s \overline{z_s}`（人手 `complex_conjugate_of_sum` の `m = 2^M`）。
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
