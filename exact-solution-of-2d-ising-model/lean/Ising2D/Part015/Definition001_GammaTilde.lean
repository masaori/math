/-
# `γ_1(θ), γ_2(θ)` と `A(θ~_μ)` の書き換え（**具体版**）

対応する人手証明のラベル: `def_gamma1_gamma2_of_theta`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_001_definition_gamma1_gamma2`）

**必要十分版は無い。** この主張は「`A(θ)` の 4 成分が `γ_1, γ_2` で書ける」という
定義の言い換えであり、取り払える構造が残っていない（`γ_2(-θ)` の明示形を
`cos(-θ) = cos θ`, `sin(-θ) = -sin θ` で計算するだけ）。

## 形式化の方針

人手証明は 015 章で `γ_1, γ_2` を `θ ∈ ℝ` の関数として**ラベル付きで定義し直して**いるが、
式は 008 章のものと文字どおり同一である（本文の `conversion.notes` にもそう書かれている）。
Lean 側では 008 章の時点で既に `θ ∈ ℝ` 全体の関数として
`Ising2D.gamma1` / `Ising2D.gamma2` / `Ising2D.AMat`（`Part008/Definition019_ThetaGamma.lean`）
が定義され、書き換え `A(θ) = !![γ_1, γ_2(θ); -γ_2(-θ), γ_1]` も
`Ising2D.AMat_eq` として証明済みである。**したがって新しい定義は導入せず、
半整数運動量 `θ~_μ`（`Ising2D.thetaTilde`、`Part013/Claim002_AntiperiodicExpSum.lean`）
への特殊化だけをここに置く。**

本ファイルではさらに、以降の章で繰り返し使う
`M · θ~_μ = (2μ-1)π`（半整数運動量が `π` の**奇数**倍になること）を用意する。
これが 015 章全体の要である（整数運動量では `M · θ_μ = 2μπ` で偶数倍）。
-/
import Ising2D.Part008.Claim027_EigenATheta
import Ising2D.Part012.Claim001_Gamma1LowerBound
import Ising2D.Part013.Definition003a_CheckIndexSet

namespace Ising2D

open Matrix

variable (K : IsingConst)

/-- **人手証明 `def_gamma1_gamma2_of_theta` の書き換え**を半整数運動量へ特殊化した形:
`A(θ~_μ) = !![γ_1(θ~_μ), γ_2(θ~_μ); -γ_2(-θ~_μ), γ_1(θ~_μ)]`。 -/
theorem AMat_thetaTilde_eq (M : ℕ) (μ : ℤ) :
    AMat K (thetaTilde M μ)
      = !![gamma1 K (thetaTilde M μ), gamma2 K (thetaTilde M μ);
          -gamma2 K (-thetaTilde M μ), gamma1 K (thetaTilde M μ)] :=
  AMat_eq K (thetaTilde M μ)

/-- **015 章の要**: `M · θ~_μ = (2μ-1)π`。右辺の係数 `2μ-1` は**奇数**である。

整数運動量では `M · θ_μ = 2μ · π`（偶数倍）であり、この違いが
`gamma_2_theta_tilde_nonzero` の例外の有無を生む。 -/
theorem thetaTilde_mul_M (M : ℕ) (hM : M ≠ 0) (μ : ℤ) :
    (M : ℝ) * thetaTilde M μ = ((2 * μ - 1 : ℤ) : ℝ) * Real.pi := by
  have hM' : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [thetaTilde]
  push_cast
  field_simp

/-- `2μ-1` が奇数であること（`thetaTilde_mul_M` と組で使う）。 -/
theorem odd_two_mul_sub_one (μ : ℤ) : Odd (2 * μ - 1) := ⟨μ - 1, by ring⟩

end Ising2D
