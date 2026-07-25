/-
# `Z_m, Y_m` は線型独立

対応する人手証明:
`parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ`
（構造化TeX: `structured-latex/content/004_transfer_matrix.mjs` の
ブロック `transfer_matrix_002_claim_Z_Y_linearly_independent`、ラベル `Z_Y_linearly_independent`）

原文の主張: `{Z_1, …, Z_M, Y_1, …, Y_M}` は線型独立。

**本ファイルを書いた時点では原文の証明は「TODO: 証明略」のまま**だったので、Lean 側で先に証明した
（`parts/006_ZとYの反交換関係` の `[Z_μ, Y_ν]₊` と同じパターン）。
その後、人手証明側でも別経路の証明（`{I, σ^x, σ^y, σ^z}^{⊗M}` が基底であることを使う筋）が
書かれている。両者は同じ主張の別証明であり、下記の Clifford 関係による証明の方が短い。

## 形式化にあたっての読み替え

原文は「集合 `{Z_1, …, Z_M, Y_1, …, Y_M}` が線型独立」と書くが、線型独立性は本来
**族**（添字づけられた列）の性質である。ここでは添字型を `Fin M ⊕ Fin M` にとった族
`ZY`（`inl m ↦ Z_m`, `inr m ↦ Y_m`）の線型独立性として述べる（`ZY_linearIndependent`）。
族としての線型独立は「`2M` 個の元がすべて相異なり、かつ集合として線型独立」を含意するので、
原文の主張より強い。集合としての形（`LinearIndepOn ℂ id (ZYSet M)`）も系として与える
（`ZYSet_linearIndepOn`）。

## 証明の方針（原文が省略した部分）

`parts/006_ZとYの反交換関係/000_claim_...` で証明した反交換関係

  `[Z_μ, Z_ν]₊ = 2 I δ_{μν}`,  `[Z_μ, Y_ν]₊ = 0`,  `[Y_μ, Y_ν]₊ = 2 I δ_{μν}`

は「`ZY` が Clifford 関係 `[e_a, e_b]₊ = 2 δ_{ab} I` を満たす」とまとめられる。
このとき `∑_a g_a e_a = 0` の両辺と `e_b` の反交換子をとると

  `0 = [∑_a g_a e_a, e_b]₊ = ∑_a g_a [e_a, e_b]₊ = 2 g_b I`

となり、`I ≠ 0` から `g_b = 0`。これが本ファイルの証明である
（反交換子の左線型性は `Ising2D.acomm_sum_smul_left`）。
-/
import Ising2D.Part004.Claim014_ZYGenerateAlgebra
import Ising2D.Part006.Claim000_AnticommutatorZY

namespace Ising2D

variable {M : ℕ}

/-- 原文の `Z_1, …, Z_M, Y_1, …, Y_M` を 1 つの族としてまとめたもの。
添字型 `Fin M ⊕ Fin M` の `inl` 側が `Z`、`inr` 側が `Y`。 -/
noncomputable def ZY : Fin M ⊕ Fin M → TensorPow M
  | Sum.inl m => Z m
  | Sum.inr m => Y m

@[simp] theorem ZY_inl (m : Fin M) : ZY (Sum.inl m) = Z m := rfl
@[simp] theorem ZY_inr (m : Fin M) : ZY (Sum.inr m) = Y m := rfl

/-- **`ZY` は Clifford 関係 `[e_a, e_b]₊ = 2 δ_{ab} I` を満たす。**

`parts/006_ZとYの反交換関係/000_claim_...` (`<anticommutator_of_Z_and_Y>`) の 3 式
（`anticomm_Z_Z`, `anticomm_Z_Y`, `anticomm_Y_Y` と対称版 `anticomm_Y_Z`）を
1 本にまとめた形。 -/
theorem acomm_ZY (a b : Fin M ⊕ Fin M) :
    acomm (ZY a) (ZY b) = (if a = b then (2 : ℂ) else 0) • (1 : TensorPow M) := by
  cases a with
  | inl μ =>
      cases b with
      | inl ν =>
          rw [ZY_inl, ZY_inl, anticomm_Z_Z, deltaM]
          by_cases h : μ = ν
          · rw [if_pos h, if_pos (congrArg Sum.inl h), mul_one]
          · rw [if_neg h, if_neg (fun he => h (Sum.inl.inj he)), mul_zero]
      | inr ν =>
          rw [ZY_inl, ZY_inr, anticomm_Z_Y, if_neg (by simp), zero_smul]
  | inr μ =>
      cases b with
      | inl ν =>
          rw [ZY_inr, ZY_inl, anticomm_Y_Z, if_neg (by simp), zero_smul]
      | inr ν =>
          rw [ZY_inr, ZY_inr, anticomm_Y_Y, deltaM]
          by_cases h : μ = ν
          · rw [if_pos h, if_pos (congrArg Sum.inr h), mul_one]
          · rw [if_neg h, if_neg (fun he => h (Sum.inr.inj he)), mul_zero]

/-- Clifford 関係を満たす族は線型独立、という一般補題（原文が省略した論証そのもの）。

`∑_a g_a e_a = 0` に `e_b` との反交換子をとると `2 g_b · 1 = 0` が出る。
`R` が非自明（`1 ≠ 0`）なら `g_b = 0`。 -/
theorem linearIndependent_of_clifford {ι : Type*} [Fintype ι] [DecidableEq ι]
    (e : ι → TensorPow M) (h : ∀ a b, acomm (e a) (e b) =
      (if a = b then (2 : ℂ) else 0) • (1 : TensorPow M)) :
    LinearIndependent ℂ e := by
  classical
  rw [Fintype.linearIndependent_iff]
  intro g hg b
  -- `[∑ₐ gₐ eₐ, e_b]₊ = ∑ₐ gₐ [eₐ, e_b]₊ = (g_b · 2) • 1`
  have hsum : acomm (∑ a, g a • e a) (e b) = (g b * 2) • (1 : TensorPow M) := by
    rw [acomm_sum_smul_left, Finset.sum_eq_single_of_mem b (Finset.mem_univ b)]
    · rw [h, if_pos rfl, smul_smul]
    · intro a _ hab
      rw [h, if_neg hab, zero_smul, smul_zero]
  -- 左辺は仮定より `[0, e_b]₊ = 0`
  have hzero : (g b * 2) • (1 : TensorPow M) = 0 := by
    rw [← hsum, hg, acomm, zero_mul, mul_zero, add_zero]
  -- 対角成分を見て `g b * 2 = 0`
  have hentry := congrArg (fun A : TensorPow M => A (default : Conf M) (default : Conf M)) hzero
  simp only [Matrix.smul_apply, Matrix.one_apply_eq, smul_eq_mul, mul_one,
    Matrix.zero_apply] at hentry
  exact by linear_combination hentry / 2

/-- **`<Z_m, Y_m は線型独立>` の形式化**（原文は「TODO: 証明略」）。

族 `(Z_1, …, Z_M, Y_1, …, Y_M)` は ℂ 上線型独立である。 -/
theorem ZY_linearIndependent (M : ℕ) :
    LinearIndependent ℂ (ZY : Fin M ⊕ Fin M → TensorPow M) :=
  linearIndependent_of_clifford ZY acomm_ZY

/-- 族としての線型独立から、`2M` 個の元がすべて相異なることが従う
（原文が集合 `{Z_1, …, Z_M, Y_1, …, Y_M}` と書いていることの正当化）。 -/
theorem ZY_injective (M : ℕ) : Function.Injective (ZY : Fin M ⊕ Fin M → TensorPow M) :=
  (ZY_linearIndependent M).injective

theorem ZYSet_eq_range (M : ℕ) : ZYSet M = Set.range (ZY : Fin M ⊕ Fin M → TensorPow M) := by
  ext v
  simp [ZYSet, Set.mem_range, Sum.exists, or_comm]

/-- 原文の字面どおり、**集合** `S = {Z_1, …, Z_M, Y_1, …, Y_M}` が線型独立であること。 -/
theorem ZYSet_linearIndepOn (M : ℕ) : LinearIndepOn ℂ id (ZYSet M) := by
  rw [ZYSet_eq_range]
  exact (ZY_linearIndependent M).linearIndepOn_id

end Ising2D
