/-
# ℤ から ℝ への包含写像（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_inclusion_zz_to_rr`、ラベル **`inclusion_zz_to_rr`**）

人手は `ι_{ℤ→ℝ} : ℤ → ℝ` を、`n ∈ ℤ_{≥0}` では `n` についての帰納法で `ι(0_ℤ) := 0_ℝ`・`ι(n + 1_ℤ) := ι(n) + 1_ℝ`、
`n ∈ ℤ_{≥1}` では `ι(-n) := -ι(n)` と定める。具体版 `inclusionZZtoRR` も同じ式で定める。
Lean の `ℤ` は `Int.ofNat n`（`n ∈ ℕ`）と `Int.negSucc n`（`-(n + 1)`）の二つの形の元からなる。`Int.ofNat n` は `Nat.cast n` と定義として等しく、
`inclusionNNtoZZ_eq_natCast` により `ι_{ℕ→ℤ}(n)` と等しいので、`Int.ofNat` の形の元は人手の `ℤ_{≥0}` の元を `ι_{ℕ→ℤ}` の像として書いたものである
（人手の `ℤ_{≥0}` の上の帰納法と Lean の ℕ の再帰の行き来は `ι_{ℕ→ℤ}` を通る）。`Int.negSucc n` は人手の `-m`（`m = ι_{ℕ→ℤ}(n + 1) ∈ ℤ_{≥1}`）である。
具体版は二つの形の場合分け（`Int.rec`）で書き、`Int.ofNat n` の側は `n` についての再帰（`Nat.rec`。人手の帰納法による定義）で、
`Int.negSucc n` の側は人手の `-ι(m)` を、`ι(n + 1) := ι(n) + 1_ℝ` を展開した `-(ι(n) + 1_ℝ)` で書く
（`-ι(n + 1)` と書くと ℕ の数字 `1` が、`Nat.succ n` と書くと後者の関数が、未定義の記号として定義の本体に出るため）。
人手の三つの式はどれも定義として成り立つ（`rfl`）。

Lean の ℤ から ℝ への写像 `Int.cast` との一致は、補題一本 `inclusionZZtoRR_eq_intCast` で示す。
ほかの具体版は ℤ の元を ℝ へ送るのに `Int.cast` を使っているので、人手の `ι_{ℤ→ℝ}` の定義の式を引く段はこの補題を通して
`Int.cast` の形へ移す（`inclusion_zz_to_rr_neg`）。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- 人手の `ι_{ℤ→ℝ}` の `ℤ_{≥0}` の側: `n` についての再帰で `ι(0) := 0_ℝ`・`ι(n + 1) := ι(n) + 1_ℝ`。 -/
noncomputable def inclusionZZtoRRNonneg (n : ℕ) : ℝ :=
  Nat.rec (motive := fun _ => ℝ) 0 (fun _ r => r + 1) n

/-- **`inclusion_zz_to_rr`**: `ι_{ℤ→ℝ}`。`ℤ_{≥0}` の元 `Int.ofNat n` では `n` についての再帰の値、
`-(n + 1)`（`Int.negSucc n`）では `-(ι(n) + 1_ℝ)`（人手の `ι(-m) := -ι(m)` の `m = n + 1`）。 -/
noncomputable def inclusionZZtoRR (z : ℤ) : ℝ :=
  Int.rec (motive := fun _ => ℝ) (fun n => inclusionZZtoRRNonneg n) (fun n => -(inclusionZZtoRRNonneg n + 1)) z

/-- **`inclusion_zz_to_rr`**: 具体版 `inclusionZZtoRR` は Lean の `Int.cast`（ℤ → ℝ）と一致する。
`ℤ_{≥0}` の側は `n` についての帰納法で `0` の段も `n + 1` の段も定義の式を当て、`-(n + 1)` の側はその値の符号反転である。 -/
theorem inclusionZZtoRR_eq_intCast (z : ℤ) : inclusionZZtoRR z = (z : ℝ) := by
  have hnonneg : ∀ n : ℕ, inclusionZZtoRRNonneg n = (n : ℝ) := by
    intro n
    induction n with
    | zero => exact Nat.cast_zero.symm                               -- `ι(0) := 0_ℝ`
    | succ n ih =>
      calc inclusionZZtoRRNonneg (n + 1) = inclusionZZtoRRNonneg n + 1 := rfl  -- `ι(n + 1) := ι(n) + 1_ℝ`
        _ = (n : ℝ) + 1 := by rw [ih]                                -- 帰納法の仮定
        _ = ((n + 1 : ℕ) : ℝ) := (Nat.cast_succ n).symm              -- `Nat.cast` の `n + 1` の値
  cases z with
  | ofNat n =>
    calc inclusionZZtoRR (Int.ofNat n) = inclusionZZtoRRNonneg n := rfl
      _ = (n : ℝ) := hnonneg n
      _ = ((Int.ofNat n : ℤ) : ℝ) := (Int.cast_natCast n).symm       -- `Int.cast` の `Int.ofNat n` の値
  | negSucc n =>
    calc inclusionZZtoRR (Int.negSucc n) = -(inclusionZZtoRRNonneg n + 1) := rfl
      _ = -((n : ℝ) + 1) := by rw [hnonneg n]
      _ = ((Int.negSucc n : ℤ) : ℝ) := by
          rw [Int.cast_negSucc, Nat.cast_succ]                       -- `Int.cast` の `-(n + 1)` の値

end Ising2D
