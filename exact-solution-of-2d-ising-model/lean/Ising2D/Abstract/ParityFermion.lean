/-
# パリティ演算子とフェルミオン（**抽象版**）

対応する人手証明のラベル（正本は `structured-latex/content/018_even_sector_closing.ts`。
具体版は `Ising2D/Part018/`）:

- `epsilon_anticommutes_with_check_Z_Y` (4) → `Ising2D.Abstract.commute_parity_num` /
  `Abstract.commute_parity_projOn`
- `epsilon_eigenvalue_on_check_Q` (2) → `Ising2D.Abstract.projOn_insert_mul_cre` /
  `Abstract.cre_mul_projOn_ne_zero`
- `trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2 →
  `Ising2D.Abstract.sum_powerset_signed_exp`

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査結果）

1. **`ε` が `n_μ` と可換であること**（人手証明 (4)）に効いているのは、
   **`ε` が生成・消滅演算子の両方と反交換すること**と `(-1)^2 = 1` だけである。
   `ε = σ^x_1⋯σ^x_M` であることも、`ψ̌` が `Ž, Y̌` の 1 次結合であることも、
   行列であることも、複素数であることも、テンソル冪であることも効いていない。
   台は**任意の環**でよい。

2. **符号の反転則**（人手証明 (2)）に効いているのは、次の 3 つだけである。
   - `Q_{T∪{μ}} (c_μ Q_T) = c_μ Q_T`（人手証明 Step 2）— これは
     **`n_μ c_μ = c_μ`** と **`n_ν`（`ν ≠ μ`）が `c_μ` と可換**なことから、
     環の計算だけで出る。
   - `c_μ Q_T ≠ 0`（人手証明 Step 1）— これは **`a_μ c_μ = 1 - n_μ`** と
     `n_μ Q_T = 0`（`μ ∉ T`）から出る。**1 次元性は要らない。**
   - `ε (c_μ Q_T) = -η_T (c_μ Q_T)`（人手証明 Step 3）— 反交換関係だけ。
   すなわち**人手証明が「`im Q̌_ε` は 1 次元だから」と言っている部分のうち、
   符号の反転則に 1 次元性が効いているのは「`η_{ε'}` が存在すること」だけ**であり、
   反転則そのものは 1 次元性なしで出る。

3. **`tr(εV^{(+)})` の積への分解**（人手証明 Step 2）に効いているのは、
   有限集合の冪集合にわたる和の積への変形（`Finset.prod_add`）と、
   `sinh x = (e^x - e^{-x})/2` だけである。`γ` が `arccosh` で書けることも、
   `V^{(+)}` が転送行列であることも、`Λ̌_ε` が固有値であることも効いていない。

## 1 次元性（`η_ε` の存在）について

`ε Q̌_ε = η_ε Q̌_ε` の**存在**は `im Q̌_ε` が 1 次元であることを使うので、
台が行列環であることが本質的である。したがって存在の部分は具体版
（`Ising2D/Part018/Claim002_EpsilonEigenvalueOnQ.lean`）にしか置かない。
本ファイルにはスカラーの一意性（`Abstract.smul_left_cancel_of_ne_zero`）だけを置く。
-/
import Ising2D.Abstract.JointEigenspace
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

set_option linter.unusedSectionVars false

namespace Ising2D.Abstract

open Finset

/-! ## 0. 反交換は 1 次結合へ引き継がれる（人手証明
`epsilon_anticommutes_with_check_Z_Y` (2)(3) の「積の `𝕜` 線型性より」） -/

section Lincomb

variable {𝕜 : Type*} [CommSemiring 𝕜] {A : Type*} [Ring A] [Algebra 𝕜 A] {ι : Type*}

/-- `e` が各 `x_i` と反交換なら、`x_i` の任意の有限 `𝕜` 線型結合とも反交換。

効いているのは**積が各因子について `𝕜` 線型であること**だけである。 -/
theorem anticomm_sum_smul {e : A} {x : ι → A} (hx : ∀ i, e * x i = -(x i * e))
    (s : Finset ι) (f : ι → 𝕜) :
    e * (∑ i ∈ s, f i • x i) = -((∑ i ∈ s, f i • x i) * e) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | insert j s hj ih =>
      rw [Finset.sum_insert hj, mul_add, add_mul, neg_add, ih]
      congr 1
      rw [mul_smul_comm, smul_mul_assoc, hx j, smul_neg]

end Lincomb

/-! ## 1. `ε` は個数演算子と可換（人手証明 `epsilon_anticommutes_with_check_Z_Y` (4)） -/

section Parity

variable {A : Type*} [Ring A] {ι : Type*} [DecidableEq ι]

/-- **人手証明 (4) の前半の抽象版**: `ε` が `c_i`, `a_i` の両方と反交換なら
`ε` は `n_i = c_i a_i` と可換。効いているのは反交換関係 2 本と `(-1)^2 = 1` だけ。 -/
theorem commute_parity_num (c a : ι → A) {e : A} {i : ι}
    (hc : e * c i = -(c i * e)) (ha : e * a i = -(a i * e)) :
    Commute e (num c a i) := by
  show e * num c a i = num c a i * e
  rw [num]
  calc e * (c i * a i) = (e * c i) * a i := by rw [mul_assoc]
    _ = (-(c i * e)) * a i := by rw [hc]
    _ = -(c i * (e * a i)) := by rw [neg_mul, mul_assoc]
    _ = -(c i * (-(a i * e))) := by rw [ha]
    _ = c i * a i * e := by noncomm_ring

/-- **人手証明 (4) の後半の抽象版**: `ε` は `Q_ε` とも可換。 -/
theorem commute_parity_projOn (c a : ι → A) {e : A}
    (hn : ∀ i j, Commute (num c a i) (num c a j))
    (hc : ∀ i, e * c i = -(c i * e)) (ha : ∀ i, e * a i = -(a i * e)) (s T : Finset ι) :
    Commute e (projOn (num c a) hn s T) :=
  commute_projOn (n := num c a) (hn := hn) fun i _ => commute_parity_num c a (hc i) (ha i)

/-- `n_i c_i = c_i`（人手証明 `epsilon_eigenvalue_on_check_Q` Step 2 冒頭）。 -/
theorem num_mul_cre (c a : ι → A) (i : ι) (hsq : c i * c i = 0)
    (hca : c i * a i + a i * c i = 1) : num c a i * c i = c i := by
  have h1 : a i * c i = 1 - num c a i := ann_mul_cre c a i hca
  calc num c a i * c i = c i * (a i * c i) := by rw [num, mul_assoc]
    _ = c i * (1 - num c a i) := by rw [h1]
    _ = c i - (c i * c i) * a i := by rw [num]; noncomm_ring
    _ = c i := by rw [hsq]; simp

end Parity

/-! ## 2. 符号の反転則（人手証明 `epsilon_eigenvalue_on_check_Q` (2)） -/

section Flip

variable {A : Type*} [Ring A] {ι : Type*} [DecidableEq ι]

/-- **人手証明 Step 2 の抽象版**: `μ ∈ s`, `μ ∉ T` なら
`Q_{T∪{μ}} (c_μ Q_T) = c_μ Q_T`。

効いているのは `n_μ c_μ = c_μ` と「`ν ≠ μ` の `n_ν` は `c_μ` と可換」だけである。 -/
theorem projOn_insert_mul_cre (c a : ι → A)
    (hn : ∀ i j, Commute (num c a i) (num c a j))
    (hidem : ∀ i, num c a i * num c a i = num c a i)
    (hcn : ∀ i j, i ≠ j → Commute (c i) (num c a j))
    (hsq : ∀ i, c i * c i = 0) (hca : ∀ i, c i * a i + a i * c i = 1)
    {s T : Finset ι} {μ : ι} (hμs : μ ∈ s) (hμT : μ ∉ T) :
    projOn (num c a) hn s (insert μ T) * (c μ * projOn (num c a) hn s T)
      = c μ * projOn (num c a) hn s T := by
  classical
  -- `Q_T = (1 - n_μ) P'`
  have hQT : (1 - num c a μ) * projOn (num c a) hn (s.erase μ) T = projOn (num c a) hn s T := by
    have h : projFactor (num c a) T μ * projOn (num c a) hn (s.erase μ) T
        = projOn (num c a) hn s T := Finset.mul_noncommProd_erase _ hμs _ _
    rwa [projFactor_of_notMem hμT] at h
  -- `Q_{T ∪ {μ}} = n_μ P'`
  have hQT' : num c a μ * projOn (num c a) hn (s.erase μ) T
      = projOn (num c a) hn s (insert μ T) := by
    have h : projFactor (num c a) (insert μ T) μ
          * projOn (num c a) hn (s.erase μ) (insert μ T)
        = projOn (num c a) hn s (insert μ T) := Finset.mul_noncommProd_erase _ hμs _ _
    rw [projFactor_of_mem (Finset.mem_insert_self μ T)] at h
    have hcongr : projOn (num c a) hn (s.erase μ) (insert μ T)
        = projOn (num c a) hn (s.erase μ) T := by
      refine projOn_congr (n := num c a) (hn := hn) fun i hi => ?_
      have hiμ : i ≠ μ := Finset.ne_of_mem_erase hi
      simp [Finset.mem_insert, hiμ]
    rwa [hcongr] at h
  -- `c_μ` は `P'` と可換
  have hcP' : Commute (c μ) (projOn (num c a) hn (s.erase μ) T) :=
    commute_projOn (n := num c a) (hn := hn) fun i hi =>
      hcn μ i (fun h => (Finset.ne_of_mem_erase hi) h.symm)
  -- `P' Q_T = Q_T`
  have hP'Q : projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn s T
      = projOn (num c a) hn s T := by
    have hcomm : Commute (projOn (num c a) hn (s.erase μ) T) (1 - num c a μ) :=
      (commute_projOn (n := num c a) (hn := hn) (x := 1 - num c a μ)
        (fun i _ => Commute.sub_left (Commute.one_left _) (hn μ i))).symm
    have hidem' : projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn (s.erase μ) T
        = projOn (num c a) hn (s.erase μ) T := projOn_mul_self (n := num c a) (hn := hn) hidem _ _
    calc projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn s T
        = projOn (num c a) hn (s.erase μ) T
            * ((1 - num c a μ) * projOn (num c a) hn (s.erase μ) T) := by rw [hQT]
      _ = ((1 - num c a μ) * projOn (num c a) hn (s.erase μ) T)
            * projOn (num c a) hn (s.erase μ) T := by rw [← mul_assoc, hcomm.eq]
      _ = (1 - num c a μ)
            * (projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn (s.erase μ) T) := by
          rw [mul_assoc]
      _ = (1 - num c a μ) * projOn (num c a) hn (s.erase μ) T := by rw [hidem']
      _ = projOn (num c a) hn s T := hQT
  have hnc : num c a μ * c μ = c μ := num_mul_cre c a μ (hsq μ) (hca μ)
  calc projOn (num c a) hn s (insert μ T) * (c μ * projOn (num c a) hn s T)
      = (num c a μ * projOn (num c a) hn (s.erase μ) T) * (c μ * projOn (num c a) hn s T) := by
        rw [hQT']
    _ = num c a μ
          * ((projOn (num c a) hn (s.erase μ) T * c μ) * projOn (num c a) hn s T) := by
        simp only [mul_assoc]
    _ = num c a μ
          * ((c μ * projOn (num c a) hn (s.erase μ) T) * projOn (num c a) hn s T) := by
        rw [hcP'.symm.eq]
    _ = (num c a μ * c μ)
          * (projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn s T) := by
        simp only [mul_assoc]
    _ = c μ * (projOn (num c a) hn (s.erase μ) T * projOn (num c a) hn s T) := by rw [hnc]
    _ = c μ * projOn (num c a) hn s T := by rw [hP'Q]

/-- **人手証明 Step 1 の抽象版**: `μ ∈ s`, `μ ∉ T`, `Q_T ≠ 0` なら `c_μ Q_T ≠ 0`。

**1 次元性は使わない。** 効いているのは `a_μ c_μ = 1 - n_μ` と `n_μ Q_T = 0` だけである。 -/
theorem cre_mul_projOn_ne_zero (c a : ι → A)
    (hn : ∀ i j, Commute (num c a i) (num c a j))
    (hidem : ∀ i, num c a i * num c a i = num c a i)
    (hca : ∀ i, c i * a i + a i * c i = 1)
    {s T : Finset ι} {μ : ι} (hμs : μ ∈ s) (hμT : μ ∉ T)
    (hQ : projOn (num c a) hn s T ≠ 0) :
    c μ * projOn (num c a) hn s T ≠ 0 := by
  classical
  have hnQ : num c a μ * projOn (num c a) hn s T = 0 := by
    rw [num_mul_projOn (n := num c a) (hn := hn) hidem hμs, if_neg hμT, zero_mul]
  have hac : a μ * c μ = 1 - num c a μ := ann_mul_cre c a μ (hca μ)
  have key : a μ * (c μ * projOn (num c a) hn s T) = projOn (num c a) hn s T := by
    calc a μ * (c μ * projOn (num c a) hn s T)
        = (a μ * c μ) * projOn (num c a) hn s T := by rw [mul_assoc]
      _ = (1 - num c a μ) * projOn (num c a) hn s T := by rw [hac]
      _ = projOn (num c a) hn s T - num c a μ * projOn (num c a) hn s T := by noncomm_ring
      _ = projOn (num c a) hn s T := by rw [hnQ, sub_zero]
  intro h
  rw [h, mul_zero] at key
  exact hQ key.symm

end Flip

/-! ## 2a. 可換な因子の積と射影（人手証明 `epsilon_eigenvalue_on_check_Q` (4)） -/

section NoncommProdSmul

variable {𝕜 : Type*} [CommSemiring 𝕜] {A : Type*} [Ring A] [Algebra 𝕜 A] {ι : Type*}
  [DecidableEq ι]

/-- 各因子が `Q` に対してスカラー倍として働くなら、積も働く:
`g_i Q = c_i Q` （すべての `i`）⇒ `(∏_{i∈s} g_i) Q = (∏_{i∈s} c_i) Q`。

効いているのは結合律とスカラー倍の両立則だけである。 -/
theorem noncommProd_mul_of_mul_eq_smul (g : ι → A) (comm : ∀ i j, Commute (g i) (g j))
    (Q : A) (c : ι → 𝕜) (h : ∀ i, g i * Q = c i • Q) (s : Finset ι) :
    s.noncommProd g (fun i _ j _ _ => comm i j) * Q = (∏ i ∈ s, c i) • Q := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | insert j s hj ih =>
      rw [Finset.noncommProd_insert_of_notMem _ _ _ _ hj, Finset.prod_insert hj, mul_assoc, ih,
        mul_smul_comm, h j, smul_smul, mul_comm]

end NoncommProdSmul

/-! ## 2b. `Q_ε` のエルミート性（人手証明 `check_number_operator_is_hermitian` (4)） -/

section Star

variable {A : Type*} [Ring A] [StarRing A] {ι : Type*} [DecidableEq ι]

/-- **人手証明 `check_number_operator_is_hermitian` (4) の抽象版**:
`n_i` がすべて自己共役なら `Q_ε` も自己共役。

効いているのは **`star` が反自己同型であること**と、**因子が互いに可換**なことだけである。 -/
theorem star_projOn (n : ι → A) (hn : ∀ i j, Commute (n i) (n j))
    (hstar : ∀ i, star (n i) = n i) (s T : Finset ι) :
    star (projOn n hn s T) = projOn n hn s T := by
  classical
  have hfac : ∀ i, star (projFactor n T i) = projFactor n T i := by
    intro i
    unfold projFactor
    split
    · exact hstar i
    · rw [star_sub, star_one, hstar i]
  induction s using Finset.induction_on with
  | empty => simp
  | insert j s hj ih =>
      have hcomm : Commute (projFactor n T j) (projOn n hn s T) :=
        Finset.noncommProd_commute _ _ _ _ fun i _ => commute_projFactor hn T T j i
      rw [projOn_insert (n := n) (hn := hn) hj, star_mul, ih, hfac j, hcomm.eq]

end Star

/-! ## 3. スカラーの一意性 -/

section Scalar

variable {𝕜 : Type*} [Field 𝕜] {A : Type*} [AddCommGroup A] [Module 𝕜 A]
  [NoZeroSMulDivisors 𝕜 A]

/-- `x ≠ 0` なら `η • x = η' • x ⇒ η = η'`（人手証明 (1) の「一意に定まる」）。 -/
theorem smul_left_cancel_of_ne_zero {x : A} (hx : x ≠ 0) {η η' : 𝕜} (h : η • x = η' • x) :
    η = η' := by
  have hz : (η - η') • x = 0 := by rw [sub_smul, h, sub_self]
  rcases smul_eq_zero.1 hz with h' | h'
  · exact sub_eq_zero.1 h'
  · exact absurd h' hx

end Scalar

/-! ## 4. 符号つき和の積への分解（人手証明
`trace_of_epsilon_V_plus_via_check_eigenvalues` Step 2） -/

section SignedSum

variable {ι : Type*} [DecidableEq ι]

/-- **人手証明 Step 2 の抽象版**:

  `∑_{T ⊆ s} (-1)^{|s|-|T|} exp(∑_{i∈s} g_i (1_{i∈T} - 1/2)) = ∏_{i∈s} 2 sinh(g_i/2)`

効いているのは有限積の展開（`Finset.prod_add`）と `sinh x = (e^x - e^{-x})/2` だけで、
`g` が `arccosh` で書けることも、転送行列も、固有値も効いていない。 -/
theorem sum_powerset_signed_exp (s : Finset ι) (g : ι → ℝ) :
    ∑ T ∈ s.powerset,
        ((-1 : ℝ) ^ (s.card - T.card)
          * Real.exp (∑ i ∈ s, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)))
      = ∏ i ∈ s, (2 * Real.sinh (g i / 2)) := by
  classical
  have hfac : ∀ T ∈ s.powerset,
      ((-1 : ℝ) ^ (s.card - T.card)
          * Real.exp (∑ i ∈ s, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)))
        = (∏ i ∈ T, Real.exp (g i / 2)) * ∏ i ∈ s \ T, (-Real.exp (-(g i / 2))) := by
    intro T hT
    have hTs : T ⊆ s := Finset.mem_powerset.1 hT
    -- 指数の和を `T` と `s \ T` に分ける
    have hsplit : ∑ i ∈ s, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)
        = (∑ i ∈ T, g i / 2) + ∑ i ∈ s \ T, -(g i / 2) := by
      rw [← Finset.sum_sdiff hTs]
      have h1 : ∀ i ∈ T, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2) = g i / 2 := by
        intro i hi; rw [if_pos hi]; ring
      have h2 : ∀ i ∈ s \ T, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2) = -(g i / 2) := by
        intro i hi
        rw [if_neg (Finset.mem_sdiff.1 hi).2]; ring
      rw [Finset.sum_congr rfl h1, Finset.sum_congr rfl h2]
      ring
    rw [hsplit, Real.exp_add, Real.exp_sum, Real.exp_sum]
    have hneg : ∏ i ∈ s \ T, (-Real.exp (-(g i / 2)))
        = (-1 : ℝ) ^ (s \ T).card * ∏ i ∈ s \ T, Real.exp (-(g i / 2)) := by
      rw [← Finset.prod_const, ← Finset.prod_mul_distrib]
      exact Finset.prod_congr rfl fun i _ => by ring
    have hcard : (s \ T).card = s.card - T.card := by
      rw [Finset.card_sdiff, Finset.inter_eq_left.2 hTs]
    rw [hneg, hcard]
    ring
  rw [Finset.sum_congr rfl hfac]
  rw [← Finset.prod_add]
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [Real.sinh_eq]
  ring

end SignedSum

end Ising2D.Abstract
