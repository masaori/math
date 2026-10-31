/-
# 必要十分版: 平方が単位元の元の指数級数の偶奇分解

対応する人手証明のラベル: **`trace_of_epsilon_V_plus`** の Step 2 の
`exp(K_1εG) = cosh(K_1)I + sinh(K_1)εG`
（具体版は `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusReduction.lean` の `matExp_smul_of_sq_eq_one`、
系としての導出は `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusReductionFromNecSuf.lean`）

## 証明手順（具体版と同じ）

1. 偶数次の項: `A^{2n} = 1` なので `((2n)!)^{-1}(tA)^{2n} = (t^{2n}/(2n)!)·1`。その和は `cosh(t)·1`。
2. 奇数次の項: `A^{2n+1} = A` なので `((2n+1)!)^{-1}(tA)^{2n+1} = (t^{2n+1}/(2n+1)!)·A`。その和は `sinh(t)·A`。
3. 偶数次と奇数次を足し直すと、指数級数の部分和の極限は `cosh(t)·1 + sinh(t)·A`。極限は一つに決まるので `E` に等しい。

## 何が効いているか / 効いていないか

- **効いている**: `A^2 = 1`（偶奇の冪を `1` と `A` に落とす）、`ℂ` のスカラー倍と冪の交換 `(tA)^k = t^k A^k`
  （`ℂ`-代数であること）、スカラー倍と和の極限の交換（`ContinuousSMul ℂ 𝔸`）、足し算と極限の交換
  （`ContinuousAdd 𝔸`）、極限の一意性（`T2Space 𝔸`）。
- **効いていない**: 行列であること、`𝔸` の可換性、ノルムと完備性（指数級数の部分和が `E` に収束することは
  仮定 `hE` として受け取り、収束の理由は使わない。`hE` は人手の `def_exp` と同じく部分和の極限であり、
  項の順序によらない和は要求しない）、`t` が実数であること（`t ∈ ℂ` で通る）、`A` が `εG` という具体的な
  積であること。
- 引き算も使わないので `𝔸` は半環でよい。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Series

namespace Ising2D.NecSuf

open Filter Topology

variable {𝔸 : Type*} [Semiring 𝔸]

/-- 手順 1 の `A^{2n} = 1`。 -/
theorem pow_two_mul_of_sq_eq_one {A : 𝔸} (hA : A ^ 2 = 1) (n : ℕ) : A ^ (2 * n) = 1 := by
  rw [pow_mul, hA, one_pow]

/-- 手順 2 の `A^{2n+1} = A`。 -/
theorem pow_two_mul_add_one_of_sq_eq_one {A : 𝔸} (hA : A ^ 2 = 1) (n : ℕ) :
    A ^ (2 * n + 1) = A := by
  rw [pow_succ, pow_two_mul_of_sq_eq_one hA n, one_mul]

variable [Algebra ℂ 𝔸] [TopologicalSpace 𝔸] [ContinuousAdd 𝔸] [ContinuousSMul ℂ 𝔸] [T2Space 𝔸]

/-- **平方が単位元の元の指数級数の偶奇分解**: `A^2 = 1` で、指数級数 `∑_k (k!)^{-1}(tA)^k` の部分和の極限が `E` なら
`E = cosh(t)·1 + sinh(t)·A`。 -/
theorem exp_series_sum_of_sq_eq_one {A E : 𝔸} (hA : A ^ 2 = 1) (t : ℂ)
    (hE : Tendsto (fun N : ℕ => ∑ k ∈ Finset.range N, ((k.factorial : ℂ))⁻¹ • (t • A) ^ k)
      atTop (𝓝 E)) :
    E = Complex.cosh t • (1 : 𝔸) + Complex.sinh t • A := by
  -- 手順 1
  have heven : HasSum (fun n : ℕ => (((2 * n).factorial : ℂ))⁻¹ • (t • A) ^ (2 * n))
      (Complex.cosh t • (1 : 𝔸)) := by
    refine ((Complex.hasSum_cosh t).smul_const (1 : 𝔸)).congr_fun fun n => ?_
    rw [smul_pow, pow_two_mul_of_sq_eq_one hA n, smul_smul, div_eq_inv_mul]
  -- 手順 2
  have hodd : HasSum (fun n : ℕ => (((2 * n + 1).factorial : ℂ))⁻¹ • (t • A) ^ (2 * n + 1))
      (Complex.sinh t • A) := by
    refine ((Complex.hasSum_sinh t).smul_const A).congr_fun fun n => ?_
    rw [smul_pow, pow_two_mul_add_one_of_sq_eq_one hA n, smul_smul, div_eq_inv_mul]
  -- 手順 3
  exact tendsto_nhds_unique hE
    (HasSum.even_add_odd (f := fun k : ℕ => ((k.factorial : ℂ))⁻¹ • (t • A) ^ k) heven hodd).tendsto_sum_nat

end Ising2D.NecSuf
