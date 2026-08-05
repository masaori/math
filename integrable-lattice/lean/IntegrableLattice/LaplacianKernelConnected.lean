/-
# 命題 W の積公式に要る 3 つ目の道具（全余因子が等しいこと）の連結性の側 — cycle 50 step 1

対応する人手証明: 本文ブロック `paper_063_theorem_W`（命題 W）の $(★_2)$——
塔の全域木数を、指標ごとの行列式の積として書く段。

## この段が要る理由（cycle 49 step 4 の測定）

cycle 49 step 4 は「全余因子が等しいこと」に着手し、**この段が 2 つに割れる**ことを測った。

- **代数の側**（`AllCofactorsEqual.lean`）: 行の和と列の和がどちらも $0$ で、
  核と左核が定数ベクトルだけなら、余因子行列は定数行列である。**連結性を 1 度も使わない。**
- **連結性の側**（本ファイル）: その核が実際に定数ベクトルだけであること。

本ファイルは後者を書く。書いた結果、2 つの側が繋がり、
**連結な多重グラフのラプラシアンについて「どの 1 行 1 列を落としても余因子が等しい」**が
仮定なしで出る（`adjugate_const_of_reachOn`）。

## 中身は平方和ひとつである

核の中身は、$L=D\,D^{\mathsf T}$ という書き方だけから出る。
$L x=0$ とすると $x^{\mathsf T}Lx=0$ であり、左辺は $D^{\mathsf T}x$ の成分の平方和である。
整数の平方は負にならないので、和が $0$ なら各項が $0$、すなわち各辺 $e$ について
$x_{t_e}-x_{s_e}=0$ になる。あとは到達可能性の鎖に沿って等号を運ぶだけである。

**行列の階数も次元も使わない。** 「階数が $|V|-1$」という言い方は同じことを述べているが、
そこを経由すると係数を体に取る必要が出る。平方和で書けば係数は $\mathbb{Z}$ のままで済む。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも 1 度も出ない。**
係数は $\mathbb{Z}$ のままで、使うのは整数の平方が負にならないことだけである。
到達可能性は `SpanningConnectivity.ReachOn`（有限の辺集合による反射推移閉包）なので、
これも可算側の組合せの言葉である。

## 書いたこと（5 段）

1. $D^{\mathsf T}x$ の成分が辺の両端の差であること（`vecMul_incMatrixSigned_apply`）。
2. $x^{\mathsf T}Lx$ が その平方和であること（`dotProduct_lapMatrix_mulVec`）。
3. 核に入る $x$ は各辺の両端で等しいこと（`eq_of_mem_ker`）。
4. 到達できる 2 点で等しいこと（`eq_of_reachOn`）——鎖に沿った帰納法である。
5. 連結なら核は定数ベクトルだけであること（`ker_eq_const_of_reachOn`）と、
   それを代数の側へ渡した結論（`adjugate_const_of_reachOn`）。

## 形式化しなかったもの

* **余因子の値そのものが全域木数であること。** それは Kirchhoff の定理の側で、
  外部定理として完了している（`KirchhoffCounting.det_mul_transpose_eq_card_spanning`）。
  本ファイルが与えるのは「どの余因子を取っても同じ値になる」ことだけである。
* **連結でない場合。** その場合も全余因子は等しい（どれも $0$ である）が、
  本ファイルの仮定の形では受け取れない。本文が当てているのは連結な塔なので、
  この場合分けは本文の主張の内容ではない。
-/
import Mathlib
import IntegrableLattice.MultigraphLaplacian
import IntegrableLattice.SpanningConnectivity
import IntegrableLattice.AllCofactorsEqual

namespace IntegrableLattice
namespace LaplacianKernelConnected

open Finset Matrix SpanningConnectivity

variable {V E : Type*} [Fintype V] [DecidableEq V] [Fintype E] [DecidableEq E]

/-! ## 1. $D^{\mathsf T}x$ の成分は辺の両端の差である -/

omit [Fintype E] [DecidableEq E] in
/-- 符号付き接続行列の転置を $x$ に当てると、辺ごとに両端の差が出る。 -/
theorem vecMul_incMatrixSigned_apply (s t : E → V) (x : V → ℤ) (e : E) :
    Matrix.vecMul x (incMatrixSigned s t) e = x (t e) - x (s e) := by
  classical
  simp only [Matrix.vecMul, dotProduct]
  have hterm : ∀ v : V, x v * incMatrixSigned s t v e
      = (if v = t e then x v else 0) - (if v = s e then x v else 0) := by
    intro v
    simp [incMatrixSigned, mul_sub, mul_ite]
  rw [Finset.sum_congr rfl fun v _ => hterm v, Finset.sum_sub_distrib]
  simp

/-! ## 2. $x^{\mathsf T}Lx$ は平方和である -/

omit [DecidableEq E] in
/-- $L=D\,D^{\mathsf T}$ なので、$x^{\mathsf T}Lx$ は辺ごとの差の平方の和になる。 -/
theorem dotProduct_lapMatrix_mulVec (s t : E → V) (x : V → ℤ) :
    x ⬝ᵥ (lapMatrixOfInc s t).mulVec x
      = ∑ e : E, (x (t e) - x (s e)) * (x (t e) - x (s e)) := by
  classical
  rw [lapMatrixOfInc, ← Matrix.mulVec_mulVec, Matrix.dotProduct_mulVec,
    Matrix.mulVec_transpose]
  simp only [dotProduct]
  exact Finset.sum_congr rfl fun e _ => by rw [vecMul_incMatrixSigned_apply]

/-! ## 3. 核に入るベクトルは、各辺の両端で等しい -/

omit [DecidableEq E] in
/-- **平方和ひとつである。** $Lx=0$ なら $x^{\mathsf T}Lx=0$ で、
それは辺ごとの差の平方の和なので、各辺の両端で $x$ は等しい。 -/
theorem eq_of_mem_ker (s t : E → V) {x : V → ℤ}
    (hx : (lapMatrixOfInc s t).mulVec x = 0) (e : E) : x (t e) = x (s e) := by
  classical
  have hzero : ∑ e : E, (x (t e) - x (s e)) * (x (t e) - x (s e)) = 0 := by
    rw [← dotProduct_lapMatrix_mulVec, hx]
    simp
  have hnonneg : ∀ e ∈ (Finset.univ : Finset E),
      0 ≤ (x (t e) - x (s e)) * (x (t e) - x (s e)) :=
    fun e _ => mul_self_nonneg _
  have := (Finset.sum_eq_zero_iff_of_nonneg hnonneg).mp hzero e (Finset.mem_univ e)
  have hdiff : x (t e) - x (s e) = 0 := by
    rcases mul_eq_zero.mp this with h | h <;> exact h
  omega

/-! ## 4. 到達できる 2 点で等しい -/

omit [DecidableEq E] in
/-- 1 歩ぶん。辺の向きを問わない `AdjOn` の両方の場合を潰すだけである。 -/
theorem eq_of_adjOn (s t : E → V) {S : Finset E} {x : V → ℤ}
    (hx : (lapMatrixOfInc s t).mulVec x = 0) {u v : V} (h : AdjOn s t S u v) :
    x u = x v := by
  obtain ⟨e, _, h1 | h1⟩ := h
  · rw [← h1.1, ← h1.2]
    exact (eq_of_mem_ker s t hx e).symm
  · rw [← h1.1, ← h1.2]
    exact eq_of_mem_ker s t hx e

omit [DecidableEq E] in
/-- 鎖に沿った帰納法。到達できる 2 点で $x$ は等しい。 -/
theorem eq_of_reachOn (s t : E → V) {S : Finset E} {x : V → ℤ}
    (hx : (lapMatrixOfInc s t).mulVec x = 0) {u v : V} (h : ReachOn s t S u v) :
    x u = x v := by
  induction h with
  | refl => rfl
  | tail _ hstep ih => exact ih.trans (eq_of_adjOn s t hx hstep)

/-! ## 5. 連結なら核は定数ベクトルだけ -/

omit [DecidableEq E] in
/-- **連結性の側の結論**。根から全頂点へ到達できるなら、
ラプラシアンの核に入るベクトルは定数ベクトルだけである。

**階数も次元も使わない。** 使うのは平方和と到達可能性の鎖だけなので、係数は $\mathbb{Z}$ のままである。 -/
theorem ker_eq_const_of_reachOn (s t : E → V) {S : Finset E} {r : V}
    (hreach : ∀ v : V, ReachOn s t S r v) {x : V → ℤ}
    (hx : (lapMatrixOfInc s t).mulVec x = 0) : ∃ c : ℤ, x = fun _ => c := by
  refine ⟨x r, ?_⟩
  funext v
  exact (eq_of_reachOn s t hx (hreach v)).symm

omit [DecidableEq E] in
/-- 左核についても同じ。ラプラシアンは対称なので、左核は核に一致する。 -/
theorem leftKer_eq_const_of_reachOn (s t : E → V) {S : Finset E} {r : V}
    (hreach : ∀ v : V, ReachOn s t S r v) {x : V → ℤ}
    (hx : Matrix.vecMul x (lapMatrixOfInc s t) = 0) : ∃ c : ℤ, x = fun _ => c := by
  classical
  refine ker_eq_const_of_reachOn s t hreach (x := x) ?_
  funext u
  have hu := congrFun hx u
  simp only [Matrix.vecMul, Matrix.mulVec, dotProduct, Pi.zero_apply] at hu ⊢
  rw [← hu]
  exact Finset.sum_congr rfl fun v _ => by
    rw [AllCofactorsEqual.lapMatrixOfInc_symm s t u v]
    ring

/-! ## 6. 2 つの側を繋ぐ -/

omit [DecidableEq E] in
/-- **この段の結論**。連結な多重グラフのラプラシアンについて、
**どの 1 行 1 列を落としても余因子は等しい。**

代数の側（`AllCofactorsEqual.adjugate_const_of_kernel_const`）が仮定として受け取っていた
「核と左核が定数ベクトルだけ」が、連結性から埋まる。 -/
theorem adjugate_const_of_reachOn [Nonempty V] (s t : E → V) {S : Finset E} {r : V}
    (hreach : ∀ v : V, ReachOn s t S r v) :
    ∃ κ : ℤ, (lapMatrixOfInc s t).adjugate = fun _ _ => κ :=
  AllCofactorsEqual.adjugate_const_of_kernel_const
    (lapMatrix_row_sum s t)
    (fun _ hker => ker_eq_const_of_reachOn s t hreach hker)
    (fun _ hker => leftKer_eq_const_of_reachOn s t hreach hker)

end LaplacianKernelConnected
end IntegrableLattice
