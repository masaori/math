/-
# 必要十分版からの導出: `check(Z), check(Y)` についての `n` 重交換子

対応する人手証明のラベル: **`nesting_of_commutator_of_H_and_check_Z`**。
人手証明と 1 対 1 の具体版は `EigenvalueProblem/ReductionToATheta/ClaimNestedCommutator.lean` にある。

**必要十分版**は `Ising2D/NecSuf/NestedCommutatorTwoDim.lean` の `nested_z_even` / `nested_z_odd` /
`nested_y_even` / `nested_y_odd`（`[h, z] = 2p y`、`[h, y] = -2q z`、`pq = 1` のとき `ad_{Kh}^n` の偶奇の閉じた形。
具体版と同じ帰納段階 1・2 をたどる）。ここでは 8 本を、`(z, y) = (check(Z)_μ, check(Y)_μ)` と次の `(h, p, q)` で特殊化して得る。

| | `h` | `p` | `q` | `[h, z] = 2p y`・`[h, y] = -2q z` の根拠 | `pq = 1` の根拠 |
| --- | --- | --- | --- | --- | --- |
| (h1.z)(h1.y) | `H_1^{(+)}` | `e^{-iθ~_μ}` | `e^{iθ~_μ}` | (A)・(B) | `e^{-iθ~}e^{iθ~} = 1`（`checkPhase_mul_neg`） |
| (h2.z)(h2.y) | `H_2` | `-1` | `-1` | (C)・(D) | `(-1)(-1) = 1` |

(h2.z) の奇数側と (h2.y) の奇数側は、`p = q = -1` を代入した右辺の符号を具体版の形へ並べ直す 1 行を足す。
-/
import Ising2D.NecSuf.NestedCommutatorTwoDim
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimNestedCommutator

namespace Ising2D

variable {M : ℕ}

/-- `adPow` は必要十分版の `NecSuf.iterComm` と同じ再帰である。 -/
theorem adPow_eq_iterComm (X : TensorPow M) :
    ∀ (n : ℕ) (W : TensorPow M), adPow X n W = NecSuf.iterComm X n W
  | 0, W => rfl
  | n + 1, W => by rw [adPow_succ, adPow_eq_iterComm X n W, NecSuf.iterComm_succ]

/-! ## `[h, z] = 2p y`・`[h, y] = -2q z` を (A)〜(D) から読む -/

/-- (A) を `[h, z] = 2p y` の形で（`p = e^{-iθ~_μ}`）。 -/
private theorem comm_H1Plus_checkZ (hM : M ≠ 0) (μ : ℤ) :
    H1plus M * checkZ M μ - checkZ M μ * H1plus M = (2 * checkPhase M 1 μ) • checkY M μ := by
  rw [← Ring.lie_def, lie_H1Plus_checkZ hM μ]

/-- (B) を `[h, y] = -2q z` の形で（`q = e^{iθ~_μ}`）。 -/
private theorem comm_H1Plus_checkY (hM : M ≠ 0) (μ : ℤ) :
    H1plus M * checkY M μ - checkY M μ * H1plus M = (-2 * checkPhase M (-1) μ) • checkZ M μ := by
  rw [← Ring.lie_def, lie_H1Plus_checkY hM μ]

/-- (C) を `[h, z] = 2p y` の形で（`p = -1`）。 -/
private theorem comm_H2_checkZ (μ : ℤ) :
    H2 M * checkZ M μ - checkZ M μ * H2 M = (2 * (-1 : ℂ)) • checkY M μ := by
  rw [← Ring.lie_def, lie_H2_checkZ μ]
  norm_num

/-- (D) を `[h, y] = -2q z` の形で（`q = -1`）。 -/
private theorem comm_H2_checkY (μ : ℤ) :
    H2 M * checkY M μ - checkY M μ * H2 M = (-2 * (-1 : ℂ)) • checkZ M μ := by
  rw [← Ring.lie_def, lie_H2_checkY μ]
  norm_num

private theorem neg_one_mul_neg_one : (-1 : ℂ) * (-1) = 1 := by norm_num

/-! ## 8 本の特殊化 -/

/-- 人手 (h1.z) の偶数側を必要十分版の特殊化として得たもの。 -/
theorem nesting_H1Plus_checkZ_even_of_necSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1plus M) (2 * k) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkZ M μ := by
  rw [adPow_eq_iterComm]
  exact NecSuf.nested_z_even (comm_H1Plus_checkZ hM μ) (comm_H1Plus_checkY hM μ)
    (checkPhase_mul_neg M μ) K1 k

/-- 人手 (h1.z) の奇数側を必要十分版の特殊化として得たもの。 -/
theorem nesting_H1Plus_checkZ_odd_of_necSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1plus M) (2 * k + 1) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
  rw [adPow_eq_iterComm]
  exact NecSuf.nested_z_odd (comm_H1Plus_checkZ hM μ) (comm_H1Plus_checkY hM μ)
    (checkPhase_mul_neg M μ) K1 k

/-- 人手 (h1.y) の偶数側を必要十分版の特殊化として得たもの。 -/
theorem nesting_H1Plus_checkY_even_of_necSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1plus M) (2 * k) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkY M μ := by
  rw [adPow_eq_iterComm]
  exact NecSuf.nested_y_even (comm_H1Plus_checkZ hM μ) (comm_H1Plus_checkY hM μ)
    (checkPhase_mul_neg M μ) K1 k

/-- 人手 (h1.y) の奇数側を必要十分版の特殊化として得たもの。 -/
theorem nesting_H1Plus_checkY_odd_of_necSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1plus M) (2 * k + 1) (checkY M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ := by
  rw [adPow_eq_iterComm]
  exact NecSuf.nested_y_odd (comm_H1Plus_checkZ hM μ) (comm_H1Plus_checkY hM μ)
    (checkPhase_mul_neg M μ) K1 k

/-- 人手 (h2.z) の偶数側を必要十分版の特殊化として得たもの。 -/
theorem nesting_H2_checkZ_even_of_necSuf (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkZ M μ := by
  rw [adPow_eq_iterComm]
  exact NecSuf.nested_z_even (comm_H2_checkZ μ) (comm_H2_checkY μ)
    neg_one_mul_neg_one K2star k

/-- 人手 (h2.z) の奇数側を必要十分版の特殊化として得たもの。 -/
theorem nesting_H2_checkZ_odd_of_necSuf (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k + 1) (checkZ M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1)) • checkY M μ := by
  rw [adPow_eq_iterComm, NecSuf.nested_z_odd (comm_H2_checkZ μ) (comm_H2_checkY μ)
    neg_one_mul_neg_one K2star k]
  -- `p = -1` を代入した `(-1)^k (2K_2^*)^{2k+1} (-1)` を具体版の `(-1)^{k+1} (2K_2^*)^{2k+1}` へ並べ直す
  congr 1
  ring

/-- 人手 (h2.y) の偶数側を必要十分版の特殊化として得たもの。 -/
theorem nesting_H2_checkY_even_of_necSuf (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkY M μ := by
  rw [adPow_eq_iterComm]
  exact NecSuf.nested_y_even (comm_H2_checkZ μ) (comm_H2_checkY μ)
    neg_one_mul_neg_one K2star k

/-- 人手 (h2.y) の奇数側を必要十分版の特殊化として得たもの。 -/
theorem nesting_H2_checkY_odd_of_necSuf (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k + 1) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ := by
  rw [adPow_eq_iterComm, NecSuf.nested_y_odd (comm_H2_checkZ μ) (comm_H2_checkY μ)
    neg_one_mul_neg_one K2star k]
  -- `q = -1` を代入した `(-1)^{k+1} (2K_2^*)^{2k+1} (-1)` を具体版の `(-1)^k (2K_2^*)^{2k+1}` へ並べ直す
  congr 1
  ring

end Ising2D
