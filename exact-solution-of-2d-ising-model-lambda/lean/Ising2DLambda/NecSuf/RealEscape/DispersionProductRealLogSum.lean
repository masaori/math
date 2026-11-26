/-
分散因子の有限積の実対数をモード和へ移す論法の必要十分版。
必要なのは有限添字、正の実数値の因子、平方と有限積の等式、実数の係数と、
対数が正の実数の乗法を加法へ移すことだけである。実対数のほかの性質（単調性・連続性）、
分散多項式、代数的数、実閉部分体の構造は使わないので、対数は正の実数の乗法を加法へ移す
任意の写像 `lg : ℝ → ℝ` とする。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.RealEscape

/-- 準備: 正の実数の有限積の像は像の和。有限集合 `S` の元の個数についての帰納法。 -/
theorem positiveProduct_log_sum_necSuf {α : Type*} [DecidableEq α]
    (lg : ℝ → ℝ) (hmul : ∀ a b : ℝ, 0 < a → 0 < b → lg (a * b) = lg a + lg b)
    (S : Finset α) (u : α → ℝ) (hu : ∀ i, 0 < u i) :
    lg (∏ i ∈ S, u i) = ∑ i ∈ S, lg (u i) := by
  induction S using Finset.induction_on with
  | empty =>
      -- 空積は 1、空和は 0。lg(1) = lg(1·1) = lg(1) + lg(1) から lg(1) = 0
      rw [Finset.prod_empty, Finset.sum_empty]
      have h11 := hmul 1 1 one_pos one_pos
      rw [mul_one] at h11
      linarith
  | insert p S hp ih =>
      -- S ∪ {p} の積は u_p·(S の積)。乗法を加法へ移し、帰納法の仮定
      rw [Finset.prod_insert hp, Finset.sum_insert hp]
      rw [hmul (u p) (∏ i ∈ S, u i) (hu p) (Finset.prod_pos fun i _ => hu i)]
      rw [ih]

/-- 平方が正の有限積である実数の絶対値の対数を、因子ごとの和へ移す。 -/
theorem squareProduct_realLog_sum {α : Type*} [DecidableEq α]
    (lg : ℝ → ℝ) (hmul : ∀ a b : ℝ, 0 < a → 0 < b → lg (a * b) = lg a + lg b)
    (S : Finset α) (T : ℝ) (u : α → ℝ) (hu : ∀ i, 0 < u i)
    (hsq : T ^ 2 = ∏ i ∈ S, u i) (c : ℝ) :
    c * lg |T| = (c / 2) * ∑ i ∈ S, lg (u i) := by
  have hprodpos : 0 < ∏ i ∈ S, u i := Finset.prod_pos fun i _ => hu i
  have hT : T ≠ 0 := by
    intro hzero
    have hsqpos : 0 < T ^ 2 := hsq ▸ hprodpos
    simp [hzero] at hsqpos
  have habs : 0 < |T| := abs_pos.mpr hT
  have hlogabs : lg |T| = (1 / 2 : ℝ) * lg (T ^ 2) := by
    have hmulabs := hmul |T| |T| habs habs
    have hsquare : |T| * |T| = T ^ 2 := by rw [← pow_two, sq_abs]
    have hlog : lg (T ^ 2) = lg |T| + lg |T| := by
      calc
        lg (T ^ 2) = lg (|T| * |T|) := congrArg lg hsquare.symm
        _ = lg |T| + lg |T| := hmulabs
    linarith
  have hlogsum : lg (T ^ 2) = ∑ i ∈ S, lg (u i) := by
    calc
      lg (T ^ 2) = lg (∏ i ∈ S, u i) := congrArg lg hsq
      _ = ∑ i ∈ S, lg (u i) := positiveProduct_log_sum_necSuf lg hmul S u hu
  rw [hlogabs, hlogsum]
  ring

end Ising2DLambda.NecSuf.RealEscape
