/-
主張「行の添字にもその像にも当たらない値を取る軌道の上の全単射の因子は零元である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitFactorZero`）の証明は、有限積から 1 つの
因子を括り出し、その因子が零元であることで結論する 1 本の議論である。証明手順は具体版と同じ。

  使っている性質                なぜ削れないか
  `hmem : i₁ ∈ O`               括り出す因子が積の中にあること。これが無いと零元の因子が
                                積に現れず、結論が成り立たない。
  `h : B i₁ (g i₁) = 0`         括り出した因子が零元であること。
  `CommMonoidWithZero S`        「零元を因子に持つ有限積は零元」と「零元を掛けると零元」。

削れたもの: 台 `O` が軌道であること、`g` が全単射であること（勝手な写像でよい）、
添字の型が有限であること・相等が判定できること、順序 `≺`、符号 `sgn_O`
（重み `w` には**何も要求していない**。±1 であることも乗法的であることも使わない）、
値の側の負号（可換半環に零元があれば足り、引き算は現れない）。

姉妹の `term_eq_zero_of_entry_zero`（台が全体 `univ`、`φ` が置換）との違いはここである。
**台を勝手な有限集合に、写像を勝手な写像に取り替えると、型の有限性と全単射性の仮定が落ちる。**
人手証明の側で言えば、この段は「軌道であること」も「$\psi$ が全単射であること」も使っていない。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、値は一般の可換モノイド）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 人手証明の主張「軌道の因子は、ある点で値が行の添字でもその像でもないとき零元である」の本体。

証明は人手証明どおり、有限積から `i₁` の因子を括り出し、それが零元であることで結論する。 -/
theorem orbitFactor_eq_zero_of_entry_zero {ι : Type*} {S : Type*} [CommMonoidWithZero S]
    (B : ι → ι → S) (w : S) (O : Finset ι) (g : ι → ι) {i₁ : ι}
    (hmem : i₁ ∈ O) (h : B i₁ (g i₁) = 0) :
    w * ∏ i ∈ O, B i (g i) = 0 := by
  have hprod : ∏ i ∈ O, B i (g i) = 0 := Finset.prod_eq_zero hmem h
  rw [hprod, mul_zero]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
