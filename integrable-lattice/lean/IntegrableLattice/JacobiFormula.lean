/-
# Jacobi の公式（行列式の微分）を書いた — cycle 44 step 3

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の証明が
  「Newton の公式より」と引いている 1 文
  （本文の整数行列 $G=(\operatorname{Tr}T^{i+j})$ と代数側の Gram 行列の同定に要る）

## この step が何を測ったか

cycle 42 総括は、この 1 文を書くのに 2 つの道があると書いていた。

| 道 | 出る先 | cycle 43 step 5 の記録 |
|---|---|---|
| 分解体で根を取り出す | $\overline{\mathbb{Q}}$（代数的閉包） | 使えるが、根を取り出す |
| 逆特性多項式の対数微分 | どこへも出ない | **「Jacobi の公式が mathlib に無いので素材が足りない」** |

cycle 44 の焦点はこれを「まず Jacobi の公式を書く量を測ること」だった。**測った。**

## 実測（記録の後半が誤りだった。そう書く）

* **mathlib に Jacobi の公式は無い。この側は正しい**（2026-08-05 実測、mathlib `520045ab14` の
  8264 ファイル。行列式の微分に当たるのは `Matrix.derivative_det_one_add_X_smul`
  （`Mathlib/LinearAlgebra/Matrix/Charpoly/Coeff.lean` 183 行）だけで、
  これは $\det(1+XM)$ の**$0$ での微分＝1 次の係数**しか与えない。一般の $A(X)$ については無い）。
* **「素材が足りない」という側は誤りである。** 要る素材は 3 つとも在った——
  行列式が行について多重線形であること（`Matrix.det_apply'` と `Polynomial.derivative_prod_finset`）、
  余因子展開（`Matrix.cramer_transpose_apply`）、余因子行列（`Matrix.adjugate`）。
  **書いた量は 25 行である。**

**これで「書けない理由」として記録されていたものが誤りだった件は 10 件目になる。**
今回の形は、cycle 40・41 の「定理の名前で引くと道具が見えない」とも、
cycle 43 の「概念の名前の側で引いた」とも違う。**引き方は正しく、無いという判定も正しかった。
誤っていたのは「無いから書けない」という推論のほうである。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも 1 度も出ない。係数環は任意の可換環で、
根も分解体も出てこない。**これがこの道を選んだ理由である。**
本文が当てる先は $\mathbb{Z}$ である。

## 書いたこと（3 段）

1. **Jacobi の公式（行ごとの形）**（`derivative_det`）。
   $\dfrac{\mathrm{d}}{\mathrm{d}X}\det A=\sum_i\det\bigl(A\ \text{の第 }i\text{ 行を微分に置き換えたもの}\bigr)$。
   **芯は、行列式を置換の和に開いて積の微分を当て、$i$ の和を置換で読み替えることだけである。**
2. **余因子展開**（`det_updateRow_eq_sum_adjugate`）。
   1 行だけ置き換えた行列式は、その行と余因子行列の内積である。
   mathlib の Cramer の公式（`Matrix.cramer_transpose_apply`）をそのまま当てる。
3. **Jacobi の公式（余因子行列の形）**（`derivative_det_eq_trace_adjugate`）。
   $\dfrac{\mathrm{d}}{\mathrm{d}X}\det A=\operatorname{tr}\bigl(\operatorname{adj}(A)\,A'\bigr)$。
   **対数微分の道が要求している形はこれである。**

## 形式化しなかったもの

* **対数微分から冪和を取り出す段。** 段 3 を $A=1-XM$ に当てると
  $P'=-\operatorname{tr}(\operatorname{adj}(1-XM)\,M)$ になり、
  $\operatorname{adj}(1-XM)=P\cdot\sum_k X^kM^k$（形式冪級数）を入れれば
  $P'=-P\sum_k\operatorname{Tr}(M^{k+1})X^k$ が出る。**その 2 段は書いていない。そう書く**——
  余因子行列を形式冪級数の形へ開くところと、係数を取り出して Newton の公式の初期値
  $\operatorname{Tr}(M^{k})$（$2\le k<r$）を読むところである。
  **道が塞がっていないことは測れた。残っているのは道の長さである。**
-/
import Mathlib

namespace IntegrableLattice
namespace JacobiFormula

open Matrix Polynomial Finset Equiv

variable {R : Type*} [CommRing R] {n : Type*} [DecidableEq n] [Fintype n]

/-! ## 段 1: Jacobi の公式（行ごとの形） -/

/-- **Jacobi の公式（行ごとの形）。**

$\dfrac{\mathrm{d}}{\mathrm{d}X}\det A=\sum_i\det\bigl(A\text{ の第 }i\text{ 行を微分に置き換えたもの}\bigr)$。

**係数環は任意の可換環でよい。根も分解体も使わない。** -/
theorem derivative_det (A : Matrix n n R[X]) :
    derivative A.det = ∑ i, (A.updateRow i (fun j => derivative (A i j))).det := by
  classical
  simp_rw [Matrix.det_apply']
  rw [map_sum, Finset.sum_comm]
  refine Finset.sum_congr rfl fun σ _ => ?_
  have hd : derivative (((Equiv.Perm.sign σ : ℤ) : R[X]) * ∏ i, A (σ i) i)
      = ((Equiv.Perm.sign σ : ℤ) : R[X]) * derivative (∏ i, A (σ i) i) := by
    rw [derivative_mul]; simp
  have key : ∀ k : n, ∏ i, (A.updateRow (σ k) fun j => derivative (A (σ k) j)) (σ i) i
      = (∏ i ∈ univ.erase k, A (σ i) i) * derivative (A (σ k) k) := by
    intro k
    rw [← Finset.mul_prod_erase univ _ (mem_univ k), mul_comm]
    congr 1
    · refine Finset.prod_congr rfl fun i hi => ?_
      rw [Matrix.updateRow_ne (fun h => (Finset.mem_erase.mp hi).1 (σ.injective h))]
    · rw [Matrix.updateRow_self]
  rw [hd, derivative_prod_finset, Finset.mul_sum]
  refine Fintype.sum_equiv σ _ _ fun k => ?_
  rw [key k]

/-! ## 段 2: 余因子展開 -/

/-- **1 行だけ置き換えた行列式は、その行と余因子行列の内積である。**

mathlib の Cramer の公式（`Matrix.cramer_transpose_apply`）をそのまま当てる。 -/
theorem det_updateRow_eq_sum_adjugate (A : Matrix n n R[X]) (i : n) (v : n → R[X]) :
    (A.updateRow i v).det = ∑ j, v j * adjugate A j i := by
  classical
  rw [← Matrix.cramer_transpose_apply, Matrix.cramer_eq_adjugate_mulVec]
  show ∑ j, Aᵀ.adjugate i j * v j = _
  exact Finset.sum_congr rfl fun j _ => by
    rw [← Matrix.adjugate_transpose, Matrix.transpose_apply, mul_comm]

/-! ## 段 3: Jacobi の公式（余因子行列の形） -/

/-- **Jacobi の公式。** $\dfrac{\mathrm{d}}{\mathrm{d}X}\det A=\operatorname{tr}\bigl(\operatorname{adj}(A)\,A'\bigr)$。

**対数微分の道が要求している形はこれである。** -/
theorem derivative_det_eq_trace_adjugate (A : Matrix n n R[X]) :
    derivative A.det = trace (adjugate A * A.map derivative) := by
  classical
  rw [derivative_det]
  rw [Matrix.trace]
  simp only [Matrix.diag_apply, Matrix.mul_apply, Matrix.map_apply]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [det_updateRow_eq_sum_adjugate]
  exact Finset.sum_congr rfl fun j _ => mul_comm _ _

end JacobiFormula
end IntegrableLattice
