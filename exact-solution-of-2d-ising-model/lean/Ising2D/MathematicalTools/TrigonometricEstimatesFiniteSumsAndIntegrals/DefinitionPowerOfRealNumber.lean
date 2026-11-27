/-
# 実数の冪（**具体版**）

正本: `structured-latex/content/020_critical_point.ts`
（`critical_definition_power_of_real_number`、ラベル **`def_power_of_real_number`**）

人手の定義: `a ∈ ℝ` と `m ∈ ℤ_{≥0}` について、冪 `a^m ∈ ℝ` を `m` についての帰納法で `a^0 := 1`、`a^{m+1} := a^m a` と定める
（積は ℝ の積、`1` は ℝ の乗法の単位元）。

Lean の具体版は mathlib の `ℝ` の冪 `a ^ m`（`m : ℕ`。`Monoid.npow`）である。`ℝ` の `Monoid.npow` は `npowRec` で定義されており、
`npowRec 0 a = 1`、`npowRec (m + 1) a = npowRec m a * a` は人手の二つの式そのものなので、二つの式を定義を開くだけで示す
（`real_pow_zero_and_succ`）。指数の `ℤ_{≥0}` を Lean の `ℕ` で書くことは、複素数の冪（`def_power_of_complex_number` の
`complex_pow_zero_and_succ`）と同じである。

人手の本文は演算を定めるだけで、Lean の演算との一致の主張を持たない。補題は Lean だけの段であり、
定義の一致を述べる補題なので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`def_power_of_real_number`**: mathlib の `ℝ` の冪は、本文の `a^0 := 1`、`a^{m+1} := a^m a` の二つの式を満たす。 -/
theorem real_pow_zero_and_succ (a : ℝ) :
    a ^ 0 = (1 : ℝ) ∧ ∀ m : ℕ, a ^ (m + 1) = a ^ m * a :=
  ⟨rfl, fun _ => rfl⟩                                       -- mathlib の冪 `npowRec` の定義を開く

end Ising2D
