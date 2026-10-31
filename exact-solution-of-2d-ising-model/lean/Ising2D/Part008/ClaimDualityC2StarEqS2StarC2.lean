/-
# `K_2` と `K_2^*` の双対関係 `c_2^* = s_2^* c_2`

対応する人手証明（正本は `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`）:

* `TV1_hatZ_hatY_016a_claim_duality_c2_star`（ラベル **`duality_c2_star_eq_s2_star_c2`**）

主張: `K_2 > 0`、`K_2^* := -(1/2) log(tanh K_2)`（`Ising2D.Kstar`）について
`s_2^* = 1/s_2`、`c_2^* = c_2/s_2`、したがって `c_2^* = s_2^* c_2`。

## 人手証明との対応

* 準備の `-2K_2^* = log(tanh K_2)` と `exp(-2K_2^*) = tanh K_2` は、004 章の
  `exp_neg_two_Kstar_eq_tanh`（同じ二行）を引く。
* `exp_two_Kstar_eq_inv_exp_neg`: 準備の最後の行 `exp(2K_2^*) = (tanh K_2)^{-1}`
  （直前の等式の逆数と `tanh K_2 ≠ 0`）。004 章の `exp_two_Kstar_eq_inv_tanh` は対数から直接出す
  別の道筋なので、008 章の行に合わせてここで置き直す。
* `s2star_eq_inv_s2`: `s_2^*` の鎖（`sinh` の指数表示 → 準備の代入 → `tanh = sinh/cosh` →
  通分 → `cosh²-sinh²=1` と倍角 → `s_2` の定義）。
* `c2star_eq_c2_div_s2`: `c_2^*` の鎖（`cosh` の指数表示 → 準備の代入 → `tanh = sinh/cosh` →
  通分 → `cosh²+sinh²=cosh 2x` と倍角 → `c_2` の定義）。
* `duality_c2_star_eq_s2_star_c2`: 最後の鎖（`c_2/s_2 = c_2 · (1/s_2) = c_2 s_2^* = s_2^* c_2`）。

倍角公式 `sinh 2x = 2 sinh x cosh x` は 004 章で指数関数から導いた
`sinh_two_eq_two_sinh_mul_cosh` を使い、`cosh 2x = cosh²x + sinh²x` も同じ形で指数関数から導く
（`cosh_two_eq_cosh_sq_add_sinh_sq`）。実数の順序は分母が 0 でないことを得るためだけに使う。

## 必要十分版について

置かない。主張は特定の実数 `K_2` での双曲線関数の値の等式で、使う構造は実数の四則と
`exp` の加法則・`exp ∘ log = id`（正の実数上）だけである。これを一般の構造へ持ち上げても
`exp`・`log` を持つ体を述べ直すだけになり、何が本質的かについて新しい情報を与えない。
-/
import Ising2D.Part004.ClaimSecondDualCouplingRelation

namespace Ising2D

/-- `cosh 2x = cosh² x + sinh² x`。人手証明が `c_2^*` の鎖で使う倍角公式を、
`sinh_two_eq_two_sinh_mul_cosh` と同じく指数関数の定義から導く。 -/
theorem cosh_two_eq_cosh_sq_add_sinh_sq (x : ℝ) :
    Real.cosh (2 * x) = Real.cosh x ^ 2 + Real.sinh x ^ 2 := by
  have hexpSq : Real.exp x ^ 2 = Real.exp (2 * x) := by
    calc
      Real.exp x ^ 2 = Real.exp x * Real.exp x := by ring
      _ = Real.exp (x + x) := by rw [Real.exp_add]
      _ = Real.exp (2 * x) := by congr 1; ring
  have hexpNegSq : Real.exp (-x) ^ 2 = Real.exp (-(2 * x)) := by
    calc
      Real.exp (-x) ^ 2 = Real.exp (-x) * Real.exp (-x) := by ring
      _ = Real.exp ((-x) + (-x)) := by rw [Real.exp_add]
      _ = Real.exp (-(2 * x)) := by congr 1; ring
  symm
  calc
    Real.cosh x ^ 2 + Real.sinh x ^ 2 =
        ((Real.exp x + Real.exp (-x)) / 2) ^ 2 + ((Real.exp x - Real.exp (-x)) / 2) ^ 2 := by
          rw [Real.cosh_eq, Real.sinh_eq]
    _ = (Real.exp x ^ 2 + Real.exp (-x) ^ 2) / 2 := by ring
    _ = (Real.exp (2 * x) + Real.exp (-(2 * x))) / 2 := by rw [hexpSq, hexpNegSq]
    _ = Real.cosh (2 * x) := by rw [Real.cosh_eq]

/-- 準備の最後の行 `exp(2K_2^*) = (tanh K_2)^{-1}`：直前の `exp(-2K_2^*) = tanh K_2` の逆数。 -/
theorem exp_two_Kstar_eq_inv_exp_neg {K2 : ℝ} (hK2 : 0 < K2) :
    Real.exp (2 * Kstar K2) = 1 / Real.tanh K2 := by
  calc
    Real.exp (2 * Kstar K2) = 1 / Real.exp (-2 * Kstar K2) := by
      -- `exp(a) · exp(-a) = 1`
      rw [eq_div_iff (Real.exp_pos _).ne', ← Real.exp_add]
      ring_nf
      exact Real.exp_zero
    _ = 1 / Real.tanh K2 := by
      -- 直前の等式 `exp(-2K_2^*) = tanh K_2`
      rw [exp_neg_two_Kstar_eq_tanh hK2]

/-- `sinh(2K_2^*) = ((tanh K_2)^{-1} - tanh K_2)/2`。人手証明の `s_2^*` の鎖の前半
（`sinh` の指数表示と準備の代入）。 -/
theorem sinh_two_Kstar_eq_inv_tanh_sub_tanh_div_two {K2 : ℝ} (hK2 : 0 < K2) :
    Real.sinh (2 * Kstar K2) = (1 / Real.tanh K2 - Real.tanh K2) / 2 := by
  have hneg : -(2 * Kstar K2) = -2 * Kstar K2 := by ring
  calc
    Real.sinh (2 * Kstar K2) =
        (Real.exp (2 * Kstar K2) - Real.exp (-(2 * Kstar K2))) / 2 := by
          rw [Real.sinh_eq]
    _ = (1 / Real.tanh K2 - Real.exp (-(2 * Kstar K2))) / 2 := by
      rw [exp_two_Kstar_eq_inv_exp_neg hK2]
    _ = (1 / Real.tanh K2 - Real.tanh K2) / 2 := by
      rw [hneg, exp_neg_two_Kstar_eq_tanh hK2]

/-- `cosh(2K_2^*) = ((tanh K_2)^{-1} + tanh K_2)/2`。人手証明の `c_2^*` の鎖の前半
（`cosh` の指数表示と準備の代入）。 -/
theorem cosh_two_Kstar_eq_half_inv_tanh_add_tanh {K2 : ℝ} (hK2 : 0 < K2) :
    Real.cosh (2 * Kstar K2) = (1 / Real.tanh K2 + Real.tanh K2) / 2 := by
  have hneg : -(2 * Kstar K2) = -2 * Kstar K2 := by ring
  calc
    Real.cosh (2 * Kstar K2) =
        (Real.exp (2 * Kstar K2) + Real.exp (-(2 * Kstar K2))) / 2 := by
          rw [Real.cosh_eq]
    _ = (1 / Real.tanh K2 + Real.exp (-(2 * Kstar K2))) / 2 := by
      rw [exp_two_Kstar_eq_inv_exp_neg hK2]
    _ = (1 / Real.tanh K2 + Real.tanh K2) / 2 := by
      rw [hneg, exp_neg_two_Kstar_eq_tanh hK2]

/-- **人手 `duality_c2_star_eq_s2_star_c2` の第一式** `s_2^* = 1/s_2`。 -/
theorem s2star_eq_inv_s2 {K2 : ℝ} (hK2 : 0 < K2) :
    Real.sinh (2 * Kstar K2) = 1 / Real.sinh (2 * K2) := by
  have hs : Real.sinh K2 ≠ 0 := ne_of_gt (Real.sinh_pos_iff.mpr hK2)
  have hc : Real.cosh K2 ≠ 0 := ne_of_gt (Real.cosh_pos K2)
  calc
    Real.sinh (2 * Kstar K2) = (1 / Real.tanh K2 - Real.tanh K2) / 2 :=
      -- `sinh` の指数表示と準備の `exp(±2K_2^*)` の代入
      sinh_two_Kstar_eq_inv_tanh_sub_tanh_div_two hK2
    _ = (1 / 2 : ℝ) * (Real.cosh K2 / Real.sinh K2 - Real.sinh K2 / Real.cosh K2) := by
      -- `tanh x = sinh x / cosh x` とその逆数
      rw [Real.tanh_eq_sinh_div_cosh, one_div_div]
      ring
    _ = (Real.cosh K2 ^ 2 - Real.sinh K2 ^ 2) / (2 * Real.sinh K2 * Real.cosh K2) := by
      -- 通分（分母 `sinh K_2 cosh K_2 ≠ 0`）
      field_simp
    _ = 1 / Real.sinh (2 * K2) := by
      -- `cosh² x - sinh² x = 1`、`2 sinh x cosh x = sinh 2x`
      rw [Real.cosh_sq_sub_sinh_sq, sinh_two_eq_two_sinh_mul_cosh]

/-- **人手 `duality_c2_star_eq_s2_star_c2` の第二式** `c_2^* = c_2/s_2`。 -/
theorem c2star_eq_c2_div_s2 {K2 : ℝ} (hK2 : 0 < K2) :
    Real.cosh (2 * Kstar K2) = Real.cosh (2 * K2) / Real.sinh (2 * K2) := by
  have hs : Real.sinh K2 ≠ 0 := ne_of_gt (Real.sinh_pos_iff.mpr hK2)
  have hc : Real.cosh K2 ≠ 0 := ne_of_gt (Real.cosh_pos K2)
  calc
    Real.cosh (2 * Kstar K2) = (1 / Real.tanh K2 + Real.tanh K2) / 2 :=
      -- `cosh` の指数表示と準備の `exp(±2K_2^*)` の代入
      cosh_two_Kstar_eq_half_inv_tanh_add_tanh hK2
    _ = (1 / 2 : ℝ) * (Real.cosh K2 / Real.sinh K2 + Real.sinh K2 / Real.cosh K2) := by
      -- `tanh x = sinh x / cosh x` とその逆数
      rw [Real.tanh_eq_sinh_div_cosh, one_div_div]
      ring
    _ = (Real.cosh K2 ^ 2 + Real.sinh K2 ^ 2) / (2 * Real.sinh K2 * Real.cosh K2) := by
      -- 通分（分母 `sinh K_2 cosh K_2 ≠ 0`）
      field_simp
    _ = Real.cosh (2 * K2) / Real.sinh (2 * K2) := by
      -- `cosh² x + sinh² x = cosh 2x`、`2 sinh x cosh x = sinh 2x`
      rw [← cosh_two_eq_cosh_sq_add_sinh_sq, sinh_two_eq_two_sinh_mul_cosh]

/-- **人手 `duality_c2_star_eq_s2_star_c2`**: `c_2^* = s_2^* c_2`。 -/
theorem duality_c2_star_eq_s2_star_c2 {K2 : ℝ} (hK2 : 0 < K2) :
    Real.cosh (2 * Kstar K2) = Real.sinh (2 * Kstar K2) * Real.cosh (2 * K2) := by
  calc
    Real.cosh (2 * Kstar K2) = Real.cosh (2 * K2) / Real.sinh (2 * K2) :=
      c2star_eq_c2_div_s2 hK2
    _ = Real.cosh (2 * K2) * (1 / Real.sinh (2 * K2)) := by
      -- `ℝ` の除法は逆数との積
      rw [mul_one_div]
    _ = Real.cosh (2 * K2) * Real.sinh (2 * Kstar K2) := by
      -- もう一方の鎖の `s_2^* = 1/s_2`
      rw [s2star_eq_inv_s2 hK2]
    _ = Real.sinh (2 * Kstar K2) * Real.cosh (2 * K2) := by
      -- `ℝ` の乗法の可換性
      rw [mul_comm]

end Ising2D
