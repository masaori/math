/-
# 実数の冪の包含は包含の冪に等しい（具体版を必要十分版から導く）

具体版 `ClaimRealInclusionPreservesPower.lean` の `real_inclusion_of_power`（人手 `real_inclusion_preserves_power`）を、
必要十分版 `Ising2D/NecSuf/MultiplicativeMapPreservesPower.lean` の `NecSuf.map_pow_of_map_one_of_map_mul'` の
`A := ℝ`、`B := ℂ`、`f := ι_{ℝ→ℂ}`（`Complex.ofReal`）の特殊化として得る。仮定の `f(1) = 1` は `Complex.ofReal_one`、
`f(ab) = f(a)f(b)` は具体版 `real_inclusion_mul`（人手 `real_inclusion_preserves_product`）を右辺から左辺へ使ったものである。

必要十分版は冪を `npowRec`（`a^0 = 1`、`a^{m+1} = a^m a`）で書くので、`ℝ`・`ℂ` の記法 `^` との一致を
`npowRec_eq_pow_of_power_equations` で両側に 1 回ずつ使う。この一致は、`ℝ`・`ℂ` の冪が人手の
`def_power_of_real_number`・`def_power_of_complex_number` と同じ 2 つの式を満たすこと（`pow_zero`・`pow_succ`）から、
`m` の帰納法で示す。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesPower
import Ising2D.NecSuf.MultiplicativeMapPreservesPower

namespace Ising2D

/-- 冪の 2 つの式 `a^0 = 1`（`h0`）・`a^{m+1} = a^m a`（`hs`）を満たす記法 `^` は `npowRec` と一致する。
`ℝ`・`ℂ` では `h0 := pow_zero`、`hs := pow_succ` として当てる。 -/
theorem npowRec_eq_pow_of_power_equations {M : Type*} [One M] [Mul M] [Pow M ℕ]
    (h0 : ∀ a : M, a ^ 0 = 1) (hs : ∀ (a : M) (m : ℕ), a ^ (m + 1) = a ^ m * a) (a : M) (m : ℕ) :
    npowRec m a = a ^ m := by
  induction m with
  | zero =>
    calc npowRec 0 a
        = 1 := rfl                               -- `npowRec` の `a^0 = 1`
      _ = a ^ 0 := (h0 a).symm                   -- 記法 `^` の `a^0 = 1` を右辺から左辺へ
  | succ m ih =>
    calc npowRec (m + 1) a
        = npowRec m a * a := rfl                 -- `npowRec` の `a^{m+1} = a^m a`
      _ = a ^ m * a := by rw [ih]                -- 帰納法の仮定
      _ = a ^ (m + 1) := (hs a m).symm           -- 記法 `^` の `a^{m+1} = a^m a` を右辺から左辺へ

/-- `real_inclusion_of_power` を `NecSuf.map_pow_of_map_one_of_map_mul'` の `f := ι_{ℝ→ℂ}` として得る。 -/
theorem real_inclusion_of_power_of_necSuf (r : ℝ) (m : ℕ) : ((r ^ m : ℝ) : ℂ) = (r : ℂ) ^ m :=
  calc ((r ^ m : ℝ) : ℂ)
      = ((npowRec m r : ℝ) : ℂ) := by rw [npowRec_eq_pow_of_power_equations pow_zero pow_succ r m]   -- `ℝ` の冪と `npowRec` の一致
    _ = npowRec m (r : ℂ) :=
        NecSuf.map_pow_of_map_one_of_map_mul' (fun x : ℝ => (x : ℂ)) Complex.ofReal_one
          (fun a b => (real_inclusion_mul a b).symm) r m                            -- 必要十分版の特殊化
    _ = (r : ℂ) ^ m := npowRec_eq_pow_of_power_equations pow_zero pow_succ (r : ℂ) m                 -- `ℂ` の冪と `npowRec` の一致

end Ising2D
