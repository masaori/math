/-
# ℕ から ℤ への包含写像（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_inclusion_nn_to_zz`、ラベル **`inclusion_nn_to_zz`**）

人手は `ι_{ℕ→ℤ} : ℕ → ℤ` を、`set_and_algebra_notation` の ℕ の再帰による定義で `ι(0_ℕ) := 0_ℤ`・`ι(n +_ℕ 1_ℕ) := ι(n) +_ℤ 1_ℤ` と定める。
具体版 `inclusionNNtoZZ` も同じ二つの式を ℕ の再帰（`Nat.rec`。人手の「再帰による定義」）で定める。二つの式はどちらも定義として成り立つ（`rfl`）。
Lean の ℕ から ℤ への写像 `Nat.cast`（`Int.ofNat`）との一致は、補題一本 `inclusionNNtoZZ_eq_natCast` で示す。
ほかの具体版は ℕ の元を ℤ へ送るのに `Nat.cast` を使っているので、人手の `ι_{ℕ→ℤ}` を引く段はこの補題を通して `Nat.cast` の形へ移す。

人手の本文は ℤ_{≥0} の元を ℤ の元のまま扱い、ℤ_{≥0} の上の帰納法で計算する。Lean の具体版は、ℤ_{≥0} の元を ℕ の元の像として書く
（Lean の ℤ は二つの形 `Int.ofNat n`・`Int.negSucc n` で作られ、ℤ_{≥0} の元は前の形をしている）。その書き直しは人手には無い Lean だけの段で、
`inclusionNNtoZZ_exists_preimage_of_nonneg`（`0_ℤ ≤ a` の `a` は ι_{ℕ→ℤ} の像である）を通して行う。
ℤ の二つの形による場合分けで示す。いまは人手の主張のブロックではないので、人手の証明との対応は無い。
同じ内容（ℤ_{≥0} への全射）を、本文 `antiperiodic_exp_sum` の主張の前置きが「`(M_col)_ℕ` が一意に在る」として証明なしに使っている。
主張のブロックは、Lean の `antiperiodic_exp_sum` の族の仮定を ℤ の `M_col` に寄せる回に置き、この補題をそのブロックの欄 `lean` へ移す。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。足した定理はどちらも Lean だけの段の補題なので、必要十分版を置かない。
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

/-- **`inclusion_nn_to_zz`**: `0_ℤ ≤ a` の `a ∈ ℤ` は、ある `n ∈ ℕ` の像 `ι_{ℕ→ℤ}(n)` である（Lean だけの段の補題）。
本文が ℤ_{≥0} の元として扱う元を、Lean の具体版が ℕ の元の像として書き直す段はこの補題を通す（mathlib の `Int.toNat`・`Int.eq_ofNat_of_zero_le` は使わない）。
Lean の ℤ の二つの形で場合を分け、`Int.ofNat n` なら `n` を取り、`Int.negSucc n` は `0_ℤ` より小さいので `0_ℤ ≤ a` と両立しない。 -/
theorem inclusionNNtoZZ_exists_preimage_of_nonneg (a : ℤ) (ha : 0 ≤ a) : ∃ n : ℕ, inclusionNNtoZZ n = a := by
  cases a with
  | ofNat n => exact ⟨n, inclusionNNtoZZ_eq_natCast n⟩               -- `a = Int.ofNat n` なら `ι(n) = a`
  | negSucc n => exact absurd ha (not_le.mpr (Int.negSucc_lt_zero n)) -- `Int.negSucc n < 0_ℤ` は `0_ℤ ≤ a` と両立しない

end Ising2D
