/-
# 一つの項のほかが 0 の有限和はその項に等しい（具体版）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_finite_sum_with_single_nonzero_term`、ラベル **`finite_sum_with_single_nonzero_term`**）

**必要十分版**: `Ising2D/NecSuf/FiniteSumWithSingleNonzeroTerm.lean` の `NecSuf.finSumLeft_single'`。
具体版をその系として導くのは、同じフォルダの `ClaimFiniteSumWithSingleNonzeroTermFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 1` の 2 行（`def_finite_sum_of_complex_numbers` → `n = 1`） | `finite_sum_with_single_nonzero_term_succ` の `zero` の `calc` の 2 段 |
| 帰納法の段の `n = m+1` の場合の 5 行（和の定義 → `j ≤ m` の項を `0_ℂ` へ → `finite_sum_of_complex_zeros` → 加法の単位元 → `n = m+1`） | `succ` の `n = Fin.last (m + 1)` の場合の `calc` の 5 段 |
| 帰納法の段の `n ≤ m` の場合の 4 行（和の定義 → 帰納法の仮定 → `z_{m+1} = 0_ℂ` → 加法の単位元） | `succ` の `n = Fin.castSucc n'` の場合の `calc` の 4 段 |

- 人手の `m ∈ ℤ_{≥1}` は Lean の `m + 1`、`z_1, …, z_m` は `z : Fin (m + 1) → ℂ`、`n ∈ {1, …, m}` は `n : Fin (m + 1)` である
  （人手の添字 `j` は Lean の `j - 1`）。人手の `m + 1` 番目の項 `z_{m+1}` は Lean の `z (Fin.last (m + 1))`、
  `j ∈ {1, …, m}` の項は `z (Fin.castSucc j)` である。
- `def_finite_sum_of_complex_numbers` の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc`
  （`ClaimRealInclusionPreservesFiniteSum.lean` と同じ読み替え）。
- `finite_sum_of_complex_zeros` は具体版が無く `Finset.sum_const_zero`（`ClaimSigmaZDiagonalAction.lean` と同じ扱い）。
  `complex_numbers_form_a_field` の加法の単位元は `zero_add`・`add_zero`。
- 人手の場合分け「`n = m+1` のとき」「`n ∈ {1, …, m}` のとき」は、Lean では `n = Fin.last (m + 1)` か、
  ある `n' : Fin (m + 1)` で `n = Fin.castSucc n'` か、の場合分けである（`Fin.eq_castSucc_or_eq_last`）。
  後者では人手の `n ∈ {1, …, m}` を `Fin (m + 1)` の元として読んだものが `n'` で、帰納法の仮定を `n'` へ当てる。
- 有限型の添字の和 `finite_sum_with_single_nonzero_term_fintype` は、残る項を指す `n : κ` があるので添字の型は空でなく、
  `card κ = m + 1` の `m` を取って `κ` に `Fin (m + 1)` の番号を付け、`_succ` を当てて番号を外す
  （番号付けの段は mathlib の `Equiv.sum_comp` で、人手のどの行にも当たらない番号付けの埋め合わせである。
  `real_inclusion_of_finite_sum_fintype` と同じ扱い）。人手の主張を引く側で、添字が `{1, …, m}` を並べ替えた集合
  （例えば Step 6 の多重添字 `Fin M → Fin 4`）のときに使う。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **人手 `finite_sum_with_single_nonzero_term`**: `j ≠ n` のすべての `j` で `z_j = 0_ℂ` なら `Σ_{j=1}^{m} z_j = z_n`
（`m ∈ ℤ_{≥1}` は Lean の `m + 1`）。`m` についての帰納法。 -/
theorem finite_sum_with_single_nonzero_term_succ :
    ∀ (m : ℕ) (z : Fin (m + 1) → ℂ) (n : Fin (m + 1)), (∀ j, j ≠ n → z j = 0) → ∑ j, z j = z n
  | 0, z, n, _ =>                                                                  -- 人手の `m = 1`
    calc ∑ j : Fin 1, z j
        = z 0 := Fin.sum_univ_one z                                                -- `def_finite_sum_of_complex_numbers`
      _ = z n := by rw [Fin.fin_one_eq_zero n]                                     -- `n = 1`
  | m + 1, z, n, hz => by                                                          -- 人手の `m → m + 1`
    rcases (Fin.eq_castSucc_or_eq_last n).symm with hn | ⟨n', rfl⟩
    · -- 人手の `n = m + 1` の場合: `j ∈ {1, …, m}` はどれも `j ≠ n`
      calc ∑ j : Fin (m + 2), z j
          = (∑ j : Fin (m + 1), z (Fin.castSucc j)) + z (Fin.last (m + 1)) :=
            Fin.sum_univ_castSucc z                                                -- `def_finite_sum_of_complex_numbers`
        _ = (∑ _j : Fin (m + 1), (0 : ℂ)) + z (Fin.last (m + 1)) := by
            rw [Finset.sum_congr rfl fun j _ => hz _ (hn ▸ (Fin.castSucc_lt_last j).ne)] -- `j ≤ m` のとき `z_j = 0_ℂ` を各項へ同時に適用
        _ = 0 + z (Fin.last (m + 1)) := by rw [Finset.sum_const_zero]              -- `finite_sum_of_complex_zeros`
        _ = z (Fin.last (m + 1)) := zero_add _                                     -- `complex_numbers_form_a_field` の加法の単位元
        _ = z n := by rw [hn]                                                      -- `n = m + 1`
    · -- 人手の `n ∈ {1, …, m}` の場合: `m + 1 ≠ n` なので `z_{m+1} = 0_ℂ`
      have hlast : z (Fin.last (m + 1)) = 0 := hz _ (Fin.castSucc_lt_last n').ne'
      calc ∑ j : Fin (m + 2), z j
          = (∑ j : Fin (m + 1), z (Fin.castSucc j)) + z (Fin.last (m + 1)) :=
            Fin.sum_univ_castSucc z                                                -- `def_finite_sum_of_complex_numbers`
        _ = z (Fin.castSucc n') + z (Fin.last (m + 1)) := by
            rw [finite_sum_with_single_nonzero_term_succ m (fun j => z (Fin.castSucc j)) n'
              (fun j hj => hz _ (fun h => hj (Fin.castSucc_injective _ h)))]      -- 帰納法の仮定を `z_1, …, z_m` と `n` へ
        _ = z (Fin.castSucc n') + 0 := by rw [hlast]                               -- `z_{m+1} = 0_ℂ`
        _ = z (Fin.castSucc n') := add_zero _                                      -- `complex_numbers_form_a_field` の加法の単位元

/-- **人手 `finite_sum_with_single_nonzero_term`**（添字が有限型 `κ` の和）。
`κ` に固定した番号を付けて `Fin (m + 1)` の上の和へ移し、`finite_sum_with_single_nonzero_term_succ` を当てて番号を外す。 -/
theorem finite_sum_with_single_nonzero_term_fintype {κ : Type*} [Fintype κ] (z : κ → ℂ) (n : κ)
    (hz : ∀ j, j ≠ n → z j = 0) : ∑ j, z j = z n := by
  haveI : Nonempty κ := ⟨n⟩
  obtain ⟨m, hm⟩ : ∃ m, Fintype.card κ = m + 1 :=
    Nat.exists_eq_succ_of_ne_zero Fintype.card_ne_zero                            -- `n ∈ κ` なので `card κ ≥ 1`
  let e : κ ≃ Fin (m + 1) := (Fintype.equivFin κ).trans (finCongr hm)
  calc ∑ j, z j
      = ∑ i : Fin (m + 1), z (e.symm i) := (e.symm.sum_comp z).symm               -- `κ` に番号を付ける
    _ = z (e.symm (e n)) :=
        finite_sum_with_single_nonzero_term_succ m (fun i => z (e.symm i)) (e n)
          (fun i hi => hz _ (fun h => hi (by rw [← h, Equiv.apply_symm_apply])))  -- `finite_sum_with_single_nonzero_term`（`m → card κ`、`n → e(n)`）
    _ = z n := by rw [Equiv.symm_apply_apply]                                      -- 番号を外す

end Ising2D
