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
* Step 2（(C)(D)）: `lie_H2_checkZ`・`lie_H2_checkY`（`M = 0` でも成り立つので `M ≠ 0` を取らない）。
* Step 3（(A)）: 境界の二項の等式 `checkPhase_smul_Yflat_boundary` と `lie_H1Plus_checkZ`。
* Step 4（(B)）: 境界の二項の等式 `checkPhase_smul_Zflat_boundary` と `lie_H1Plus_checkY`。

人手 `anticommutator_of_Z_and_Y` は `anticomm_Z_Z`・`anticomm_Z_Y`・`anticomm_Y_Y`・`Z_mul_self`・`Y_mul_self`
（`ClaimAnticommutatorZY.lean`）。

必要十分版は `NecSuf/CommutatorSiteSum.lean`（同じ手順を、`R`-代数の族 `z, y` の反交換関係 5 つと
位相の加法性・`p(0) = 1`・境界の符号と位相の一周の関係だけで書いたもの）。この 4 式をその特殊化として導く系は
`ClaimCommutatorHCheckZYFromNecSuf.lean`。`NecSuf/CommutatorClifford.lean` は `H` を `check(Z), check(Y)` の和で表してから
計算する別の経路（参照用ノートへ退避した `H1_H2_via_check_Z_Y` を使う）の一般化で、この証明とは対応しない。

## 人手の行と Lean の行がまとまっている箇所

* Lean の `H1plus` は境界項を `lastSign (-1)` 付きの 1 項として含む `M` 項の和なので、人手の
  「和と境界項に分ける」「境界項（または和の項）を 0 で消す」「零行列の和」の行は、
  `lie_H1Plus_Z`・`lie_H1Plus_Y` の `Finset.sum_eq_single` 1 回にまとまる（`lie_H2_Z`・`lie_H2_Y` も同じ）。
  境界項の等式 `[-Y_M Z_1, Z_1] = 2Y♭_0`・`[-Y_M Z_1, Y_M] = -2Z♭_{M+1}` は、その場合分けの中の `rw` で出す。
  人手のこの段の根拠は、`O` を足して消す行が `matrix_plus_zero_matrix`・`zero_matrix_plus_matrix`、`O` を引いて消す行が
  `matrix_minus_zero_matrix`、零行列の有限和を `O` にする行が `finite_sum_of_zero_matrices`（添字が `1, …, M-1` の 2 か所）と
  名前の根拠「零行列の和は零行列」（一つの添字を除いた集合の上の和の 4 か所。`M = 2` では空の和）である。
  具体版（`ClaimAddAndSubtractZeroMatrix.lean`）は添字が `Fin m` の行列についてのもので、`TensorPow M` の添字 `Conf M` に当てはまらない。
  加えて有限和の添字の付け方が本文でまだ定まっていない（状態台帳の「有限和の添字の付け方」の件）ので、`Finset.sum_eq_single` にまとめたままにしてある。
* Step 3 の添字の付け替え `l = j - 1` は、和の添字 `j : Fin M` の `ι_{ℕ→ℤ}(j.val)`（`= finIndexToZZ M j − 1_ℤ`）がそのまま人手の `l` なので、行が無い
  （`checkZ`・`checkY` の位相の添字は `((j : ℕ) : ℤ) + 1` で書いてあり、まだ `finIndexToZZ M j` を通していない）。
  Step 4 の付け替え `l = j + 1` は `checkPhase_add_left`（`theorem_exp_product`）と同じ行で行う。
* 人手の「分配律」の行では、`2` と `e^{∓iθ~_μ}` を 1 つのスカラーにまとめる。
  人手の最後の 2 行（`1 ≤ l ≤ M` で延長を外す行と `def_half_integer_checkY`・`def_half_integer_checkZ` の行）は 1 行にまとめる。

## 単位行列と差の段

* Step 1 の `identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult`・
  `matrix_difference_zero_iff_equal` の `⟸` の段は、`identity_matrix_mul_tensorPow`・`mul_identity_matrix_tensorPow`
  （`ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf.lean`）・`matrix_sub_eq_zero_iff_tensorPow`
  （`ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf.lean`）で閉じる。具体版は添字が `Fin m` の行列について述べてあり、
  Lean の `TensorPow M` は添字を `Conf M` に取るので、同じ手順の必要十分版を `Conf M` へ特殊化した系を使う。

## 添字の扱い

site 添字は `Fin M` で、人手の添字 `j ∈ {1,…,M}` は `finIndexToZZ M k = j`（`def_index_set_from_one_to_n`）を満たす `k : Fin M` である。
`lie_H1Plus_Z`・`lie_H1Plus_Y` の場合分け（人手の `j = 1` と `2 ≤ j ≤ M`、`j = M` と `1 ≤ j ≤ M-1`）は、この像を `1_ℤ`・`ι_{ℕ→ℤ}(M)` と ℤ で比べて行う。
人手の `m = j - 1`・`j + 1` のサイトは全単射の補題 `finIndexToZZ_bijective_onto_index_set` の全射で取り、サイトの等号はその単射で得る。
人手のサイト `1`・`M` は `firstSite`・`lastSite`、次のサイトの像は `finIndexToZZ_nextSite_of_lt`・`finIndexToZZ_nextSite_of_last` で求める。
Lean の定義 `lastSign`・`nextSite` の仮定（値の `m.val + 1 = M` など）へは `finIndexToZZ_eq_iff_val_add_one_eq` で移す。
延長 `Y♭_l`（`l = 0, …, M`）・`Z♭_l`（`l = 1, …, M+1`）は人手と同じ自然数の添字 `l` で持つ。定義の場合分けは延長の添字 `l` どうしの ℕ の比較で、
本文の添字と `Fin M` の元の行き来ではない。行き来は定義の中の `Y ⟨l - 1, _⟩`・`Z ⟨l - 1, _⟩` で、これを写像経由にするには `finIndexToZZ` の逆写像に
名前を付けて置く必要があるので、この定義は残す。人手の添字から `l` へ移る段は `finIndexToZZ_eq_inclusion_add_one_iff_val_eq`（像が `ι_{ℕ→ℤ}(l) + 1_ℤ`
であることと値が `l` であることの同値）で行い、境界の `Y♭_0 = -Y_M`・`Z♭_{M+1} = -Z_1` の右辺は `lastSite`・`firstSite` で書く。
モード添字 `μ` は `ℤ` のまま扱う（4 式とも `μ ∈ ℤ` で成り立つ）。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimAnticommutatorCheckZY
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionH1H2V1V2
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf

namespace Ising2D

variable {M : ℕ}

/-! ## 準備: `anticommutator_of_Z_and_Y` から従う関係式 -/

/-- `j ≠ k` なら `Z_j Z_k = -Z_k Z_j`。 -/
theorem Z_mul_Z_of_ne {j k : Fin M} (h : j ≠ k) : Z j * Z k = -(Z k * Z j) := by
  have := anticomm_Z_Z j k
  rw [acomm, deltaM_of_ne h, mul_zero, zero_smul] at this
  exact eq_neg_of_add_eq_zero_left this

/-- `j ≠ k` なら `Y_j Y_k = -Y_k Y_j`。 -/
theorem Y_mul_Y_of_ne {j k : Fin M} (h : j ≠ k) : Y j * Y k = -(Y k * Y j) := by
  have := anticomm_Y_Y j k
  rw [acomm, deltaM_of_ne h, mul_zero, zero_smul] at this
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
    _ = 0 := (matrix_sub_eq_zero_iff_tensorPow _ _).mpr rfl  -- `matrix_difference_zero_iff_equal` の `⟸`

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
    _ = 0 := (matrix_sub_eq_zero_iff_tensorPow _ _).mpr rfl  -- `matrix_difference_zero_iff_equal` の `⟸`

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
    _ = 0 := (matrix_sub_eq_zero_iff_tensorPow _ _).mpr rfl  -- `matrix_difference_zero_iff_equal` の `⟸`

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
    _ = 0 := (matrix_sub_eq_zero_iff_tensorPow _ _).mpr rfl  -- `matrix_difference_zero_iff_equal` の `⟸`

/-! ## Step 1: 同じ添字を含む項 -/

/-- `[Z_j Y_j, Z_j] = -2 Y_j`。 -/
theorem lie_ZY_Z_self (j : Fin M) : ⁅Z j * Y j, Z j⁆ = (-2 : ℂ) • Y j := by
  calc ⁅Z j * Y j, Z j⁆
      = (Z j * Y j) * Z j - Z j * (Z j * Y j) := Ring.lie_def _ _
    _ = Z j * (Y j * Z j) - (Z j * Z j) * Y j := by rw [mul_assoc, mul_assoc]
    _ = Z j * (-(Z j * Y j)) - (Z j * Z j) * Y j := by rw [Y_mul_Z_anticomm]
    _ = -((Z j * Z j) * Y j) - (Z j * Z j) * Y j := by rw [mul_neg, mul_assoc]
    _ = -(1 * Y j) - 1 * Y j := by rw [Z_mul_self]
    _ = -Y j - Y j := by rw [identity_matrix_mul_tensorPow]  -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = (-2 : ℂ) • Y j := by rw [neg_smul, two_smul, neg_add]; abel

/-- `[Z_j Y_j, Y_j] = 2 Z_j`。 -/
theorem lie_ZY_Y_self (j : Fin M) : ⁅Z j * Y j, Y j⁆ = (2 : ℂ) • Z j := by
  calc ⁅Z j * Y j, Y j⁆
      = (Z j * Y j) * Y j - Y j * (Z j * Y j) := Ring.lie_def _ _
    _ = Z j * (Y j * Y j) - (Y j * Z j) * Y j := by rw [mul_assoc, mul_assoc]
    _ = Z j * 1 - (Y j * Z j) * Y j := by rw [Y_mul_self]
    _ = Z j - (Y j * Z j) * Y j := by rw [mul_identity_matrix_tensorPow]  -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = Z j - (-(Z j * Y j)) * Y j := by rw [Y_mul_Z_anticomm]
    _ = Z j + Z j * (Y j * Y j) := by rw [neg_mul, sub_neg_eq_add, mul_assoc]
    _ = Z j + Z j * 1 := by rw [Y_mul_self]
    _ = Z j + Z j := by rw [mul_identity_matrix_tensorPow]  -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = (2 : ℂ) • Z j := (two_smul ℂ _).symm

/-- `[Y_a Z_b, Z_b] = 2 Y_a`（人手の `[Y_m Z_{m+1}, Z_{m+1}] = 2Y_m` と、境界項 `[Y_M Z_1, Z_1]` の内側）。 -/
theorem lie_YZ_Z_right (a b : Fin M) : ⁅Y a * Z b, Z b⁆ = (2 : ℂ) • Y a := by
  calc ⁅Y a * Z b, Z b⁆
      = (Y a * Z b) * Z b - Z b * (Y a * Z b) := Ring.lie_def _ _
    _ = Y a * (Z b * Z b) - (Z b * Y a) * Z b := by rw [mul_assoc, mul_assoc]
    _ = Y a * 1 - (Z b * Y a) * Z b := by rw [Z_mul_self]
    _ = Y a - (Z b * Y a) * Z b := by rw [mul_identity_matrix_tensorPow]  -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = Y a - (-(Y a * Z b)) * Z b := by rw [Z_mul_Y_anticomm]
    _ = Y a + Y a * (Z b * Z b) := by rw [neg_mul, sub_neg_eq_add, mul_assoc]
    _ = Y a + Y a * 1 := by rw [Z_mul_self]
    _ = Y a + Y a := by rw [mul_identity_matrix_tensorPow]  -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = (2 : ℂ) • Y a := (two_smul ℂ _).symm

/-- `[Y_a Z_b, Y_a] = -2 Z_b`（人手の `[Y_m Z_{m+1}, Y_m] = -2Z_{m+1}` と、境界項 `[Y_M Z_1, Y_M]` の内側）。 -/
theorem lie_YZ_Y_left (a b : Fin M) : ⁅Y a * Z b, Y a⁆ = (-2 : ℂ) • Z b := by
  calc ⁅Y a * Z b, Y a⁆
      = (Y a * Z b) * Y a - Y a * (Y a * Z b) := Ring.lie_def _ _
    _ = Y a * (Z b * Y a) - (Y a * Y a) * Z b := by rw [mul_assoc, mul_assoc]
    _ = Y a * (-(Y a * Z b)) - (Y a * Y a) * Z b := by rw [Z_mul_Y_anticomm]
    _ = -((Y a * Y a) * Z b) - (Y a * Y a) * Z b := by rw [mul_neg, mul_assoc]
    _ = -(1 * Z b) - 1 * Z b := by rw [Y_mul_self]
    _ = -Z b - Z b := by rw [identity_matrix_mul_tensorPow]  -- `identity_matrix_is_left_unit_of_mat_mult`
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

/-- `Y♭_0 = -Y_M`（人手のサイト `M` は `lastSite`）。 -/
theorem Yflat_zero (hM : M ≠ 0) : Yflat M 0 = -Y (lastSite M hM) := by
  rw [Yflat, dif_neg (by omega), dif_pos ⟨rfl, Nat.pos_of_ne_zero hM⟩]
  rfl

/-- `1 ≤ l ≤ M` では `Z♭_l = Z_l`（Lean の添字では `Zflat M (k+1) = Z k`）。 -/
theorem Zflat_succ (k : Fin M) : Zflat M ((k : ℕ) + 1) = Z k := by
  rw [Zflat, dif_pos ⟨by omega, k.isLt⟩]
  congr 1

/-- `Z♭_{M+1} = -Z_1`（人手のサイト `1` は `firstSite`）。 -/
theorem Zflat_last (hM : M ≠ 0) : Zflat M (M + 1) = -Z (firstSite M hM) := by
  rw [Zflat, dif_neg (by omega), dif_pos ⟨rfl, Nat.pos_of_ne_zero hM⟩]
  rfl

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

/-- **Step 1 の第 3 式** `[H_1^{(+)}, Z_j] = 2 Y♭_{j-1}`。人手の添字 `j` は `finIndexToZZ M k`（`def_index_set_from_one_to_n`）で、
延長の自然数の添字 `ι_{ℕ→ℤ}(k.val) = finIndexToZZ M k − 1_ℤ` が人手の `j − 1` である。

人手は `2 ≤ j ≤ M` と `j = 1` に分ける。Lean は `finIndexToZZ M k = 1`（`j = 1`）とその否定（`2 ≤ j ≤ M`）で分けるので、
二つの場合の並びは人手と逆である。どちらも、`Z_j` を右因子に持つただ 1 つの項（`2 ≤ j ≤ M` なら `m = j - 1`、`j = 1` なら境界項 `-Y_M Z_1`）以外は
`[Y_a Z_b, Z_j] = 0 (b ≠ j)` で消える。 -/
theorem lie_H1Plus_Z (k : Fin M) : ⁅H1plus M, Z k⁆ = (2 : ℂ) • Yflat M (k : ℕ) := by
  have hM : 0 < M := Fin.pos k
  -- 人手の添字 `j ∈ {1,…,M}` は `finIndexToZZ M k`、和の添字 `m` は `finIndexToZZ M m`（`def_index_set_from_one_to_n`）。
  -- 場合分けはこの像の ℤ の比較で行い、分けた後のサイトの等号は全単射の補題の単射で、`m = j - 1` のサイトは全射で得る
  have hinj := (finIndexToZZ_bijective_onto_index_set M).1
  have hrange := (finIndexToZZ_bijective_onto_index_set M).2.1
  have hsurj := (finIndexToZZ_bijective_onto_index_set M).2.2
  rw [H1plus, lie_sum_smul_left']
  by_cases hk : finIndexToZZ M k = 1
  · -- `j = 1`: 境界項 `m = M`（人手のサイト `M` は `lastSite`）だけが残る
    set last : Fin M := lastSite M hM.ne'
    have hlastZ : finIndexToZZ M last = inclusionNNtoZZ M := finIndexToZZ_lastSite hM.ne'
    have hlast : (last : ℕ) + 1 = M := (finIndexToZZ_eq_iff_val_add_one_eq M last).1 hlastZ
    have hnext : nextSite last = k := hinj _ _ (by rw [finIndexToZZ_nextSite_of_last hlast, hk])
    -- 延長 `Y♭` の添字（ℕ）へ移す: 人手の `j - 1 = 0`
    have hk0 : (k : ℕ) = 0 :=
      (finIndexToZZ_eq_inclusion_add_one_iff_val_eq M k 0).1 (by rw [inclusionNNtoZZ_eq_natCast]; omega)
    rw [Finset.sum_eq_single last]
    · rw [lastSign_of_last hlast, hnext, lie_YZ_Z_right, hk0, Yflat_zero hM.ne', smul_smul,
        smul_neg, ← neg_smul]
      congr 1
      norm_num
    · intro m _ hm
      -- 人手の `m + 1 = 1` となる和の添字は `m = M` だけ
      have hne : nextSite m ≠ k := by
        intro he
        apply hm
        by_cases hmlast : finIndexToZZ M m = inclusionNNtoZZ M
        · exact hinj _ _ (by rw [hmlast, hlastZ])
        · have hlt : (m : ℕ) + 1 < M := by
            have := (finIndexToZZ_eq_iff_val_add_one_eq M m).not.1 hmlast
            have := m.isLt
            omega
          have h1 := finIndexToZZ_nextSite_of_lt hlt
          rw [he, hk] at h1
          have := (hrange m).1
          omega
      rw [lie_YZ_Z_of_ne _ hne, smul_zero]
    · exact fun h => absurd (Finset.mem_univ _) h
  · -- `2 ≤ j ≤ M`: `m = j - 1` の項だけが残る
    have hkr := hrange k
    obtain ⟨prev, hprevZ⟩ := hsurj (finIndexToZZ M k - 1) (by omega) (by omega)
    have hprevNotLast : (prev : ℕ) + 1 ≠ M := fun h => by
      have := (finIndexToZZ_eq_iff_val_add_one_eq M prev).2 h
      omega
    have hprev : (prev : ℕ) + 1 < M := by have := prev.isLt; omega
    have hnext : nextSite prev = k :=
      hinj _ _ (by rw [finIndexToZZ_nextSite_of_lt hprev, hprevZ]; ring)
    -- 延長 `Y♭` の添字（ℕ）へ移す: 人手の `j - 1 = m`
    have hkval : (k : ℕ) = (prev : ℕ) + 1 := by
      have hprevval := (finIndexToZZ_eq_inclusion_add_one_iff_val_eq M prev prev).2 rfl
      refine (finIndexToZZ_eq_inclusion_add_one_iff_val_eq M k ((prev : ℕ) + 1)).1 ?_
      rw [inclusionNNtoZZ_eq_natCast] at hprevval ⊢
      push_cast
      omega
    rw [Finset.sum_eq_single prev]
    · rw [lastSign_of_not_last hprevNotLast, hnext, lie_YZ_Z_right, one_smul]
      congr 1
      rw [hkval, Yflat_succ]
    · intro m _ hm
      -- 人手の `m + 1 = j`（`j ≥ 2`）となる和の添字は `m = j - 1` だけ
      have hne : nextSite m ≠ k := by
        intro he
        apply hm
        apply hinj
        by_cases hmlast : finIndexToZZ M m = inclusionNNtoZZ M
        · have h1 := finIndexToZZ_nextSite_of_last ((finIndexToZZ_eq_iff_val_add_one_eq M m).1 hmlast)
          rw [he] at h1
          exact absurd h1 hk
        · have hlt : (m : ℕ) + 1 < M := by
            have := (finIndexToZZ_eq_iff_val_add_one_eq M m).not.1 hmlast
            have := m.isLt
            omega
          have h1 := finIndexToZZ_nextSite_of_lt hlt
          rw [he] at h1
          omega
      rw [lie_YZ_Z_of_ne _ hne, smul_zero]
    · exact fun h => absurd (Finset.mem_univ _) h

/-- **Step 1 の第 4 式** `[H_1^{(+)}, Y_j] = -2 Z♭_{j+1}`。人手の添字 `j` は `finIndexToZZ M k`（`def_index_set_from_one_to_n`）で、
延長の自然数の添字 `ι_{ℕ→ℤ}(k.val + 2) = finIndexToZZ M k + 1_ℤ` が人手の `j + 1` である。

人手は `1 ≤ j ≤ M-1` と `j = M` に分ける。Lean は `finIndexToZZ M k = ι_{ℕ→ℤ}(M)`（`j = M`）とその否定（`1 ≤ j ≤ M-1`）で分けるので、
二つの場合の並びは人手と逆である。どちらも、`Y_j` を左因子に持つただ 1 つの項
（`m = j`。`j = M` なら境界項 `-Y_M Z_1`）以外は `[Y_a Z_b, Y_j] = 0 (a ≠ j)` で消える。 -/
theorem lie_H1Plus_Y (k : Fin M) : ⁅H1plus M, Y k⁆ = (-2 : ℂ) • Zflat M ((k : ℕ) + 2) := by
  have hM : 0 < M := Fin.pos k
  -- 人手の添字 `j ∈ {1,…,M}` は `finIndexToZZ M k`（`def_index_set_from_one_to_n`）。
  -- 場合分けはこの像と `ι_{ℕ→ℤ}(M)` の比較で行い、人手の `j + 1` のサイトは全単射の補題の全射で、その等号は単射で得る
  have hinj := (finIndexToZZ_bijective_onto_index_set M).1
  have hrange := (finIndexToZZ_bijective_onto_index_set M).2.1
  have hsurj := (finIndexToZZ_bijective_onto_index_set M).2.2
  rw [H1plus, lie_sum_smul_left',
    Finset.sum_eq_single k (fun m _ hm => by rw [lie_YZ_Y_of_ne _ hm, smul_zero])
      (fun h => absurd (Finset.mem_univ k) h),
    lie_YZ_Y_left, smul_smul]
  by_cases hkZ : finIndexToZZ M k = inclusionNNtoZZ M
  · -- `j = M`: 境界項。次のサイトは人手のサイト `1`（`firstSite`）
    have hk : (k : ℕ) + 1 = M := (finIndexToZZ_eq_iff_val_add_one_eq M k).1 hkZ
    rw [lastSign_of_last hk, show (k : ℕ) + 2 = M + 1 by omega, Zflat_last hM.ne', smul_neg,
      ← neg_smul]
    have hnext : nextSite k = firstSite M hM.ne' :=
      hinj _ _ (by rw [finIndexToZZ_nextSite_of_last hk, finIndexToZZ_firstSite])
    rw [hnext]
    congr 1
    norm_num
  · -- `1 ≤ j ≤ M - 1`: 次のサイトは人手の添字 `j + 1` のサイト
    have hk : (k : ℕ) + 1 ≠ M := fun h => hkZ ((finIndexToZZ_eq_iff_val_add_one_eq M k).2 h)
    have hlt : (k : ℕ) + 1 < M := by have := k.isLt; omega
    have hkr := hrange k
    obtain ⟨nk, hnkZ⟩ := hsurj (finIndexToZZ M k + 1) (by omega) (by omega)
    have hnext : nextSite k = nk := hinj _ _ (by rw [finIndexToZZ_nextSite_of_lt hlt, hnkZ])
    -- 延長 `Z♭` の添字（ℕ）へ移す: 人手の `j + 1`
    have hnkval : (k : ℕ) + 2 = (nk : ℕ) + 1 := by
      have hkval := (finIndexToZZ_eq_inclusion_add_one_iff_val_eq M k k).2 rfl
      have hnk : (nk : ℕ) = (k : ℕ) + 1 := by
        refine (finIndexToZZ_eq_inclusion_add_one_iff_val_eq M nk ((k : ℕ) + 1)).1 ?_
        rw [inclusionNNtoZZ_eq_natCast] at hkval ⊢
        push_cast
        omega
      omega
    rw [lastSign_of_not_last hk, hnext, hnkval, Zflat_succ, one_mul]

/-! ## Step 2: (C)(D) -/

/-- **原文 (C) の形式化**: `[H_2, check(Z)_μ] = -2 check(Y)_μ`。 -/
theorem lie_H2_checkZ (ν : ℤ) :
    ⁅H2 M, checkZ M ν⁆ = (-2 : ℂ) • checkY M ν := by
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
theorem lie_H2_checkY (ν : ℤ) :
    ⁅H2 M, checkY M ν⁆ = (2 : ℂ) • checkZ M ν := by
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
    _ = (1 : ℂ) • (-Y (lastSite M hM)) := by rw [Yflat_zero hM]
    _ = (-1 : ℂ) • Y (lastSite M hM) := by rw [one_smul, neg_one_smul]
    _ = checkPhase M (M : ℤ) ν • Y (lastSite M hM) := by rw [checkPhase_antiperiodic hM]
    _ = checkPhase M (M : ℤ) ν • Yflat M M := by
          rw [Yflat, dif_pos ⟨hM0, le_refl M⟩]
          rfl

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
    _ = (checkPhase M (M : ℤ) ν * checkPhase M 1 ν) • (-Z (firstSite M hM)) := by rw [Zflat_last hM]
    _ = ((-1) * checkPhase M 1 ν) • (-Z (firstSite M hM)) := by rw [checkPhase_antiperiodic hM]
    _ = checkPhase M 1 ν • Z (firstSite M hM) := by rw [smul_neg, ← neg_smul]; congr 1; ring
    _ = checkPhase M 1 ν • Zflat M 1 := by
          rw [show (1 : ℕ) = ((firstSite M hM : Fin M) : ℕ) + 1 from rfl, Zflat_succ]

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
