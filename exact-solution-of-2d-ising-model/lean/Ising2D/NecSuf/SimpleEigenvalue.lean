/-
# 単純固有値（**必要十分版**）

対応する人手証明のラベル（具体版は
`Ising2D/Part017/Theorem011_MaxEigenvalueSimple.lean`）:
`max_eigenvalue_of_V_plus_simple` (2)(3)。

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査）

人手証明は 2 つのことを言っている。

**(2) 最大性が狭義であること。** これは
「重み `γ(θ~_μ)` がすべて**狭義に**正であること」と
「`ε` の各成分が独立に `0/1` を選べること」だけから出る
（`sum_weight_lt_of_ne_univ`）。指数関数も転送行列も固有値も効いていない。
章 009 が `γ(θ_μ) ≥ 0` しか持てず単純性を言えなかったのは、
まさにこの狭義性が無かったからである。

**(3) 固有空間が 1 次元であること。** 人手証明は
「`x = ∑_ε Q̌_ε x` と (5) の直和性から各項が `0`」という筋で書いているが、
形式化してみると**直和分解 (5) は要らない**。効いているのは

1. 台が環であり、その環が加群へ作用すること（作用の 4 法則だけ）、
2. `∑_ε Q_ε = 1`（単位の分解）、
3. `Q_ε V = Λ_ε Q_ε`（**左からの**固有関係。人手証明は `V Q_ε = Λ_ε Q_ε` を
   書いているが、`V` と `Q_ε` が可換なので同値）、
4. `Λ_ε ≠ Λ_{ε_0}`（`ε ≠ ε_0`）、

の 4 つだけである（`eq_proj_of_eigen`）。射影であること（`Q^2 = Q`）も、
`Q_ε Q_{ε'} = 0` も、有限次元性も、複素数体であることすら使っていない
（スカラーは可除環ならよい。ここでは具体版に合わせて ℂ で述べる）。

作用を `Module` インスタンスではなく明示の 4 法則
（`hmul`, `hone`, `hsmul`, `hlin`, `hsum`）で受け取っているのは、
具体版が **行列の `mulVec` による作用**（`ℂ^{2^M}` への作用）を使うためである。
同じ補題は `act = (· * ·)`（環の自分自身への作用）にも特殊化できる。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Module.Defs
import Mathlib.Analysis.RCLike.Basic
import Mathlib.Analysis.Normed.Algebra.Exponential
import Mathlib.Analysis.SpecialFunctions.Exponential

namespace Ising2D.NecSuf

open Finset

/-! ## 狭義に正な重みの下での最大値の一意性 -/

section StrictMax

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **人手証明 `max_eigenvalue_of_V_plus_simple` (2) の核**:
重み `w_i` がすべて狭義に正なら、`∑_i w_i (χ_T(i) - 1/2)` は
`T = univ` のときにのみ最大値を取る。 -/
theorem sum_weight_lt_of_ne_univ (w : ι → ℝ) (hw : ∀ i, 0 < w i) {T : Finset ι}
    (hT : T ≠ Finset.univ) :
    ∑ i, w i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)
      < ∑ i, w i * ((if i ∈ (Finset.univ : Finset ι) then (1 : ℝ) else 0) - 1 / 2) := by
  obtain ⟨i₀, hi₀⟩ : ∃ i₀ : ι, i₀ ∉ T := by
    by_contra hc
    push_neg at hc
    exact hT (Finset.eq_univ_of_forall hc)
  refine Finset.sum_lt_sum (fun i _ => ?_) ⟨i₀, Finset.mem_univ i₀, ?_⟩
  · have h1 : (if i ∈ T then (1 : ℝ) else 0)
        ≤ (if i ∈ (Finset.univ : Finset ι) then (1 : ℝ) else 0) := by
      simp only [Finset.mem_univ, if_true]
      split <;> norm_num
    nlinarith [hw i]
  · simp only [Finset.mem_univ, if_true, if_neg hi₀]
    nlinarith [hw i₀]

/-- 重みが非負なら `T = univ` が最大（章 009 の `bigLambda_le_max` に対応する非狭義版）。 -/
theorem sum_weight_le_univ (w : ι → ℝ) (hw : ∀ i, 0 ≤ w i) (T : Finset ι) :
    ∑ i, w i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)
      ≤ ∑ i, w i * ((if i ∈ (Finset.univ : Finset ι) then (1 : ℝ) else 0) - 1 / 2) := by
  refine Finset.sum_le_sum fun i _ => ?_
  have h1 : (if i ∈ T then (1 : ℝ) else 0)
      ≤ (if i ∈ (Finset.univ : Finset ι) then (1 : ℝ) else 0) := by
    simp only [Finset.mem_univ, if_true]
    split <;> norm_num
  nlinarith [hw i]

/-- 重みが非負なら `T = ∅` が最小。 -/
theorem sum_weight_empty_le (w : ι → ℝ) (hw : ∀ i, 0 ≤ w i) (T : Finset ι) :
    ∑ i, w i * ((if i ∈ (∅ : Finset ι) then (1 : ℝ) else 0) - 1 / 2)
      ≤ ∑ i, w i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2) := by
  refine Finset.sum_le_sum fun i _ => ?_
  have h1 : (if i ∈ (∅ : Finset ι) then (1 : ℝ) else 0) ≤ (if i ∈ T then (1 : ℝ) else 0) := by
    simp only [Finset.notMem_empty, if_false]
    split <;> norm_num
  nlinarith [hw i]

end StrictMax

/-! ## 単位の分解から出る固有空間の同定 -/

section SimpleEigen

variable {A : Type*} [Ring A] [SMul ℂ A] {Mod : Type*} [AddCommGroup Mod] [Module ℂ Mod]
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **人手証明 `max_eigenvalue_of_V_plus_simple` (3) 前半の必要十分版**:
`∑_ε Q_ε = 1` と `Q_ε V = Λ_ε Q_ε`、および `Λ_ε ≠ Λ_{ε_0}`（`ε ≠ ε_0`）だけから、
固有値 `Λ_{ε_0}` の固有ベクトルは `Q_{ε_0}` の像に入る。

直和分解も射影の性質（`Q^2 = Q`, `Q_ε Q_{ε'} = 0`）も使わない。 -/
theorem eq_proj_of_eigen
    (act : A → Mod → Mod)
    (hmul : ∀ (x y : A) (v : Mod), act (x * y) v = act x (act y v))
    (hone : ∀ v : Mod, act 1 v = v)
    (hsmul : ∀ (r : ℂ) (x : A) (v : Mod), act (r • x) v = r • act x v)
    (hlin : ∀ (x : A) (r : ℂ) (v : Mod), act x (r • v) = r • act x v)
    (hsum : ∀ (q : ι → A) (v : Mod), act (∑ i, q i) v = ∑ i, act (q i) v)
    (Q : ι → A) (V : A) (lam : ι → ℂ) (i₀ : ι)
    (hres : ∑ i, Q i = 1)
    (hQV : ∀ i, Q i * V = lam i • Q i)
    (hne : ∀ i, i ≠ i₀ → lam i ≠ lam i₀)
    {x : Mod} (hx : act V x = lam i₀ • x) :
    x = act (Q i₀) x := by
  have hzero : ∀ i, i ≠ i₀ → act (Q i) x = 0 := by
    intro i hi
    have h1 : act (Q i * V) x = lam i • act (Q i) x := by rw [hQV i, hsmul]
    have h2 : act (Q i * V) x = lam i₀ • act (Q i) x := by rw [hmul, hx, hlin]
    have h3 : (lam i - lam i₀) • act (Q i) x = 0 := by
      rw [sub_smul, ← h1, ← h2, sub_self]
    rcases smul_eq_zero.1 h3 with h | h
    · exact absurd (sub_eq_zero.1 h) (hne i hi)
    · exact h
  calc x = act 1 x := (hone x).symm
    _ = act (∑ i, Q i) x := by rw [hres]
    _ = ∑ i, act (Q i) x := hsum _ _
    _ = act (Q i₀) x := by
        rw [Finset.sum_eq_single i₀ (fun i _ hi => hzero i hi) (fun h => absurd (mem_univ i₀) h)]

end SimpleEigen

/-! ## 左右を入れ替えた `exp(X) Q = e^g Q`

`Ising2D/NecSuf/JointEigenspace.lean` の `pow_mul_eq_of_mul_eq_smul` /
`exp_mul_eq_of_mul_eq_smul` は `X Q = g Q ⇒ exp(X) Q = e^g Q` の形だが、
`eq_proj_of_eigen` が要求するのは `Q V = Λ Q`（左からの形）である。
人手証明はこの 2 つを区別していない（`X` と `Q̌_ε` が可換だからである）。
効いている構造は左版とまったく同じ（ℂ 上の完備ノルム環）で、
証明も左右を入れ替えるだけである。 -/

section ExpRight

open NormedSpace Nat

variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [CompleteSpace A]

/-- `Q X = g Q ⇒ Q X^k = g^k Q`。 -/
theorem mul_pow_eq_of_mul_eq_smul {X Q : A} {g : ℂ} (h : Q * X = g • Q) (k : ℕ) :
    Q * X ^ k = g ^ k • Q := by
  induction k with
  | zero => simp
  | succ k ih =>
      calc Q * X ^ (k + 1) = (Q * X ^ k) * X := by rw [pow_succ, mul_assoc]
        _ = (g ^ k • Q) * X := by rw [ih]
        _ = g ^ k • (Q * X) := by rw [smul_mul_assoc]
        _ = g ^ k • (g • Q) := by rw [h]
        _ = g ^ (k + 1) • Q := by rw [smul_smul, ← pow_succ]

/-- `Q X = g Q ⇒ Q exp(X) = e^g Q`。 -/
theorem mul_exp_eq_of_mul_eq_smul {X Q : A} {g : ℂ} (h : Q * X = g • Q) :
    Q * exp X = Complex.exp g • Q := by
  have hX : HasSum (fun k : ℕ => ((k ! : ℂ))⁻¹ • X ^ k) (exp X) :=
    NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) X
  have h1 : HasSum (fun k : ℕ => Q * (((k ! : ℂ))⁻¹ • X ^ k)) (Q * exp X) :=
    hX.mul_left Q
  have hg : HasSum (fun k : ℕ => ((k ! : ℂ))⁻¹ • g ^ k) (Complex.exp g) := by
    have := NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) g
    rwa [← Complex.exp_eq_exp_ℂ] at this
  have h2 : HasSum (fun k : ℕ => (((k ! : ℂ))⁻¹ • g ^ k) • Q) (Complex.exp g • Q) :=
    hg.smul_const Q
  refine h1.unique ?_
  refine h2.congr_fun ?_
  intro k
  rw [mul_smul_comm, mul_pow_eq_of_mul_eq_smul h k, smul_smul, smul_eq_mul]

end ExpRight

end Ising2D.NecSuf
