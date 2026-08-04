/-
# 多重グラフの符号付き接続行列とラプラシアン（matrix-tree 定理の入口）

対応する人手証明:

* 本文ブロック `paper_def_graph_tower`（voltage グラフ、$\mathbb{Z}_\ell^2$ 塔、全域木数、
  voltage ラプラシアン）（`structured-latex/content/005_duality.ts`）
* 本文ブロック `paper_prop_T`（命題 T）の証明が引く Kirchhoff の matrix-tree 定理

## このファイルの位置づけ（cycle 30 step 2 の判断の一部）

matrix-tree 定理（全域木を数える定理）は mathlib に無い。cycle 29 の仕分けはこれを
最大の壁とし、5 つの段がこれに依ると数えた。cycle 30 step 2 はこれを自前で書くかを判断し、
**書く**と決めた。判断の根拠と、書く場合の段取りは
`outputs/reports/cycle30_ops_matrix_tree_decision.md` にある。

本ファイルはその第一石である。**判断を言葉で書くだけにせず、入口が実際に通ることを確かめる。**

## 何が入ったか

多重グラフを「頂点の型 $V$、辺の型 $E$、始点と終点 $s,t:E\to V$」で表し、
符号付き接続行列 $D_{v,e}=[v=t_e]-[v=s_e]$ とラプラシアン $L=D\,D^{\mathsf T}$ を定義した。
そのうえで、$L$ が本文の言う次数と隣接の形に一致することを証明した:

* 対角成分は $v$ に接続する非ループ辺の本数（`lapMatrix_diag`）。
* 非対角成分は $u,v$ を結ぶ辺の本数の符号を変えたもの（`lapMatrix_offDiag`）。
* 各行の和は $0$（`lapMatrix_row_sum`）。

**ループの辺は $D$ の列が $0$ になるので、$L$ に寄与しない。** これは本文の voltage ラプラシアンで
ループが $2-\mathrm{mon}-\mathrm{mon}^{-1}$ を与え、$z=w=1$ で $0$ になることと整合する。

## 何が入っていないか（matrix-tree 定理までに残る段）

1. **Cauchy–Binet の公式**（$\det(AB)=\sum_S\det A_{\cdot S}\det B_{S\cdot}$）。
   mathlib に無い（2026-08-04 実測。`Cauchy.Binet` / `cauchy_binet` / `CauchyBinet` の
   3 通りで 0 件。`lean/logs/mathlib-gap-survey-cycle30-matrixtree.log`）。
2. **符号付き接続行列の小行列式が $0$ か $\pm1$ であること**（全域森かどうかで決まる）。
3. 1 と 2 から出る Kirchhoff の定理（余因子＝全域木数）。
4. 導来グラフのラプラシアンを指標で分解し、voltage ラプラシアンの評価値の積にする段。

本ファイルは 1〜4 のいずれも書いていない。入口だけである。
-/
import Mathlib

namespace IntegrableLattice

open Finset Matrix

/-! ## 多重グラフの符号付き接続行列

多重グラフは「辺の型 $E$ と、始点・終点を与える写像 $s,t:E\to V$」で表す。
多重辺は $E$ の別の元として、ループは $s_e=t_e$ として自然に入る。
単純グラフの型を使わないのは、本文が多重辺とループを許すからである。 -/

section Multigraph

variable {V E : Type*} [Fintype V] [DecidableEq V] [Fintype E] [DecidableEq E]

/-- **符号付き接続行列** $D_{v,e}=[v=t_e]-[v=s_e]$。
ループ（$s_e=t_e$）の列は $0$ になる。 -/
def incMatrixSigned (s t : E → V) : Matrix V E ℤ :=
  Matrix.of fun v e => (if v = t e then 1 else 0) - (if v = s e then 1 else 0)

/-- **ラプラシアン** $L=D\,D^{\mathsf T}$。 -/
def lapMatrixOfInc (s t : E → V) : Matrix V V ℤ :=
  incMatrixSigned s t * (incMatrixSigned s t)ᵀ

omit [Fintype V] [DecidableEq E] in
theorem lapMatrixOfInc_apply (s t : E → V) (u v : V) :
    lapMatrixOfInc s t u v =
      ∑ e : E, ((if u = t e then 1 else 0) - (if u = s e then 1 else 0)) *
        ((if v = t e then 1 else 0) - (if v = s e then 1 else 0)) := by
  simp [lapMatrixOfInc, incMatrixSigned, Matrix.mul_apply, Matrix.transpose_apply]

omit [Fintype V] [Fintype E] [DecidableEq E] in
/-- ループの列は $0$。本文の voltage ラプラシアンでループの寄与が
$2-\mathrm{mon}-\mathrm{mon}^{-1}$ であり $z=w=1$ で消えることに対応する。 -/
theorem incMatrixSigned_loop (s t : E → V) {e : E} (he : s e = t e) (v : V) :
    incMatrixSigned s t v e = 0 := by
  simp [incMatrixSigned, he]

omit [Fintype V] [DecidableEq E] in
/-- **対角成分は $v$ に接続する非ループ辺の本数**。 -/
theorem lapMatrix_diag (s t : E → V) (v : V) :
    lapMatrixOfInc s t v v =
      (univ.filter fun e => (s e = v ∧ t e ≠ v) ∨ (t e = v ∧ s e ≠ v)).card := by
  classical
  rw [lapMatrixOfInc_apply, Finset.card_filter]
  push_cast
  refine Finset.sum_congr rfl fun e _ => ?_
  by_cases h1 : v = t e <;> by_cases h2 : v = s e <;>
    by_cases h5 : s e = t e <;> simp [h1, h2, h5, eq_comm]

omit [Fintype V] [DecidableEq E] in
/-- **非対角成分は $u,v$ を結ぶ辺の本数の符号を変えたもの**。 -/
theorem lapMatrix_offDiag (s t : E → V) {u v : V} (huv : u ≠ v) :
    lapMatrixOfInc s t u v =
      -((univ.filter fun e => (s e = u ∧ t e = v) ∨ (s e = v ∧ t e = u)).card : ℤ) := by
  classical
  rw [lapMatrixOfInc_apply, Finset.card_filter]
  push_cast
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun e _ => ?_
  by_cases h1 : u = t e <;> by_cases h2 : u = s e <;> by_cases h3 : v = t e <;>
    by_cases h4 : v = s e <;> by_cases h5 : s e = t e <;>
    simp_all [eq_comm]

omit [DecidableEq E] in
/-- **各行の和は $0$**（$D$ の各列の和が $0$ であることから出る）。
Kirchhoff の定理で「どの 1 行 1 列を落としても余因子が等しい」ことの土台になる。 -/
theorem lapMatrix_row_sum (s t : E → V) (u : V) :
    ∑ v : V, lapMatrixOfInc s t u v = 0 := by
  classical
  simp only [lapMatrixOfInc_apply]
  rw [Finset.sum_comm]
  refine Finset.sum_eq_zero fun e _ => ?_
  rw [← Finset.mul_sum]
  have hsum : ∑ v : V, ((if v = t e then (1 : ℤ) else 0) - (if v = s e then 1 else 0)) = 0 := by
    rw [Finset.sum_sub_distrib]
    simp
  rw [hsum, mul_zero]

end Multigraph

end IntegrableLattice
