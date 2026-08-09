/-
章「固有値の代数性」の主張「軌道の上の全単射の符号は +1 か -1 であり、恒等写像の符号は
+1 である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_permutation_sign_values`）の 3 つの結論に対応する。

  人手証明                                        このファイル
  第一の主張（sgn_O は ±1）                       orbitPermSign_eq_one_or_neg_one
  第二の主張（sgn_O の 2 乗は 1）                 orbitPermSign_mul_self
  第三の主張（sgn_O(id_O) = +1）                  orbitPermSign_id（と orbitInversionCount_id）

人手証明が `ψ : O → O` と書くところを、このファイルは前のセクションと同じく ambient の
写像 `g : RowConfig L → RowConfig L` で受ける（`orbitPermSign` がその形で定義されている）。
`orbitPermSign_congr` により `O` の中での値だけで決まるので、恒等写像については
`fun τ => τ` を渡せばよい。

mathlib の `Equiv.Perm.sign` は引いていない（引くと転倒数で定めるという人手証明の定義が消える）。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは個数（ℕ）と符号（ℤ）だけである）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitBijectionIdOrShift

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 第一の主張。軌道の上の全単射の符号は `+1` か `-1` である。 -/
theorem orbitPermSign_eq_one_or_neg_one (O : Finset (RowConfig L))
    (g : RowConfig L → RowConfig L) :
    orbitPermSign L O g = 1 ∨ orbitPermSign L O g = -1 :=
  neg_one_pow_eq_or ℤ _

/-- 第二の主張。符号の 2 乗は `1` である（人手証明の 4 つの等号）。 -/
theorem orbitPermSign_mul_self (O : Finset (RowConfig L)) (g : RowConfig L → RowConfig L) :
    orbitPermSign L O g * orbitPermSign L O g = 1 := by
  unfold orbitPermSign
  rw [← pow_add, ← two_mul, pow_mul, neg_one_sq, one_pow]

/-- 第三の主張の前半。恒等写像の転倒数は `0` である。

人手証明どおり、転倒数の定義に現れる集合が空であることを三分律から出す
（`(τ,τ') ∈ F(O,O)` ならば `τ ≺ τ'` なので `τ' ≺ τ` は成り立たない）。 -/
theorem orbitInversionCount_id (O : Finset (RowConfig L)) :
    orbitInversionCount L O (fun τ => τ) = 0 := by
  rw [orbitInversionCount, card_eq_zero, filter_eq_empty_iff]
  intro p hp
  exact not_rowConfigLess_of_rowConfigLess (mem_crossOrderedPairs.mp hp).2

/-- 第三の主張。恒等写像の符号は `+1` である（人手証明の 3 つの等号）。 -/
theorem orbitPermSign_id (O : Finset (RowConfig L)) :
    orbitPermSign L O (fun τ => τ) = 1 := by
  rw [orbitPermSign, orbitInversionCount_id, pow_zero]

end Ising2DLambda.AlgebraicEigenvalue
