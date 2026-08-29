/-
章「トーラス上の Kac--Ward 行列式」の「閉歩道の循環総回転数は 4 の倍数である」
（`claim_cyclic_total_turning_multiple_of_four`）の必要十分版。

人手証明が使うのは次の三つだけである。
- 射影 π₄ が零を零へ送ること（`hzero`。人手証明の「π₄(0) は零元」）。
- 射影 π₄ の加法性（`hadd`。型クラスではなく素の仮定として置く。
  人手証明が使うのは二項の加法性そのものだからである）。
- 方向番号の住む集合での左簡約（人手証明の「両辺に加法逆元を加える」一歩。
  群である必要はなく `AddLeftCancelMonoid` で足りる。この仮定が必要な理由は、
  簡約できないモノイドでは `d + x = d` から `x = 0` が従わないことである）。

辺・トーラス・ℤ/4ℤ は具体側のデータであり、この代数計算そのものには現れない。
歩道に沿う方向番号の更新列を `List.foldl` で表し、人手証明の帰納法
（`claim_walk_direction_difference`）はリストの帰納法に対応する。
一歩の更新（`claim_step_advances_direction`）は、この模型では更新関数
`fun a n => a + φ n` の定義そのものにあたるため、独立した定理を持たない。
-/
import Ising2DLambda.NecSuf.KacWard.TotalTurning

namespace Ising2DLambda.NecSuf.KacWard

/-- 端の値の差は更新量の総和である（`claim_walk_direction_difference` の骨格）。
人手証明と同じく、列の長さについての帰納法で示す。仮定は `φ` が零を保つことと
加法性だけである。 -/
theorem foldl_add_of_additive_necSuf {A : Type*} [AddMonoid A] (φ : ℤ → A)
    (hzero : φ 0 = 0) (hadd : ∀ a b : ℤ, φ (a + b) = φ a + φ b)
    (d : A) (steps : List ℤ) :
    steps.foldl (fun a n => a + φ n) d = d + φ steps.sum := by
  induction steps generalizing d with
  | nil => simp [hzero]
  | cons head tail ih =>
    simp [List.foldl_cons, ih, List.sum_cons, hadd, add_assoc]

/-- 一周して端の値が戻るなら、更新量の総和の像は零である
（`claim_cyclic_total_turning_multiple_of_four` の骨格）。
人手証明の四段（一歩の更新・帰納法の等式・加法性・循環総回転数の定義）を
`foldl_add_of_additive_necSuf` と `hadd` でまとめ、最後に左簡約する。 -/
theorem closed_walk_additive_vanishes_necSuf {A : Type*} [AddLeftCancelMonoid A]
    (φ : ℤ → A) (hzero : φ 0 = 0) (hadd : ∀ a b : ℤ, φ (a + b) = φ a + φ b)
    (d : A) (steps : List ℤ) (closing : ℤ)
    (hclosed : steps.foldl (fun a n => a + φ n) d + φ closing = d) :
    φ (steps.sum + closing) = 0 := by
  have h1 : d + (φ steps.sum + φ closing) = d + 0 := by
    rw [← add_assoc, ← foldl_add_of_additive_necSuf φ hzero hadd d steps, hclosed,
      add_zero]
  rw [hadd]
  exact add_left_cancel h1

end Ising2DLambda.NecSuf.KacWard
