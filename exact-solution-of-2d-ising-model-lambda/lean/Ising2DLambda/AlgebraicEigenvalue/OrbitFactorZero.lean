/-
章「固有値の代数性」の「行の添字にもその像にも当たらない値を取る軌道の上の全単射の因子は
零元である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_factor_zero`）に対応する。

  人手証明                                          このファイル
  W_O(ch(U),ψ) = ι(κ(0))（ψ(τ₁)≠τ₁ かつ ψ(τ₁)≠S(τ₁)）  orbitFactor_shiftMatrix_eq_zero

`ψ` の持ち方は `orbitFactor` に合わせ、`O` の上で値を取る ambient の写像として受ける
（人手証明の `ψ ∈ 𝔅_O` に対応する）。全単射であることは証明に現れないので仮定しない。

mathlib の `Matrix.charpoly` / `Equiv.Perm.support` は引いていない。使ったのは
`Finset.prod_eq_zero`（人手証明の「有限積から 1 つの因子を括り出す」）と、既に示した
`charMatrix_shiftMatrix_eq_zero`（人手証明の `claim_shift_char_matrix_entry_zero`）だけである。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（係数は ℤ[x][t]、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTermFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の主張「行の添字にもその像にも当たらない値を取る軌道の上の全単射の因子は
零元である」。

証明は人手証明どおり、軌道にわたる有限積から `τ₁` の因子を括り出し、それが零元であることで
結論する。`τ₁ ∈ O` を仮定に置くのは、人手証明が `τ₁ ∈ O` を取っているためである。 -/
theorem orbitFactor_shiftMatrix_eq_zero (O : Finset (RowConfig L))
    (g : RowConfig L → RowConfig L) {τ₁ : RowConfig L} (hmem : τ₁ ∈ O)
    (h₁ : g τ₁ ≠ τ₁) (h₂ : g τ₁ ≠ rowShift L τ₁) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O g = 0 := by
  classical
  have hprod : ∏ τ ∈ O, charMatrix L (shiftMatrix L) τ (g τ) = 0 :=
    Finset.prod_eq_zero hmem (charMatrix_shiftMatrix_eq_zero h₁ h₂)
  unfold orbitFactor
  rw [hprod, mul_zero]

end Ising2DLambda.AlgebraicEigenvalue
