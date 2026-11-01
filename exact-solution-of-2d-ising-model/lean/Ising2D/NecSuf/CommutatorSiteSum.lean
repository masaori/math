/-
# `H_1^{(+)}, H_2` と `check(Z)_μ, check(Y)_μ` の交換関係（**必要十分版**）

対応する人手証明のラベル（具体版と共通）: `commutator_of_H_and_check_Z_Y`
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensector_004_claim_commutator_H_check_Z_Y`）。
具体版は `Ising2D/EigenvalueProblem/ReductionToATheta/ClaimCommutatorHCheckZY.lean`、
具体版をこのファイルの特殊化として導く系は
`Ising2D/EigenvalueProblem/ReductionToATheta/ClaimCommutatorHCheckZYFromNecSuf.lean`。

## 具体版との対応（手順は同じ）

具体版の補題を、同じ順・同じ計算で次へ置き換えた。

| 具体版 | 必要十分版 |
| --- | --- |
| `Z_mul_Z_of_ne` / `Y_mul_Y_of_ne` / `Z_mul_Y_anticomm` / `Y_mul_Z_anticomm` | 構造 `SiteZY` の欄 `z_mul_z_of_ne` / `y_mul_y_of_ne` / `z_mul_y` と `SiteZY.y_mul_z` |
| `lie_ZY_Z_of_ne` ほか相異なる添字の 4 式 | `SiteZY.lie_zy_z_of_ne` ほか 4 式 |
| `lie_ZY_Z_self` ほか同じ添字の 4 式 | `SiteZY.lie_zy_z_self` ほか 4 式 |
| `Yflat` / `Zflat` | `SiteZY.yflat` / `SiteZY.zflat`（延長の符号を `η` にした） |
| `lie_H2_Z` / `lie_H2_Y` / `lie_H1Plus_Z` / `lie_H1Plus_Y` | `SiteZY.lie_h2_z` / `lie_h2_y` / `lie_h1_z` / `lie_h1_y` |
| `lie_H2_checkZ` / `lie_H2_checkY`（(C)(D)） | `SiteZY.lie_h2_checkZ` / `lie_h2_checkY` |
| `checkPhase_smul_Yflat_boundary` / `lie_H1Plus_checkZ`（(A)） | `SiteZY.phase_smul_yflat_boundary` / `lie_h1_checkZ` |
| `checkPhase_smul_Zflat_boundary` / `lie_H1Plus_checkY`（(B)） | `SiteZY.phase_smul_zflat_boundary` / `lie_h1_checkY` |

## 仮定（具体版の証明が実際に使っている性質だけ）

* 台 `A` は環（交換子 `ab - ba` と `z_j z_k = -z_k z_j` に要る）、係数 `R` は可換環で、`A` は `R`-代数
  （`Module`・`IsScalarTower`・`SMulCommClass` を合わせたものと同じ強さ）。係数に負元が要るのは、
  主張の `-2` と `neg_smul` のためである。
* 族 `z, y : Fin M → A` について、`j ≠ k` で `z_j z_k = -z_k z_j`・`y_j y_k = -y_k y_j`、
  任意の `j, k` で `z_j y_k = -y_k z_j`、`z_j^2 = y_j^2 = 1`。
  人手 `anticommutator_of_Z_and_Y` のうち、具体版が使っているのはこの 5 つだけである。
  `Z, Y` の具体形（Jordan–Wigner 文字列・クロネッカー積）は効いていない。
* 位相 `p : ℤ → R` について、積で周波数が足されること `p(k + l) = p(k) p(l)` と `p(0) = 1`。
  `p` が指数関数であることも、`θ~_μ` の値も効いていない。
  `p(0) = 1` は (A) のほかの仮定からは出ない（`p ≡ 0`・`η = 0` が反例）。ただし加法性から出る
  `p(0) p(M) = p(M)` へ境界の二項の 1 行を替えれば要らなくなる。具体版が `checkPhase_zero_left` を使う行と
  手順をそろえるために残している。
* 境界項の符号 `η ∈ R`（人手の `H_1^{(+)}` では `η = -1`）と位相の一周 `p(M)` の関係が、
  (A) では `η = p(M)`、(B) では `p(M) η = 1` である。人手の具体版は両方を
  `η = -1` と反周期性 `p(M) = -1` から得ている。
  (A) に効くのは `η = p(M)` だけ、(B) に効くのは `p(M) η = 1` だけで、両方を同じ `η`・`p` で満たすのは
  `η = p(M)` かつ `η^2 = 1` のときである。`-1` という値そのものは効いていない
  （`η = p(M) = 1` の周期境界と整数運動量でも同じ 4 式が出る）。
* `M ≠ 0`（(A)(B) の境界の二項を書くのに要る。(C)(D) は `M = 0` でも成り立つ）。

**必要十分版は Lean の中だけに置く**（`exact-solution-of-2d-ising-model/README.md` 4 節）。
-/
import Mathlib.Algebra.Lie.OfAssociative
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D.NecSuf

/-- 具体版が使う `Z_j, Y_j` の関係だけを束ねた族。 -/
structure SiteZY (A : Type*) [Ring A] (M : ℕ) where
  /-- 人手の `Z_j`。 -/
  z : Fin M → A
  /-- 人手の `Y_j`。 -/
  y : Fin M → A
  z_mul_z_of_ne : ∀ {j k : Fin M}, j ≠ k → z j * z k = -(z k * z j)
  y_mul_y_of_ne : ∀ {j k : Fin M}, j ≠ k → y j * y k = -(y k * y j)
  z_mul_y : ∀ j k : Fin M, z j * y k = -(y k * z j)
  z_mul_self : ∀ j : Fin M, z j * z j = 1
  y_mul_self : ∀ j : Fin M, y j * y j = 1

/-- 周期的な次のサイト `m ↦ m + 1 (mod M)`（具体版の `nextSite` と同じ定義）。 -/
def nextIdx {M : ℕ} (m : Fin M) : Fin M := ⟨((m : ℕ) + 1) % M, Nat.mod_lt _ m.pos⟩

theorem nextIdx_val_of_lt {M : ℕ} {m : Fin M} (h : (m : ℕ) + 1 < M) :
    ((nextIdx m : Fin M) : ℕ) = (m : ℕ) + 1 := by
  simp [nextIdx, Nat.mod_eq_of_lt h]

theorem nextIdx_val_of_last {M : ℕ} {m : Fin M} (h : (m : ℕ) + 1 = M) :
    ((nextIdx m : Fin M) : ℕ) = 0 := by
  simp [nextIdx, ← h]

/-- 境界項の符号（具体版の `lastSign` と同じ定義）: 最後のサイトでだけ `η`、ほかは `1`。 -/
def bdSign {R : Type*} [One R] {M : ℕ} (η : R) (m : Fin M) : R :=
  if (m : ℕ) + 1 = M then η else 1

theorem bdSign_of_last {R : Type*} [One R] {M : ℕ} {η : R} {m : Fin M} (h : (m : ℕ) + 1 = M) :
    bdSign η m = η := by
  simp [bdSign, h]

theorem bdSign_of_not_last {R : Type*} [One R] {M : ℕ} {η : R} {m : Fin M}
    (h : (m : ℕ) + 1 ≠ M) : bdSign η m = 1 := by
  simp [bdSign, h]

section LieLinear

variable {R : Type*} [CommRing R] {A : Type*} [Ring A] [Algebra R A]

/-! 交換子の線型性の 3 本は、具体版 `ClaimCommutatorHCheckZY.lean` の `lie_sum_smul_left'` ほかと同じ主張である。
`NecSuf/CommutatorClifford.lean` の `lie_sum_smul_left` も同じ主張だが、そのファイルは退避した別経路の一般化なので
import せず、ここに置く。 -/

/-- 交換子の第 1 引数についての線型性（有限和とスカラー倍）。 -/
theorem lie_sum_smul_left_site {ι : Type*} [Fintype ι] (c : ι → R) (x : ι → A) (w : A) :
    ⁅∑ i, c i • x i, w⁆ = ∑ i, c i • ⁅x i, w⁆ := by
  simp only [Ring.lie_def, Finset.sum_mul, Finset.mul_sum, Algebra.smul_mul_assoc,
    Algebra.mul_smul_comm, smul_sub, Finset.sum_sub_distrib]

/-- 交換子の第 2 引数についての線型性（有限和とスカラー倍）。 -/
theorem lie_sum_smul_right_site {ι : Type*} [Fintype ι] (c : ι → R) (x : ι → A) (w : A) :
    ⁅w, ∑ i, c i • x i⁆ = ∑ i, c i • ⁅w, x i⁆ := by
  simp only [Ring.lie_def, Finset.sum_mul, Finset.mul_sum, Algebra.smul_mul_assoc,
    Algebra.mul_smul_comm, smul_sub, Finset.sum_sub_distrib]

/-- 交換子の第 1 引数についての加法性（有限和）。 -/
theorem sum_lie_site {ι : Type*} [Fintype ι] (x : ι → A) (w : A) :
    ⁅∑ i, x i, w⁆ = ∑ i, ⁅x i, w⁆ := by
  simp only [Ring.lie_def, Finset.sum_mul, Finset.mul_sum, Finset.sum_sub_distrib]

end LieLinear

namespace SiteZY

variable {R : Type*} [CommRing R] {A : Type*} [Ring A] [Algebra R A] {M : ℕ}
variable (s : SiteZY A M)

/-- 任意の `j, k` で `y_j z_k = -z_k y_j`（欄 `z_mul_y` の両辺の符号を反転したもの）。 -/
theorem y_mul_z (j k : Fin M) : s.y j * s.z k = -(s.z k * s.y j) := by
  rw [s.z_mul_y, neg_neg]

/-! ## 人手の `H_2`, `H_1`, `check(Z)`, `check(Y)` -/

/-- 人手の `H_2 = ∑_m Z_m Y_m`。 -/
def h2 : A := ∑ m : Fin M, s.z m * s.y m

/-- 人手の `H_1^{(+)} = Y_1 Z_2 + ⋯ + Y_{M-1} Z_M + η Y_M Z_1`（人手は `η = -1`）。 -/
def h1 (η : R) : A := ∑ m : Fin M, bdSign η m • (s.y m * s.z (nextIdx m))

/-- 人手の `check(Z)_μ = ∑_j e^{-ijθ~_μ} Z_j`（位相 `e^{-ikθ~_μ}` を `p k` と書く）。 -/
def checkZ (p : ℤ → R) : A := ∑ j : Fin M, p (((j : ℕ) : ℤ) + 1) • s.z j

/-- 人手の `check(Y)_μ = ∑_j e^{-ijθ~_μ} Y_j`。 -/
def checkY (p : ℤ → R) : A := ∑ j : Fin M, p (((j : ℕ) : ℤ) + 1) • s.y j

/-! ## Step 1: 相異なる添字の項が消える -/

/-- `a ≠ j` なら `[z_a y_a, z_j] = 0`。 -/
theorem lie_zy_z_of_ne {a j : Fin M} (h : a ≠ j) : ⁅s.z a * s.y a, s.z j⁆ = 0 := by
  calc ⁅s.z a * s.y a, s.z j⁆
      = (s.z a * s.y a) * s.z j - s.z j * (s.z a * s.y a) := Ring.lie_def _ _
    _ = s.z a * (s.y a * s.z j) - s.z j * (s.z a * s.y a) := by rw [mul_assoc]
    _ = s.z a * (-(s.z j * s.y a)) - s.z j * (s.z a * s.y a) := by rw [s.y_mul_z]
    _ = -((s.z a * s.z j) * s.y a) - s.z j * (s.z a * s.y a) := by rw [mul_neg, mul_assoc]
    _ = -((-(s.z j * s.z a)) * s.y a) - s.z j * (s.z a * s.y a) := by rw [s.z_mul_z_of_ne h]
    _ = (s.z j * s.z a) * s.y a - s.z j * (s.z a * s.y a) := by rw [neg_mul, neg_neg]
    _ = s.z j * (s.z a * s.y a) - s.z j * (s.z a * s.y a) := by rw [mul_assoc]
    _ = 0 := sub_self _

/-- `a ≠ j` なら `[z_a y_a, y_j] = 0`。 -/
theorem lie_zy_y_of_ne {a j : Fin M} (h : a ≠ j) : ⁅s.z a * s.y a, s.y j⁆ = 0 := by
  calc ⁅s.z a * s.y a, s.y j⁆
      = (s.z a * s.y a) * s.y j - s.y j * (s.z a * s.y a) := Ring.lie_def _ _
    _ = s.z a * (s.y a * s.y j) - s.y j * (s.z a * s.y a) := by rw [mul_assoc]
    _ = s.z a * (-(s.y j * s.y a)) - s.y j * (s.z a * s.y a) := by rw [s.y_mul_y_of_ne h]
    _ = -((s.z a * s.y j) * s.y a) - s.y j * (s.z a * s.y a) := by rw [mul_neg, mul_assoc]
    _ = -((-(s.y j * s.z a)) * s.y a) - s.y j * (s.z a * s.y a) := by rw [s.z_mul_y]
    _ = (s.y j * s.z a) * s.y a - s.y j * (s.z a * s.y a) := by rw [neg_mul, neg_neg]
    _ = s.y j * (s.z a * s.y a) - s.y j * (s.z a * s.y a) := by rw [mul_assoc]
    _ = 0 := sub_self _

/-- `b ≠ j` なら `[y_a z_b, z_j] = 0`。 -/
theorem lie_yz_z_of_ne (a : Fin M) {b j : Fin M} (h : b ≠ j) : ⁅s.y a * s.z b, s.z j⁆ = 0 := by
  calc ⁅s.y a * s.z b, s.z j⁆
      = (s.y a * s.z b) * s.z j - s.z j * (s.y a * s.z b) := Ring.lie_def _ _
    _ = s.y a * (s.z b * s.z j) - s.z j * (s.y a * s.z b) := by rw [mul_assoc]
    _ = s.y a * (-(s.z j * s.z b)) - s.z j * (s.y a * s.z b) := by rw [s.z_mul_z_of_ne h]
    _ = -((s.y a * s.z j) * s.z b) - s.z j * (s.y a * s.z b) := by rw [mul_neg, mul_assoc]
    _ = -((-(s.z j * s.y a)) * s.z b) - s.z j * (s.y a * s.z b) := by rw [s.y_mul_z]
    _ = (s.z j * s.y a) * s.z b - s.z j * (s.y a * s.z b) := by rw [neg_mul, neg_neg]
    _ = s.z j * (s.y a * s.z b) - s.z j * (s.y a * s.z b) := by rw [mul_assoc]
    _ = 0 := sub_self _

/-- `a ≠ j` なら `[y_a z_b, y_j] = 0`。 -/
theorem lie_yz_y_of_ne {a j : Fin M} (b : Fin M) (h : a ≠ j) : ⁅s.y a * s.z b, s.y j⁆ = 0 := by
  calc ⁅s.y a * s.z b, s.y j⁆
      = (s.y a * s.z b) * s.y j - s.y j * (s.y a * s.z b) := Ring.lie_def _ _
    _ = s.y a * (s.z b * s.y j) - s.y j * (s.y a * s.z b) := by rw [mul_assoc]
    _ = s.y a * (-(s.y j * s.z b)) - s.y j * (s.y a * s.z b) := by rw [s.z_mul_y]
    _ = -((s.y a * s.y j) * s.z b) - s.y j * (s.y a * s.z b) := by rw [mul_neg, mul_assoc]
    _ = -((-(s.y j * s.y a)) * s.z b) - s.y j * (s.y a * s.z b) := by rw [s.y_mul_y_of_ne h]
    _ = (s.y j * s.y a) * s.z b - s.y j * (s.y a * s.z b) := by rw [neg_mul, neg_neg]
    _ = s.y j * (s.y a * s.z b) - s.y j * (s.y a * s.z b) := by rw [mul_assoc]
    _ = 0 := sub_self _

/-! ## Step 1: 同じ添字を含む項 -/

/-- `[z_j y_j, z_j] = -2 y_j`。 -/
theorem lie_zy_z_self (j : Fin M) : ⁅s.z j * s.y j, s.z j⁆ = (-2 : R) • s.y j := by
  calc ⁅s.z j * s.y j, s.z j⁆
      = (s.z j * s.y j) * s.z j - s.z j * (s.z j * s.y j) := Ring.lie_def _ _
    _ = s.z j * (s.y j * s.z j) - (s.z j * s.z j) * s.y j := by rw [mul_assoc, mul_assoc]
    _ = s.z j * (-(s.z j * s.y j)) - (s.z j * s.z j) * s.y j := by rw [s.y_mul_z]
    _ = -((s.z j * s.z j) * s.y j) - (s.z j * s.z j) * s.y j := by rw [mul_neg, mul_assoc]
    _ = -(1 * s.y j) - 1 * s.y j := by rw [s.z_mul_self]
    _ = -s.y j - s.y j := by rw [one_mul]
    _ = (-2 : R) • s.y j := by rw [neg_smul, two_smul, neg_add]; abel

/-- `[z_j y_j, y_j] = 2 z_j`。 -/
theorem lie_zy_y_self (j : Fin M) : ⁅s.z j * s.y j, s.y j⁆ = (2 : R) • s.z j := by
  calc ⁅s.z j * s.y j, s.y j⁆
      = (s.z j * s.y j) * s.y j - s.y j * (s.z j * s.y j) := Ring.lie_def _ _
    _ = s.z j * (s.y j * s.y j) - (s.y j * s.z j) * s.y j := by rw [mul_assoc, mul_assoc]
    _ = s.z j * 1 - (s.y j * s.z j) * s.y j := by rw [s.y_mul_self]
    _ = s.z j - (s.y j * s.z j) * s.y j := by rw [mul_one]
    _ = s.z j - (-(s.z j * s.y j)) * s.y j := by rw [s.y_mul_z]
    _ = s.z j + s.z j * (s.y j * s.y j) := by rw [neg_mul, sub_neg_eq_add, mul_assoc]
    _ = s.z j + s.z j * 1 := by rw [s.y_mul_self]
    _ = s.z j + s.z j := by rw [mul_one]
    _ = (2 : R) • s.z j := (two_smul R _).symm

/-- `[y_a z_b, z_b] = 2 y_a`。 -/
theorem lie_yz_z_right (a b : Fin M) : ⁅s.y a * s.z b, s.z b⁆ = (2 : R) • s.y a := by
  calc ⁅s.y a * s.z b, s.z b⁆
      = (s.y a * s.z b) * s.z b - s.z b * (s.y a * s.z b) := Ring.lie_def _ _
    _ = s.y a * (s.z b * s.z b) - (s.z b * s.y a) * s.z b := by rw [mul_assoc, mul_assoc]
    _ = s.y a * 1 - (s.z b * s.y a) * s.z b := by rw [s.z_mul_self]
    _ = s.y a - (s.z b * s.y a) * s.z b := by rw [mul_one]
    _ = s.y a - (-(s.y a * s.z b)) * s.z b := by rw [s.z_mul_y]
    _ = s.y a + s.y a * (s.z b * s.z b) := by rw [neg_mul, sub_neg_eq_add, mul_assoc]
    _ = s.y a + s.y a * 1 := by rw [s.z_mul_self]
    _ = s.y a + s.y a := by rw [mul_one]
    _ = (2 : R) • s.y a := (two_smul R _).symm

/-- `[y_a z_b, y_a] = -2 z_b`。 -/
theorem lie_yz_y_left (a b : Fin M) : ⁅s.y a * s.z b, s.y a⁆ = (-2 : R) • s.z b := by
  calc ⁅s.y a * s.z b, s.y a⁆
      = (s.y a * s.z b) * s.y a - s.y a * (s.y a * s.z b) := Ring.lie_def _ _
    _ = s.y a * (s.z b * s.y a) - (s.y a * s.y a) * s.z b := by rw [mul_assoc, mul_assoc]
    _ = s.y a * (-(s.y a * s.z b)) - (s.y a * s.y a) * s.z b := by rw [s.z_mul_y]
    _ = -((s.y a * s.y a) * s.z b) - (s.y a * s.y a) * s.z b := by rw [mul_neg, mul_assoc]
    _ = -(1 * s.z b) - 1 * s.z b := by rw [s.y_mul_self]
    _ = -s.z b - s.z b := by rw [one_mul]
    _ = (-2 : R) • s.z b := by rw [neg_smul, two_smul, neg_add]; abel

/-! ## Step 1: 延長 `y♭_l`, `z♭_l` -/

/-- 人手の `Y♭_l`（`l = 0, …, M`）: `y♭_0 := η y_M`、`1 ≤ l ≤ M` で `y♭_l := y_l`。
範囲外の `l` では `0` と置く（使わない）。 -/
def yflat (η : R) (l : ℕ) : A :=
  if h : 1 ≤ l ∧ l ≤ M then s.y ⟨l - 1, by omega⟩
  else if h0 : l = 0 ∧ 0 < M then η • s.y ⟨M - 1, by omega⟩ else 0

/-- 人手の `Z♭_l`（`l = 1, …, M+1`）: `z♭_{M+1} := η z_1`、`1 ≤ l ≤ M` で `z♭_l := z_l`。
範囲外の `l` では `0` と置く（使わない）。 -/
def zflat (η : R) (l : ℕ) : A :=
  if h : 1 ≤ l ∧ l ≤ M then s.z ⟨l - 1, by omega⟩
  else if h0 : l = M + 1 ∧ 0 < M then η • s.z ⟨0, by omega⟩ else 0

theorem yflat_succ (η : R) (k : Fin M) : s.yflat η ((k : ℕ) + 1) = s.y k := by
  rw [yflat, dif_pos ⟨by omega, k.isLt⟩]
  congr 1

theorem yflat_zero (η : R) (hM : 0 < M) : s.yflat η 0 = η • s.y ⟨M - 1, by omega⟩ := by
  rw [yflat, dif_neg (by omega), dif_pos ⟨rfl, hM⟩]

theorem zflat_succ (η : R) (k : Fin M) : s.zflat η ((k : ℕ) + 1) = s.z k := by
  rw [zflat, dif_pos ⟨by omega, k.isLt⟩]
  congr 1

theorem zflat_last (η : R) (hM : 0 < M) : s.zflat η (M + 1) = η • s.z ⟨0, hM⟩ := by
  rw [zflat, dif_neg (by omega), dif_pos ⟨rfl, hM⟩]

/-! ## Step 1: 和へまとめる -/

/-- **Step 1 の第 1 式** `[H_2, z_j] = -2 y_j`。 -/
theorem lie_h2_z (j : Fin M) : ⁅s.h2, s.z j⁆ = (-2 : R) • s.y j := by
  calc ⁅s.h2, s.z j⁆
      = ⁅∑ a : Fin M, s.z a * s.y a, s.z j⁆ := rfl
    _ = ∑ a : Fin M, ⁅s.z a * s.y a, s.z j⁆ := sum_lie_site _ _
    _ = ⁅s.z j * s.y j, s.z j⁆ := Finset.sum_eq_single j (fun a _ ha => s.lie_zy_z_of_ne ha)
          (fun h => absurd (Finset.mem_univ j) h)
    _ = (-2 : R) • s.y j := s.lie_zy_z_self j

/-- **Step 1 の第 2 式** `[H_2, y_j] = 2 z_j`。 -/
theorem lie_h2_y (j : Fin M) : ⁅s.h2, s.y j⁆ = (2 : R) • s.z j := by
  calc ⁅s.h2, s.y j⁆
      = ⁅∑ a : Fin M, s.z a * s.y a, s.y j⁆ := rfl
    _ = ∑ a : Fin M, ⁅s.z a * s.y a, s.y j⁆ := sum_lie_site _ _
    _ = ⁅s.z j * s.y j, s.y j⁆ := Finset.sum_eq_single j (fun a _ ha => s.lie_zy_y_of_ne ha)
          (fun h => absurd (Finset.mem_univ j) h)
    _ = (2 : R) • s.z j := s.lie_zy_y_self j

/-- **Step 1 の第 3 式** `[H_1, z_j] = 2 y♭_{j-1}`（添字 `k = j - 1`）。 -/
theorem lie_h1_z (η : R) (k : Fin M) : ⁅s.h1 η, s.z k⁆ = (2 : R) • s.yflat η (k : ℕ) := by
  have hM : 0 < M := Fin.pos k
  rw [h1, lie_sum_smul_left_site]
  by_cases hk : (k : ℕ) = 0
  · -- `j = 1`: 境界項 `m = M` だけが残る
    set last : Fin M := ⟨M - 1, by omega⟩
    have hlast : (last : ℕ) + 1 = M := by simp [last]; omega
    have hnext : nextIdx last = k := Fin.ext (by rw [nextIdx_val_of_last hlast, hk])
    rw [Finset.sum_eq_single last]
    · rw [bdSign_of_last hlast, hnext, s.lie_yz_z_right (R := R), hk, s.yflat_zero η hM, smul_smul,
        smul_smul, mul_comm]
    · intro m _ hm
      have hne : nextIdx m ≠ k := by
        intro he
        apply hm
        apply Fin.ext
        rcases Nat.lt_or_ge ((m : ℕ) + 1) M with h | h
        · have := congrArg Fin.val he
          rw [nextIdx_val_of_lt h] at this
          omega
        · have := m.isLt
          simp [last]; omega
      rw [s.lie_yz_z_of_ne _ hne, smul_zero]
    · exact fun h => absurd (Finset.mem_univ _) h
  · -- `2 ≤ j ≤ M`: `m = j - 1` の項だけが残る
    set prev : Fin M := ⟨(k : ℕ) - 1, by omega⟩
    have hprev : (prev : ℕ) + 1 < M := by simp [prev]; omega
    have hnext : nextIdx prev = k := Fin.ext (by rw [nextIdx_val_of_lt hprev]; simp [prev]; omega)
    rw [Finset.sum_eq_single prev]
    · rw [bdSign_of_not_last (by omega), hnext, s.lie_yz_z_right (R := R), one_smul]
      congr 1
      rw [show (k : ℕ) = (prev : ℕ) + 1 by simp [prev]; omega, s.yflat_succ]
    · intro m _ hm
      have hne : nextIdx m ≠ k := by
        intro he
        apply hm
        apply Fin.ext
        have := congrArg Fin.val he
        rcases Nat.lt_or_ge ((m : ℕ) + 1) M with h | h
        · rw [nextIdx_val_of_lt h] at this
          simp [prev]; omega
        · have hl : (m : ℕ) + 1 = M := by have := m.isLt; omega
          rw [nextIdx_val_of_last hl] at this
          omega
      rw [s.lie_yz_z_of_ne _ hne, smul_zero]
    · exact fun h => absurd (Finset.mem_univ _) h

/-- **Step 1 の第 4 式** `[H_1, y_j] = -2 z♭_{j+1}`（添字 `k = j - 1`、`j + 1 = k + 2`）。 -/
theorem lie_h1_y (η : R) (k : Fin M) :
    ⁅s.h1 η, s.y k⁆ = (-2 : R) • s.zflat η ((k : ℕ) + 2) := by
  have hM : 0 < M := Fin.pos k
  rw [h1, lie_sum_smul_left_site,
    Finset.sum_eq_single k (fun m _ hm => by rw [s.lie_yz_y_of_ne _ hm, smul_zero])
      (fun h => absurd (Finset.mem_univ k) h),
    s.lie_yz_y_left (R := R), smul_smul]
  by_cases hk : (k : ℕ) + 1 = M
  · -- `j = M`: 境界項
    rw [bdSign_of_last hk, show (k : ℕ) + 2 = M + 1 by omega, s.zflat_last η hM, smul_smul]
    have hnext : nextIdx k = ⟨0, hM⟩ := Fin.ext (nextIdx_val_of_last hk)
    rw [hnext, mul_comm]
  · -- `1 ≤ j ≤ M - 1`
    have hlt : (k : ℕ) + 1 < M := by have := k.isLt; omega
    set nk : Fin M := ⟨(k : ℕ) + 1, hlt⟩
    have hnext : nextIdx k = nk := Fin.ext (nextIdx_val_of_lt hlt)
    rw [bdSign_of_not_last hk, hnext, show (k : ℕ) + 2 = (nk : ℕ) + 1 by simp [nk],
      s.zflat_succ, one_mul]

/-! ## Step 2: (C)(D) -/

/-- **(C)** `[H_2, check(Z)] = -2 check(Y)`。 -/
theorem lie_h2_checkZ (p : ℤ → R) : ⁅s.h2, s.checkZ p⁆ = (-2 : R) • s.checkY p := by
  calc ⁅s.h2, s.checkZ p⁆
      = ⁅s.h2, ∑ j : Fin M, p (((j : ℕ) : ℤ) + 1) • s.z j⁆ := rfl
    _ = ∑ j : Fin M, p (((j : ℕ) : ℤ) + 1) • ⁅s.h2, s.z j⁆ := lie_sum_smul_right_site _ _ _
    _ = ∑ j : Fin M, p (((j : ℕ) : ℤ) + 1) • ((-2 : R) • s.y j) := by
          simp only [s.lie_h2_z (R := R)]
    _ = (-2 : R) • ∑ j : Fin M, p (((j : ℕ) : ℤ) + 1) • s.y j := by
          rw [Finset.smul_sum]
          exact Finset.sum_congr rfl fun j _ => smul_comm _ _ _
    _ = (-2 : R) • s.checkY p := rfl

/-- **(D)** `[H_2, check(Y)] = 2 check(Z)`。 -/
theorem lie_h2_checkY (p : ℤ → R) : ⁅s.h2, s.checkY p⁆ = (2 : R) • s.checkZ p := by
  calc ⁅s.h2, s.checkY p⁆
      = ⁅s.h2, ∑ j : Fin M, p (((j : ℕ) : ℤ) + 1) • s.y j⁆ := rfl
    _ = ∑ j : Fin M, p (((j : ℕ) : ℤ) + 1) • ⁅s.h2, s.y j⁆ := lie_sum_smul_right_site _ _ _
    _ = ∑ j : Fin M, p (((j : ℕ) : ℤ) + 1) • ((2 : R) • s.z j) := by
          simp only [s.lie_h2_y (R := R)]
    _ = (2 : R) • ∑ j : Fin M, p (((j : ℕ) : ℤ) + 1) • s.z j := by
          rw [Finset.smul_sum]
          exact Finset.sum_congr rfl fun j _ => smul_comm _ _ _
    _ = (2 : R) • s.checkZ p := rfl

/-! ## Step 3: (A) -/

/-- **Step 3 の境界の二項の等式** `p(0) y♭_0 = p(M) y♭_M`。
使うのは `p(0) = 1` と、境界の符号が位相の一周と一致すること `η = p(M)` だけである。 -/
theorem phase_smul_yflat_boundary (hM : M ≠ 0) (p : ℤ → R) (η : R) (hp0 : p 0 = 1)
    (hA : η = p M) : p 0 • s.yflat η 0 = p M • s.yflat η M := by
  have hM0 : 0 < M := Nat.pos_of_ne_zero hM
  calc p 0 • s.yflat η 0
      = (1 : R) • s.yflat η 0 := by rw [hp0]
    _ = (1 : R) • (η • s.y ⟨M - 1, by omega⟩) := by rw [s.yflat_zero η hM0]
    _ = η • s.y ⟨M - 1, by omega⟩ := by rw [one_smul]
    _ = p M • s.y ⟨M - 1, by omega⟩ := by rw [hA]
    _ = p M • s.yflat η M := by
          rw [yflat, dif_pos ⟨hM0, le_refl M⟩]

/-- **(A)** `[H_1, check(Z)] = 2 p(1) check(Y)`（人手の `e^{-iθ~_μ} = p(1)`）。 -/
theorem lie_h1_checkZ (hM : M ≠ 0) (p : ℤ → R) (η : R)
    (hadd : ∀ k l : ℤ, p (k + l) = p k * p l) (hp0 : p 0 = 1) (hA : η = p M) :
    ⁅s.h1 η, s.checkZ p⁆ = (2 * p 1) • s.checkY p := by
  obtain ⟨n, rfl⟩ : ∃ n, M = n + 1 := Nat.exists_eq_succ_of_ne_zero hM
  have hsumM : ∑ k : Fin (n + 1), p (((k : ℕ) : ℤ) + 1) • s.yflat η ((k : ℕ) + 1)
      = ∑ i : Fin n, p (((i : ℕ) : ℤ) + 1) • s.yflat η ((i : ℕ) + 1)
        + p ((n + 1 : ℕ) : ℤ) • s.yflat η (n + 1) := by
    rw [Fin.sum_univ_castSucc]
    simp only [Fin.val_castSucc, Fin.val_last]
    push_cast
    rfl
  have hsum0 : ∑ k : Fin (n + 1), p ((k : ℕ) : ℤ) • s.yflat η (k : ℕ)
      = p 0 • s.yflat η 0
        + ∑ i : Fin n, p (((i : ℕ) : ℤ) + 1) • s.yflat η ((i : ℕ) + 1) := by
    rw [Fin.sum_univ_succ]
    simp only [Fin.val_zero, Fin.val_succ]
    push_cast
    rfl
  calc ⁅s.h1 η, s.checkZ p⁆
      = ⁅s.h1 η, ∑ j : Fin (n + 1), p (((j : ℕ) : ℤ) + 1) • s.z j⁆ := rfl
    _ = ∑ j : Fin (n + 1), p (((j : ℕ) : ℤ) + 1) • ⁅s.h1 η, s.z j⁆ :=
          lie_sum_smul_right_site _ _ _
    _ = ∑ j : Fin (n + 1), p (((j : ℕ) : ℤ) + 1) • ((2 : R) • s.yflat η (j : ℕ)) := by
          simp only [lie_h1_z]
    _ = (2 : R) • ∑ j : Fin (n + 1), p (((j : ℕ) : ℤ) + 1) • s.yflat η (j : ℕ) := by
          rw [Finset.smul_sum]
          exact Finset.sum_congr rfl fun j _ => smul_comm _ _ _
    _ = (2 : R) • ∑ l : Fin (n + 1), (p 1 * p ((l : ℕ) : ℤ)) • s.yflat η (l : ℕ) := by
          congr 1
          refine Finset.sum_congr rfl fun l _ => ?_
          rw [← hadd, add_comm (1 : ℤ)]
    _ = (2 * p 1) • ∑ l : Fin (n + 1), p ((l : ℕ) : ℤ) • s.yflat η (l : ℕ) := by
          simp only [Finset.smul_sum, mul_smul]
    _ = (2 * p 1) • ∑ k : Fin (n + 1), p (((k : ℕ) : ℤ) + 1) • s.yflat η ((k : ℕ) + 1) := by
          rw [hsum0, hsumM, s.phase_smul_yflat_boundary hM p η hp0 hA]
          congr 1
          exact add_comm _ _
    _ = (2 * p 1) • s.checkY p := by
          simp only [yflat_succ]
          rfl

/-! ## Step 4: (B) -/

/-- **Step 4 の境界の二項の等式** `p(M+1) z♭_{M+1} = p(1) z♭_1`。
使うのは周波数の加法性と、境界の符号と位相の一周の積が `1` であること `p(M) η = 1` だけである。 -/
theorem phase_smul_zflat_boundary (hM : M ≠ 0) (p : ℤ → R) (η : R)
    (hadd : ∀ k l : ℤ, p (k + l) = p k * p l) (hB : p M * η = 1) :
    p ((M : ℤ) + 1) • s.zflat η (M + 1) = p 1 • s.zflat η 1 := by
  have hM0 : 0 < M := Nat.pos_of_ne_zero hM
  calc p ((M : ℤ) + 1) • s.zflat η (M + 1)
      = (p M * p 1) • s.zflat η (M + 1) := by rw [hadd]
    _ = (p M * p 1) • (η • s.z ⟨0, hM0⟩) := by rw [s.zflat_last η hM0]
    _ = ((p M * η) * p 1) • s.z ⟨0, hM0⟩ := by rw [smul_smul]; congr 1; ring
    _ = p 1 • s.z ⟨0, hM0⟩ := by rw [hB, one_mul]
    _ = p 1 • s.zflat η 1 := by
          rw [show (1 : ℕ) = ((⟨0, hM0⟩ : Fin M) : ℕ) + 1 from rfl, s.zflat_succ]

/-- **(B)** `[H_1, check(Y)] = -2 p(-1) check(Z)`（人手の `e^{iθ~_μ} = p(-1)`）。 -/
theorem lie_h1_checkY (hM : M ≠ 0) (p : ℤ → R) (η : R)
    (hadd : ∀ k l : ℤ, p (k + l) = p k * p l) (hB : p M * η = 1) :
    ⁅s.h1 η, s.checkY p⁆ = (-2 * p (-1)) • s.checkZ p := by
  obtain ⟨n, rfl⟩ : ∃ n, M = n + 1 := Nat.exists_eq_succ_of_ne_zero hM
  have hsumLast : ∑ k : Fin (n + 1), p (((k : ℕ) : ℤ) + 2) • s.zflat η ((k : ℕ) + 2)
      = ∑ i : Fin n, p (((i : ℕ) : ℤ) + 2) • s.zflat η ((i : ℕ) + 2)
        + p (((n + 1 : ℕ) : ℤ) + 1) • s.zflat η (n + 1 + 1) := by
    rw [Fin.sum_univ_castSucc]
    simp only [Fin.val_castSucc, Fin.val_last]
    push_cast
    congr 2
  have hsumFirst : ∑ k : Fin (n + 1), p (((k : ℕ) : ℤ) + 1) • s.zflat η ((k : ℕ) + 1)
      = p 1 • s.zflat η 1
        + ∑ i : Fin n, p (((i : ℕ) : ℤ) + 2) • s.zflat η ((i : ℕ) + 2) := by
    rw [Fin.sum_univ_succ]
    simp only [Fin.val_zero, Fin.val_succ]
    push_cast
    congr 2
  calc ⁅s.h1 η, s.checkY p⁆
      = ⁅s.h1 η, ∑ j : Fin (n + 1), p (((j : ℕ) : ℤ) + 1) • s.y j⁆ := rfl
    _ = ∑ j : Fin (n + 1), p (((j : ℕ) : ℤ) + 1) • ⁅s.h1 η, s.y j⁆ :=
          lie_sum_smul_right_site _ _ _
    _ = ∑ j : Fin (n + 1), p (((j : ℕ) : ℤ) + 1) •
          ((-2 : R) • s.zflat η ((j : ℕ) + 2)) := by simp only [lie_h1_y]
    _ = (-2 : R) • ∑ j : Fin (n + 1), p (((j : ℕ) : ℤ) + 1) • s.zflat η ((j : ℕ) + 2) := by
          rw [Finset.smul_sum]
          exact Finset.sum_congr rfl fun j _ => smul_comm _ _ _
    _ = (-2 : R) • ∑ l : Fin (n + 1),
          (p (-1) * p (((l : ℕ) : ℤ) + 2)) • s.zflat η ((l : ℕ) + 2) := by
          congr 1
          refine Finset.sum_congr rfl fun l _ => ?_
          rw [← hadd]
          congr 2
          ring
    _ = (-2 * p (-1)) • ∑ l : Fin (n + 1),
          p (((l : ℕ) : ℤ) + 2) • s.zflat η ((l : ℕ) + 2) := by
          simp only [Finset.smul_sum, mul_smul]
    _ = (-2 * p (-1)) • ∑ k : Fin (n + 1),
          p (((k : ℕ) : ℤ) + 1) • s.zflat η ((k : ℕ) + 1) := by
          rw [hsumLast, hsumFirst, s.phase_smul_zflat_boundary hM p η hadd hB]
          congr 1
          exact add_comm _ _
    _ = (-2 * p (-1)) • s.checkZ p := by
          simp only [zflat_succ]
          rfl

end SiteZY

end Ising2D.NecSuf
