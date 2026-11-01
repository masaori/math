/-
# 行ベクトルの右逆行列による書き直しと、線型写像の一致の移し替え（必要十分版）

具体版: `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimTVPlusEqTCheckVprimeOnCheckZY.lean`
（人手 `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` の Step 1 と Step 3）。具体版をこのファイルの系として導くのは
`Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimTVPlusEqTCheckVprimeOnCheckZYFromNecSuf.lean` の
`checkZY_row_eq_rowMul_checkPmat_inv_of_necSuf`（Step 1。`eq_rowMul2_of_rowMul2_eq` の特殊化）と
`eq_on_checkZY_of_eq_on_checkPsi_of_necSuf`（Step 1 と Step 3。`linear_eq_on_of_rowMul2_eq` の特殊化）。

| 具体版の段 | 必要十分版 |
| --- | --- |
| Step 1 の鎖 `(Ž, Y̌) = (Ž, Y̌)(P̌P̌^{-1}) = ((Ž, Y̌)P̌)P̌^{-1} = (ψ̌^†, ψ̌)P̌^{-1}` | `eq_rowMul2_of_rowMul2_eq` |
| Step 3 の 5 行の鎖（`Ž` と `Y̌`） | `linear_eq_on_of_rowMul2_eq` |

## 何が効いているか / 効いていないか

- Step 1 で `P̌_μ` について使うのは、可逆性を右逆行列の等式 `G H = I` の形で使うことだけである。
  可換半環の上の正方行列では `G H = I` は `G` の可逆性と同値なので（mathlib `IsUnit.of_mul_eq_one`）、
  これは可逆性より弱い条件ではない。行列式の値そのもの・係数が体であること・`ℂ` であることは効いていない。
- 行ベクトルと行列の積を左スカラー倍 `G_{kl} • z` で書いたため、結合律 `((z, y)G)H = (z, y)(GH)` に
  係数の乗法の可換則を使う（右加群の右スカラー倍で書けば、この結合律は可換則なしで成り立つ）。
  引き算は使わないので、係数は可換半環でよい。
- Step 3 で写像について効くのは、加法とスカラー倍を保つこと（線型性）だけである。
  `T_{(V^{(+)})}`・`T_{(V̌')}` が共役であることも、可逆であることも効いていない。
- 台 `A` は可換半環上の任意の加群でよい。積（行列の積・テンソル積）は使わない。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Module.LinearMap.Defs
import Mathlib.Tactic.Module

namespace Ising2D.NecSuf

open Matrix

variable {R A : Type*} [CommSemiring R] [AddCommMonoid A] [Module R A]

/-- 長さ 2 の行ベクトル `(z, y)` と `2×2` 行列 `G` の積 `(z, y) G`（第 `l` 成分は `G_{0l} z + G_{1l} y`）。 -/
def rowMul2 (p : A × A) (G : Matrix (Fin 2) (Fin 2) R) : A × A :=
  (G 0 0 • p.1 + G 1 0 • p.2, G 0 1 • p.1 + G 1 1 • p.2)

/-- `(z, y) I = (z, y)`。 -/
theorem rowMul2_one (p : A × A) : rowMul2 p (1 : Matrix (Fin 2) (Fin 2) R) = p := by
  simp [rowMul2]

/-- 結合律 `((z, y) G) H = (z, y)(G H)`（左スカラー倍で書いたので係数の乗法の可換則を使う）。 -/
theorem rowMul2_rowMul2 (p : A × A) (G H : Matrix (Fin 2) (Fin 2) R) :
    rowMul2 (rowMul2 p G) H = rowMul2 p (G * H) := by
  simp only [rowMul2, Matrix.mul_apply, Fin.sum_univ_two, Prod.mk.injEq]
  constructor <;> module

/-- **Step 1 の必要十分版**: `G H = I` かつ `(z, y) G = (a, b)` なら `(z, y) = (a, b) H`。 -/
theorem eq_rowMul2_of_rowMul2_eq {p q : A × A} {G H : Matrix (Fin 2) (Fin 2) R}
    (hGH : G * H = 1) (h : rowMul2 p G = q) : p = rowMul2 q H := by
  rw [← h, rowMul2_rowMul2, hGH, rowMul2_one]

/-- **Step 1 と Step 3 の必要十分版**: `G H = I` かつ `(z, y) G = (a, b)` のとき、
2 つの線型写像が `a` と `b` の上で一致すれば、`z` と `y` の上でも一致する。 -/
theorem linear_eq_on_of_rowMul2_eq {z y a b : A} {G H : Matrix (Fin 2) (Fin 2) R}
    (hGH : G * H = 1) (h : rowMul2 (z, y) G = (a, b)) {T₁ T₂ : A →ₗ[R] A}
    (ha : T₁ a = T₂ a) (hb : T₁ b = T₂ b) :
    T₁ z = T₂ z ∧ T₁ y = T₂ y := by
  have hzy := eq_rowMul2_of_rowMul2_eq hGH h
  simp only [rowMul2, Prod.mk.injEq] at hzy
  rw [hzy.1, hzy.2]
  simp only [map_add, map_smul, ha, hb, and_self]

end Ising2D.NecSuf
