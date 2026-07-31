/-
# 成分ごとの絶対値を取ると偶セクターへ移る（具体版）

正本: `structured-latex/content/019_max_eigenvalue_sector.ts`
（`sector_002_claim_abs_vector_moves_to_even_sector`、
ラベル **`abs_vector_moves_to_even_sector`**）

必要十分版は `Ising2D/NecSuf/PermSector.lean`（同じラベル）。
本ファイルの (1)(2)(3) はすべて必要十分版の**系として**導いてある。

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| `u_k := |x_k|` | `Ising2D.NecSuf.absVec` |
| (1) `εu = u`（`u ∈ 𝓕^{(+)}∩ℝ^{2^M}`） | `epsilonR_mulVec_absVec` |
| (2) `‖u‖ = ‖x‖` | `vecNormSq_absVec_eq` |
| (3) `uᵀWu ≥ |xᵀWx| ≥ xᵀWx` | `abs_quad_le_quad_absVec_epsilonR` / `quad_le_quad_absVec_epsilonR` |

## 必要十分版で分かったこと（人手証明の仮定の過剰さ）

人手証明 (3) は `W_has_positive_entries`（`W_{kl} > 0`）を引くが、
三角不等式に必要なのは **`0 ≤ W_{kl}` だけ**である。本ファイルでは人手証明どおり
`0 < W_{kl}` を仮定した版（`quad_le_quad_absVec_epsilonR`）と、
非負だけを仮定した版（`quad_le_quad_absVec_epsilonR_of_nonneg`）の両方を置く。

Perron–Frobenius の定理・スペクトル定理・行列の対角化可能性は使っていない。
-/
import Ising2D.Part019.Claim001_EpsilonSignFlipPermutation

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手証明 (1) `εu = u`**（`x ∈ 𝓕^{(-)} ⇒ u = (|x_k|)_k ∈ 𝓕^{(+)}`）。 -/
theorem epsilonR_mulVec_absVec {x : Conf M → ℝ}
    (hx : epsilonR M *ᵥ x = (-1 : ℝ) • x) :
    epsilonR M *ᵥ NecSuf.absVec x = (1 : ℝ) • NecSuf.absVec x :=
  NecSuf.permMat_mulVec_absVec hx

/-- **人手証明 (2) `‖u‖ = ‖x‖`**（`‖·‖²` の形）。 -/
theorem vecNormSq_absVec_eq (x : Conf M → ℝ) :
    vecNormSq (NecSuf.absVec x) = vecNormSq x :=
  NecSuf.vecNormSq_absVec x

/-- **人手証明 (3) の第 1 の不等号** `uᵀWu ≥ |xᵀWx|`。 -/
theorem abs_quad_le_quad_absVec_epsilonR {W : Matrix (Conf M) (Conf M) ℝ}
    (hW : ∀ k l, 0 < W k l) (x : Conf M → ℝ) :
    |x ⬝ᵥ W *ᵥ x| ≤ NecSuf.absVec x ⬝ᵥ W *ᵥ NecSuf.absVec x :=
  NecSuf.abs_quad_le_quad_absVec (fun k l => (hW k l).le) x

/-- **人手証明 (3)** `uᵀWu ≥ xᵀWx`（人手証明どおり `W_{kl} > 0` を仮定した版）。 -/
theorem quad_le_quad_absVec_epsilonR {W : Matrix (Conf M) (Conf M) ℝ}
    (hW : ∀ k l, 0 < W k l) (x : Conf M → ℝ) :
    x ⬝ᵥ W *ᵥ x ≤ NecSuf.absVec x ⬝ᵥ W *ᵥ NecSuf.absVec x :=
  NecSuf.quad_le_quad_absVec (fun k l => (hW k l).le) x

/-- 上の**非負版**（必要十分版で分かった、本当に効いている仮定）。 -/
theorem quad_le_quad_absVec_epsilonR_of_nonneg {W : Matrix (Conf M) (Conf M) ℝ}
    (hW : ∀ k l, 0 ≤ W k l) (x : Conf M → ℝ) :
    x ⬝ᵥ W *ᵥ x ≤ NecSuf.absVec x ⬝ᵥ W *ᵥ NecSuf.absVec x :=
  NecSuf.quad_le_quad_absVec hW x

/-- **人手証明 (1)(2)(3) をまとめた形**: 奇セクターの単位ベクトル `x` に対し、
偶セクターの単位ベクトル `u` で `xᵀWx ≤ uᵀWu` を満たすものが存在する。 -/
theorem exists_even_sector_unit_ge {W : Matrix (Conf M) (Conf M) ℝ}
    (hW : ∀ k l, 0 < W k l) {x : Conf M → ℝ}
    (hx : epsilonR M *ᵥ x = (-1 : ℝ) • x) (hx1 : vecNormSq x = 1) :
    ∃ u : Conf M → ℝ, epsilonR M *ᵥ u = (1 : ℝ) • u ∧ vecNormSq u = 1 ∧
      x ⬝ᵥ W *ᵥ x ≤ u ⬝ᵥ W *ᵥ u :=
  ⟨NecSuf.absVec x, epsilonR_mulVec_absVec hx,
    by rw [vecNormSq_absVec_eq, hx1], quad_le_quad_absVec_epsilonR hW x⟩

end Ising2D
