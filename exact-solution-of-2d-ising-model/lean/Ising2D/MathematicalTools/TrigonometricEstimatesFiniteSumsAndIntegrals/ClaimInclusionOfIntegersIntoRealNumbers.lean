/-
# `ℤ → ℝ` の包含写像と、`ι(1) = 1`・非負の整数の和・`ℤ` 全体の後者と和と積と差と符号反転・定数の有限和・2 の冪（**具体版**）

対応する人手証明のラベル: `inclusion_zz_to_rr`、`inclusion_zz_to_rr_of_one`、`inclusion_zz_to_rr_preserves_sum_of_nonnegatives`、
`finite_sum_of_constant_real_number`、`inclusion_zz_to_rr_of_positive_is_at_least_one`、`inclusion_zz_to_rr_of_nonpositive_is_nonpositive`、
`inclusion_zz_to_rr_is_monotone_on_nonnegatives`、`inclusion_zz_to_rr_of_successor`、`inclusion_zz_to_rr_preserves_sum`、`inclusion_zz_to_rr_preserves_product`、`inclusion_zz_to_rr_preserves_difference`、`inclusion_zz_to_rr_preserves_negation`（`structured-latex/content/000_calculation_formulae_00_09.ts` の
`calc_formulae_definition_inclusion_zz_to_rr`・`calc_formulae_claim_inclusion_zz_to_rr_of_one`・
`calc_formulae_claim_inclusion_zz_to_rr_preserves_sum_of_nonnegatives`・`calc_formulae_claim_finite_sum_of_constant_real_number`・
`calc_formulae_claim_inclusion_zz_to_rr_of_positive_is_at_least_one`・`calc_formulae_claim_inclusion_zz_to_rr_of_nonpositive_is_nonpositive`・
`calc_formulae_claim_inclusion_zz_to_rr_is_monotone_on_nonnegatives`・`calc_formulae_claim_inclusion_zz_to_rr_of_successor`・
`calc_formulae_claim_inclusion_zz_to_rr_preserves_sum`・`calc_formulae_claim_inclusion_zz_to_rr_preserves_product`・
`calc_formulae_claim_inclusion_zz_to_rr_preserves_difference`・`calc_formulae_claim_inclusion_zz_to_rr_preserves_negation`）と
`def_power_of_integer`・`power_of_two_in_integers_is_at_least_one`・`inclusion_zz_to_rr_of_power_of_two`（`structured-latex/content/020_critical_point.ts` の
`critical_definition_power_of_integer`・`critical_claim_power_of_two_in_integers_is_at_least_one`・`critical_claim_inclusion_zz_to_rr_of_power_of_two`）。

**必要十分版**: `Ising2D/NecSuf/NaturalNumberCastIntoSemiring.lean`。具体版をその系として導くのは
`ClaimInclusionOfIntegersIntoRealNumbersFromNecSuf.lean`。

## 人手証明との対応

* 人手の `ι_{ℤ→ℝ}` を、`ℤ_{≥0}` の元では Lean の自然数の実数への埋め込み `(n : ℕ) → (n : ℝ)`（`Nat.cast`）で、`ℤ` 全体では
  `Int.cast` で書く（人手の `ℤ_{≥0}` を Lean の `ℕ` で書くのは、ほかのファイルと同じ）。人手の定義の 3 つの式は
  `inclusion_zz_to_rr_zero`（`Nat.cast_zero`）・`inclusion_zz_to_rr_succ`（`Nat.cast_succ`）・`inclusion_zz_to_rr_neg`（`Int.cast_neg`）で、
  `ℤ_{≥0}` の上で 2 つの書き方が一致することは `inclusion_zz_to_rr_of_natCast`（`Int.cast_natCast`）である。
  `ι(0) := 0` を `Int.cast` の形で書いたものは `inclusion_zz_to_rr_zero_intCast`（`inclusion_zz_to_rr_of_natCast` で `Nat.cast` の形へ移して当てる）。
  `trace_power_upper_bound`・`real_log_of_power` は `ℤ_{≥0}` の元だけを送るので `Nat.cast` の形だけを使い、`limit_of_log_Z_in_N_row` の
  `N_0 ∈ ℤ` は `Int.cast` で送る。
* `inclusion_zz_to_rr_of_one` は人手の 4 行と 1 対 1 の `calc` である。`ℤ` の元を送る主張が引く `Int.cast` の形は
  `inclusion_zz_to_rr_of_one_intCast`（`inclusion_zz_to_rr_of_natCast` で `Nat.cast` の形へ移してから `inclusion_zz_to_rr_of_one` を当てる）。
* `inclusion_zz_to_rr_preserves_sum_of_nonnegatives` は人手と同じく `b` についての帰納法で、`b = 0` の 3 行と帰納法の段の 5 行が人手の行と 1 対 1 の `calc` である。
  `ℤ` の元を送る主張が引く `Int.cast` の形は `inclusion_zz_to_rr_preserves_sum_of_nonnegatives_intCast`（`inclusion_zz_to_rr_of_natCast` で
  `Nat.cast` の形へ移して当てる）。
* `inclusion_zz_to_rr_of_successor` は人手と同じく `n ∈ ℤ_{≥0}`・`n = -1_ℤ`・`n = -(p + 1_ℤ)`（`p ∈ ℤ_{≥1}`）の場合分けで、`n = -1_ℤ` の 5 行と
  `n = -(p + 1_ℤ)` の 8 行が人手の行と 1 対 1 の `calc` である。人手の定義の `ι(n + 1) := ι(n) + 1`（`n ∈ ℤ_{≥0}`）の `Int.cast` の形は
  `inclusion_zz_to_rr_succ_intCast`（`inclusion_zz_to_rr_of_natCast` で `Nat.cast` の形へ移して当てる）。
* `inclusion_zz_to_rr_preserves_sum` は人手と同じく `a` を固定した `b` についての 2 方向の帰納法（`Int.induction_on`）で、`b = 0` の 3 行、
  `b → b + 1` の 5 行、`b → b − 1` の 12 行が人手の行と 1 対 1 の `calc` である。`ℤ` の四則の段は `omega` で閉じる。
* `inclusion_zz_to_rr_preserves_product` は人手と同じく `a` を固定した `b` についての 2 方向の帰納法（`Int.induction_on`）で、`b = 0` の 4 行、
  `b → b + 1` の 7 行、`b → b − 1` の 15 行が人手の行と 1 対 1 の `calc` である。`b = 0` の `x · 0 = 0` は人手と同じく `real_times_zero_is_zero`。
  `ℤ` の分配律・積の単位元・四則の段は `mul_sub`・`mul_one`・`sub_add_cancel`・`omega`（`b = (b − 1) + 1`）で閉じる。
* `inclusion_zz_to_rr_preserves_difference` は人手の 9 行と 1 対 1 の `calc` である。`def_int_difference` は `int_sub_eq_add_neg`、
  `ℤ` の和の結合律・加法逆元 `(−x) + x = 0`・和の単位元は `add_assoc`・`neg_add_cancel`・`add_zero`、
  `def_real_difference`（`y − z := y + (−z)`）は `sub_eq_add_neg` で当てる。
* `inclusion_zz_to_rr_preserves_negation` は人手の 5 行と 1 対 1 の `calc` である。`ℤ` の四則 `-x = 0 - x` の段は `zero_sub`、
  `ι(0_ℤ) := 0_ℝ` は `inclusion_zz_to_rr_zero_intCast`、`def_real_difference` は `sub_eq_add_neg`、`0_ℝ` が和の単位元であることは `zero_add` で当てる。
* `finite_sum_of_constant_real_number_succ` は人手の `m ∈ ℤ_{≥1}` を Lean の `m + 1`（`Fin (m + 1)` の上の和）で書き、`m = 1` の 3 行と
  帰納法の段の 5 行が人手の行と 1 対 1 の `calc` である。`def_finite_sum_of_real_numbers` の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc`
  （`ClaimFiniteSumsOfRealNumbers.lean` と同じ読み替え）。
  有限型の添字の和 `finite_sum_of_constant_real_number_fintype` は、人手の `m ∈ ℤ_{≥1}` に合わせて `1 ≤ card κ` を仮定し、`card κ = m + 1` の `m` を取って
  `κ` に `Fin (m + 1)` の番号を付け、`_succ` を当てる（空の和の場合を通らない）。
* `inclusion_zz_to_rr_of_positive_is_at_least_one` は人手と同じく `n` についての帰納法で、`n = 1` の 2 行と帰納法の段の 4 行が人手の行と 1 対 1 の `calc` である
  （`calc` は `1 ≤ …` の向きに書くので、人手の行を下から上へ並べている）。
* `inclusion_zz_to_rr_of_nonpositive_is_nonpositive` は人手と同じく `n = 0` と `n = -m`（`m ∈ ℤ_{≥1}`）の場合分けで、`n = -m` の段は人手の 4 行に、
  `ι(m)` を `ℕ` の埋め込みの形にする 1 段（`inclusion_zz_to_rr_of_natCast`）を足したもの、`n = 0` の段は人手の 2 行に同じ 1 段を足したものである。
  `n = -m` の鎖の最後の段 `-0_ℝ = 0_ℝ` は人手と同じく `real_negation_of_zero_is_zero`（mathlib の `neg_zero` は使わない）。
* `inclusion_zz_to_rr_is_monotone_on_nonnegatives` は人手と同じく `k := b − a` を置き、`ι(k) ≥ 0` の 2 つの場合と、`ι(b) ≥ ι(a)` の 4 行の鎖
  （`calc` は `ι(a) ≤ …` の向きに書くので下から上へ）である。
* 人手の `ℤ` の冪 `def_power_of_integer` は、`ℤ_{≥0}` の元では Lean の `ℕ` の冪で、`a^0 := 1` は `Nat.pow_zero`、`a^{m+1} := a^ma` は `Nat.pow_succ` である。
  人手の `2_ℤ := 1_ℤ + 1_ℤ` は `ℕ` の数字の `2` が `1 + 1` であること（`rfl`）である。
* `power_of_two_in_integers_is_at_least_one` は人手と同じく `M` についての帰納法で、`M = 0` の 2 行と帰納法の段の 8 行が人手の行と 1 対 1 の `calc` である。
* `inclusion_zz_to_rr_of_power_of_two` は人手と同じく `M` についての帰納法で、`M = 0` の 3 行と帰納法の段の 10 行が人手の行と 1 対 1 の `calc` である。
  人手の `2_ℝ := 1_ℝ + 1_ℝ` は `def_real_two` の具体版 `real_two_eq_one_add_one`（Lean の `(2 : ℝ)` は数字の `2`）で読む。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealTwo
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionIntegerDifference
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Real.Basic
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfZeroIsZero
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfSumIsSumOfNegations
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTimesZeroIsZero

namespace Ising2D

/-- **`inclusion_zz_to_rr`** の `ι(0_ℤ) := 0_ℝ`。 -/
theorem inclusion_zz_to_rr_zero : ((0 : ℕ) : ℝ) = 0 := Nat.cast_zero

/-- **`inclusion_zz_to_rr`** の `ι(n + 1_ℤ) := ι(n) + 1_ℝ`（`n ∈ ℤ_{≥0}`）。 -/
theorem inclusion_zz_to_rr_succ (n : ℕ) : ((n + 1 : ℕ) : ℝ) = (n : ℝ) + 1 := Nat.cast_succ n

/-- **`inclusion_zz_to_rr`** の `ι(-n) := -ι(n)`（`n ∈ ℤ_{≥1}`。証明は `1 ≤ n` を使わない）。 -/
theorem inclusion_zz_to_rr_neg (n : ℤ) (_hn : 1 ≤ n) : ((-n : ℤ) : ℝ) = -((n : ℤ) : ℝ) := Int.cast_neg n

/-- `ℤ_{≥0}` の上で、`ℤ` 全体の `ι`（`Int.cast`）と `ℕ` の埋め込み（`Nat.cast`）は一致する。 -/
theorem inclusion_zz_to_rr_of_natCast (n : ℕ) : (((n : ℤ)) : ℝ) = (n : ℝ) := Int.cast_natCast n

/-- **`inclusion_zz_to_rr`** の `ι(0_ℤ) := 0_ℝ` を `ℤ` 全体の `ι`（`Int.cast`）の形で書いたもの。
`0_ℤ ∈ ℤ_{≥0}` なので、2 つの書き方の一致 `inclusion_zz_to_rr_of_natCast` で `Nat.cast` の形 `inclusion_zz_to_rr_zero` へ移す。
`ℤ` の元を `ℝ` へ送る主張（`periodicity_of_check_fermi` の準備の第二など）が引く。 -/
theorem inclusion_zz_to_rr_zero_intCast : ((0 : ℤ) : ℝ) = 0 :=
  calc ((0 : ℤ) : ℝ) = (((0 : ℕ) : ℤ) : ℝ) := rfl                          -- `0_ℤ` は `ℤ_{≥0}` の元（Lean では `ℕ` の `0` の像と定義で一致）
    _ = ((0 : ℕ) : ℝ) := inclusion_zz_to_rr_of_natCast 0                   -- `ℤ_{≥0}` の上で `Int.cast` と `Nat.cast` は一致する
    _ = 0 := inclusion_zz_to_rr_zero                                       -- `inclusion_zz_to_rr` の `ι(0) := 0`

/-- **人手 `inclusion_zz_to_rr_of_one`**: `ι(1_ℤ) = 1_ℝ`。 -/
theorem inclusion_zz_to_rr_of_one : ((1 : ℕ) : ℝ) = 1 :=
  calc ((1 : ℕ) : ℝ) = ((0 + 1 : ℕ) : ℝ) := by rw [Nat.zero_add]           -- `0_ℤ` は `ℤ` の和の単位元
    _ = ((0 : ℕ) : ℝ) + 1 := inclusion_zz_to_rr_succ 0                     -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`（`n → 0`）
    _ = 0 + 1 := by rw [inclusion_zz_to_rr_zero]                           -- `inclusion_zz_to_rr` の `ι(0) := 0`
    _ = 1 := zero_add 1                                                    -- `0_ℝ` は `ℝ` の和の単位元

/-- **人手 `inclusion_zz_to_rr_of_one`** を `ℤ` 全体の `ι`（`Int.cast`）の形で書いたもの: `ι(1_ℤ) = 1_ℝ`。
`1_ℤ ∈ ℤ_{≥0}` なので、2 つの書き方の一致 `inclusion_zz_to_rr_of_natCast` で `Nat.cast` の形 `inclusion_zz_to_rr_of_one` へ移す。
`ℤ` の元を `ℝ` へ送る主張（`periodicity_of_check_fermi` など）が引く。 -/
theorem inclusion_zz_to_rr_of_one_intCast : ((1 : ℤ) : ℝ) = 1 :=
  calc ((1 : ℤ) : ℝ) = (((1 : ℕ) : ℤ) : ℝ) := rfl                          -- `1_ℤ` は `ℤ_{≥0}` の元（Lean では `ℕ` の `1` の像と定義で一致）
    _ = ((1 : ℕ) : ℝ) := inclusion_zz_to_rr_of_natCast 1                   -- `ℤ_{≥0}` の上で `Int.cast` と `Nat.cast` は一致する
    _ = 1 := inclusion_zz_to_rr_of_one                                     -- `inclusion_zz_to_rr_of_one`

/-- **人手 `inclusion_zz_to_rr_preserves_sum_of_nonnegatives`**: `a, b ∈ ℤ_{≥0}` なら `ι(a + b) = ι(a) + ι(b)`。`b` についての帰納法。 -/
theorem inclusion_zz_to_rr_preserves_sum_of_nonnegatives (a b : ℕ) :
    ((a + b : ℕ) : ℝ) = (a : ℝ) + (b : ℝ) := by
  induction b with
  | zero =>
    calc ((a + 0 : ℕ) : ℝ) = (a : ℝ) := by rw [Nat.add_zero]              -- `0_ℤ` は `ℤ` の和の単位元
      _ = (a : ℝ) + 0 := (add_zero _).symm                                 -- `0_ℝ` は `ℝ` の和の単位元
      _ = (a : ℝ) + ((0 : ℕ) : ℝ) := by rw [inclusion_zz_to_rr_zero]       -- `inclusion_zz_to_rr` の `ι(0) := 0` を右辺から左辺へ
  | succ b ih =>
    calc ((a + (b + 1) : ℕ) : ℝ) = (((a + b) + 1 : ℕ) : ℝ) := by rw [Nat.add_assoc]  -- `ℤ` の和の結合律
      _ = ((a + b : ℕ) : ℝ) + 1 := inclusion_zz_to_rr_succ (a + b)        -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`（`n → a + b`）
      _ = ((a : ℝ) + (b : ℝ)) + 1 := by rw [ih]                            -- 帰納法の仮定
      _ = (a : ℝ) + ((b : ℝ) + 1) := add_assoc _ _ _                       -- `ℝ` の和の結合律
      _ = (a : ℝ) + ((b + 1 : ℕ) : ℝ) := by rw [inclusion_zz_to_rr_succ b] -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`（`n → b`）を右辺から左辺へ

/-- **人手 `inclusion_zz_to_rr_preserves_sum_of_nonnegatives`** を `ℤ` 全体の `ι`（`Int.cast`）の形で書いたもの:
`a, b ∈ ℤ_{≥0}` なら `ι(a + b) = ι(a) + ι(b)`。`a, b, a + b ∈ ℤ_{≥0}` なので、2 つの書き方の一致 `inclusion_zz_to_rr_of_natCast` で
`Nat.cast` の形へ移してから `inclusion_zz_to_rr_preserves_sum_of_nonnegatives` を当て、同じ一致で戻す。
`ℤ` の元を `ℝ` へ送る主張（`conjugate_index_of_check_Z_Y` など）が引く。 -/
theorem inclusion_zz_to_rr_preserves_sum_of_nonnegatives_intCast (a b : ℕ) :
    (((a : ℤ) + (b : ℤ) : ℤ) : ℝ) = ((a : ℤ) : ℝ) + ((b : ℤ) : ℝ) :=
  calc (((a : ℤ) + (b : ℤ) : ℤ) : ℝ) = (((a + b : ℕ) : ℤ) : ℝ) := rfl     -- `ℤ_{≥0}` の和（Lean では `ℕ` の和の像と定義で一致）
    _ = ((a + b : ℕ) : ℝ) := inclusion_zz_to_rr_of_natCast (a + b)         -- `ℤ_{≥0}` の上で `Int.cast` と `Nat.cast` は一致する
    _ = (a : ℝ) + (b : ℝ) := inclusion_zz_to_rr_preserves_sum_of_nonnegatives a b
                                                                           -- `inclusion_zz_to_rr_preserves_sum_of_nonnegatives`
    _ = ((a : ℤ) : ℝ) + ((b : ℤ) : ℝ) := by
        rw [inclusion_zz_to_rr_of_natCast a, inclusion_zz_to_rr_of_natCast b]
                                                                           -- 同じ一致を右辺から左辺へ二か所へ同時に

/-- **`inclusion_zz_to_rr`** の `ι(n + 1_ℤ) := ι(n) + 1_ℝ`（`n ∈ ℤ_{≥0}`）を `ℤ` 全体の `ι`（`Int.cast`）の形で書いたもの。
`n, n + 1 ∈ ℤ_{≥0}` なので、2 つの書き方の一致 `inclusion_zz_to_rr_of_natCast` で `Nat.cast` の形 `inclusion_zz_to_rr_succ` へ移し、同じ一致で戻す。
`inclusion_zz_to_rr_of_successor` の `n ∈ ℤ_{≥0}` の場合と `n = -(p + 1)` の場合が引く。 -/
theorem inclusion_zz_to_rr_succ_intCast (k : ℕ) : (((k : ℤ) + 1 : ℤ) : ℝ) = ((k : ℤ) : ℝ) + 1 :=
  calc (((k : ℤ) + 1 : ℤ) : ℝ) = (((k + 1 : ℕ) : ℤ) : ℝ) := rfl            -- `ℤ_{≥0}` の和（Lean では `ℕ` の和の像と定義で一致）
    _ = ((k + 1 : ℕ) : ℝ) := inclusion_zz_to_rr_of_natCast (k + 1)         -- `ℤ_{≥0}` の上で `Int.cast` と `Nat.cast` は一致する
    _ = (k : ℝ) + 1 := inclusion_zz_to_rr_succ k                           -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`（`n → k`）
    _ = ((k : ℤ) : ℝ) + 1 := by rw [inclusion_zz_to_rr_of_natCast k]       -- 同じ一致を右辺から左辺へ

/-- **人手 `inclusion_zz_to_rr_of_successor`**: `n ∈ ℤ` なら `ι(n + 1_ℤ) = ι(n) + 1_ℝ`。
人手と同じく `n ∈ ℤ_{≥0}`・`n = -1_ℤ`・`n = -(p + 1_ℤ)`（`p ∈ ℤ_{≥1}`）の 3 つの場合に分ける。
`n ∈ ℤ_{≥0}` の場合は人手の 1 行（定義）で、Lean では `Int.cast` の形の `inclusion_zz_to_rr_succ_intCast` である。
`n = -1_ℤ` の場合は人手の 5 行、`n = -(p + 1_ℤ)` の場合は人手の 8 行と 1 対 1 の `calc` である
（人手の `p ∈ ℤ_{≥1} ⊂ ℤ_{≥0}` を Lean では `ℕ` の元 `q`（`1 ≤ q`）の像 `(q : ℤ)` で書く）。 -/
theorem inclusion_zz_to_rr_of_successor (n : ℤ) : ((n + 1 : ℤ) : ℝ) = ((n : ℤ) : ℝ) + 1 := by
  rcases le_or_gt 0 n with hn | hn
  · -- `n ∈ ℤ_{≥0}` のとき
    obtain ⟨k, rfl⟩ := Int.eq_ofNat_of_zero_le hn
    exact inclusion_zz_to_rr_succ_intCast k                                -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`
  · obtain ⟨m, hm, rfl⟩ : ∃ m : ℤ, 1 ≤ m ∧ n = -m := ⟨-n, by omega, by omega⟩
    rcases eq_or_lt_of_le hm with h1 | h2
    · -- `n = -1_ℤ` のとき
      subst h1
      calc ((-(1 : ℤ) + 1 : ℤ) : ℝ) = ((0 : ℤ) : ℝ) := by rw [neg_add_cancel]  -- `ℤ` の加法逆元 `(-1) + 1 = 0`
        _ = 0 := inclusion_zz_to_rr_zero_intCast                           -- `inclusion_zz_to_rr` の `ι(0) := 0`
        _ = -(1 : ℝ) + 1 := (neg_add_cancel 1).symm                        -- `ℝ` の加法逆元 `(-1) + 1 = 0` を右辺から左辺へ
        _ = -((1 : ℤ) : ℝ) + 1 := by rw [inclusion_zz_to_rr_of_one_intCast]  -- `inclusion_zz_to_rr_of_one` を右辺から左辺へ
        _ = ((-(1 : ℤ) : ℤ) : ℝ) + 1 := by rw [inclusion_zz_to_rr_neg 1 le_rfl]
                                                                           -- `inclusion_zz_to_rr` の `ι(-n) := -ι(n)`（`n → 1`）を右辺から左辺へ
    · -- `n = -(p + 1_ℤ)`（`p ∈ ℤ_{≥1}`）のとき
      obtain ⟨q, hq, rfl⟩ : ∃ q : ℕ, 1 ≤ q ∧ m = (q : ℤ) + 1 := ⟨(m - 1).toNat, by omega, by omega⟩
      calc ((-((q : ℤ) + 1) + 1 : ℤ) : ℝ) = ((-(q : ℤ) : ℤ) : ℝ) := by
            rw [show -((q : ℤ) + 1) + 1 = -(q : ℤ) by omega]                -- `ℤ` の四則 `-(p + 1) + 1 = -p`
        _ = -((q : ℤ) : ℝ) := inclusion_zz_to_rr_neg _ (by exact_mod_cast hq)
                                                                           -- `inclusion_zz_to_rr` の `ι(-n) := -ι(n)`（`n → p`）
        _ = -((q : ℤ) : ℝ) + 0 := (add_zero _).symm                        -- `0_ℝ` は `ℝ` の和の単位元
        _ = -((q : ℤ) : ℝ) + (-(1 : ℝ) + 1) := by rw [neg_add_cancel]      -- `ℝ` の加法逆元 `(-1) + 1 = 0` を右辺から左辺へ
        _ = (-((q : ℤ) : ℝ) + -(1 : ℝ)) + 1 := (add_assoc _ _ _).symm       -- `ℝ` の和の結合律を右辺から左辺へ
        _ = -(((q : ℤ) : ℝ) + 1) + 1 := by
            rw [real_negation_of_sum_is_sum_of_negations]                  -- `real_negation_of_sum_is_sum_of_negations`（`x → ι(p)`, `y → 1`）を右辺から左辺へ
        _ = -((((q : ℤ) + 1 : ℤ)) : ℝ) + 1 := by rw [inclusion_zz_to_rr_succ_intCast q]
                                                                           -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1`（`n → p`）を右辺から左辺へ
        _ = ((-((q : ℤ) + 1) : ℤ) : ℝ) + 1 := by
            rw [inclusion_zz_to_rr_neg ((q : ℤ) + 1) (by omega)]           -- `inclusion_zz_to_rr` の `ι(-n) := -ι(n)`（`n → p + 1`）を右辺から左辺へ

/-- **人手 `inclusion_zz_to_rr_preserves_sum`**: `a, b ∈ ℤ` なら `ι(a + b) = ι(a) + ι(b)`。
人手と同じく `a` を固定し、`b ∈ ℤ_{≥0}` は `0` から `1` を足す帰納法、`b ∈ ℤ_{≤0}` は `0` から `1` を引く帰納法で示す
（Lean では `Int.induction_on`。`b ∈ ℤ_{≤0}` の段の `b` は `ℕ` の元 `i` の像の符号反転 `-(i : ℤ)` である）。
`b = 0` の 3 行、`b → b + 1` の 5 行、`b → b - 1` の 12 行が人手の行と 1 対 1 の `calc` である。 -/
theorem inclusion_zz_to_rr_preserves_sum (a b : ℤ) :
    ((a + b : ℤ) : ℝ) = ((a : ℤ) : ℝ) + ((b : ℤ) : ℝ) := by
  refine Int.induction_on b ?_ ?_ ?_
  · -- `b = 0_ℤ` のとき
    calc ((a + 0 : ℤ) : ℝ) = ((a : ℤ) : ℝ) := by rw [add_zero]            -- `0_ℤ` は `ℤ` の和の単位元
      _ = ((a : ℤ) : ℝ) + 0 := (add_zero _).symm                           -- `0_ℝ` は `ℝ` の和の単位元
      _ = ((a : ℤ) : ℝ) + ((0 : ℤ) : ℝ) := by rw [inclusion_zz_to_rr_zero_intCast]
                                                                           -- `inclusion_zz_to_rr` の `ι(0) := 0` を右辺から左辺へ
  · -- `b ∈ ℤ_{≥0}` から `b + 1_ℤ` へ
    intro i ih
    calc ((a + ((i : ℤ) + 1) : ℤ) : ℝ) = (((a + (i : ℤ)) + 1 : ℤ) : ℝ) := by rw [add_assoc]
                                                                           -- `ℤ` の和の結合律
      _ = ((a + (i : ℤ) : ℤ) : ℝ) + 1 := inclusion_zz_to_rr_of_successor _ -- `inclusion_zz_to_rr_of_successor`（`n → a + b`）
      _ = (((a : ℤ) : ℝ) + (((i : ℤ)) : ℝ)) + 1 := by rw [ih]              -- 帰納法の仮定
      _ = ((a : ℤ) : ℝ) + ((((i : ℤ)) : ℝ) + 1) := add_assoc _ _ _         -- `ℝ` の和の結合律
      _ = ((a : ℤ) : ℝ) + ((((i : ℤ) + 1 : ℤ)) : ℝ) := by
          rw [inclusion_zz_to_rr_of_successor (i : ℤ)]                     -- `inclusion_zz_to_rr_of_successor`（`n → b`）を右辺から左辺へ
  · -- `b ∈ ℤ_{≤0}` から `b - 1_ℤ` へ
    intro i ih
    calc ((a + (-(i : ℤ) - 1) : ℤ) : ℝ)
        = ((a + (-(i : ℤ) - 1) : ℤ) : ℝ) + 0 := (add_zero _).symm          -- `0_ℝ` は `ℝ` の和の単位元
      _ = ((a + (-(i : ℤ) - 1) : ℤ) : ℝ) + (1 + -(1 : ℝ)) := by rw [add_neg_cancel]
                                                                           -- `ℝ` の加法逆元 `1 + (-1) = 0` を右辺から左辺へ
      _ = (((a + (-(i : ℤ) - 1) : ℤ) : ℝ) + 1) + -(1 : ℝ) := (add_assoc _ _ _).symm
                                                                           -- `ℝ` の和の結合律を右辺から左辺へ
      _ = (((a + (-(i : ℤ) - 1)) + 1 : ℤ) : ℝ) + -(1 : ℝ) := by
          rw [inclusion_zz_to_rr_of_successor (a + (-(i : ℤ) - 1))]        -- `inclusion_zz_to_rr_of_successor`（`n → a + (b - 1)`）を右辺から左辺へ
      _ = ((a + -(i : ℤ) : ℤ) : ℝ) + -(1 : ℝ) := by
          rw [show (a + (-(i : ℤ) - 1)) + 1 = a + -(i : ℤ) by omega]        -- `ℤ` の四則 `(a + (b - 1)) + 1 = a + b`
      _ = (((a : ℤ) : ℝ) + ((-(i : ℤ) : ℤ) : ℝ)) + -(1 : ℝ) := by rw [ih]  -- 帰納法の仮定
      _ = ((a : ℤ) : ℝ) + (((-(i : ℤ) : ℤ) : ℝ) + -(1 : ℝ)) := add_assoc _ _ _
                                                                           -- `ℝ` の和の結合律
      _ = ((a : ℤ) : ℝ) + ((((-(i : ℤ) - 1) + 1 : ℤ) : ℝ) + -(1 : ℝ)) := by
          rw [show (-(i : ℤ) - 1) + 1 = -(i : ℤ) by omega]                  -- `ℤ` の四則 `b = (b - 1) + 1`
      _ = ((a : ℤ) : ℝ) + ((((-(i : ℤ) - 1 : ℤ) : ℝ) + 1) + -(1 : ℝ)) := by
          rw [inclusion_zz_to_rr_of_successor (-(i : ℤ) - 1)]              -- `inclusion_zz_to_rr_of_successor`（`n → b - 1`）
      _ = ((a : ℤ) : ℝ) + (((-(i : ℤ) - 1 : ℤ) : ℝ) + (1 + -(1 : ℝ))) := by
          rw [add_assoc (((-(i : ℤ) - 1 : ℤ) : ℝ))]                        -- `ℝ` の和の結合律
      _ = ((a : ℤ) : ℝ) + (((-(i : ℤ) - 1 : ℤ) : ℝ) + 0) := by rw [add_neg_cancel]
                                                                           -- `ℝ` の加法逆元 `1 + (-1) = 0`
      _ = ((a : ℤ) : ℝ) + ((-(i : ℤ) - 1 : ℤ) : ℝ) := by rw [add_zero]     -- `0_ℝ` は `ℝ` の和の単位元

/-- **人手 `inclusion_zz_to_rr_preserves_product`**: `a, b ∈ ℤ` なら `ι(ab) = ι(a)ι(b)`。
人手と同じく `a` を固定し、`b ∈ ℤ_{≥0}` は `0` から `1` を足す帰納法、`b ∈ ℤ_{≤0}` は `0` から `1` を引く帰納法で示す
（Lean では `Int.induction_on`。`b ∈ ℤ_{≤0}` の段の `b` は `ℕ` の元 `i` の像の符号反転 `-(i : ℤ)` である）。
`b = 0` の 4 行、`b → b + 1` の 7 行、`b → b - 1` の 15 行が人手の行と 1 対 1 の `calc` である。 -/
theorem inclusion_zz_to_rr_preserves_product (a b : ℤ) :
    ((a * b : ℤ) : ℝ) = ((a : ℤ) : ℝ) * ((b : ℤ) : ℝ) := by
  refine Int.induction_on b ?_ ?_ ?_
  · -- `b = 0_ℤ` のとき
    calc ((a * 0 : ℤ) : ℝ) = ((0 : ℤ) : ℝ) := by rw [mul_zero]            -- `ℤ` で `a · 0 = 0`
      _ = 0 := inclusion_zz_to_rr_zero_intCast                             -- `inclusion_zz_to_rr` の `ι(0) := 0`
      _ = ((a : ℤ) : ℝ) * 0 := (real_times_zero_is_zero _).symm            -- `real_times_zero_is_zero`（`x → ι(a)`）を右辺から左辺へ
      _ = ((a : ℤ) : ℝ) * ((0 : ℤ) : ℝ) := by rw [inclusion_zz_to_rr_zero_intCast]
                                                                           -- `inclusion_zz_to_rr` の `ι(0) := 0` を右辺から左辺へ
  · -- `b ∈ ℤ_{≥0}` から `b + 1_ℤ` へ
    intro i ih
    calc ((a * ((i : ℤ) + 1) : ℤ) : ℝ) = ((a * (i : ℤ) + a * 1 : ℤ) : ℝ) := by rw [mul_add]
                                                                           -- `ℤ` の分配律
      _ = ((a * (i : ℤ) + a : ℤ) : ℝ) := by rw [mul_one]                   -- `1_ℤ` は `ℤ` の積の単位元
      _ = ((a * (i : ℤ) : ℤ) : ℝ) + ((a : ℤ) : ℝ) := inclusion_zz_to_rr_preserves_sum _ _
                                                                           -- `inclusion_zz_to_rr_preserves_sum`（`a → ab`, `b → a`）
      _ = ((a : ℤ) : ℝ) * (((i : ℤ)) : ℝ) + ((a : ℤ) : ℝ) := by rw [ih]    -- 帰納法の仮定
      _ = ((a : ℤ) : ℝ) * (((i : ℤ)) : ℝ) + ((a : ℤ) : ℝ) * 1 := by rw [mul_one]
                                                                           -- `1_ℝ` は `ℝ` の積の単位元
      _ = ((a : ℤ) : ℝ) * ((((i : ℤ)) : ℝ) + 1) := (mul_add _ _ _).symm    -- `ℝ` の分配律を右辺から左辺へ
      _ = ((a : ℤ) : ℝ) * ((((i : ℤ) + 1 : ℤ)) : ℝ) := by
          rw [inclusion_zz_to_rr_of_successor (i : ℤ)]                     -- `inclusion_zz_to_rr_of_successor`（`n → b`）を右辺から左辺へ
  · -- `b ∈ ℤ_{≤0}` から `b - 1_ℤ` へ
    intro i ih
    calc ((a * (-(i : ℤ) - 1) : ℤ) : ℝ)
        = ((a * (-(i : ℤ) - 1) : ℤ) : ℝ) + 0 := (add_zero _).symm          -- `0_ℝ` は `ℝ` の和の単位元
      _ = ((a * (-(i : ℤ) - 1) : ℤ) : ℝ) + (((a : ℤ) : ℝ) + -((a : ℤ) : ℝ)) := by rw [add_neg_cancel]
                                                                           -- `ℝ` の加法逆元 `x + (-x) = 0`（`x → ι(a)`）を右辺から左辺へ
      _ = (((a * (-(i : ℤ) - 1) : ℤ) : ℝ) + ((a : ℤ) : ℝ)) + -((a : ℤ) : ℝ) := (add_assoc _ _ _).symm
                                                                           -- `ℝ` の和の結合律を右辺から左辺へ
      _ = ((a * (-(i : ℤ) - 1) + a : ℤ) : ℝ) + -((a : ℤ) : ℝ) := by
          rw [inclusion_zz_to_rr_preserves_sum (a * (-(i : ℤ) - 1)) a]    -- `inclusion_zz_to_rr_preserves_sum`（`a → a(b - 1)`, `b → a`）を右辺から左辺へ
      _ = (((a * -(i : ℤ) - a * 1) + a : ℤ) : ℝ) + -((a : ℤ) : ℝ) := by rw [mul_sub]
                                                                           -- `ℤ` の分配律
      _ = (((a * -(i : ℤ) - a) + a : ℤ) : ℝ) + -((a : ℤ) : ℝ) := by rw [mul_one]
                                                                           -- `1_ℤ` は `ℤ` の積の単位元
      _ = ((a * -(i : ℤ) : ℤ) : ℝ) + -((a : ℤ) : ℝ) := by rw [sub_add_cancel]
                                                                           -- `ℤ` の四則 `(x - a) + a = x`（`x → ab`）
      _ = ((a : ℤ) : ℝ) * ((-(i : ℤ) : ℤ) : ℝ) + -((a : ℤ) : ℝ) := by rw [ih]
                                                                           -- 帰納法の仮定
      _ = ((a : ℤ) : ℝ) * (((-(i : ℤ) - 1) + 1 : ℤ) : ℝ) + -((a : ℤ) : ℝ) := by
          rw [show (-(i : ℤ) - 1) + 1 = -(i : ℤ) by omega]                  -- `ℤ` の四則 `b = (b - 1) + 1`
      _ = ((a : ℤ) : ℝ) * (((-(i : ℤ) - 1 : ℤ) : ℝ) + 1) + -((a : ℤ) : ℝ) := by
          rw [inclusion_zz_to_rr_of_successor (-(i : ℤ) - 1)]              -- `inclusion_zz_to_rr_of_successor`（`n → b - 1`）
      _ = (((a : ℤ) : ℝ) * ((-(i : ℤ) - 1 : ℤ) : ℝ) + ((a : ℤ) : ℝ) * 1) + -((a : ℤ) : ℝ) := by
          rw [mul_add]                                                     -- `ℝ` の分配律
      _ = (((a : ℤ) : ℝ) * ((-(i : ℤ) - 1 : ℤ) : ℝ) + ((a : ℤ) : ℝ)) + -((a : ℤ) : ℝ) := by
          rw [mul_one]                                                     -- `1_ℝ` は `ℝ` の積の単位元
      _ = ((a : ℤ) : ℝ) * ((-(i : ℤ) - 1 : ℤ) : ℝ) + (((a : ℤ) : ℝ) + -((a : ℤ) : ℝ)) := add_assoc _ _ _
                                                                           -- `ℝ` の和の結合律
      _ = ((a : ℤ) : ℝ) * ((-(i : ℤ) - 1 : ℤ) : ℝ) + 0 := by rw [add_neg_cancel]
                                                                           -- `ℝ` の加法逆元 `x + (-x) = 0`（`x → ι(a)`）
      _ = ((a : ℤ) : ℝ) * ((-(i : ℤ) - 1 : ℤ) : ℝ) := add_zero _          -- `0_ℝ` は `ℝ` の和の単位元

/-- **人手 `inclusion_zz_to_rr_preserves_difference`**: `a, b ∈ ℤ` なら `ι(a - b) = ι(a) - ι(b)`。
人手の 9 行と 1 対 1 の `calc` で、主張は `inclusion_zz_to_rr_preserves_sum` だけを引き、定義は `def_int_difference`（`int_sub_eq_add_neg`）を引く。 -/
theorem inclusion_zz_to_rr_preserves_difference (a b : ℤ) :
    ((a - b : ℤ) : ℝ) = ((a : ℤ) : ℝ) - ((b : ℤ) : ℝ) :=
  calc ((a - b : ℤ) : ℝ)
      = ((a - b : ℤ) : ℝ) + 0 := (add_zero _).symm                        -- `0_ℝ` は `ℝ` の和の単位元
    _ = ((a - b : ℤ) : ℝ) + (((b : ℤ) : ℝ) + -((b : ℤ) : ℝ)) := by rw [add_neg_cancel]
                                                                           -- `ℝ` の加法逆元 `x + (-x) = 0`（`x → ι(b)`）を右辺から左辺へ
    _ = (((a - b : ℤ) : ℝ) + ((b : ℤ) : ℝ)) + -((b : ℤ) : ℝ) := (add_assoc _ _ _).symm
                                                                           -- `ℝ` の和の結合律を右辺から左辺へ
    _ = ((a - b + b : ℤ) : ℝ) + -((b : ℤ) : ℝ) := by
        rw [inclusion_zz_to_rr_preserves_sum (a - b) b]                    -- `inclusion_zz_to_rr_preserves_sum`（`a → a - b`, `b → b`）を右辺から左辺へ
    _ = ((a + -b + b : ℤ) : ℝ) + -((b : ℤ) : ℝ) := by
        rw [int_sub_eq_add_neg a b]                                        -- `def_int_difference`（`y → a`, `z → b`）
    _ = ((a + (-b + b) : ℤ) : ℝ) + -((b : ℤ) : ℝ) := by rw [add_assoc a (-b) b]
                                                                           -- `ℤ` の和の結合律
    _ = ((a + 0 : ℤ) : ℝ) + -((b : ℤ) : ℝ) := by rw [neg_add_cancel b]     -- `ℤ` の加法逆元 `(-x) + x = 0`（`x → b`）
    _ = ((a : ℤ) : ℝ) + -((b : ℤ) : ℝ) := by rw [add_zero a]              -- `0_ℤ` は `ℤ` の和の単位元
    _ = ((a : ℤ) : ℝ) - ((b : ℤ) : ℝ) := (sub_eq_add_neg _ _).symm        -- `def_real_difference`（`y → ι(a)`, `z → ι(b)`）を右辺から左辺へ

/-- **人手 `inclusion_zz_to_rr_preserves_negation`**: `a ∈ ℤ` なら `ι(-a) = -ι(a)`（`a` の符号を問わない）。
人手の 5 行と 1 対 1 の `calc` で、`inclusion_zz_to_rr_preserves_difference` と定義の `ι(0) := 0` を引く。 -/
theorem inclusion_zz_to_rr_preserves_negation (a : ℤ) :
    ((-a : ℤ) : ℝ) = -((a : ℤ) : ℝ) :=
  calc ((-a : ℤ) : ℝ)
      = ((0 - a : ℤ) : ℝ) := by rw [zero_sub]                              -- `ℤ` の四則 `-x = 0 - x`（`x → a`）
    _ = ((0 : ℤ) : ℝ) - ((a : ℤ) : ℝ) :=
        inclusion_zz_to_rr_preserves_difference 0 a                       -- `inclusion_zz_to_rr_preserves_difference`（`a → 0`, `b → a`）
    _ = 0 - ((a : ℤ) : ℝ) := by rw [inclusion_zz_to_rr_zero_intCast]      -- `inclusion_zz_to_rr` の `ι(0_ℤ) := 0_ℝ`
    _ = 0 + -((a : ℤ) : ℝ) := sub_eq_add_neg _ _                          -- `def_real_difference`（`y → 0_ℝ`, `z → ι(a)`）
    _ = -((a : ℤ) : ℝ) := zero_add _                                      -- `0_ℝ` は `ℝ` の和の単位元

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
      _ = (((m + 1 : ℕ) : ℝ) + 1) * r := (add_mul _ _ _).symm              -- `ℝ` の分配律
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
      _ = 2 ^ M * 1 + 2 ^ M * 1 := Nat.mul_add _ _ _                       -- `ℤ` の分配律
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
      _ = ((2 ^ M * 1 + 2 ^ M * 1 : ℕ) : ℝ) := by rw [Nat.mul_add]         -- `ℤ` の分配律
      _ = ((2 ^ M + 2 ^ M : ℕ) : ℝ) := by rw [Nat.mul_one]                 -- `1_ℤ` は乗法の単位元を二か所へ同時に
      _ = ((2 ^ M : ℕ) : ℝ) + ((2 ^ M : ℕ) : ℝ) :=
          inclusion_zz_to_rr_preserves_sum_of_nonnegatives _ _             -- `inclusion_zz_to_rr_preserves_sum_of_nonnegatives`（`a, b → 2^M`）
      _ = (2 : ℝ) ^ M + (2 : ℝ) ^ M := by rw [ih]                          -- 帰納法の仮定を二か所へ同時に
      _ = (2 : ℝ) ^ M * 1 + (2 : ℝ) ^ M * 1 := by rw [mul_one]             -- `1_ℝ` は `ℝ` の乗法の単位元を二か所へ同時に
      _ = (2 : ℝ) ^ M * (1 + 1) := (mul_add _ _ _).symm                    -- `ℝ` の分配律
      _ = (2 : ℝ) ^ M * 2 := by rw [← real_two_eq_one_add_one]                    -- `2_ℝ := 1_ℝ + 1_ℝ`
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
      _ = 0 := real_negation_of_zero_is_zero                               -- `real_negation_of_zero_is_zero`
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
