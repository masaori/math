/-
# ℕ から ℤ への包含写像（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_inclusion_nn_to_zz`、ラベル **`inclusion_nn_to_zz`**）

人手は `ι_{ℕ→ℤ} : ℕ → ℤ` を、`set_and_algebra_notation` の ℕ の再帰による定義で `ι(0_ℕ) := 0_ℤ`・`ι(n +_ℕ 1_ℕ) := ι(n) +_ℤ 1_ℤ` と定める。
具体版 `inclusionNNtoZZ` も同じ二つの式を ℕ の再帰（`Nat.rec`。人手の「再帰による定義」）で定める。二つの式はどちらも定義として成り立つ（`rfl`）。
Lean の ℕ から ℤ への写像 `Nat.cast`（`Int.ofNat`）との一致は、補題一本 `inclusionNNtoZZ_eq_natCast` で示す。
ほかの具体版は ℕ の元を ℤ へ送るのに `Nat.cast` を使っているので、人手の `ι_{ℕ→ℤ}` を引く段はこの補題を通して `Nat.cast` の形へ移す。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`inclusion_nn_to_zz`**: `ι_{ℕ→ℤ}`。ℕ の再帰で `ι(0_ℕ) := 0_ℤ`・`ι(n + 1_ℕ) := ι(n) + 1_ℤ` と定める。 -/
def inclusionNNtoZZ (n : ℕ) : ℤ :=
  Nat.rec (motive := fun _ => ℤ) 0 (fun _ z => z + 1) n

/-- **`inclusion_nn_to_zz`**: 具体版 `inclusionNNtoZZ` は Lean の `Nat.cast`（ℕ → ℤ）と一致する。
`n` についての帰納法で、`0` の段も `n + 1` の段も二つの定義の式を当てる。 -/
theorem inclusionNNtoZZ_eq_natCast (n : ℕ) : inclusionNNtoZZ n = (n : ℤ) := by
  induction n with
  | zero => rfl                                                      -- 両辺とも `ι(0_ℕ) := 0_ℤ`
  | succ n ih =>
    calc inclusionNNtoZZ (n + 1) = inclusionNNtoZZ n + 1 := rfl     -- `ι(n + 1_ℕ) := ι(n) + 1_ℤ`
      _ = (n : ℤ) + 1 := by rw [ih]                                 -- 帰納法の仮定
      _ = ((n + 1 : ℕ) : ℤ) := rfl                                  -- `Nat.cast`（`Int.ofNat`）の `n + 1` の値

end Ising2D
