/-
# 一つの項のほかが 0 の有限和はその項に等しい（必要十分版）

対応する人手証明のラベル: `finite_sum_with_single_nonzero_term`・`finite_sum_of_matrices_with_single_nonzero_term`
具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimFiniteSumWithSingleNonzeroTerm.lean` の
`finite_sum_with_single_nonzero_term_succ` と、
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimFiniteSumOfMatricesWithSingleNonzeroTerm.lean` の
`finite_sum_of_matrices_with_single_nonzero_term`。具体版をこのファイルの系として導くのは、それぞれ同じフォルダの
`ClaimFiniteSumWithSingleNonzeroTermFromNecSuf.lean`・`ClaimFiniteSumOfMatricesWithSingleNonzeroTermFromNecSuf.lean`。

人手の `ℂ` を、零と加法を持つ集合 `G` に置き換える。有限和は左から足す和 `finSumLeft`
（`Ising2D/NecSuf/AdditiveToMultiplicativeMapOfFiniteSum.lean`。人手の `m ∈ ℤ_{≥1}` は Lean の `r + 1`、
`def_finite_sum_of_complex_numbers` の 2 つの式がそのまま 2 つの節）である。

## 何が効いているか / 効いていないか

| 人手の段 | 具体版の段 | 必要十分版の段 | 効いている仮定 |
| --- | --- | --- | --- |
| `m = 1` の 2 行 | 和の定義 → `n = 1` | `finSumLeft_single'` の `0` の節（同じ 2 段） | 和の定義の `Σ_{j=1}^{1} z_j := z_1` |
| `n = m+1` の 5 行 | 和の定義 → 各項を `0` へ → 零の和 → `0 + z = z`（`complex_zero_plus_is_original`） → `n = m+1` | `r + 1` の節の `Fin.last` の場合（同じ 5 段） | `0 + z = z`、零の和が `0`（`finSumLeft_zeros'`。`z + 0 = z` の特別な場合 `0 + 0 = 0`） |
| `n ≤ m` の 4 行 | 和の定義 → 帰納法の仮定 → `z_{m+1} = 0` → 加法の単位元 | `r + 1` の節の `Fin.castSucc` の場合（同じ 4 段） | `z + 0 = z` |
| 行列版の成分の鎖の 2 行と「成分が一致」 | `Matrix.sum_apply` → `finite_sum_with_single_nonzero_term_fintype` → `Matrix.ext` | `finSumLeft_matrix_single'`（`finSumLeft_matrix_apply'` → `finSumLeft_single'` → `Matrix.ext`） | 成分の加法が和の成分（行列の和の定義）、零行列の成分が `0` |

- **効いているのは、`0` が加法の左右の単位元であること（`AddZeroClass`）だけである。**
  零の和 `finite_sum_of_complex_zeros` は `0 + 0 = 0` だけで済み、これも右の単位元の特別な場合である。
- **効いていないもの**: 加法の結合則・交換則（和は左から順に畳み込むので、括弧の付け替えも並べ替えも現れない）、
  加法の逆元、乗法、`ℂ` であること。行列版では、行と列の添字の有限性、成分の乗法。
- 左右の単位元は削れない。`G := {0, 1}` に `a + b := b`（右の値を返す）と零 `0` を入れると `z + 0 = 0 ≠ z`（`z = 1`）で、`z_1 = 1, z_2 = 0`、`n = 1` の
  `Σ_{j=1}^{2} z_j = z_1 + z_2 = 0 ≠ 1 = z_1` となる。左右を入れ替えた `a + b := a` では `0 + z = 0` が崩れ、
  `z_1 = 0, z_2 = 1`、`n = 2` で `Σ = 0 ≠ 1 = z_2` となる。したがって左右の単位元はどちらも削れない。
- 具体版の有限型の添字の版（`_fintype`）は番号付け（mathlib の `Equiv.sum_comp`）を使うので `Finset.sum` に依り、
  加法の結合則・交換則を要する（番号の付け方に依らないため）。人手の主張（添字 `{1, …, m}`）そのものには要らないので、
  必要十分版は番号の付いた和 `finSumLeft` で述べる。
-/
import Ising2D.NecSuf.AdditiveToMultiplicativeMapOfFiniteSum
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

/-- 零の左から足す和は `0`（具体版では `finite_sum_of_complex_zeros` を `Finset.sum_const_zero` で引く段）。
`0 + 0 = 0` だけを使う。 -/
theorem finSumLeft_zeros' {G : Type*} [AddZeroClass G] :
    ∀ r : ℕ, finSumLeft r (fun _ : Fin (r + 1) => (0 : G)) = 0
  | 0 => finSumLeft_zero _
  | r + 1 =>
    calc finSumLeft (r + 1) (fun _ : Fin (r + 2) => (0 : G))
        = finSumLeft r (fun _ : Fin (r + 1) => (0 : G)) + 0 := finSumLeft_succ r _     -- 和の定義
      _ = 0 + 0 := by rw [finSumLeft_zeros' r]                                          -- 帰納法の仮定
      _ = 0 := add_zero 0                                                               -- `0 + 0 = 0`

/-- **必要十分版の `finite_sum_with_single_nonzero_term`**: `j ≠ n` のすべての `j` で `z_j = 0` なら
`Σ_{j=1}^{r+1} z_j = z_n`。具体版 `finite_sum_with_single_nonzero_term_succ` と同じく項の個数についての帰納法。 -/
theorem finSumLeft_single' {G : Type*} [AddZeroClass G] :
    ∀ (r : ℕ) (z : Fin (r + 1) → G) (n : Fin (r + 1)), (∀ j, j ≠ n → z j = 0) → finSumLeft r z = z n
  | 0, z, n, _ =>
    calc finSumLeft 0 z
        = z 0 := finSumLeft_zero z                                                      -- 和の定義
      _ = z n := by rw [Fin.fin_one_eq_zero n]                                          -- `n = 1`
  | r + 1, z, n, hz => by
    rcases (Fin.eq_castSucc_or_eq_last n).symm with hn | ⟨n', rfl⟩
    · -- 具体版の `n = m + 1` の場合
      have hfirst : (fun j : Fin (r + 1) => z (Fin.castSucc j)) = fun _ => 0 :=
        funext fun j => hz _ (hn ▸ (Fin.castSucc_lt_last j).ne)
      calc finSumLeft (r + 1) z
          = finSumLeft r (fun j => z (Fin.castSucc j)) + z (Fin.last (r + 1)) :=
            finSumLeft_succ r z                                                         -- 和の定義
        _ = finSumLeft r (fun _ : Fin (r + 1) => (0 : G)) + z (Fin.last (r + 1)) := by
            rw [hfirst]                                                                 -- `j ≤ m` の各項を `0` へ
        _ = 0 + z (Fin.last (r + 1)) := by rw [finSumLeft_zeros' r]                     -- 零の和
        _ = z (Fin.last (r + 1)) := zero_add _                                          -- `0 + z = z`
        _ = z n := by rw [hn]                                                           -- `n = m + 1`
    · -- 具体版の `n ∈ {1, …, m}` の場合
      have hlast : z (Fin.last (r + 1)) = 0 := hz _ (Fin.castSucc_lt_last n').ne'
      calc finSumLeft (r + 1) z
          = finSumLeft r (fun j => z (Fin.castSucc j)) + z (Fin.last (r + 1)) :=
            finSumLeft_succ r z                                                         -- 和の定義
        _ = z (Fin.castSucc n') + z (Fin.last (r + 1)) := by
            rw [finSumLeft_single' r (fun j => z (Fin.castSucc j)) n'
              (fun j hj => hz _ (fun h => hj (Fin.castSucc_injective _ h)))]           -- 帰納法の仮定
        _ = z (Fin.castSucc n') + 0 := by rw [hlast]                                    -- `z_{m+1} = 0`
        _ = z (Fin.castSucc n') := add_zero _                                           -- `z + 0 = z`

/-- 行列の左から足す和の成分は、成分の左から足す和（具体版では `finite_sum_of_matrices_entrywise` を `Matrix.sum_apply` で引く段）。
成分の加法が行列の和の成分であること（行列の和の定義）だけを使う。 -/
theorem finSumLeft_matrix_apply' {α β R : Type*} [Add R] :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix α β R) (i : α) (k : β),
      finSumLeft r X i k = finSumLeft r (fun a => X a i k)
  | 0, _, _, _ => rfl
  | r + 1, X, i, k => by
    rw [finSumLeft_succ, finSumLeft_succ, Matrix.add_apply, finSumLeft_matrix_apply' r]

/-- **必要十分版の `finite_sum_of_matrices_with_single_nonzero_term`**: `a ≠ q` のすべての `a` で `X_a = O` なら
`Σ_{a=1}^{r+1} X_a = X_q`。具体版と同じく、成分の鎖（成分の和 → 一つの項のほかが `0` の和）と成分の一致。 -/
theorem finSumLeft_matrix_single' {α β R : Type*} [AddZeroClass R]
    (r : ℕ) (X : Fin (r + 1) → Matrix α β R) (q : Fin (r + 1)) (hX : ∀ a, a ≠ q → X a = 0) :
    finSumLeft r X = X q :=
  Matrix.ext fun i k =>
    calc finSumLeft r X i k
        = finSumLeft r (fun a => X a i k) := finSumLeft_matrix_apply' r X i k           -- 行列の和は成分ごと
      _ = X q i k :=
          finSumLeft_single' r (fun a => X a i k) q
            (fun a ha => by rw [hX a ha]; exact Matrix.zero_apply i k)                  -- `finSumLeft_single'`（`(X_a)_{ik} = O_{ik} = 0`）

end Ising2D.NecSuf
