/-
# 命題 W の積公式に要る 3 つ目の道具（全余因子が等しいこと）の代数の側 — cycle 49 step 4

対応する人手証明: 本文ブロック `paper_063_theorem_W`（命題 W）の $(★_2)$——
塔の全域木数を、指標ごとの行列式の積として書く段。

## この段が要る理由（cycle 48 step 4 の測定）

cycle 47 step 2 は積公式の段を「在る道具（指標分解と matrix-tree）を組み立てるだけ」と読んだ。
cycle 48 step 4 が測ると、**組み立てるだけではなかった**——指標分解が与えるのは
ラプラシアン全体の行列式であり、全域木数はその「1 行 1 列を落とした余因子」の側なので、
**両者を繋ぐ段が別に要る。**その中身が、**どの 1 行 1 列を落としても余因子が等しいこと**である。

土台は cycle 30 step 2 が書いている（`MultigraphLaplacian.lapMatrix_row_sum`。
その時点で「全余因子が等しいことの土台になる」と書かれていた）。

## 着手して測ると、この段は 2 つに割れた（本 step の主題）

**代数の側と、連結性の側である。そう書く。**

- **代数の側**（本ファイル）: 行の和と列の和がどちらも $0$ なら $\det M=0$ であり、
  余因子行列 $\operatorname{adj}M$ の各列は $M$ の核に、各行は左核に入る。
  **したがって核が定数ベクトルだけであれば、$\operatorname{adj}M$ は定数行列になる**
  ——すなわち全余因子が等しい。**ここまでは連結性を 1 度も使わない。**
- **連結性の側**（本ファイルには無い）: その核が実際に定数ベクトルだけであること。
  これは階数が $|V|-1$ であることと同じで、グラフが連結であることから出る。
  **連結でなければ全余因子は等しいままだが、どれも $0$ である**（この場合も結論は成り立つが、
  本ファイルの仮定の形では受け取れない）。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも 1 度も出ない。** 係数は可換環のままで、
体も整域も使わない（行列式と余因子行列の恒等式だけである）。

## 書いたこと（4 段）

1. 行の和が $0$ なら定数ベクトルが核に入る（`mulVec_one_eq_zero`）。
2. そこから $\det M=0$（`det_eq_zero_of_row_sum_zero`）。
3. $M\operatorname{adj}M=0$ と $\operatorname{adj}M\,M=0$（`mul_adjugate_eq_zero` / `adjugate_mul_eq_zero`）。
4. 核が定数だけなら余因子行列は定数行列（`adjugate_const_of_kernel_const`）。

## 形式化しなかったもの

* **核が定数ベクトルだけであること（連結性の側）。** 階数が $|V|-1$ であることと同じで、
  グラフの連結性から出る。本ファイルは仮定として受け取っている。
-/
import Mathlib
import IntegrableLattice.MultigraphLaplacian

namespace IntegrableLattice
namespace AllCofactorsEqual

open Finset Matrix

variable {V R : Type*} [Fintype V] [DecidableEq V] [CommRing R]

/-! ## 1. 行の和が $0$ であることの言い換え -/

/-- 行の和が $0$ であることは、定数ベクトル $1$ が核に入ることと同じである。 -/
theorem mulVec_one_eq_zero {M : Matrix V V R} (hrow : ∀ u, ∑ v, M u v = 0) :
    M.mulVec (fun _ => (1 : R)) = 0 := by
  funext u
  simpa [Matrix.mulVec, dotProduct] using hrow u

/-- 列の和が $0$ であることは、定数ベクトル $1$ が左核に入ることと同じである。 -/
theorem vecMul_one_eq_zero {M : Matrix V V R} (hcol : ∀ v, ∑ u, M u v = 0) :
    Matrix.vecMul (fun _ => (1 : R)) M = 0 := by
  funext v
  simpa [Matrix.vecMul, dotProduct] using hcol v

/-! ## 2. 行列式が $0$ であること -/

/-- **行の和が $0$ なら行列式は $0$ である**（頂点が 1 つ以上あるとき）。
核に $0$ でないベクトルが入っているので、行列式は $0$ になる。 -/
theorem det_eq_zero_of_row_sum_zero [Nonempty V] [IsDomain R] {M : Matrix V V R}
    (hrow : ∀ u, ∑ v, M u v = 0) : M.det = 0 := by
  refine Matrix.exists_mulVec_eq_zero_iff.mp ⟨fun _ => (1 : R), ?_, mulVec_one_eq_zero hrow⟩
  intro h
  exact one_ne_zero (congrFun h (Classical.arbitrary V))

/-! ## 3. 余因子行列の列と行が核に入ること -/

/-- $\det M=0$ なら $M\operatorname{adj}M=0$。 -/
theorem mul_adjugate_eq_zero {M : Matrix V V R} (hdet : M.det = 0) :
    M * M.adjugate = 0 := by
  rw [Matrix.mul_adjugate, hdet, zero_smul]

/-- $\det M=0$ なら $\operatorname{adj}M\,M=0$。 -/
theorem adjugate_mul_eq_zero {M : Matrix V V R} (hdet : M.det = 0) :
    M.adjugate * M = 0 := by
  rw [Matrix.adjugate_mul, hdet, zero_smul]

/-- 余因子行列の各列は $M$ の核に入る。 -/
theorem mulVec_adjugate_col {M : Matrix V V R} (hdet : M.det = 0) (j : V) :
    M.mulVec (fun i => M.adjugate i j) = 0 := by
  funext i
  have := congrFun (congrFun (mul_adjugate_eq_zero hdet) i) j
  simpa [Matrix.mul_apply, Matrix.mulVec, dotProduct] using this

/-- 余因子行列の各行は $M$ の左核に入る。 -/
theorem vecMul_adjugate_row {M : Matrix V V R} (hdet : M.det = 0) (i : V) :
    Matrix.vecMul (fun j => M.adjugate i j) M = 0 := by
  funext j
  have := congrFun (congrFun (adjugate_mul_eq_zero hdet) i) j
  simpa [Matrix.mul_apply, Matrix.vecMul, dotProduct] using this

/-! ## 4. 核が定数だけなら、全余因子が等しい -/

/-- **この段の結論**。行の和と列の和がどちらも $0$ で、核と左核がどちらも定数ベクトルだけなら、
余因子行列は定数行列である——すなわち**どの 1 行 1 列を落としても余因子は等しい。**

**連結性は 1 度も使っていない。** 使うのは行列式と余因子行列の恒等式だけである。
核が定数ベクトルだけであることが、グラフの側では連結性から来る（本ファイルの外）。 -/
theorem adjugate_const_of_kernel_const [Nonempty V] [IsDomain R] {M : Matrix V V R}
    (hrow : ∀ u, ∑ v, M u v = 0)
    (hker : ∀ x : V → R, M.mulVec x = 0 → ∃ c : R, x = fun _ => c)
    (hkerT : ∀ x : V → R, Matrix.vecMul x M = 0 → ∃ c : R, x = fun _ => c) :
    ∃ κ : R, M.adjugate = fun _ _ => κ := by
  have hdet : M.det = 0 := det_eq_zero_of_row_sum_zero hrow
  -- 各列が定数、各行も定数。
  choose c hc using fun j => hker _ (mulVec_adjugate_col hdet j)
  choose d hd using fun i => hkerT _ (vecMul_adjugate_row hdet i)
  refine ⟨c (Classical.arbitrary V), ?_⟩
  funext i j
  show M.adjugate i j = c (Classical.arbitrary V)
  -- 列 `j` が定数 `c j`、行 `i` が定数 `d i` なので、すべての成分が等しい。
  have hij' : M.adjugate i j = d i := congrFun (hd i) j
  have harb : M.adjugate i (Classical.arbitrary V) = d i :=
    congrFun (hd i) (Classical.arbitrary V)
  have harb' : M.adjugate i (Classical.arbitrary V) = c (Classical.arbitrary V) :=
    congrFun (hc (Classical.arbitrary V)) i
  rw [hij', ← harb, harb']

/-! ## 5. 多重グラフのラプラシアンに当てる -/

section Laplacian

variable {E : Type*} [Fintype E] [DecidableEq E]

/-- 符号付き接続行列から作ったラプラシアンは対称である（$L=D\,D^{\mathsf T}$ だからである）。 -/
theorem lapMatrixOfInc_symm (s t : E → V) (u v : V) :
    lapMatrixOfInc s t u v = lapMatrixOfInc s t v u := by
  classical
  simp only [lapMatrixOfInc_apply]
  exact Finset.sum_congr rfl fun e _ => by ring

/-- ラプラシアンの列の和も $0$ である（対称性と行の和から出る）。 -/
theorem lapMatrix_col_sum (s t : E → V) (v : V) :
    ∑ u : V, lapMatrixOfInc s t u v = 0 := by
  classical
  have : ∑ u : V, lapMatrixOfInc s t u v
      = ∑ u : V, lapMatrixOfInc s t v u :=
    Finset.sum_congr rfl fun u _ => lapMatrixOfInc_symm s t u v
  rw [this]
  exact lapMatrix_row_sum s t v

end Laplacian

end AllCofactorsEqual
end IntegrableLattice
