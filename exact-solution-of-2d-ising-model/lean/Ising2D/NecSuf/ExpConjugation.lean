/-
# 必要十分版: `exp(X) A exp(-X)` の級数展開（随伴作用の指数関数表示）

対応する人手証明のラベル: **`<exp_X_Y_exp_-X>`**
（`structured-latex/content/008_TV1_hatZ_hatY_part1.mjs` の
`TV1_hatZ_hatY_006_claim_exp_conjugation`。級数展開の本体は 005 章
`structured-latex/content/005_exp_conjugation_proof.mjs` の
`<matrix_exp_conjugation>` と `<ad_binomial>`）。

**具体版は `Ising2D/Part008/Claim006_ExpConjugation.lean`**
（`Mat(2,ℂ)^{⊗M}` = `Ising2D.TensorPow M` の元について人手証明と 1 対 1 に対応する形で述べ、
本ファイルの系として導出する）。

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

## 何が本質的か

* **行列であることも、有限次元であることも効いていない。** 必要なのは
  「ℂ 上のノルム環で、かつ完備であること」だけである（`NormedRing 𝔸`,
  `NormedAlgebra ℂ 𝔸`, `CompleteSpace 𝔸`）。完備性は指数級数が収束するために要る。
* **リー群・リー環は一切要らない。** 効いているのは
  「左乗法 `L_X : A ↦ X A` と右乗法 `R_X : A ↦ A X` が**線型作用素として可換**である」
  という一点だけである（`mul_assoc` から出る）。随伴作用は `ad X = L_X - R_X` なので、
  可換な作用素の指数法則 `exp(P+Q) = exp(P) exp(Q)` から
  `exp(ad X) = exp(L_X) ∘ exp(-R_X)` が出る。
* **`exp(L_X) = L_{exp X}` に効いているのは `(L_X)^n = L_{X^n}` と `L` の連続線型性だけ**である
  （代数準同型であることまでは要らない）。右乗法も `(R_X)^n = R_{X^n}` なので同じ議論で済み、
  反同型・反対環を経由する必要がない。
* 人手証明が `ad_binomial`（二項定理型の展開）と有限和の組み替えで通しているところを、
  ここでは「可換な作用素の指数法則」1 本に置き換えている。どちらも
  「`L_X` と `R_X` が可換」という同じ事実の言い換えである。

## 2 次元不変部分空間での閉じた形（後段で使う系）

`ad X` が `span{z, y}` を保つ場合、すなわち `ad X z = α y`, `ad X y = β z` のとき、
`s^2 = α β` を満たす `s` をとると

  `exp(X) z exp(-X) = cosh(s) z + α sinhc(s) y`
  `exp(X) y exp(-X) = cosh(s) y + β sinhc(s) z`

となる。ここで `sinhc(s) := sinh(s)/s`（`s = 0` では `1`）である。
`sinh(s)/s` をそのまま書くと `s = 0` で 0 割りになるので、`sinhc` を別に定義して
**`s = 0` の場合も含めて成り立つ形**にしてある。
`s ≠ 0` のときは `α sinhc(s) = (α/s) sinh(s)` なので、人手証明
`<extract_taylor_coefficient_of_Z_Y>` の `cosh(K_1) ẑ + i e^{-iθ} sinh(K_1) ŷ` の形と
（`s = K_1`, `α = i e^{-iθ} K_1` として）一致する。
-/
import Mathlib.Analysis.Normed.Algebra.Exponential
import Mathlib.Analysis.Normed.Operator.Mul
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Series
import Mathlib.Topology.Algebra.InfiniteSum.Module

namespace Ising2D.NecSuf

open NormedSpace Nat

/-! ## `sinhc` と cosh / sinh の冪級数 -/

section Sinhc

/-- `sinhc s := sinh s / s`（ただし `s = 0` では `1`）。

`sinh` の冪級数 `∑ s^{2k+1}/(2k+1)!` を `s` で割った `∑ s^{2k}/(2k+1)!` の値であり、
`s = 0` でも意味をもつ。 -/
noncomputable def sinhc (s : ℂ) : ℂ := if s = 0 then 1 else Complex.sinh s / s

@[simp] theorem sinhc_zero : sinhc 0 = 1 := if_pos rfl

theorem sinhc_of_ne_zero {s : ℂ} (hs : s ≠ 0) : sinhc s = Complex.sinh s / s := if_neg hs

/-- `s · sinhc s = sinh s`（`s = 0` でも成立: 両辺 `0`）。 -/
theorem mul_sinhc (s : ℂ) : s * sinhc s = Complex.sinh s := by
  by_cases hs : s = 0
  · simp [hs]
  · rw [sinhc_of_ne_zero hs, mul_div_cancel₀ _ hs]

/-- `sinhc` の冪級数 `sinhc s = ∑_{k≥0} s^{2k}/(2k+1)!`。

`s ≠ 0` のときは `sinh` の冪級数（mathlib の `Complex.hasSum_sinh`）を `s` で割って得る。
`s = 0` のときは `k = 0` の項だけが残り、和は `1 = sinhc 0` になる。 -/
theorem hasSum_sinhc (s : ℂ) :
    HasSum (fun k : ℕ => s ^ (2 * k) / ((2 * k + 1)! : ℂ)) (sinhc s) := by
  by_cases hs : s = 0
  · subst hs
    have hfun : (fun k : ℕ => (0 : ℂ) ^ (2 * k) / ((2 * k + 1)! : ℂ))
        = fun k : ℕ => if k = 0 then (1 : ℂ) else 0 := by
      funext k
      rcases Nat.eq_zero_or_pos k with rfl | hk
      · norm_num
      · rw [if_neg (by omega), zero_pow (by omega), zero_div]
    rw [hfun, sinhc_zero]
    simpa using hasSum_ite_eq (0 : ℕ) (1 : ℂ)
  · have h := (Complex.hasSum_sinh s).mul_right s⁻¹
    have hfun : (fun k : ℕ => s ^ (2 * k) / ((2 * k + 1)! : ℂ))
        = fun k : ℕ => s ^ (2 * k + 1) / ((2 * k + 1)! : ℂ) * s⁻¹ := by
      funext k
      have hfac : (((2 * k + 1)! : ℕ) : ℂ) ≠ 0 :=
        Nat.cast_ne_zero.mpr (Nat.factorial_ne_zero _)
      rw [pow_succ]
      field_simp
    rw [sinhc_of_ne_zero hs, div_eq_mul_inv, hfun]
    exact h

end Sinhc

/-! ## 左乗法・右乗法と随伴作用 -/

section Ad

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]

/-- 左乗法 `L_x : a ↦ x * a`（連続 ℂ-線型作用素として）。 -/
noncomputable def lmulCLM (x : 𝔸) : 𝔸 →L[ℂ] 𝔸 := ContinuousLinearMap.mul ℂ 𝔸 x

/-- 右乗法 `R_x : a ↦ a * x`（連続 ℂ-線型作用素として）。 -/
noncomputable def rmulCLM (x : 𝔸) : 𝔸 →L[ℂ] 𝔸 := (ContinuousLinearMap.mul ℂ 𝔸).flip x

/-- 随伴作用 `ad x = L_x - R_x`、すなわち `a ↦ x a - a x`。 -/
noncomputable def adCLM (x : 𝔸) : 𝔸 →L[ℂ] 𝔸 := lmulCLM x - rmulCLM x

@[simp] theorem lmulCLM_apply (x a : 𝔸) : lmulCLM x a = x * a := rfl
@[simp] theorem rmulCLM_apply (x a : 𝔸) : rmulCLM x a = a * x := rfl
@[simp] theorem adCLM_apply (x a : 𝔸) : adCLM x a = x * a - a * x := rfl

/-- **本証明の核**: 左乗法と右乗法は線型作用素として可換。
効いているのは結合律 `x (a y) = (x a) y` だけである。 -/
theorem commute_lmulCLM_rmulCLM (x y : 𝔸) : Commute (lmulCLM x) (rmulCLM y) := by
  ext a
  simp [mul_assoc]

theorem lmulCLM_pow (x : 𝔸) : ∀ n : ℕ, lmulCLM x ^ n = lmulCLM (x ^ n)
  | 0 => by ext a; simp [lmulCLM]
  | n + 1 => by
      ext a
      rw [pow_succ, pow_succ]
      simp [lmulCLM_pow x n, mul_assoc]

theorem rmulCLM_pow (x : 𝔸) : ∀ n : ℕ, rmulCLM x ^ n = rmulCLM (x ^ n)
  | 0 => by ext a; simp [rmulCLM]
  | n + 1 => by
      ext a
      rw [pow_succ, pow_succ]
      simp [rmulCLM_pow x n, mul_assoc, ((Commute.refl x).pow_right n).eq]

/-- `exp(L_x) = L_{exp x}`。`L` が連続線型であることと `(L_x)^n = L_{x^n}` だけを使う
（代数準同型であることまでは要らない）。 -/
theorem exp_lmulCLM (x : 𝔸) : exp (lmulCLM x) = lmulCLM (exp x) := by
  have h := (ContinuousLinearMap.mul ℂ 𝔸).hasSum
    (NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) x)
  simp only [map_smul] at h
  have hfun : ∀ n : ℕ,
      (ContinuousLinearMap.mul ℂ 𝔸) (x ^ n) = lmulCLM x ^ n := fun n => (lmulCLM_pow x n).symm
  simp only [hfun] at h
  exact (NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) (lmulCLM x)).unique h

/-- `exp(R_x) = R_{exp x}`。右乗法は反同型だが、`(R_x)^n = R_{x^n}` は左乗法と同じ形なので
反対環を経由する必要はない。 -/
theorem exp_rmulCLM (x : 𝔸) : exp (rmulCLM x) = rmulCLM (exp x) := by
  have h := ((ContinuousLinearMap.mul ℂ 𝔸).flip).hasSum
    (NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) x)
  simp only [map_smul] at h
  have hfun : ∀ n : ℕ,
      ((ContinuousLinearMap.mul ℂ 𝔸).flip) (x ^ n) = rmulCLM x ^ n := fun n =>
    (rmulCLM_pow x n).symm
  simp only [hfun] at h
  exact (NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) (rmulCLM x)).unique h

/-- **必要十分版の本体**（人手証明 `<exp_X_Y_exp_-X>`）:
`exp(ad x)(a) = exp(x) a exp(-x)`。

証明は「`L_x` と `R_x` が可換」→「可換な作用素の指数法則」→「`exp(L_x) = L_{exp x}`」の 3 段。 -/
theorem exp_adCLM_apply (x a : 𝔸) : exp (adCLM x) a = exp x * a * exp (-x) := by
  have hneg : rmulCLM (-x) = -rmulCLM x := by ext b; simp
  have hsplit : adCLM x = lmulCLM x + rmulCLM (-x) := by
    rw [hneg, adCLM, sub_eq_add_neg]
  have hc : Commute (lmulCLM x) (rmulCLM (-x)) := commute_lmulCLM_rmulCLM x (-x)
  haveI : NormedAlgebra ℚ 𝔸 := NormedAlgebra.restrictScalars ℚ ℂ 𝔸
  haveI : NormedAlgebra ℚ (𝔸 →L[ℂ] 𝔸) := NormedAlgebra.restrictScalars ℚ ℂ (𝔸 →L[ℂ] 𝔸)
  rw [hsplit, exp_add_of_commute hc, exp_lmulCLM, exp_rmulCLM]
  show exp x * (a * exp (-x)) = exp x * a * exp (-x)
  rw [mul_assoc]

/-- **級数の形**（人手証明 `<exp_X_Y_exp_-X>` の右辺）:
級数 `Σ_n (1/n!) ad_x^n(a)` は収束し、その和は `exp(x) a exp(-x)` である。 -/
theorem hasSum_exp_conj (x a : 𝔸) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ • ((adCLM x ^ n) a)) (exp x * a * exp (-x)) := by
  have h := (ContinuousLinearMap.apply ℂ 𝔸 a).hasSum
    (NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) (adCLM x))
  simp only [map_smul, ContinuousLinearMap.apply_apply] at h
  rwa [exp_adCLM_apply] at h

/-- 同じ主張を `tsum` で書いた版。 -/
theorem exp_conj_eq_tsum (x a : 𝔸) :
    exp x * a * exp (-x) = ∑' n : ℕ, ((n ! : ℂ))⁻¹ • ((adCLM x ^ n) a) :=
  (hasSum_exp_conj x a).tsum_eq.symm

end Ad

/-! ## 2 次元不変部分空間での閉じた形 -/

section TwoDim

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]
variable {x z y : 𝔸} {α β s : ℂ}

/-- `ad x` が `span{z, y}` を保つとき、`(ad x)^2` は `z` の向きに `s^2` 倍として働く。 -/
theorem adCLM_sq_z (hz : adCLM x z = α • y) (hy : adCLM x y = β • z) (hs : s ^ 2 = α * β) :
    (adCLM x ^ 2) z = (s ^ 2) • z := by
  rw [pow_two]
  show adCLM x (adCLM x z) = _
  rw [hz, map_smul, hy, smul_smul, hs]

/-- 同上（`y` の向き）。 -/
theorem adCLM_sq_y (hz : adCLM x z = α • y) (hy : adCLM x y = β • z) (hs : s ^ 2 = α * β) :
    (adCLM x ^ 2) y = (s ^ 2) • y := by
  rw [pow_two]
  show adCLM x (adCLM x y) = _
  rw [hy, map_smul, hz, smul_smul, hs, mul_comm α β]

/-- 偶数回の随伴作用: `(ad x)^{2k} z = s^{2k} z`, `(ad x)^{2k} y = s^{2k} y`。 -/
theorem adCLM_pow_even (hz : adCLM x z = α • y) (hy : adCLM x y = β • z) (hs : s ^ 2 = α * β) :
    ∀ k : ℕ, (adCLM x ^ (2 * k)) z = (s ^ (2 * k)) • z ∧
      (adCLM x ^ (2 * k)) y = (s ^ (2 * k)) • y
  | 0 => by simp
  | k + 1 => by
      obtain ⟨ihz, ihy⟩ := adCLM_pow_even hz hy hs k
      have hmul : 2 * (k + 1) = 2 * k + 2 := by ring
      constructor
      · rw [hmul, pow_add]
        show (adCLM x ^ (2 * k)) ((adCLM x ^ 2) z) = _
        rw [adCLM_sq_z hz hy hs, map_smul, ihz, smul_smul, ← pow_add, Nat.add_comm]
      · rw [hmul, pow_add]
        show (adCLM x ^ (2 * k)) ((adCLM x ^ 2) y) = _
        rw [adCLM_sq_y hz hy hs, map_smul, ihy, smul_smul, ← pow_add, Nat.add_comm]

/-- 奇数回の随伴作用（`z` 始点）: `(ad x)^{2k+1} z = s^{2k} α y`。 -/
theorem adCLM_pow_odd_z (hz : adCLM x z = α • y) (hy : adCLM x y = β • z) (hs : s ^ 2 = α * β)
    (k : ℕ) : (adCLM x ^ (2 * k + 1)) z = (s ^ (2 * k) * α) • y := by
  rw [pow_add, pow_one]
  show (adCLM x ^ (2 * k)) (adCLM x z) = _
  rw [hz, map_smul, (adCLM_pow_even hz hy hs k).2, smul_smul, mul_comm α]

/-- 奇数回の随伴作用（`y` 始点）: `(ad x)^{2k+1} y = s^{2k} β z`。 -/
theorem adCLM_pow_odd_y (hz : adCLM x z = α • y) (hy : adCLM x y = β • z) (hs : s ^ 2 = α * β)
    (k : ℕ) : (adCLM x ^ (2 * k + 1)) y = (s ^ (2 * k) * β) • z := by
  rw [pow_add, pow_one]
  show (adCLM x ^ (2 * k)) (adCLM x y) = _
  rw [hy, map_smul, (adCLM_pow_even hz hy hs k).1, smul_smul, mul_comm β]

/-- **系（後段で使う閉じた形）**: `ad x` が `span{z, y}` を保つとき、
`exp(x) z exp(-x) = cosh(s) z + α sinhc(s) y`。`s = 0` の場合も含めて成り立つ。 -/
theorem exp_conj_two_dim_z (hz : adCLM x z = α • y) (hy : adCLM x y = β • z)
    (hs : s ^ 2 = α * β) :
    exp x * z * exp (-x) = Complex.cosh s • z + (α * sinhc s) • y := by
  refine (hasSum_exp_conj x z).unique (HasSum.even_add_odd ?_ ?_)
  · have heq : ∀ k : ℕ, ((((2 * k)! : ℕ) : ℂ))⁻¹ • ((adCLM x ^ (2 * k)) z)
        = (s ^ (2 * k) / (((2 * k)! : ℕ) : ℂ)) • z := by
      intro k
      rw [(adCLM_pow_even hz hy hs k).1, smul_smul, div_eq_mul_inv, mul_comm]
    simpa only [heq] using (Complex.hasSum_cosh s).smul_const z
  · have heq : ∀ k : ℕ, ((((2 * k + 1)! : ℕ) : ℂ))⁻¹ • ((adCLM x ^ (2 * k + 1)) z)
        = (α * (s ^ (2 * k) / (((2 * k + 1)! : ℕ) : ℂ))) • y := by
      intro k
      rw [adCLM_pow_odd_z hz hy hs k, smul_smul]
      congr 1
      rw [div_eq_mul_inv]
      ring
    simpa only [heq] using ((hasSum_sinhc s).mul_left α).smul_const y

/-- 同上（`y` 始点）: `exp(x) y exp(-x) = cosh(s) y + β sinhc(s) z`。 -/
theorem exp_conj_two_dim_y (hz : adCLM x z = α • y) (hy : adCLM x y = β • z)
    (hs : s ^ 2 = α * β) :
    exp x * y * exp (-x) = Complex.cosh s • y + (β * sinhc s) • z := by
  refine (hasSum_exp_conj x y).unique (HasSum.even_add_odd ?_ ?_)
  · have heq : ∀ k : ℕ, ((((2 * k)! : ℕ) : ℂ))⁻¹ • ((adCLM x ^ (2 * k)) y)
        = (s ^ (2 * k) / (((2 * k)! : ℕ) : ℂ)) • y := by
      intro k
      rw [(adCLM_pow_even hz hy hs k).2, smul_smul, div_eq_mul_inv, mul_comm]
    simpa only [heq] using (Complex.hasSum_cosh s).smul_const y
  · have heq : ∀ k : ℕ, ((((2 * k + 1)! : ℕ) : ℂ))⁻¹ • ((adCLM x ^ (2 * k + 1)) y)
        = (β * (s ^ (2 * k) / (((2 * k + 1)! : ℕ) : ℂ))) • z := by
      intro k
      rw [adCLM_pow_odd_y hz hy hs k, smul_smul]
      congr 1
      rw [div_eq_mul_inv]
      ring
    simpa only [heq] using ((hasSum_sinhc s).mul_left β).smul_const z

end TwoDim

end Ising2D.NecSuf
