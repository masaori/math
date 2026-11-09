/-
# 実数の有限和の包含は包含の有限和に等しい（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_real_inclusion_preserves_finite_sum`、ラベル **`real_inclusion_preserves_finite_sum`**）

**必要十分版**: `Ising2D/NecSuf/AdditiveMapPreservesFiniteSum.lean` の `NecSuf.map_finSumLeft_of_map_add'`。
具体版をその系として導くのは、同じフォルダの `ClaimRealInclusionPreservesFiniteSumFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 1` の 2 行（`def_finite_sum_of_complex_numbers` → `def_finite_sum_of_real_numbers`） | `real_inclusion_of_finite_sum_succ` の `zero` の `calc` の 2 段 |
| 帰納法の段の 7 行（ℂ の和の定義 → 帰納法の仮定 → `inclusion_rr_to_cc` を各項へ → `definition_of_cc` の和 → ℝ の和の定義 → ℝ で `0 + 0 = 0` → `inclusion_rr_to_cc`） | `real_inclusion_of_finite_sum_succ` の `succ` の `calc` の 7 段 |

- 人手の `m ∈ ℤ_{≥1}` は Lean の `m + 1`、`r_1, …, r_m` は `r : Fin (m + 1) → ℝ` である。
  `def_finite_sum_of_real_numbers`・`def_finite_sum_of_complex_numbers` の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc`
  （`ClaimInclusionOfIntegersIntoRealNumbers.lean` の `finite_sum_of_constant_real_number_succ` と同じ読み替え）。
- 人手の `r_ℂ := (r, 0)` は Lean の `(r : ℂ)`（実部 `r`、虚部 `0` の構造体）で、`inclusion_rr_to_cc` の 2 段は `rfl`、
  `definition_of_cc` の和の段も mathlib の ℂ の和の定義と同じ式なので `rfl` である（`real_inclusion_add` と同じ）。
- 有限型の添字の和 `real_inclusion_of_finite_sum_fintype` は、人手の `m ∈ ℤ_{≥1}` に合わせて添字の型が空でないことを仮定し、
  `card κ = m + 1` の `m` を取って `κ` に `Fin (m + 1)` の番号を付け、`_succ` を当てて番号を外す
  （番号付けの 2 段は mathlib の `Equiv.sum_comp` で、人手のどの行にも当たらない番号付けの埋め合わせである。
  `finite_sum_of_constant_real_number_fintype` と同じ扱い）。
- `real_inclusion_of_finite_sum_fintype_or_empty` は、添字の型が空かもしれない Lean の主張（人手は `m, n ∈ ℤ_{≥1}` の行列・ベクトルを扱うが、
  Lean の主張は任意の有限型を添字に取る）から引くためのもので、空でなければ `_fintype` を当てる。空の場合は人手の主張に無い Lean だけの場合で、
  両辺の和はどちらも空の和 `0` である（mathlib の `Fintype.sum_empty`、`0_ℂ = (0_ℝ)_ℂ` は `Complex.ofReal_zero`）。
- `real_inclusion_of_finite_sum_finset` は、有限集合 `S ⊆ κ` の上の和（例えば `Σ_{m=1}^{M_col-1}` を `Fin M` の部分集合の上の和で書いたもの）から引くためのもので、
  `S` の元の型の上の和へ移して（mathlib の `Finset.sum_coe_sort`。人手のどの行にも当たらない書き方の埋め合わせ）`_or_empty` を当てる。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **人手 `real_inclusion_preserves_finite_sum`**: `Σ_{j=1}^{m} (r_j)_ℂ = (Σ_{j=1}^{m} r_j)_ℂ`（`m ∈ ℤ_{≥1}` は Lean の `m + 1`）。
`m` についての帰納法。 -/
theorem real_inclusion_of_finite_sum_succ (m : ℕ) (r : Fin (m + 1) → ℝ) :
    ∑ j, ((r j : ℝ) : ℂ) = ((∑ j, r j : ℝ) : ℂ) := by
  induction m with
  | zero =>                                                                        -- 人手の `m = 1`
    calc ∑ j : Fin 1, ((r j : ℝ) : ℂ)
        = ((r 0 : ℝ) : ℂ) := Fin.sum_univ_one _                                    -- `def_finite_sum_of_complex_numbers`
      _ = ((∑ j : Fin 1, r j : ℝ) : ℂ) := by rw [Fin.sum_univ_one]                  -- `def_finite_sum_of_real_numbers`
  | succ m ih =>                                                                   -- 人手の `m → m + 1`
    calc ∑ j : Fin (m + 2), ((r j : ℝ) : ℂ)
        = (∑ j : Fin (m + 1), ((r j.castSucc : ℝ) : ℂ)) + ((r (Fin.last (m + 1)) : ℝ) : ℂ) :=
          Fin.sum_univ_castSucc _                                                  -- `def_finite_sum_of_complex_numbers`
      _ = ((∑ j : Fin (m + 1), r j.castSucc : ℝ) : ℂ) + ((r (Fin.last (m + 1)) : ℝ) : ℂ) := by
          rw [ih (fun j => r j.castSucc)]                                          -- 帰納法の仮定
      _ = (⟨∑ j : Fin (m + 1), r j.castSucc, 0⟩ : ℂ) + ⟨r (Fin.last (m + 1)), 0⟩ := rfl -- `inclusion_rr_to_cc` を各項へ
      _ = ⟨(∑ j : Fin (m + 1), r j.castSucc) + r (Fin.last (m + 1)), 0 + 0⟩ := rfl -- `definition_of_cc` の和
      _ = ⟨∑ j : Fin (m + 2), r j, 0 + 0⟩ := by rw [Fin.sum_univ_castSucc r]         -- `def_finite_sum_of_real_numbers`
      _ = ⟨∑ j : Fin (m + 2), r j, 0⟩ := Complex.ext rfl (add_zero (0 : ℝ))         -- ℝ で `0 + 0 = 0`
      _ = ((∑ j : Fin (m + 2), r j : ℝ) : ℂ) := rfl                                -- `inclusion_rr_to_cc`

/-- **人手 `real_inclusion_preserves_finite_sum`**（添字が空でない有限型 `κ` の和）。
`κ` に固定した番号を付けて `Fin (m + 1)` の上の和へ移し、`real_inclusion_of_finite_sum_succ` を当てて番号を外す。 -/
theorem real_inclusion_of_finite_sum_fintype {κ : Type*} [Fintype κ] [Nonempty κ] (r : κ → ℝ) :
    ∑ j, ((r j : ℝ) : ℂ) = ((∑ j, r j : ℝ) : ℂ) := by
  obtain ⟨m, hm⟩ : ∃ m, Fintype.card κ = m + 1 :=
    Nat.exists_eq_succ_of_ne_zero Fintype.card_ne_zero                            -- `κ` は空でないので `card κ ≥ 1`
  let e : κ ≃ Fin (m + 1) := (Fintype.equivFin κ).trans (finCongr hm)
  calc ∑ j, ((r j : ℝ) : ℂ)
      = ∑ i : Fin (m + 1), ((r (e.symm i) : ℝ) : ℂ) :=
        (e.symm.sum_comp (fun j => ((r j : ℝ) : ℂ))).symm                          -- `κ` に番号を付ける
    _ = ((∑ i : Fin (m + 1), r (e.symm i) : ℝ) : ℂ) :=
        real_inclusion_of_finite_sum_succ m (fun i => r (e.symm i))               -- `real_inclusion_preserves_finite_sum`（`m → card κ`）
    _ = ((∑ j, r j : ℝ) : ℂ) := by rw [e.symm.sum_comp r]                         -- 番号を外す

/-- 添字の型が空かもしれない有限型 `κ` の和。空でなければ `real_inclusion_of_finite_sum_fintype`（人手 `real_inclusion_preserves_finite_sum`）、
空なら両辺が空の和 `0`（人手の主張に無い Lean だけの場合）。 -/
theorem real_inclusion_of_finite_sum_fintype_or_empty {κ : Type*} [Fintype κ] (r : κ → ℝ) :
    ∑ j, ((r j : ℝ) : ℂ) = ((∑ j, r j : ℝ) : ℂ) := by
  cases isEmpty_or_nonempty κ with
  | inl _ =>                                                                      -- 添字の型が空（Lean だけの場合）
    calc ∑ j, ((r j : ℝ) : ℂ)
        = 0 := Fintype.sum_empty _                                                -- 空の和
      _ = ((0 : ℝ) : ℂ) := Complex.ofReal_zero.symm                               -- `0_ℂ = (0_ℝ)_ℂ`
      _ = ((∑ j, r j : ℝ) : ℂ) := by rw [Fintype.sum_empty]                       -- 空の和を右辺から左辺へ
  | inr _ => exact real_inclusion_of_finite_sum_fintype r                         -- `real_inclusion_preserves_finite_sum`

/-- 有限集合 `S ⊆ κ` の上の和。`S` の元の型の上の和へ移して `real_inclusion_of_finite_sum_fintype_or_empty` を当てる。 -/
theorem real_inclusion_of_finite_sum_finset {κ : Type*} (S : Finset κ) (r : κ → ℝ) :
    ∑ j ∈ S, ((r j : ℝ) : ℂ) = ((∑ j ∈ S, r j : ℝ) : ℂ) := by
  calc ∑ j ∈ S, ((r j : ℝ) : ℂ)
      = ∑ j : S, ((r j : ℝ) : ℂ) := (Finset.sum_coe_sort S _).symm               -- `S` の元の型の上の和へ移す
    _ = ((∑ j : S, r j : ℝ) : ℂ) :=
        real_inclusion_of_finite_sum_fintype_or_empty (fun j : S => r j)          -- `real_inclusion_preserves_finite_sum`
    _ = ((∑ j ∈ S, r j : ℝ) : ℂ) := by rw [Finset.sum_coe_sort S r]               -- 和を `S` の上の和へ戻す

end Ising2D
