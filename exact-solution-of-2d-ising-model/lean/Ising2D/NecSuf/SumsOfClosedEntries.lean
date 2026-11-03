/-
# 成分がすべて実数の行列の和・差・有限和（必要十分版）

具体版: `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimSumsOfRealEntryMatricesHaveRealEntries.lean`
（人手 `sum_of_real_entry_matrices_has_real_entries`・`difference_of_real_entry_matrices_has_real_entries`・
`finite_sum_of_real_entry_matrices_has_real_entries`）。
具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimSumsOfRealEntryMatricesFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 和: `def_matrix_sum` の段（`(A + B)_{pq} = A_{pq} + B_{pq}`） | `add_entries_mem` の 1 段目 |
| 和: `s, t` の取り方 → `inclusion_rr_to_cc` → `definition_of_cc` の和 → `0 + 0 = 0` → `inclusion_rr_to_cc` の 5 段 | 仮定 `hA p q`・`hB p q` を和で閉じること `hadd` に渡す 1 段 |
| 差: `matrix_difference_is_sum_with_negation` → `negation_is_scalar_multiple_by_minus_one` → 略記 `-1_ℂ = ι(-1)` の鎖 | `sub_entries_mem` の 2 段（略記の段は、`-1` が性質に入ること `hm1` に吸収される） |
| 差: `real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`c → -1`） → `sum_of_real_entry_matrices_has_real_entries` | `smul_entries_mem`（`ScalarMultipleOfClosedEntries.lean`）→ `add_entries_mem` |
| 有限和: `r = 1` と帰納法の段（`def_finite_sum_of_matrices` → 帰納法の仮定 → `sum_of_real_entry_matrices_has_real_entries`） | `finite_sum_entries_mem` の 2 つの場合 |

## 何が効いているか / 効いていないか

- 「`r_ℂ` の形に書ける」（`ℝ` の像に入る）を、係数の型 `R` の任意の性質 `S` に置き換えた。
- 和で効いているのは **`S` が和で閉じていること**（`hadd`）だけである。具体版の 2〜6 段目（実数 `s, t` を取り出して
  `(s + t)_ℂ` を組む段）は、`S` を `ℝ` の像に取ったときに `hadd` を与える計算で、手順（成分を和の定義で成分の和に読み、和で閉じることに渡す）は同じである。
- 有限和で効いているのも **和で閉じていること**だけで、空の和を持たない（人手の `r ≥ 1`）ので零元が性質に入ることは使わない。
  係数に `AddCommMonoid R` を置いたのは、Lean の有限和 `∑`（`Finset.sum`）がそれを要求するためで、論証は加法の結合性・可換性・零元を使わない
  （`Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で人手の左から足す和の定義へ読み替えるだけ）。
- 差で効いているのは、**差が `x + (-y)` で定まること**（`hsub`。人手の `matrix_difference_is_sum_with_negation` が引く `def_complex_difference`）、
  **符号反転が `-1` 倍であること**（`hneg`。人手の `multiply_by_minus_one`）、**`-1` が `S` に入ること**（`hm1`。人手の `(-1)_ℂ` が `-1 ∈ ℝ` の像であること）、
  **積で閉じること**（`hmul`。実数倍の段）、**和で閉じること**（`hadd`）である。
  `hm1` と `hmul` を合わせた分は、論証が実際に使う「`-1` 倍で閉じること」より強い（例えば `ℤ + ℤ·2^{1/3}` の像は和と `-1` 倍で閉じるが積で閉じない）。
  `hmul` を置いたのは、具体版の手順（`real_scalar_multiple_of_real_entry_matrix_has_real_entries` を `c → -1` で引く段）を `smul_entries_mem` を通して保つためである。
  削れない理由: `hm1` を落とすと `-B` の成分が `S` に入る根拠が無い（`S` を「`0` 以上の実数の像」に取ると、和・積で閉じ `hsub`・`hneg` も成り立つが、差で閉じない）。
- 行列の添字 `α`・`β` は任意の型で、正方であることも有限であることも効いていない。
-/
import Ising2D.NecSuf.ScalarMultipleOfClosedEntries
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D.NecSuf

/-- **和で閉じた性質に成分がすべて入る 2 つの行列の和も、成分はすべてその性質に入る**（具体版 `matrix_add_hasRealEntries`）。 -/
theorem add_entries_mem {R α β : Type*} [Add R] (S : R → Prop) (hadd : ∀ a b, S a → S b → S (a + b))
    (A B : Matrix α β R) (hA : ∀ p q, S (A p q)) (hB : ∀ p q, S (B p q)) :
    ∀ p q, S ((A + B) p q) := by
  intro p q
  have h : (A + B) p q = A p q + B p q := rfl                               -- 和の定義
  rw [h]
  exact hadd (A p q) (B p q) (hA p q) (hB p q)                              -- 仮定 `hA p q`・`hB p q` を、和で閉じること `hadd` に

/-- **差（具体版 `matrix_sub_hasRealEntries`）**: 差が `x + (-y)`、符号反転が `-1` 倍で定まり、`-1` が性質に入り、
性質が積と和で閉じていれば、成分がすべて性質に入る 2 つの行列の差も、成分はすべてその性質に入る。 -/
theorem sub_entries_mem {R α β : Type*} [Add R] [Mul R] [Neg R] [Sub R] [One R] (S : R → Prop)
    (hsub : ∀ x y : R, x - y = x + -y) (hneg : ∀ x : R, -x = (-1) * x) (hm1 : S (-1))
    (hmul : ∀ a b, S a → S b → S (a * b)) (hadd : ∀ a b, S a → S b → S (a + b))
    (A B : Matrix α β R) (hA : ∀ p q, S (A p q)) (hB : ∀ p q, S (B p q)) :
    ∀ p q, S ((A - B) p q) := by
  have hchain : A - B = A + ((-1 : R) • B) := by
    calc A - B
        = A + (-B) := Matrix.ext fun p q => hsub (A p q) (B p q)            -- `matrix_difference_is_sum_with_negation`（成分で `hsub`）
      _ = A + ((-1 : R) • B) := by
          congr 1
          exact Matrix.ext fun p q => hneg (B p q)                          -- `negation_is_scalar_multiple_by_minus_one`（成分で `hneg`）
  rw [hchain]
  exact add_entries_mem S hadd A _ hA (smul_entries_mem S hmul (-1) hm1 B hB)  -- 実数倍（`c → -1`）→ 和

/-- **有限和（具体版 `finite_sum_hasRealEntries`）**: 和で閉じた性質に成分がすべて入る `X_1, …, X_{r+1}` の有限和も、
成分はすべてその性質に入る。`r` についての帰納法。 -/
theorem finite_sum_entries_mem {R α β : Type*} [AddCommMonoid R] (S : R → Prop)
    (hadd : ∀ a b, S a → S b → S (a + b)) :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix α β R), (∀ j p q, S (X j p q)) → ∀ p q, S ((∑ j, X j) p q)
  | 0, X, hX => by
    rw [Fin.sum_univ_one]                                                   -- 有限和の定義（`r = 1`）
    exact hX 0
  | r + 1, X, hX => by
    rw [Fin.sum_univ_castSucc X]                                            -- 有限和の定義（帰納法の段）
    exact add_entries_mem S hadd _ _
      (finite_sum_entries_mem S hadd r (fun j => X j.castSucc) fun j => hX j.castSucc)  -- 帰納法の仮定
      (hX (Fin.last _))                                                     -- 和で閉じること

end Ising2D.NecSuf
