/-
# 複素数の冪（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_definition_power_of_complex_number`、ラベル **`def_power_of_complex_number`**）

人手の定義: `z ∈ ℂ` と `m ∈ ℤ_{≥0}` について、冪 `z^m ∈ ℂ` を `m` についての帰納法で `z^0 := 1_ℂ`、`z^{m+1} := z^m z` と定める
（積は `definition_of_cc` の積、`1_ℂ` は `inclusion_rr_to_cc` の略記）。

Lean の具体版は mathlib の `ℂ` の冪 `z ^ m`（`m : ℕ`。`Monoid.npow`）である。`ℂ` の `Monoid.npow` は `npowRec` で定義されており、
`npowRec 0 z = 1`、`npowRec (m + 1) z = npowRec m z * z` は人手の二つの式そのものなので、二つの式を定義を開くだけで示す
（`complex_pow_zero_and_succ`）。指数の `ℤ_{≥0}` を Lean の `ℕ` で書くことは、行列の冪（`def_matrix_power` の
`tensorPow_pow_zero_and_succ`）と同じである。

人手の本文は演算を定めるだけで、Lean の演算との一致の主張を持たない。補題は Lean だけの段であり、
定義の一致を述べる補題なので、必要十分版は置かない。
-/
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **`def_power_of_complex_number`**: mathlib の `ℂ` の冪は、本文の `z^0 := 1_ℂ`、`z^{m+1} := z^m z` の二つの式を満たす。 -/
theorem complex_pow_zero_and_succ (z : ℂ) :
    z ^ 0 = (1 : ℂ) ∧ ∀ m : ℕ, z ^ (m + 1) = z ^ m * z :=
  ⟨rfl, fun _ => rfl⟩                                       -- mathlib の冪 `npowRec` の定義を開く

end Ising2D
