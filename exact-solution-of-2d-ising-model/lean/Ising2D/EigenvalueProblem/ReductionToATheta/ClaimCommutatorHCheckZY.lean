/-
# `H_1^{(+)}, H_2` と `check(Z)_μ, check(Y)_μ` の交換関係（**具体版**）

対応する人手証明のラベル: `commutator_of_H_and_check_Z_Y`
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensector_004_claim_commutator_H_check_Z_Y`）

## 原文の主張（`μ ∈ 𝓜̌`）

  (A) `[H_1^{(+)}, check(Z)_μ] = 2 e^{-iθ~_μ} check(Y)_μ`
  (B) `[H_1^{(+)}, check(Y)_μ] = -2 e^{iθ~_μ} check(Z)_μ`
  (C) `[H_2, check(Z)_μ]       = -2 check(Y)_μ`
  (D) `[H_2, check(Y)_μ]       = 2 check(Z)_μ`

## 人手証明との対応

* Step 1（サイトごとの交換関係）: 相異なる添字の項が消える 4 式
  （`lie_ZY_Z_of_ne`・`lie_ZY_Y_of_ne`・`lie_YZ_Z_of_ne`・`lie_YZ_Y_of_ne`）、
  同じ添字を含む項の 4 式（`lie_ZY_Z_self`・`lie_ZY_Y_self`・`lie_YZ_Z_right`・`lie_YZ_Y_left`）、
  それらを和へまとめた 4 式（`lie_H2_Z`・`lie_H2_Y`・`lie_H1Plus_Z`・`lie_H1Plus_Y`）。
  人手の境界項 `[-Y_M Z_1, Z_1]`・`[-Y_M Z_1, Y_M]` は、交換子の第 1 引数の線型性で
  `lie_YZ_Z_right`・`lie_YZ_Y_left` の `a = M, b = 1` に帰着させている（人手の鎖の第 1 行と同じ）。
  反周期的な延長 `Y♭_l`・`Z♭_l` は `Yflat`・`Zflat`。
* Step 2（(C)(D)）: `lie_H2_checkZ`・`lie_H2_checkY`。
* Step 3（(A)）: 境界の二項の等式 `checkPhase_smul_Yflat_boundary` と `lie_H1Plus_checkZ`。
* Step 4（(B)）: 境界の二項の等式 `checkPhase_smul_Zflat_boundary` と `lie_H1Plus_checkY`。

人手 `anticommutator_of_Z_and_Y` は `anticomm_Z_Z`・`anticomm_Z_Y`・`anticomm_Y_Y`・`Z_mul_self`・`Y_mul_self`
（`ClaimAnticommutatorZY.lean`）。

**必要十分版は未作成である。** `NecSuf/CommutatorClifford.lean` は `H` を `check(Z), check(Y)` の和で表してから
計算する別の経路（参照用ノートへ退避した `H1_H2_via_check_Z_Y` を使う）の一般化で、
この証明の手順（サイトごとの交換関係から和へまとめる）とは対応しない。この証明が使う性質は、
結合的な ℂ 代数であること、`anticommutator_of_Z_and_Y` から従う反交換関係、位相 `checkPhase` の
2 性質（`checkPhase_add_left` と反周期性 `checkPhase_antiperiodic`）だけなので、同じ手順の必要十分版は書ける見込みである。

## 人手の行と Lean の行がまとまっている箇所

* Lean の `H1plus` は境界項を `lastSign (-1)` 付きの 1 項として含む `M` 項の和なので、人手の
  「和と境界項に分ける」「境界項（または和の項）を 0 で消す」「零行列の和」の行は、
  `lie_H1Plus_Z`・`lie_H1Plus_Y` の `Finset.sum_eq_single` 1 回にまとまる（`lie_H2_Z`・`lie_H2_Y` も同じ）。
  境界項の等式 `[-Y_M Z_1, Z_1] = 2Y♭_0`・`[-Y_M Z_1, Y_M] = -2Z♭_{M+1}` は、その場合分けの中の `rw` で出す。
* Step 3 の添字の付け替え `l = j - 1` は、Lean の 0 始まりの `Fin` の値がそのまま人手の `l` なので、行が無い。
  Step 4 の付け替え `l = j + 1` は `checkPhase_add_left`（`theorem_exp_product`）と同じ行で行う。
* 人手の「分配則」の行では、`2` と `e^{∓iθ~_μ}` を 1 つのスカラーにまとめる。
  人手の最後の 2 行（`1 ≤ l ≤ M` で延長を外す行と `def_half_integer_checkY`・`def_half_integer_checkZ` の行）は 1 行にまとめる。

## 添字の扱い

site 添字は `Fin M` で、人手の `j` は `(j : ℕ) + 1`。延長 `Y♭_l`（`l = 0, …, M`）・`Z♭_l`（`l = 1, …, M+1`）は
人手と同じ自然数の添字 `l` で持つ。モード添字 `μ` は `ℤ` のまま扱う（4 式とも `μ ∈ ℤ` で成り立つ）。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimAnticommutatorCheckZY

namespace Ising2D

variable {M : ℕ}

/-! ## 準備: `anticommutator_of_Z_and_Y` から従う関係式 -/

/-- `j ≠ k` なら `Z_j Z_k = -Z_k Z_j`。 -/
theorem Z_mul_Z_of_ne {j k : Fin M} (h : j ≠ k) : Z j * Z k = -(Z k * Z j) := by
  have := anticomm_Z_Z j k
  rw [acomm, deltaM, if_neg h, mul_zero, zero_smul] at this
  exact eq_neg_of_add_eq_zero_left this

/-- `j ≠ k` なら `Y_j Y_k = -Y_k Y_j`。 -/
theorem Y_mul_Y_of_ne {j k : Fin M} (h : j ≠ k) : Y j * Y k = -(Y k * Y j) := by
  have := anticomm_Y_Y j k
  rw [acomm, deltaM, if_neg h, mul_zero, zero_smul] at this
  exact eq_neg_of_add_eq_zero_left this

/-- 任意の `j, k` で `Z_j Y_k = -Y_k Z_j`。 -/
theorem Z_mul_Y_anticomm (j k : Fin M) : Z j * Y k = -(Y k * Z j) := by
  have := anticomm_Z_Y j k
  rw [acomm] at this
  exact eq_neg_of_add_eq_zero_left this

/-- 任意の `j, k` で `Y_j Z_k = -Z_k Y_j`。 -/
theorem Y_mul_Z_anticomm (j k : Fin M) : Y j * Z k = -(Z k * Y j) := by
  have := anticomm_Y_Z j k
  rw [acomm] at this
  exact eq_neg_of_add_eq_zero_left this

/-! ## Step 1: 相異なる添字の項が消える -/

/-- `a ≠ j` なら `[Z_a Y_a, Z_j] = 0`。 -/
theorem lie_ZY_Z_of_ne {a j : Fin M} (h : a ≠ j) : ⁅Z a * Y a, Z j⁆ = 0 := by
  calc ⁅Z a * Y a, Z j⁆
      = (Z a * Y a) * Z j - Z j * (Z a * Y a) := Ring.lie_def _ _
    _ = Z a * (Y a * Z j) - Z j * (Z a * Y a) := by rw [mul_assoc]
    _ = Z a * (-(Z j * Y a)) - Z j * (Z a * Y a) := by rw [Y_mul_Z_anticomm]
    _ = -((Z a * Z j) * Y a) - Z j * (Z a * Y a) := by rw [mul_neg, mul_assoc]
    _ = -((-(Z j * Z a)) * Y a) - Z j * (Z a * Y a) := by rw [Z_mul_Z_of_ne h]
    _ = (Z j * Z a) * Y a - Z j * (Z a * Y a) := by rw [neg_mul, neg_neg]
    _ = Z j * (Z a * Y a) - Z j * (Z a * Y a) := by rw [mul_assoc]
    _ = 0 := sub_self _

/-- `a ≠ j` なら `[Z_a Y_a, Y_j] = 0`。 -/
theorem lie_ZY_Y_of_ne {a j : Fin M} (h : a ≠ j) : ⁅Z a * Y a, Y j⁆ = 0 := by
  calc ⁅Z a * Y a, Y j⁆
      = (Z a * Y a) * Y j - Y j * (Z a * Y a) := Ring.lie_def _ _
    _ = Z a * (Y a * Y j) - Y j * (Z a * Y a) := by rw [mul_assoc]
    _ = Z a * (-(Y j * Y a)) - Y j * (Z a * Y a) := by rw [Y_mul_Y_of_ne h]
    _ = -((Z a * Y j) * Y a) - Y j * (Z a * Y a) := by rw [mul_neg, mul_assoc]
    _ = -((-(Y j * Z a)) * Y a) - Y j * (Z a * Y a) := by rw [Z_mul_Y_anticomm]
    _ = (Y j * Z a) * Y a - Y j * (Z a * Y a) := by rw [neg_mul, neg_neg]
    _ = Y j * (Z a * Y a) - Y j * (Z a * Y a) := by rw [mul_assoc]
    _ = 0 := sub_self _

/-- `b ≠ j` なら `[Y_a Z_b, Z_j] = 0`。 -/
theorem lie_YZ_Z_of_ne (a : Fin M) {b j : Fin M} (h : b ≠ j) : ⁅Y a * Z b, Z j⁆ = 0 := by
  calc ⁅Y a * Z b, Z j⁆
      = (Y a * Z b) * Z j - Z j * (Y a * Z b) := Ring.lie_def _ _
    _ = Y a * (Z b * Z j) - Z j * (Y a * Z b) := by rw [mul_assoc]
    _ = Y a * (-(Z j * Z b)) - Z j * (Y a * Z b) := by rw [Z_mul_Z_of_ne h]
    _ = -((Y a * Z j) * Z b) - Z j * (Y a * Z b) := by rw [mul_neg, mul_assoc]
    _ = -((-(Z j * Y a)) * Z b) - Z j * (Y a * Z b) := by rw [Y_mul_Z_anticomm]
    _ = (Z j * Y a) * Z b - Z j * (Y a * Z b) := by rw [neg_mul, neg_neg]
    _ = Z j * (Y a * Z b) - Z j * (Y a * Z b) := by rw [mul_assoc]
    _ = 0 := sub_self _

/-- `a ≠ j` なら `[Y_a Z_b, Y_j] = 0`。 -/
theorem lie_YZ_Y_of_ne {a j : Fin M} (b : Fin M) (h : a ≠ j) : ⁅Y a * Z b, Y j⁆ = 0 := by
  calc ⁅Y a * Z b, Y j⁆
      = (Y a * Z b) * Y j - Y j * (Y a * Z b) := Ring.lie_def _ _
    _ = Y a * (Z b * Y j) - Y j * (Y a * Z b) := by rw [mul_assoc]
    _ = Y a * (-(Y j * Z b)) - Y j * (Y a * Z b) := by rw [Z_mul_Y_anticomm]
    _ = -((Y a * Y j) * Z b) - Y j * (Y a * Z b) := by rw [mul_neg, mul_assoc]
    _ = -((-(Y j * Y a)) * Z b) - Y j * (Y a * Z b) := by rw [Y_mul_Y_of_ne h]
    _ = (Y j * Y a) * Z b - Y j * (Y a * Z b) := by rw [neg_mul, neg_neg]
    _ = Y j * (Y a * Z b) - Y j * (Y a * Z b) := by rw [mul_assoc]
    _ = 0 := sub_self _

/-! ## Step 1: 同じ添字を含む項 -/

/-- `[Z_j Y_j, Z_j] = -2 Y_j`。 -/
theorem lie_ZY_Z_self (j : Fin M) : ⁅Z j * Y j, Z j⁆ = (-2 : ℂ) • Y j := by
  calc ⁅Z j * Y j, Z j⁆
      = (Z j * Y j) * Z j - Z j * (Z j * Y j) := Ring.lie_def _ _
    _ = Z j * (Y j * Z j) - (Z j * Z j) * Y j := by rw [mul_assoc, mul_assoc]
    _ = Z j * (-(Z j * Y j)) - (Z j * Z j) * Y j := by rw [Y_mul_Z_anticomm]
    _ = -((Z j * Z j) * Y j) - (Z j * Z j) * Y j := by rw [mul_neg, mul_assoc]
    _ = -(1 * Y j) - 1 * Y j := by rw [Z_mul_self]
    _ = -Y j - Y j := by rw [one_mul]
    _ = (-2 : ℂ) • Y j := by rw [neg_smul, two_smul, neg_add]; abel

/-- `[Z_j Y_j, Y_j] = 2 Z_j`。 -/
theorem lie_ZY_Y_self (j : Fin M) : ⁅Z j * Y j, Y j⁆ = (2 : ℂ) • Z j := by
  calc ⁅Z j * Y j, Y j⁆
      = (Z j * Y j) * Y j - Y j * (Z j * Y j) := Ring.lie_def _ _
    _ = Z j * (Y j * Y j) - (Y j * Z j) * Y j := by rw [mul_assoc, mul_assoc]
    _ = Z j * 1 - (Y j * Z j) * Y j := by rw [Y_mul_self]
    _ = Z j - (Y j * Z j) * Y j := by rw [mul_one]
    _ = Z j - (-(Z j * Y j)) * Y j := by rw [Y_mul_Z_anticomm]
    _ = Z j + Z j * (Y j * Y j) := by rw [neg_mul, sub_neg_eq_add, mul_assoc]
    _ = Z j + Z j * 1 := by rw [Y_mul_self]
    _ = Z j + Z j := by rw [mul_one]
    _ = (2 : ℂ) • Z j := (two_smul ℂ _).symm

/-- `[Y_a Z_b, Z_b] = 2 Y_a`（人手の `[Y_m Z_{m+1}, Z_{m+1}] = 2Y_m` と、境界項 `[Y_M Z_1, Z_1]` の内側）。 -/
theorem lie_YZ_Z_right (a b : Fin M) : ⁅Y a * Z b, Z b⁆ = (2 : ℂ) • Y a := by
  calc ⁅Y a * Z b, Z b⁆
      = (Y a * Z b) * Z b - Z b * (Y a * Z b) := Ring.lie_def _ _
    _ = Y a * (Z b * Z b) - (Z b * Y a) * Z b := by rw [mul_assoc, mul_assoc]
    _ = Y a * 1 - (Z b * Y a) * Z b := by rw [Z_mul_self]
    _ = Y a - (Z b * Y a) * Z b := by rw [mul_one]
    _ = Y a - (-(Y a * Z b)) * Z b := by rw [Z_mul_Y_anticomm]
    _ = Y a + Y a * (Z b * Z b) := by rw [neg_mul, sub_neg_eq_add, mul_assoc]
    _ = Y a + Y a * 1 := by rw [Z_mul_self]
    _ = Y a + Y a := by rw [mul_one]
    _ = (2 : ℂ) • Y a := (two_smul ℂ _).symm

/-- `[Y_a Z_b, Y_a] = -2 Z_b`（人手の `[Y_m Z_{m+1}, Y_m] = -2Z_{m+1}` と、境界項 `[Y_M Z_1, Y_M]` の内側）。 -/
theorem lie_YZ_Y_left (a b : Fin M) : ⁅Y a * Z b, Y a⁆ = (-2 : ℂ) • Z b := by
  calc ⁅Y a * Z b, Y a⁆
      = (Y a * Z b) * Y a - Y a * (Y a * Z b) := Ring.lie_def _ _
    _ = Y a * (Z b * Y a) - (Y a * Y a) * Z b := by rw [mul_assoc, mul_assoc]
    _ = Y a * (-(Y a * Z b)) - (Y a * Y a) * Z b := by rw [Z_mul_Y_anticomm]
    _ = -((Y a * Y a) * Z b) - (Y a * Y a) * Z b := by rw [mul_neg, mul_assoc]
    _ = -(1 * Z b) - 1 * Z b := by rw [Y_mul_self]
    _ = -Z b - Z b := by rw [one_mul]
    _ = (-2 : ℂ) • Z b := by rw [neg_smul, two_smul, neg_add]; abel

/-! ## Step 1: 反周期的な延長 `Y♭_l`, `Z♭_l` -/

/-- 人手 Step 1 の `Y♭_l`（`l = 0, …, M`）: `Y♭_0 := -Y_M`、`1 ≤ l ≤ M` で `Y♭_l := Y_l`。
範囲外の `l` では `0` と置く（使わない）。 -/
noncomputable def Yflat (M : ℕ) (l : ℕ) : TensorPow M :=
  if h : 1 ≤ l ∧ l ≤ M then Y ⟨l - 1, by omega⟩
  else if h0 : l = 0 ∧ 0 < M then -Y ⟨M - 1, by omega⟩ else 0

/-- 人手 Step 1 の `Z♭_l`（`l = 1, …, M+1`）: `Z♭_{M+1} := -Z_1`、`1 ≤ l ≤ M` で `Z♭_l := Z_l`。
範囲外の `l` では `0` と置く（使わない）。 -/
noncomputable def Zflat (M : ℕ) (l : ℕ) : TensorPow M :=
  if h : 1 ≤ l ∧ l ≤ M then Z ⟨l - 1, by omega⟩
  else if h0 : l = M + 1 ∧ 0 < M then -Z ⟨0, by omega⟩ else 0

/-- `1 ≤ l ≤ M` では `Y♭_l = Y_l`（Lean の添字では `Yflat M (k+1) = Y k`）。 -/
theorem Yflat_succ (k : Fin M) : Yflat M ((k : ℕ) + 1) = Y k := by
  rw [Yflat, dif_pos ⟨by omega, k.isLt⟩]
  congr 1

/-- `Y♭_0 = -Y_M`。 -/
theorem Yflat_zero (hM : 0 < M) : Yflat M 0 = -Y ⟨M - 1, by omega⟩ := by
  rw [Yflat, dif_neg (by omega), dif_pos ⟨rfl, hM⟩]

/-- `1 ≤ l ≤ M` では `Z♭_l = Z_l`（Lean の添字では `Zflat M (k+1) = Z k`）。 -/
theorem Zflat_succ (k : Fin M) : Zflat M ((k : ℕ) + 1) = Z k := by
  rw [Zflat, dif_pos ⟨by omega, k.isLt⟩]
  congr 1

/-- `Z♭_{M+1} = -Z_1`。 -/
theorem Zflat_last (hM : 0 < M) : Zflat M (M + 1) = -Z ⟨0, hM⟩ := by
  rw [Zflat, dif_neg (by omega), dif_pos ⟨rfl, hM⟩]

/-! ## Step 1: 和へまとめる -/

/-- 交換子の第 1 引数についての線型性（有限和とスカラー倍）。 -/
theorem lie_sum_smul_left' {ι : Type*} [Fintype ι] (c : ι → ℂ) (x : ι → TensorPow M)
    (w : TensorPow M) : ⁅∑ i, c i • x i, w⁆ = ∑ i, c i • ⁅x i, w⁆ := by
  simp only [Ring.lie_def, Finset.sum_mul, Finset.mul_sum, Algebra.smul_mul_assoc,
    Algebra.mul_smul_comm, smul_sub, Finset.sum_sub_distrib]

/-- 交換子の第 2 引数についての線型性（有限和とスカラー倍）。 -/
theorem lie_sum_smul_right' {ι : Type*} [Fintype ι] (c : ι → ℂ) (x : ι → TensorPow M)
    (w : TensorPow M) : ⁅w, ∑ i, c i • x i⁆ = ∑ i, c i • ⁅w, x i⁆ := by
  simp only [Ring.lie_def, Finset.sum_mul, Finset.mul_sum, Algebra.smul_mul_assoc,
    Algebra.mul_smul_comm, smul_sub, Finset.sum_sub_distrib]

/-- 交換子の第 1 引数についての加法性（有限和）。 -/
theorem sum_lie' {ι : Type*} [Fintype ι] (x : ι → TensorPow M) (w : TensorPow M) :
    ⁅∑ i, x i, w⁆ = ∑ i, ⁅x i, w⁆ := by
  simp only [Ring.lie_def, Finset.sum_mul, Finset.mul_sum, Finset.sum_sub_distrib]

/-- **Step 1 の第 1 式** `[H_2, Z_j] = -2 Y_j`。 -/
theorem lie_H2_Z (j : Fin M) : ⁅H2 M, Z j⁆ = (-2 : ℂ) • Y j := by
  calc ⁅H2 M, Z j⁆
      = ⁅∑ a : Fin M, Z a * Y a, Z j⁆ := rfl
    _ = ∑ a : Fin M, ⁅Z a * Y a, Z j⁆ := sum_lie' _ _
    _ = ⁅Z j * Y j, Z j⁆ := Finset.sum_eq_single j (fun a _ ha => lie_ZY_Z_of_ne ha)
          (fun h => absurd (Finset.mem_univ j) h)
    _ = (-2 : ℂ) • Y j := lie_ZY_Z_self j

/-- **Step 1 の第 2 式** `[H_2, Y_j] = 2 Z_j`。 -/
theorem lie_H2_Y (j : Fin M) : ⁅H2 M, Y j⁆ = (2 : ℂ) • Z j := by
  calc ⁅H2 M, Y j⁆
      = ⁅∑ a : Fin M, Z a * Y a, Y j⁆ := rfl
    _ = ∑ a : Fin M, ⁅Z a * Y a, Y j⁆ := sum_lie' _ _
    _ = ⁅Z j * Y j, Y j⁆ := Finset.sum_eq_single j (fun a _ ha => lie_ZY_Y_of_ne ha)
          (fun h => absurd (Finset.mem_univ j) h)
    _ = (2 : ℂ) • Z j := lie_ZY_Y_self j

/-- **Step 1 の第 3 式** `[H_1^{(+)}, Z_j] = 2 Y♭_{j-1}`（Lean の添字 `k = j - 1`）。

人手は `2 ≤ j ≤ M`（`k ≠ 0`）と `j = 1`（`k = 0`）に分ける。どちらも、`Z_j` を右因子に持つ
ただ 1 つの項（`k ≠ 0` なら `m = j - 1`、`k = 0` なら境界項 `-Y_M Z_1`）以外は
`[Y_a Z_b, Z_j] = 0 (b ≠ j)` で消える。 -/
theorem lie_H1Plus_Z (k : Fin M) : ⁅H1plus M, Z k⁆ = (2 : ℂ) • Yflat M (k : ℕ) := by
  have hM : 0 < M := Fin.pos k
  rw [H1plus, lie_sum_smul_left']
  by_cases hk : (k : ℕ) = 0
  · -- `j = 1`: 境界項 `m = M` だけが残る
    set last : Fin M := ⟨M - 1, by omega⟩
    have hlast : (last : ℕ) + 1 = M := by simp [last]; omega
    have hnext : nextSite last = k := Fin.ext (by rw [nextSite_val_of_last hlast, hk])
    rw [Finset.sum_eq_single last]
    · rw [lastSign_of_last hlast, hnext, lie_YZ_Z_right, hk, Yflat_zero hM, smul_smul,
        smul_neg, ← neg_smul]
      congr 1
      norm_num
    · intro m _ hm
      have hne : nextSite m ≠ k := by
        intro he
        apply hm
        apply Fin.ext
        have hlt : (m : ℕ) + 1 ≤ M := m.isLt
        rcases Nat.lt_or_ge ((m : ℕ) + 1) M with h | h
        · have := congrArg Fin.val he
          rw [nextSite_val_of_lt h] at this
          omega
        · simp [last]; omega
      rw [lie_YZ_Z_of_ne _ hne, smul_zero]
    · exact fun h => absurd (Finset.mem_univ _) h
  · -- `2 ≤ j ≤ M`: `m = j - 1` の項だけが残る
    set prev : Fin M := ⟨(k : ℕ) - 1, by omega⟩
    have hprev : (prev : ℕ) + 1 < M := by simp [prev]; omega
    have hnext : nextSite prev = k := Fin.ext (by rw [nextSite_val_of_lt hprev]; simp [prev]; omega)
    rw [Finset.sum_eq_single prev]
    · rw [lastSign_of_not_last (by omega), hnext, lie_YZ_Z_right, one_smul]
      congr 1
      rw [show (k : ℕ) = (prev : ℕ) + 1 by simp [prev]; omega, Yflat_succ]
    · intro m _ hm
      have hne : nextSite m ≠ k := by
        intro he
        apply hm
        apply Fin.ext
        have := congrArg Fin.val he
        rcases Nat.lt_or_ge ((m : ℕ) + 1) M with h | h
        · rw [nextSite_val_of_lt h] at this
          simp [prev]; omega
        · have hl : (m : ℕ) + 1 = M := by have := m.isLt; omega
          rw [nextSite_val_of_last hl] at this
          omega
      rw [lie_YZ_Z_of_ne _ hne, smul_zero]
    · exact fun h => absurd (Finset.mem_univ _) h

/-- **Step 1 の第 4 式** `[H_1^{(+)}, Y_j] = -2 Z♭_{j+1}`（Lean の添字 `k = j - 1`、`j + 1 = k + 2`）。

人手は `1 ≤ j ≤ M-1` と `j = M` に分ける。どちらも、`Y_j` を左因子に持つただ 1 つの項
（`m = j`。`j = M` なら境界項 `-Y_M Z_1`）以外は `[Y_a Z_b, Y_j] = 0 (a ≠ j)` で消える。 -/
theorem lie_H1Plus_Y (k : Fin M) : ⁅H1plus M, Y k⁆ = (-2 : ℂ) • Zflat M ((k : ℕ) + 2) := by
  have hM : 0 < M := Fin.pos k
  rw [H1plus, lie_sum_smul_left',
    Finset.sum_eq_single k (fun m _ hm => by rw [lie_YZ_Y_of_ne _ hm, smul_zero])
      (fun h => absurd (Finset.mem_univ k) h),
    lie_YZ_Y_left, smul_smul]
  by_cases hk : (k : ℕ) + 1 = M
  · -- `j = M`: 境界項
    rw [lastSign_of_last hk, show (k : ℕ) + 2 = M + 1 by omega, Zflat_last hM, smul_neg,
      ← neg_smul]
    have hnext : nextSite k = ⟨0, hM⟩ := Fin.ext (nextSite_val_of_last hk)
    rw [hnext]
    congr 1
    norm_num
  · -- `1 ≤ j ≤ M - 1`
    have hlt : (k : ℕ) + 1 < M := by have := k.isLt; omega
    set nk : Fin M := ⟨(k : ℕ) + 1, hlt⟩
    have hnext : nextSite k = nk := Fin.ext (nextSite_val_of_lt hlt)
    rw [lastSign_of_not_last hk, hnext, show (k : ℕ) + 2 = (nk : ℕ) + 1 by simp [nk],
      Zflat_succ, one_mul]

/-! ## Step 2: (C)(D) -/

/-- **原文 (C) の形式化**: `[H_2, check(Z)_μ] = -2 check(Y)_μ`。 -/
theorem lie_H2_checkZ (hM : M ≠ 0) (ν : ℤ) :
    ⁅H2 M, checkZ M ν⁆ = (-2 : ℂ) • checkY M ν := by
  have _ := hM
  calc ⁅H2 M, checkZ M ν⁆
      = ⁅H2 M, ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) ν • Z j⁆ := rfl
    _ = ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) ν • ⁅H2 M, Z j⁆ := lie_sum_smul_right' _ _ _
    _ = ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) ν • ((-2 : ℂ) • Y j) := by
          simp only [lie_H2_Z]
    _ = (-2 : ℂ) • ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) ν • Y j := by
          rw [Finset.smul_sum]
          exact Finset.sum_congr rfl fun j _ => smul_comm _ _ _
    _ = (-2 : ℂ) • checkY M ν := rfl

/-- **原文 (D) の形式化**: `[H_2, check(Y)_μ] = 2 check(Z)_μ`。 -/
theorem lie_H2_checkY (hM : M ≠ 0) (ν : ℤ) :
    ⁅H2 M, checkY M ν⁆ = (2 : ℂ) • checkZ M ν := by
  have _ := hM
  calc ⁅H2 M, checkY M ν⁆
      = ⁅H2 M, ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) ν • Y j⁆ := rfl
    _ = ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) ν • ⁅H2 M, Y j⁆ := lie_sum_smul_right' _ _ _
    _ = ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) ν • ((2 : ℂ) • Z j) := by
          simp only [lie_H2_Y]
    _ = (2 : ℂ) • ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) ν • Z j := by
          rw [Finset.smul_sum]
          exact Finset.sum_congr rfl fun j _ => smul_comm _ _ _
    _ = (2 : ℂ) • checkZ M ν := rfl

/-! ## Step 3: (A) -/

/-- **Step 3 の境界の二項の等式**: `e^{-i·0·θ~_μ} Y♭_0 = e^{-iMθ~_μ} Y♭_M`。 -/
theorem checkPhase_smul_Yflat_boundary (hM : M ≠ 0) (ν : ℤ) :
    checkPhase M 0 ν • Yflat M 0 = checkPhase M (M : ℤ) ν • Yflat M M := by
  have hM0 : 0 < M := Nat.pos_of_ne_zero hM
  calc checkPhase M 0 ν • Yflat M 0
      = (1 : ℂ) • Yflat M 0 := by rw [checkPhase_zero_left]
    _ = (1 : ℂ) • (-Y ⟨M - 1, by omega⟩) := by rw [Yflat_zero hM0]
    _ = (-1 : ℂ) • Y ⟨M - 1, by omega⟩ := by rw [one_smul, neg_one_smul]
    _ = checkPhase M (M : ℤ) ν • Y ⟨M - 1, by omega⟩ := by rw [checkPhase_antiperiodic hM]
    _ = checkPhase M (M : ℤ) ν • Yflat M M := by
          rw [Yflat, dif_pos ⟨hM0, le_refl M⟩]

/-- **原文 (A) の形式化**: `[H_1^{(+)}, check(Z)_μ] = 2 e^{-iθ~_μ} check(Y)_μ`。 -/
theorem lie_H1Plus_checkZ (hM : M ≠ 0) (ν : ℤ) :
    ⁅H1plus M, checkZ M ν⁆ = (2 * checkPhase M 1 ν) • checkY M ν := by
  obtain ⟨n, rfl⟩ : ∃ n, M = n + 1 := Nat.exists_eq_succ_of_ne_zero hM
  -- 人手の `∑_{l=1}^{M} e^{-ilθ~} Y♭_l` を、最後の項 `l = M` を分けた形で
  have hsumM : ∑ k : Fin (n + 1), checkPhase (n + 1) (((k : ℕ) : ℤ) + 1) ν • Yflat (n + 1) ((k : ℕ) + 1)
      = ∑ i : Fin n, checkPhase (n + 1) (((i : ℕ) : ℤ) + 1) ν • Yflat (n + 1) ((i : ℕ) + 1)
        + checkPhase (n + 1) ((n + 1 : ℕ) : ℤ) ν • Yflat (n + 1) (n + 1) := by
    rw [Fin.sum_univ_castSucc]
    simp only [Fin.val_castSucc, Fin.val_last]
    push_cast
    rfl
  -- 人手の `∑_{l=0}^{M-1} e^{-ilθ~} Y♭_l` を、最初の項 `l = 0` を分けた形で
  have hsum0 : ∑ k : Fin (n + 1), checkPhase (n + 1) ((k : ℕ) : ℤ) ν • Yflat (n + 1) (k : ℕ)
      = checkPhase (n + 1) 0 ν • Yflat (n + 1) 0
        + ∑ i : Fin n, checkPhase (n + 1) (((i : ℕ) : ℤ) + 1) ν • Yflat (n + 1) ((i : ℕ) + 1) := by
    rw [Fin.sum_univ_succ]
    simp only [Fin.val_zero, Fin.val_succ]
    push_cast
    rfl
  calc ⁅H1plus (n + 1), checkZ (n + 1) ν⁆
      = ⁅H1plus (n + 1), ∑ j : Fin (n + 1), checkPhase (n + 1) (((j : ℕ) : ℤ) + 1) ν • Z j⁆ := rfl
    _ = ∑ j : Fin (n + 1), checkPhase (n + 1) (((j : ℕ) : ℤ) + 1) ν • ⁅H1plus (n + 1), Z j⁆ :=
          lie_sum_smul_right' _ _ _
    _ = ∑ j : Fin (n + 1), checkPhase (n + 1) (((j : ℕ) : ℤ) + 1) ν •
          ((2 : ℂ) • Yflat (n + 1) (j : ℕ)) := by simp only [lie_H1Plus_Z]
    _ = (2 : ℂ) • ∑ j : Fin (n + 1), checkPhase (n + 1) (((j : ℕ) : ℤ) + 1) ν •
          Yflat (n + 1) (j : ℕ) := by
          rw [Finset.smul_sum]
          exact Finset.sum_congr rfl fun j _ => smul_comm _ _ _
    _ = (2 : ℂ) • ∑ l : Fin (n + 1), (checkPhase (n + 1) 1 ν * checkPhase (n + 1) ((l : ℕ) : ℤ) ν) •
          Yflat (n + 1) (l : ℕ) := by
          congr 1
          refine Finset.sum_congr rfl fun l _ => ?_
          rw [← checkPhase_add_left, add_comm (1 : ℤ)]
    _ = (2 * checkPhase (n + 1) 1 ν) • ∑ l : Fin (n + 1), checkPhase (n + 1) ((l : ℕ) : ℤ) ν •
          Yflat (n + 1) (l : ℕ) := by
          simp only [Finset.smul_sum, mul_smul]
    _ = (2 * checkPhase (n + 1) 1 ν) • ∑ k : Fin (n + 1), checkPhase (n + 1) (((k : ℕ) : ℤ) + 1) ν •
          Yflat (n + 1) ((k : ℕ) + 1) := by
          rw [hsum0, hsumM, checkPhase_smul_Yflat_boundary hM]
          congr 1
          exact add_comm _ _
    _ = (2 * checkPhase (n + 1) 1 ν) • checkY (n + 1) ν := by
          simp only [Yflat_succ]
          rfl

/-! ## Step 4: (B) -/

/-- **Step 4 の境界の二項の等式**: `e^{-i(M+1)θ~_μ} Z♭_{M+1} = e^{-i·1·θ~_μ} Z♭_1`。 -/
theorem checkPhase_smul_Zflat_boundary (hM : M ≠ 0) (ν : ℤ) :
    checkPhase M ((M : ℤ) + 1) ν • Zflat M (M + 1) = checkPhase M 1 ν • Zflat M 1 := by
  have hM0 : 0 < M := Nat.pos_of_ne_zero hM
  calc checkPhase M ((M : ℤ) + 1) ν • Zflat M (M + 1)
      = (checkPhase M (M : ℤ) ν * checkPhase M 1 ν) • Zflat M (M + 1) := by
          rw [checkPhase_add_left]
    _ = (checkPhase M (M : ℤ) ν * checkPhase M 1 ν) • (-Z ⟨0, hM0⟩) := by rw [Zflat_last hM0]
    _ = ((-1) * checkPhase M 1 ν) • (-Z ⟨0, hM0⟩) := by rw [checkPhase_antiperiodic hM]
    _ = checkPhase M 1 ν • Z ⟨0, hM0⟩ := by rw [smul_neg, ← neg_smul]; congr 1; ring
    _ = checkPhase M 1 ν • Zflat M 1 := by
          rw [show (1 : ℕ) = ((⟨0, hM0⟩ : Fin M) : ℕ) + 1 from rfl, Zflat_succ]

/-- **原文 (B) の形式化**: `[H_1^{(+)}, check(Y)_μ] = -2 e^{iθ~_μ} check(Z)_μ`
（`e^{iθ~_μ} = checkPhase M (-1) μ`）。 -/
theorem lie_H1Plus_checkY (hM : M ≠ 0) (ν : ℤ) :
    ⁅H1plus M, checkY M ν⁆ = (-2 * checkPhase M (-1) ν) • checkZ M ν := by
  obtain ⟨n, rfl⟩ : ∃ n, M = n + 1 := Nat.exists_eq_succ_of_ne_zero hM
  -- 人手の `∑_{l=2}^{M+1} e^{-ilθ~} Z♭_l` を、最後の項 `l = M+1` を分けた形で
  have hsumLast : ∑ k : Fin (n + 1), checkPhase (n + 1) (((k : ℕ) : ℤ) + 2) ν • Zflat (n + 1) ((k : ℕ) + 2)
      = ∑ i : Fin n, checkPhase (n + 1) (((i : ℕ) : ℤ) + 2) ν • Zflat (n + 1) ((i : ℕ) + 2)
        + checkPhase (n + 1) (((n + 1 : ℕ) : ℤ) + 1) ν • Zflat (n + 1) (n + 1 + 1) := by
    rw [Fin.sum_univ_castSucc]
    simp only [Fin.val_castSucc, Fin.val_last]
    push_cast
    congr 2
  -- 人手の `∑_{l=1}^{M} e^{-ilθ~} Z♭_l` を、最初の項 `l = 1` を分けた形で
  have hsumFirst : ∑ k : Fin (n + 1), checkPhase (n + 1) (((k : ℕ) : ℤ) + 1) ν • Zflat (n + 1) ((k : ℕ) + 1)
      = checkPhase (n + 1) 1 ν • Zflat (n + 1) 1
        + ∑ i : Fin n, checkPhase (n + 1) (((i : ℕ) : ℤ) + 2) ν • Zflat (n + 1) ((i : ℕ) + 2) := by
    rw [Fin.sum_univ_succ]
    simp only [Fin.val_zero, Fin.val_succ]
    push_cast
    congr 2
  calc ⁅H1plus (n + 1), checkY (n + 1) ν⁆
      = ⁅H1plus (n + 1), ∑ j : Fin (n + 1), checkPhase (n + 1) (((j : ℕ) : ℤ) + 1) ν • Y j⁆ := rfl
    _ = ∑ j : Fin (n + 1), checkPhase (n + 1) (((j : ℕ) : ℤ) + 1) ν • ⁅H1plus (n + 1), Y j⁆ :=
          lie_sum_smul_right' _ _ _
    _ = ∑ j : Fin (n + 1), checkPhase (n + 1) (((j : ℕ) : ℤ) + 1) ν •
          ((-2 : ℂ) • Zflat (n + 1) ((j : ℕ) + 2)) := by simp only [lie_H1Plus_Y]
    _ = (-2 : ℂ) • ∑ j : Fin (n + 1), checkPhase (n + 1) (((j : ℕ) : ℤ) + 1) ν •
          Zflat (n + 1) ((j : ℕ) + 2) := by
          rw [Finset.smul_sum]
          exact Finset.sum_congr rfl fun j _ => smul_comm _ _ _
    _ = (-2 : ℂ) • ∑ l : Fin (n + 1),
          (checkPhase (n + 1) (-1) ν * checkPhase (n + 1) (((l : ℕ) : ℤ) + 2) ν) •
          Zflat (n + 1) ((l : ℕ) + 2) := by
          congr 1
          refine Finset.sum_congr rfl fun l _ => ?_
          rw [← checkPhase_add_left]
          congr 2
          ring
    _ = (-2 * checkPhase (n + 1) (-1) ν) • ∑ l : Fin (n + 1),
          checkPhase (n + 1) (((l : ℕ) : ℤ) + 2) ν • Zflat (n + 1) ((l : ℕ) + 2) := by
          simp only [Finset.smul_sum, mul_smul]
    _ = (-2 * checkPhase (n + 1) (-1) ν) • ∑ k : Fin (n + 1),
          checkPhase (n + 1) (((k : ℕ) : ℤ) + 1) ν • Zflat (n + 1) ((k : ℕ) + 1) := by
          rw [hsumLast, hsumFirst, show (((n + 1 : ℕ) : ℤ) + 1) = ((n + 1 : ℕ) : ℤ) + 1 from rfl,
            checkPhase_smul_Zflat_boundary hM]
          congr 1
          exact add_comm _ _
    _ = (-2 * checkPhase (n + 1) (-1) ν) • checkZ (n + 1) ν := by
          simp only [Zflat_succ]
          rfl

end Ising2D
