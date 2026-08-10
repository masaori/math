/-
章「固有値の代数性」の「恒等写像の因子は、その軌道の元の個数で決まる」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_identity_factor`）に対応する。

  人手証明                                             このファイル
  共通の段（符号を落として対角成分の積にする）          orbitFactor_id_eq_prod_diag
  第一の場合 |O| ≥ 2 ⇒ W_O(ch(U),id_O) = t^{|O|}        orbitFactor_shiftMatrix_id_of_two_le
  第二の場合 |O| = 1 ⇒ W_O(ch(U),id_O) = t + ι(-κ(1))   orbitFactor_shiftMatrix_id_of_card_one

`id_O` は `orbitFactor` の引数の持ち方に合わせて ambient の恒等写像 `fun τ => τ` として渡す。
値は `O` の上でしか見られないので、これは人手証明の `id_O ∈ 𝔅_O` に対応する。

mathlib の `Matrix.charpoly` や置換行列の既製定理は引いていない。使ったのは既に示した
`orbitPermSign_id`・`charMatrix_shiftMatrix_diag_of_two_le`・
`charMatrix_shiftMatrix_diag_of_card_one` と、有限積の基本則
（`Finset.prod_congr`・`Finset.prod_const`・`Finset.prod_singleton`）だけである。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（成分は `Polynomial (Polynomial ℤ)`、添字は行配位、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTermFactorization
import Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSignValues
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharDiagonalEntry

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の共通の段。恒等写像の因子は対角成分の有限積である
（`sgn_O(id_O) = +1` と `ι(κ(1))` が単位元であることによる）。 -/
theorem orbitFactor_id_eq_prod_diag (B : SecondRowMatrix L) (O : Finset (RowConfig L)) :
    orbitFactor L B O (fun τ => τ) = ∏ τ ∈ O, B τ τ := by
  unfold orbitFactor
  rw [orbitPermSign_id O, constPoly_one, show constSecond (1 : Polynomial ℤ) = 1 from map_one _, one_mul]

/-- 人手証明の第一の場合「`|O| ≥ 2` ならば `W_O(ch(U), id_O) = t^{|O|}`」。 -/
theorem orbitFactor_shiftMatrix_id_of_two_le {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hcard : 2 ≤ O.card) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O (fun τ => τ)
      = Polynomial.X ^ O.card := by
  classical
  rw [orbitFactor_id_eq_prod_diag]
  rw [Finset.prod_congr rfl
    (fun τ hmem => charMatrix_shiftMatrix_diag_of_two_le hO hmem hcard)]
  exact Finset.prod_const _

/-- 人手証明の第二の場合「`|O| = 1` ならば `W_O(ch(U), id_O) = t + ι(-κ(1))`」。 -/
theorem orbitFactor_shiftMatrix_id_of_card_one {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hcard : O.card = 1) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O (fun τ => τ)
      = Polynomial.X + constSecond (-(constPoly 1)) := by
  classical
  obtain ⟨τ₁, hs⟩ := Finset.card_eq_one.mp hcard
  have hmem : τ₁ ∈ O := by rw [hs]; exact Finset.mem_singleton_self τ₁
  rw [orbitFactor_id_eq_prod_diag, hs, Finset.prod_singleton]
  exact charMatrix_shiftMatrix_diag_of_card_one hO hmem hcard

end Ising2DLambda.AlgebraicEigenvalue
