/-
# 劣加法的な写像と有限和・項ごとの大小と有限和（**必要十分版**）

対応する人手証明のラベル: `finite_sum_of_real_numbers_triangle_inequality`, `finite_sum_of_real_numbers_is_monotone`
（`structured-latex/content/000_calculation_formulae_00_09.ts`）。具体版は
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean`、
導出は同じフォルダの `ClaimFiniteSumsOfRealNumbersFromNecSuf.lean`。

## 何が効いているか / 効いていないか

| 具体版（係数 `ℝ`） | 必要十分版（同じ並び） | 効いている仮定 |
| --- | --- | --- |
| `finite_sum_of_real_numbers_triangle_inequality_succ` | `finite_sum_subadditive_succ'` | 和の側 `R` は加法についての可換モノイドだけ。値の側 `S` は加法についての可換モノイドと前順序と、右に同じ元を足しても `≤` が保たれること（`AddRightMono`）。写像 `f` については明示の仮定 `f(a + b) ≤ f(a) + f(b)`（劣加法性）だけ |
| `finite_sum_of_real_numbers_triangle_inequality` | `finite_sum_subadditive_fin'` | 同上と、空の和のための明示の仮定 `f(0) ≤ 0` |
| `finite_sum_of_real_numbers_is_monotone_succ` | `finite_sum_le_succ'` | 加法についての可換モノイドと順序と、両辺に同じ元を足しても `≤` が保たれること（`IsOrderedAddMonoid`。可換性の下で左右の単調性をまとめた形で、`add_le_add` がこの形を要求する） |
| `finite_sum_of_real_numbers_is_monotone` | `finite_sum_le_fin'` | 同上 |

* 有限和の三角不等式で絶対値について効いているのは、帰納法の段の `|α + a| ≤ |α| + |a|`（劣加法性）だけである。
  絶対値が非負であること、`|0| = 0`（空の和を除く）、`|-a| = |a|`、積の絶対値、順序が全順序であること、加法の逆元は効いていない。
  帰納法の段の「帰納法の仮定の両辺に `|a_{m+1}|` を足す」は右に足す段だけで、仮定はそれを `AddRightMono` で置く
  （和の側が可換なので左右は同じ内容である）。
* 項ごとの大小の主張は、帰納法の段で右に足す段（帰納法の仮定に `a_{m+1}` を足す）と左に足す段（`a_{m+1} ≤ b_{m+1}` に `Σ b_j` を足す）を使う。
  順序は前順序で足り、反対称律・全順序、差、乗法、実数であることは効いていない。
* 加法の交換則は、`Finset` の上の和 `∑` が `AddCommMonoid` を要求するので外せない（人手の左から足す和を `Fin` の上の `∑` で受けるための仮定）。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.Monoid.Unbundled.Basic
import Mathlib.Algebra.Order.Monoid.Defs

namespace Ising2D.NecSuf

/-- **`finite_sum_of_real_numbers_triangle_inequality`** の必要十分版（`m + 1` 項）:
劣加法的な `f` について `f(Σ_{j=1}^{m+1} a_j) ≤ Σ_{j=1}^{m+1} f(a_j)`。`m` についての帰納法。 -/
theorem finite_sum_subadditive_succ' {R S : Type*} [AddCommMonoid R] [AddCommMonoid S] [Preorder S]
    [AddRightMono S] (f : R → S) (hf : ∀ a b, f (a + b) ≤ f a + f b) (m : ℕ) (a : Fin (m + 1) → R) :
    f (∑ j, a j) ≤ ∑ j, f (a j) := by
  induction m with
  | zero =>
    calc f (∑ j : Fin 1, a j)
        = f (a 0) := by rw [Fin.sum_univ_one]                                -- 和の定義（1 項）
      _ = ∑ j : Fin 1, f (a j) := (Fin.sum_univ_one (fun j => f (a j))).symm  -- 和の定義（1 項、`r_j → f(a_j)`）
      _ ≤ ∑ j : Fin 1, f (a j) := le_rfl
  | succ m ih =>
    calc f (∑ j : Fin (m + 2), a j)
        = f ((∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _)) := by
          rw [Fin.sum_univ_castSucc]                                          -- 和の定義（帰納の段）
      _ ≤ f (∑ j : Fin (m + 1), a j.castSucc) + f (a (Fin.last _)) := hf _ _  -- 劣加法性（具体版の三角不等式）
      _ ≤ (∑ j : Fin (m + 1), f (a j.castSucc)) + f (a (Fin.last _)) :=
          add_le_add_left (ih (fun j => a j.castSucc)) _                      -- 帰納法の仮定の両辺に右から足す
      _ = ∑ j, f (a j) := (Fin.sum_univ_castSucc (fun j => f (a j))).symm     -- 和の定義（帰納の段、`r_j → f(a_j)`）

/-- **`finite_sum_of_real_numbers_triangle_inequality`** の必要十分版（`Fin m` の上の和。空の和には `f(0) ≤ 0` を仮定する）。 -/
theorem finite_sum_subadditive_fin' {R S : Type*} [AddCommMonoid R] [AddCommMonoid S] [Preorder S]
    [AddRightMono S] (f : R → S) (hf : ∀ a b, f (a + b) ≤ f a + f b) (h0 : f 0 ≤ 0) (m : ℕ) (a : Fin m → R) :
    f (∑ j, a j) ≤ ∑ j, f (a j) := by
  cases m with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero]; exact h0
  | succ m => exact finite_sum_subadditive_succ' f hf m a

/-- **`finite_sum_of_real_numbers_is_monotone`** の必要十分版（`m + 1` 項）。`m` についての帰納法。 -/
theorem finite_sum_le_succ' {R : Type*} [AddCommMonoid R] [Preorder R] [IsOrderedAddMonoid R]
    (m : ℕ) (a b : Fin (m + 1) → R) (hab : ∀ j, a j ≤ b j) : ∑ j, a j ≤ ∑ j, b j := by
  induction m with
  | zero =>
    calc ∑ j : Fin 1, a j
        = a 0 := Fin.sum_univ_one _
      _ ≤ b 0 := hab 0
      _ = ∑ j : Fin 1, b j := (Fin.sum_univ_one _).symm
  | succ m ih =>
    calc ∑ j : Fin (m + 2), a j
        = (∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _) := Fin.sum_univ_castSucc _
      _ ≤ (∑ j : Fin (m + 1), b j.castSucc) + a (Fin.last _) :=
          add_le_add (ih (fun j => a j.castSucc) (fun j => b j.castSucc) (fun j => hab _)) le_rfl
      _ ≤ (∑ j : Fin (m + 1), b j.castSucc) + b (Fin.last _) := add_le_add le_rfl (hab _)
      _ = ∑ j, b j := (Fin.sum_univ_castSucc b).symm

/-- **`finite_sum_of_real_numbers_is_monotone`** の必要十分版（`Fin m` の上の和）。 -/
theorem finite_sum_le_fin' {R : Type*} [AddCommMonoid R] [Preorder R] [IsOrderedAddMonoid R]
    (m : ℕ) (a b : Fin m → R) (hab : ∀ j, a j ≤ b j) : ∑ j, a j ≤ ∑ j, b j := by
  cases m with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero]
  | succ m => exact finite_sum_le_succ' m a b hab

end Ising2D.NecSuf
