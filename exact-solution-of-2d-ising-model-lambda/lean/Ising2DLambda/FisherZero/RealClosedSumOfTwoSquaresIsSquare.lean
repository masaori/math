/-
章「零点の詰め寄り」の「実閉部分体では二つの平方の和がまた平方である」
（`claim_real_closed_sum_of_two_squares_is_square`）と、その特殊化
「$2$ が平方であり $-2$ は平方でない」（`claim_two_is_square_in_real_closed`）の具体版。

  人手証明                                                          このファイル
  代数閉性で u·u = x + yω を満たす u を取る                          `IsAlgClosed.exists_pow_nat_eq`
  第 4 条件で u = a + bω と一意表示                                  `data.unique_decomposition`
  展開して x = a·a - b·b、y = a·b + a·b（一意性）                    `hx`, `hy`
  c := a·a + b·b と置き Gauss の恒等式                               `gauss_sum_of_two_squares_identity_necSuf`
  x := 1, y := 1 として 1+1 = s·s、s ≠ 0                             `two_is_square_in_realClosed`
  三分法の第 2 の場合が成り立つので第 3 は成り立たない               `neg_two_not_square_in_realClosed`

`2` を `1 + 1` と書くのは、部分体の数値リテラルの型変換を避けるためである
（`↑(2 : ↥carrier)` は `push_cast` で `(2 : Qbar)` へ落ちない）。人手証明の `2 := 1 + 1` と同じ約束である。

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.RealClosedSubfield
import Ising2DLambda.NecSuf.FisherZero.RealClosedSumOfTwoSquaresIsSquare
import Mathlib.FieldTheory.IsAlgClosed.Basic

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 平方の和は平方である。証人 `c` は一意表示の成分から `a·a + b·b` として作る。 -/
theorem realClosed_sum_of_two_squares_is_square (data : RealClosedSubfieldData)
    (x y : data.carrier) :
    ∃ c : data.carrier, x * x + y * y = c * c := by
  -- 代数閉性で平方根を取る。
  obtain ⟨u, hu⟩ :=
    IsAlgClosed.exists_pow_nat_eq ((x : Qbar) + (y : Qbar) * data.omega) (n := 2) two_pos
  have hu2 : u * u = (x : Qbar) + (y : Qbar) * data.omega := by
    rw [← hu]; ring
  -- 第 4 条件で u = a + bω。
  obtain ⟨⟨a, b⟩, hab, _⟩ := data.unique_decomposition u
  -- 展開して x + yω = (a·a - b·b) + (a·b + a·b)·ω。
  have hexp : (x : Qbar) + (y : Qbar) * data.omega
      = ((a * a - b * b : data.carrier) : Qbar)
        + ((a * b + a * b : data.carrier) : Qbar) * data.omega := by
    push_cast
    linear_combination (-1 : Qbar) * hu2
      + (u + (a : Qbar) + (b : Qbar) * data.omega) * hab
      + ((b : Qbar) * (b : Qbar)) * data.omega_sq
  -- 一意性で成分を比べる。
  obtain ⟨cd, _, huniq2⟩ := data.unique_decomposition ((x : Qbar) + (y : Qbar) * data.omega)
  have h1 : ((x, y) : data.carrier × data.carrier) = cd := huniq2 (x, y) rfl
  have h2 : ((a * a - b * b, a * b + a * b) : data.carrier × data.carrier) = cd :=
    huniq2 (a * a - b * b, a * b + a * b) hexp
  have hxy : ((x, y) : data.carrier × data.carrier)
      = (a * a - b * b, a * b + a * b) := by rw [h1, ← h2]
  have hx : x = a * a - b * b := congrArg Prod.fst hxy
  have hy : y = a * b + a * b := congrArg Prod.snd hxy
  -- Gauss の恒等式へ代入する（部分体の中の計算）。
  refine ⟨a * a + b * b, ?_⟩
  rw [hx, hy]
  ring

/-- `x := 1`, `y := 1` の特殊化。`1 + 1` は `R` の零でない元の平方である。 -/
theorem two_is_square_in_realClosed (data : RealClosedSubfieldData) :
    ∃ s : data.carrier, s ≠ 0 ∧ s * s = 1 + 1 := by
  obtain ⟨s, hs⟩ := realClosed_sum_of_two_squares_is_square data 1 1
  have hs' : s * s = 1 + 1 := by
    rw [← hs]; ring
  refine ⟨s, ?_, hs'⟩
  intro hzero
  rw [hzero] at hs'
  have hcast := congrArg (fun z : data.carrier => (z : Qbar)) hs'
  push_cast at hcast
  norm_num at hcast

/-- 三分法の第 2 の場合が成り立つので、第 3 の場合（`-(1+1)` が平方）は成り立たない。 -/
theorem neg_two_not_square_in_realClosed (data : RealClosedSubfieldData) :
    ¬ ∃ w : data.carrier, w ≠ 0 ∧ -(1 + 1 : data.carrier) = w * w := by
  obtain ⟨s, hs0, hs⟩ := two_is_square_in_realClosed data
  have htri := data.squareTrichotomy (1 + 1)
  exact fun hneg => htri.2.2.2 ⟨⟨s, hs0, hs.symm⟩, hneg⟩

end Ising2DLambda.FisherZero
