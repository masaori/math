/-
# `ℤ → ℝ` の包含写像と、`ι(1) = 1`・非負の整数の和・定数の有限和・2 の冪（**具体版**）

対応する人手証明のラベル: `inclusion_zz_to_rr`、`inclusion_zz_to_rr_of_one`、`inclusion_zz_to_rr_preserves_sum_of_nonnegatives`、
`finite_sum_of_constant_real_number`、`inclusion_zz_to_rr_of_positive_is_at_least_one`、`inclusion_zz_to_rr_of_nonpositive_is_nonpositive`、
`inclusion_zz_to_rr_is_monotone_on_nonnegatives`（`structured-latex/content/000_calculation_formulae_00_09.ts` の
`calc_formulae_definition_inclusion_zz_to_rr`・`calc_formulae_claim_inclusion_zz_to_rr_of_one`・
`calc_formulae_claim_inclusion_zz_to_rr_preserves_sum_of_nonnegatives`・`calc_formulae_claim_finite_sum_of_constant_real_number`・
`calc_formulae_claim_inclusion_zz_to_rr_of_positive_is_at_least_one`・`calc_formulae_claim_inclusion_zz_to_rr_of_nonpositive_is_nonpositive`・
`calc_formulae_claim_inclusion_zz_to_rr_is_monotone_on_nonnegatives`）と
`def_power_of_integer`・`power_of_two_in_integers_is_at_least_one`・`inclusion_zz_to_rr_of_power_of_two`（`structured-latex/content/020_critical_point.ts` の
`critical_definition_power_of_integer`・`critical_claim_power_of_two_in_integers_is_at_least_one`・`critical_claim_inclusion_zz_to_rr_of_power_of_two`）。

**必要十分版**: `Ising2D/NecSuf/NaturalNumberCastIntoSemiring.lean`。具体版をその系として導くのは
`ClaimInclusionOfIntegersIntoRealNumbersFromNecSuf.lean`。

## 人手証明との対応

* 人手の `ι_{ℤ→ℝ}` を、`ℤ_{≥0}` の元では Lean の自然数の実数への埋め込み `(n : ℕ) → (n : ℝ)`（`Nat.cast`）で、`ℤ` 全体では
  `Int.cast` で書く（人手の `ℤ_{≥0}` を Lean の `ℕ` で書くのは、ほかのファイルと同じ）。人手の定義の 3 つの式は
  `inclusion_zz_to_rr_zero`（`Nat.cast_zero`）・`inclusion_zz_to_rr_succ`（`Nat.cast_succ`）・`inclusion_zz_to_rr_neg`（`Int.cast_neg`）で、
  `ℤ_{≥0}` の上で 2 つの書き方が一致することは `inclusion_zz_to_rr_of_natCast`（`Int.cast_natCast`）である。
  `trace_power_upper_bound`・`real_log_of_power` は `ℤ_{≥0}` の元だけを送るので `Nat.cast` の形だけを使い、`limit_of_log_Z_in_N_row` の
  `N_0 ∈ ℤ` は `Int.cast` で送る。
* `inclusion_zz_to_rr_of_one` は人手の 4 行と 1 対 1 の `calc` である。
* `inclusion_zz_to_rr_preserves_sum_of_nonnegatives` は人手と同じく `b` についての帰納法で、`b = 0` の 3 行と帰納法の段の 5 行が人手の行と 1 対 1 の `calc` である。
* `finite_sum_of_constant_real_number_succ` は人手の `m ∈ ℤ_{≥1}` を Lean の `m + 1`（`Fin (m + 1)` の上の和）で書き、`m = 1` の 3 行と
  帰納法の段の 5 行が人手の行と 1 対 1 の `calc` である。`def_finite_sum_of_real_numbers` の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc`
  （`ClaimFiniteSumsOfRealNumbers.lean` と同じ読み替え）。
  有限型の添字の和 `finite_sum_of_constant_real_number_fintype` は、人手の `m ∈ ℤ_{≥1}` に合わせて `1 ≤ card κ` を仮定し、`card κ = m + 1` の `m` を取って
  `κ` に `Fin (m + 1)` の番号を付け、`_succ` を当てる（空の和の場合を通らない）。
* `inclusion_zz_to_rr_of_positive_is_at_least_one` は人手と同じく `n` についての帰納法で、`n = 1` の 2 行と帰納法の段の 4 行が人手の行と 1 対 1 の `calc` である
  （`calc` は `1 ≤ …` の向きに書くので、人手の行を下から上へ並べている）。
* `inclusion_zz_to_rr_of_nonpositive_is_nonpositive` は人手と同じく `n = 0` と `n = -m`（`m ∈ ℤ_{≥1}`）の場合分けで、`n = -m` の段は人手の 4 行に、
  `ι(m)` を `ℕ` の埋め込みの形にする 1 段（`inclusion_zz_to_rr_of_natCast`）を足したもの、`n = 0` の段は人手の 2 行に同じ 1 段を足したものである。
* `inclusion_zz_to_rr_is_monotone_on_nonnegatives` は人手と同じく `k := b − a` を置き、`ι(k) ≥ 0` の 2 つの場合と、`ι(b) ≥ ι(a)` の 4 行の鎖
  （`calc` は `ι(a) ≤ …` の向きに書くので下から上へ）である。
* 人手の `ℤ` の冪 `def_power_of_integer` は、`ℤ_{≥0}` の元では Lean の `ℕ` の冪で、`a^0 := 1` は `Nat.pow_zero`、`a^{m+1} := a^ma` は `Nat.pow_succ` である。
  人手の `2_ℤ := 1_ℤ + 1_ℤ` は `ℕ` の数字の `2` が `1 + 1` であること（`rfl`）である。
* `power_of_two_in_integers_is_at_least_one` は人手と同じく `M` についての帰納法で、`M = 0` の 2 行と帰納法の段の 8 行が人手の行と 1 対 1 の `calc` である。
* `inclusion_zz_to_rr_of_power_of_two` は人手と同じく `M` についての帰納法で、`M = 0` の 3 行と帰納法の段の 10 行が人手の行と 1 対 1 の `calc` である。
  人手の `2_ℝ := 1_ℝ + 1_ℝ` は `one_add_one_eq_two`（Lean の `(2 : ℝ)` は数字の `2`）である。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`inclusion_zz_to_rr`** の `ι(0_ℤ) := 0_ℝ`。 -/
theorem inclusion_zz_to_rr_zero : ((0 : ℕ) : ℝ) = 0 := Nat.cast_zero

/-- **`inclusion_zz_to_rr`** の `ι(n + 1_ℤ) := ι(n) + 1_ℝ`（`n ∈ ℤ_{≥0}`）。 -/
theorem inclusion_zz_to_rr_succ (n : ℕ) : ((n + 1 : ℕ) : ℝ) = (n : ℝ) + 1 := Nat.cast_succ n

/-- **`inclusion_zz_to_rr`** の `ι(-n) := -ι(n)`（`n ∈ ℤ_{≥1}`。証明は `1 ≤ n` を使わない）。 -/
theorem inclusion_zz_to_rr_neg (n : ℤ) (_hn : 1 ≤ n) : ((-n : ℤ) : ℝ) = -((n : ℤ) : ℝ) := Int.cast_neg n

/-- `ℤ_{≥0}` の上で、`ℤ` 全体の `ι`（`Int.cast`）と `ℕ` の埋め込み（`Nat.cast`）は一致する。 -/
theorem inclusion_zz_to_rr_of_natCast (n : ℕ) : (((n : ℤ)) : ℝ) = (n : ℝ) := Int.cast_natCast n

/-- **人手 `inclusion_zz_to_rr_of_one`**: `ι(1_ℤ) = 1_ℝ`。 -/
theorem inclusion_zz_to_rr_of_one : ((1 : ℕ) : ℝ) = 1 :=
  calc ((1 : ℕ) : ℝ) = ((0 + 1 : ℕ) : ℝ) := by rw [Nat.zero_add]           -- `0_ℤ` は `ℤ` の和の単位元
    _ = ((0 : ℕ) : ℝ) + 1 := inclusion_zz_to_rr_succ 0                     -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`（`n → 0`）
    _ = 0 + 1 := by rw [inclusion_zz_to_rr_zero]                           -- `inclusion_zz_to_rr` の `ι(0) := 0`
    _ = 1 := zero_add 1                                                    -- `0_ℝ` は `ℝ` の和の単位元

/-- **人手 `inclusion_zz_to_rr_preserves_sum_of_nonnegatives`**: `a, b ∈ ℤ_{≥0}` なら `ι(a + b) = ι(a) + ι(b)`。`b` についての帰納法。 -/
theorem inclusion_zz_to_rr_preserves_sum_of_nonnegatives (a b : ℕ) :
    ((a + b : ℕ) : ℝ) = (a : ℝ) + (b : ℝ) := by
  induction b with
  | zero =>
    calc ((a + 0 : ℕ) : ℝ) = (a : ℝ) := by rw [Nat.add_zero]              -- `0_ℤ` は `ℤ` の和の単位元
      _ = (a : ℝ) + 0 := (add_zero _).symm                                 -- `0_ℝ` は `ℝ` の和の単位元
      _ = (a : ℝ) + ((0 : ℕ) : ℝ) := by rw [inclusion_zz_to_rr_zero]       -- `inclusion_zz_to_rr` の `ι(0) := 0` を右辺から左辺へ
  | succ b ih =>
    calc ((a + (b + 1) : ℕ) : ℝ) = (((a + b) + 1 : ℕ) : ℝ) := by rw [Nat.add_assoc]  -- `ℤ` の和の結合則
      _ = ((a + b : ℕ) : ℝ) + 1 := inclusion_zz_to_rr_succ (a + b)        -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`（`n → a + b`）
      _ = ((a : ℝ) + (b : ℝ)) + 1 := by rw [ih]                            -- 帰納法の仮定
      _ = (a : ℝ) + ((b : ℝ) + 1) := add_assoc _ _ _                       -- `ℝ` の和の結合則
      _ = (a : ℝ) + ((b + 1 : ℕ) : ℝ) := by rw [inclusion_zz_to_rr_succ b] -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`（`n → b`）を右辺から左辺へ

/-- **人手 `finite_sum_of_constant_real_number`**（`m + 1` 項）: `Σ_{j=1}^{m+1} r = ι(m + 1) r`。`m` についての帰納法。 -/
theorem finite_sum_of_constant_real_number_succ (m : ℕ) (r : ℝ) :
    ∑ _j : Fin (m + 1), r = ((m + 1 : ℕ) : ℝ) * r := by
  induction m with
  | zero =>
    calc ∑ _j : Fin 1, r = r := Fin.sum_univ_one _                         -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{1} r_j := r_1`（`r_1 → r`）
      _ = 1 * r := (one_mul r).symm                                        -- `1_ℝ` は `ℝ` の乗法の単位元
      _ = ((1 : ℕ) : ℝ) * r := by rw [inclusion_zz_to_rr_of_one]           -- `inclusion_zz_to_rr_of_one` を右辺から左辺へ
  | succ m ih =>
    calc ∑ _j : Fin (m + 2), r
        = (∑ _j : Fin (m + 1), r) + r := Fin.sum_univ_castSucc (fun _ => r)  -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}`
      _ = ((m + 1 : ℕ) : ℝ) * r + r := by rw [ih]                          -- 帰納法の仮定
      _ = ((m + 1 : ℕ) : ℝ) * r + 1 * r := by rw [one_mul]                 -- `1_ℝ` は `ℝ` の乗法の単位元
      _ = (((m + 1 : ℕ) : ℝ) + 1) * r := (add_mul _ _ _).symm              -- `ℝ` の分配法則
      _ = ((m + 1 + 1 : ℕ) : ℝ) * r := by rw [inclusion_zz_to_rr_succ (m + 1)]
                                                                           -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`（`n → m`）を右辺から左辺へ

/-- **`finite_sum_of_constant_real_number`**（添字が有限型 `κ` の和。人手の `m ∈ ℤ_{≥1}` に合わせて `1 ≤ card κ` を仮定する）。
人手の和は添字 `1, …, m` の上の和なので、`card κ = m + 1` の `m` を取り、`κ` に `Fin (m + 1)` の番号を付けて
`finite_sum_of_constant_real_number_succ` を当てる（番号を付ける段は mathlib の `Equiv.sum_comp` による）。 -/
theorem finite_sum_of_constant_real_number_fintype {κ : Type*} [Fintype κ] (hκ : 1 ≤ Fintype.card κ) (r : ℝ) :
    ∑ _j : κ, r = (Fintype.card κ : ℝ) * r := by
  obtain ⟨m, hm⟩ : ∃ m : ℕ, Fintype.card κ = m + 1 := ⟨Fintype.card κ - 1, (Nat.sub_add_cancel hκ).symm⟩
  set e : κ ≃ Fin (m + 1) := (Fintype.equivFin κ).trans (finCongr hm)
  calc ∑ _j : κ, r
      = ∑ _j : Fin (m + 1), r := (e.symm.sum_comp (fun _ => r)).symm      -- `κ` に番号を付ける
    _ = ((m + 1 : ℕ) : ℝ) * r := finite_sum_of_constant_real_number_succ m r  -- `finite_sum_of_constant_real_number`（`m → card κ`）
    _ = (Fintype.card κ : ℝ) * r := by rw [hm]                             -- `card κ = m + 1`

/-- **人手 `power_of_two_in_integers_is_at_least_one`**: `M ∈ ℤ_{≥0}` なら `2_ℤ^M ≥ 1`。`M` についての帰納法。 -/
theorem power_of_two_in_integers_is_at_least_one (M : ℕ) : 1 ≤ 2 ^ M := by
  induction M with
  | zero =>
    calc 2 ^ 0 = 1 := Nat.pow_zero 2                                       -- `def_power_of_integer` の `a^0 := 1`（`a → 2_ℤ`）
      _ ≥ 1 := Nat.le_refl 1                                               -- `≤_ℤ` の反射律
  | succ M ih =>
    calc 2 ^ (M + 1) = 2 ^ M * 2 := Nat.pow_succ 2 M                         -- `def_power_of_integer` の `a^{m+1} := a^ma`
      _ = 2 ^ M * (1 + 1) := rfl                                           -- `2_ℤ := 1_ℤ + 1_ℤ`
      _ = 2 ^ M * 1 + 2 ^ M * 1 := Nat.mul_add _ _ _                       -- `ℤ` の分配法則
      _ = 2 ^ M + 2 ^ M := by rw [Nat.mul_one]                             -- `1_ℤ` は乗法の単位元を二か所へ同時に
      _ ≥ 1 + 2 ^ M := Nat.add_le_add_right ih _                           -- 帰納法の仮定 `2^M ≥ 1` の両辺に `2^M` を足す
      _ ≥ 1 + 1 := Nat.add_le_add_left ih _                                -- 帰納法の仮定 `2^M ≥ 1` の両辺に `1` を足す
      _ ≥ 1 + 0 := Nat.add_le_add_left (Nat.zero_le 1) 1                   -- `1 ≥ 0` の両辺に `1` を足す
      _ = 1 := Nat.add_zero 1                                              -- `0_ℤ` は和の単位元

/-- **人手 `inclusion_zz_to_rr_of_power_of_two`**: `M ∈ ℤ_{≥0}` なら `ι(2_ℤ^M) = 2_ℝ^M`。`M` についての帰納法。 -/
theorem inclusion_zz_to_rr_of_power_of_two (M : ℕ) : ((2 ^ M : ℕ) : ℝ) = (2 : ℝ) ^ M := by
  induction M with
  | zero =>
    calc ((2 ^ 0 : ℕ) : ℝ) = ((1 : ℕ) : ℝ) := by rw [Nat.pow_zero]        -- `def_power_of_integer` の `a^0 := 1`（`a → 2_ℤ`）
      _ = 1 := inclusion_zz_to_rr_of_one                                   -- `inclusion_zz_to_rr_of_one`
      _ = (2 : ℝ) ^ 0 := (pow_zero 2).symm                                 -- `def_power_of_real_number` の `a^0 := 1`（`a → 2_ℝ`）を右辺から左辺へ
  | succ M ih =>
    calc ((2 ^ (M + 1) : ℕ) : ℝ) = ((2 ^ M * 2 : ℕ) : ℝ) := by rw [Nat.pow_succ]  -- `def_power_of_integer` の `a^{m+1} := a^ma`
      _ = ((2 ^ M * (1 + 1) : ℕ) : ℝ) := rfl                               -- `2_ℤ := 1_ℤ + 1_ℤ`
      _ = ((2 ^ M * 1 + 2 ^ M * 1 : ℕ) : ℝ) := by rw [Nat.mul_add]         -- `ℤ` の分配法則
      _ = ((2 ^ M + 2 ^ M : ℕ) : ℝ) := by rw [Nat.mul_one]                 -- `1_ℤ` は乗法の単位元を二か所へ同時に
      _ = ((2 ^ M : ℕ) : ℝ) + ((2 ^ M : ℕ) : ℝ) :=
          inclusion_zz_to_rr_preserves_sum_of_nonnegatives _ _             -- `inclusion_zz_to_rr_preserves_sum_of_nonnegatives`（`a, b → 2^M`）
      _ = (2 : ℝ) ^ M + (2 : ℝ) ^ M := by rw [ih]                          -- 帰納法の仮定を二か所へ同時に
      _ = (2 : ℝ) ^ M * 1 + (2 : ℝ) ^ M * 1 := by rw [mul_one]             -- `1_ℝ` は `ℝ` の乗法の単位元を二か所へ同時に
      _ = (2 : ℝ) ^ M * (1 + 1) := (mul_add _ _ _).symm                    -- `ℝ` の分配法則
      _ = (2 : ℝ) ^ M * 2 := by rw [one_add_one_eq_two]                    -- `2_ℝ := 1_ℝ + 1_ℝ`
      _ = (2 : ℝ) ^ (M + 1) := (pow_succ _ _).symm                         -- `def_power_of_real_number` の `a^{m+1} := a^ma`（`a → 2_ℝ`, `m → M`）を右辺から左辺へ

/-- **人手 `inclusion_zz_to_rr_of_positive_is_at_least_one`**: `n ∈ ℤ_{≥1}` なら `ι(n) ≥ 1_ℝ`。`n` についての帰納法。 -/
theorem inclusion_zz_to_rr_of_positive_is_at_least_one (n : ℕ) (hn : 1 ≤ n) : (1 : ℝ) ≤ (n : ℝ) := by
  induction n, hn using Nat.le_induction with
  | base =>
    calc (1 : ℝ) ≤ 1 := le_refl 1                                          -- `≤_ℝ` の反射律
      _ = ((1 : ℕ) : ℝ) := inclusion_zz_to_rr_of_one.symm                  -- `inclusion_zz_to_rr_of_one`
  | succ n _ ih =>
    calc (1 : ℝ) = 1 + 0 := (add_zero 1).symm                              -- `0_ℝ` は `ℝ` の和の単位元
      _ ≤ 1 + 1 := add_le_add (le_refl 1) zero_le_one                         -- `1_ℝ ≥ 0_ℝ` の両辺に `1_ℝ` を足す
      _ ≤ (n : ℝ) + 1 := add_le_add ih (le_refl 1)                           -- 帰納法の仮定 `ι(n) ≥ 1_ℝ` の両辺に `1_ℝ` を足す
      _ = ((n + 1 : ℕ) : ℝ) := (inclusion_zz_to_rr_succ n).symm            -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`

/-- **人手 `inclusion_zz_to_rr_of_nonpositive_is_nonpositive`**: `n ∈ ℤ_{≤0}` なら `ι(n) ≤ 0_ℝ`。
`n = 0` と `n = -m`（`m ∈ ℤ_{≥1}`）の場合分け。`m` は `ℤ_{≥0}` の元なので、`ι(m)` を `ℕ` の埋め込みの形
（`inclusion_zz_to_rr_of_natCast`）に書いてから `inclusion_zz_to_rr_of_positive_is_at_least_one` を当てる。 -/
theorem inclusion_zz_to_rr_of_nonpositive_is_nonpositive (n : ℤ) (hn : n ≤ 0) : ((n : ℤ) : ℝ) ≤ 0 := by
  rcases hn.lt_or_eq with hneg | hzero
  · -- `n = -m`（`m ∈ ℤ_{≥1}`）のとき
    obtain ⟨k, hk⟩ : ∃ k : ℕ, ((k : ℤ)) = -n := ⟨(-n).toNat, Int.toNat_of_nonneg (by omega)⟩
    have hk1 : 1 ≤ k := by omega
    have hm : n = -((k : ℤ)) := by omega
    calc ((n : ℤ) : ℝ) = ((-((k : ℤ)) : ℤ) : ℝ) := by rw [hm]
      _ = -(((k : ℤ)) : ℝ) := inclusion_zz_to_rr_neg _ (by exact_mod_cast hk1)
                                                                           -- `inclusion_zz_to_rr` の `ι(-n) := -ι(n)`（`n → m`）
      _ = -(k : ℝ) := by rw [inclusion_zz_to_rr_of_natCast]                -- `m ∈ ℤ_{≥0}` の `ι(m)` を `ℕ` の埋め込みで
      _ ≤ -1 := neg_le_neg (inclusion_zz_to_rr_of_positive_is_at_least_one k hk1)
                                                                           -- `inclusion_zz_to_rr_of_positive_is_at_least_one`（`n → m`）の両辺の符号を反転する
      _ ≤ -0 := neg_le_neg zero_le_one                                     -- `1_ℝ ≥ 0_ℝ` の両辺の符号を反転する
      _ = 0 := neg_zero                                                    -- `-0_ℝ = 0_ℝ`
  · -- `n = 0` のとき
    calc ((n : ℤ) : ℝ) = (((0 : ℕ) : ℤ) : ℝ) := by rw [hzero]; rfl
      _ = ((0 : ℕ) : ℝ) := inclusion_zz_to_rr_of_natCast 0
      _ = 0 := inclusion_zz_to_rr_zero                                     -- `inclusion_zz_to_rr` の `ι(0) := 0`
      _ ≤ 0 := le_refl 0                                                   -- `≤_ℝ` の反射律

/-- **人手 `inclusion_zz_to_rr_is_monotone_on_nonnegatives`**: `a, b ∈ ℤ_{≥0}`、`a ≤ b` なら `ι(a) ≤ ι(b)`。
`k := b − a ∈ ℤ_{≥0}` を置き、`ι(k) ≥ 0` を `k = 0` と `k ≥ 1` に分けて示してから、`ι(b) = ι(a + k) = ι(a) + ι(k) ≥ ι(a) + 0 = ι(a)`。 -/
theorem inclusion_zz_to_rr_is_monotone_on_nonnegatives (a b : ℕ) (hab : a ≤ b) : (a : ℝ) ≤ (b : ℝ) := by
  set k : ℕ := b - a with hkdef
  have hb : b = a + k := (Nat.add_sub_cancel' hab).symm                    -- `ℤ` の四則
  have hk : (0 : ℝ) ≤ (k : ℝ) := by
    rcases Nat.eq_zero_or_pos k with h0 | h1
    · calc (0 : ℝ) ≤ 0 := le_refl 0                                        -- `≤_ℝ` の反射律
        _ = ((0 : ℕ) : ℝ) := inclusion_zz_to_rr_zero.symm                  -- `inclusion_zz_to_rr` の `ι(0) := 0`
        _ = (k : ℝ) := by rw [h0]
    · calc (0 : ℝ) ≤ 1 := zero_le_one                                      -- `1_ℝ ≥ 0_ℝ`
        _ ≤ (k : ℝ) := inclusion_zz_to_rr_of_positive_is_at_least_one k h1 -- `inclusion_zz_to_rr_of_positive_is_at_least_one`（`n → k`）
  calc (a : ℝ) = (a : ℝ) + 0 := (add_zero _).symm                          -- `0_ℝ` は `ℝ` の和の単位元
    _ ≤ (a : ℝ) + (k : ℝ) := add_le_add (le_refl _) hk                        -- 上の `ι(k) ≥ 0_ℝ` の両辺に `ι(a)` を足す
    _ = ((a + k : ℕ) : ℝ) := (inclusion_zz_to_rr_preserves_sum_of_nonnegatives a k).symm
                                                                           -- `inclusion_zz_to_rr_preserves_sum_of_nonnegatives`（`b → k`）
    _ = (b : ℝ) := by rw [← hb]                                            -- `b = a + k`

end Ising2D
