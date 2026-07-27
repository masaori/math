/-
# 導関数の両側評価から増分の両側評価へ（抽象版）

対応する人手証明のラベル: `kappa_of_K_basic` (5)
（正本は `structured-latex/content/020_critical_point.ts`）

具体版: `Ising2D/Part020/Claim006_KappaOfK.lean`

## この主張に本質的に効いている構造は何か

人手証明 (5) は (R4)（微分積分学の基本定理）と (R3)（積分の単調性）を組み合わせて
`3.53|K-K_c| ≤ |κ(K)| ≤ 4.72|K-K_c|` を出している。しかし効いているのは

* 定義域が**凸**であること
* 導関数が定数 `c_lo`, `c_hi` で両側から抑えられること
* 下界 `c_lo` が**非負**であること（絶対値を両側に付けるため）

の 3 つだけであり、積分そのものは効いていない（平均値の定理で足りる）。
`κ` が Ising 模型の量であることも、`arcsinh` で書けることも効いていない。
-/
import Mathlib.Analysis.Calculus.Deriv.MeanValue

namespace Ising2D.Abstract

/-- **抽象版**: 凸集合 `D` 上で `c_lo ≤ f' ≤ c_hi`（`0 ≤ c_lo`）なら
`c_lo |y - x| ≤ |f y - f x| ≤ c_hi |y - x|`。 -/
theorem abs_sub_bounds_of_deriv_bounds {D : Set ℝ} (hD : Convex ℝ D) {f : ℝ → ℝ}
    {clo chi : ℝ} (hf : ContinuousOn f D) (hd : DifferentiableOn ℝ f (interior D))
    (hlo : ∀ x ∈ interior D, clo ≤ deriv f x) (hhi : ∀ x ∈ interior D, deriv f x ≤ chi)
    (hclo : 0 ≤ clo) {x y : ℝ} (hx : x ∈ D) (hy : y ∈ D) :
    clo * |y - x| ≤ |f y - f x| ∧ |f y - f x| ≤ chi * |y - x| := by
  rcases le_total x y with h | h
  · have h1 := hD.mul_sub_le_image_sub_of_le_deriv hf hd hlo x hx y hy h
    have h2 := hD.image_sub_le_mul_sub_of_deriv_le hf hd hhi x hx y hy h
    have hd0 : 0 ≤ y - x := by linarith
    have hfd : 0 ≤ f y - f x := le_trans (by positivity) h1
    rw [abs_of_nonneg hd0, abs_of_nonneg hfd]
    exact ⟨h1, h2⟩
  · have h1 := hD.mul_sub_le_image_sub_of_le_deriv hf hd hlo y hy x hx h
    have h2 := hD.image_sub_le_mul_sub_of_deriv_le hf hd hhi y hy x hx h
    have hd0 : 0 ≤ x - y := by linarith
    have hfd : 0 ≤ f x - f y := le_trans (by positivity) h1
    rw [abs_of_nonpos (by linarith : y - x ≤ 0), abs_of_nonpos (by linarith : f y - f x ≤ 0)]
    constructor <;> linarith

/-- **抽象版**: 凸集合 `D` 上で `|f'| ≤ C` なら `|f y - f x| ≤ C |y - x|`。 -/
theorem abs_sub_le_of_abs_deriv_le {D : Set ℝ} (hD : Convex ℝ D) {f : ℝ → ℝ} {C : ℝ}
    (hf : ContinuousOn f D) (hd : DifferentiableOn ℝ f (interior D))
    (hC : ∀ x ∈ interior D, |deriv f x| ≤ C) {x y : ℝ} (hx : x ∈ D) (hy : y ∈ D) :
    |f y - f x| ≤ C * |y - x| := by
  have hlo : ∀ z ∈ interior D, -C ≤ deriv f z := fun z hz => (abs_le.1 (hC z hz)).1
  have hhi : ∀ z ∈ interior D, deriv f z ≤ C := fun z hz => (abs_le.1 (hC z hz)).2
  rcases le_total x y with h | h
  · have h1 := hD.mul_sub_le_image_sub_of_le_deriv hf hd hlo x hx y hy h
    have h2 := hD.image_sub_le_mul_sub_of_deriv_le hf hd hhi x hx y hy h
    rw [abs_of_nonneg (by linarith : (0:ℝ) ≤ y - x), abs_le]
    constructor <;> linarith
  · have h1 := hD.mul_sub_le_image_sub_of_le_deriv hf hd hlo y hy x hx h
    have h2 := hD.image_sub_le_mul_sub_of_deriv_le hf hd hhi y hy x hx h
    rw [abs_of_nonpos (by linarith : y - x ≤ 0), abs_le]
    constructor <;> linarith

end Ising2D.Abstract
