/-
「横断数の整礎帰納は閉歩道を横断のない有限族へ分ける」の具体版。
人手証明（claim_crossing_elimination_by_smoothing）と同じく、閉歩道の型 W と
横断数・循環総回転数・二つの切断線偶奇を取り、「横断数が正なら横断を選んで
平滑化でき、二本の横断数の和が真に減り（claim_smoothing_split_crossing_descent）、
循環総回転数は和で（claim_smoothing_split_turning_sum）、切断線偶奇は法 2 で
（claim_smoothing_split_seam_parity）保存される」ことを仮定に置き、
横断数についての累積帰納で横断のない有限族へ分ける。
-/
import Ising2DLambda.NecSuf.KacWard.CrossingEliminationBySmoothing

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 閉歩道の横断数についての整礎帰納。平滑化の一歩（横断数の和の狭義減少と
三つの保存則）を繰り返すと、横断のない閉歩道の空でない有限族に達し、
循環総回転数の総和と二つの切断線偶奇の総和の法 2 が保たれる。 -/
theorem crossing_elimination_by_smoothing {W : Type}
    (crossingNumber : W → ℕ) (cyclicTurning : W → ℤ)
    (horizontalParity verticalParity : W → ℕ)
    (smoothing : ∀ γ : W, 0 < crossingNumber γ → ∃ γA γB : W,
      crossingNumber γA + crossingNumber γB < crossingNumber γ ∧
      cyclicTurning γA + cyclicTurning γB = cyclicTurning γ ∧
      (horizontalParity γA + horizontalParity γB) % 2 = horizontalParity γ % 2 ∧
      (verticalParity γA + verticalParity γB) % 2 = verticalParity γ % 2) :
    ∀ γ : W, ∃ family : List W,
      family ≠ [] ∧
      (∀ δ ∈ family, crossingNumber δ = 0) ∧
      (family.map cyclicTurning).sum = cyclicTurning γ ∧
      (family.map horizontalParity).sum % 2 = horizontalParity γ % 2 ∧
      (family.map verticalParity).sum % 2 = verticalParity γ % 2 :=
  crossing_elimination_by_smoothing_necSuf
    crossingNumber cyclicTurning horizontalParity verticalParity smoothing

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem crossing_elimination_by_smoothing_from_necSuf {W : Type}
    (crossingNumber : W → ℕ) (cyclicTurning : W → ℤ)
    (horizontalParity verticalParity : W → ℕ)
    (smoothing : ∀ γ : W, 0 < crossingNumber γ → ∃ γA γB : W,
      crossingNumber γA + crossingNumber γB < crossingNumber γ ∧
      cyclicTurning γA + cyclicTurning γB = cyclicTurning γ ∧
      (horizontalParity γA + horizontalParity γB) % 2 = horizontalParity γ % 2 ∧
      (verticalParity γA + verticalParity γB) % 2 = verticalParity γ % 2) :
    ∀ γ : W, ∃ family : List W,
      family ≠ [] ∧
      (∀ δ ∈ family, crossingNumber δ = 0) ∧
      (family.map cyclicTurning).sum = cyclicTurning γ ∧
      (family.map horizontalParity).sum % 2 = horizontalParity γ % 2 ∧
      (family.map verticalParity).sum % 2 = verticalParity γ % 2 :=
  crossing_elimination_by_smoothing
    crossingNumber cyclicTurning horizontalParity verticalParity smoothing

end Ising2DLambda.KacWard
