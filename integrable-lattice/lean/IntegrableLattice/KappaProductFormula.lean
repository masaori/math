/-
# 塔の全域木数を指標ごとの行列式の積へ繋ぐ段（$\kappa_n$ の独立計算） — cycle 50 step 2

対応する人手証明:

* 本文ブロック `paper_055_theorem_theta_infinity`（命題 G′）と
  `paper_056_theorem_ell2_family`（命題 G″）が塔の全域木数 $\kappa_n$ を出す段
* 本文ブロック `paper_063_theorem_W`（命題 W）の $(★_2)$

## この段が要る理由（cycle 49 step 1 の全数の突き合わせ）

**外部定理としての Kirchhoff の matrix-tree 定理も、道具としての指標分解も、どちらも閉じている。
それでも塔の全域木数は出ない。**指標分解が与えるのはラプラシアン全体の行列式であり、
全域木数はその「1 行 1 列を落とした余因子」の側だからである。
そしてラプラシアンの行列式は $0$ なので、行列式の等式をそのまま使っても両辺が $0$ になるだけである。

**この段はどちらの内容でもないので、どこにも数えられていなかった**（cycle 49 step 1 の実測）。
**3 つの欄（命題 G′・命題 G″・命題 W）に共通する。**

## 段の中身（対角に変数を 1 つ足す）

$0=0$ にならないようにするために、対角へ変数 $x$ を足してから指標分解を当てる。
$x$ の 1 次の係数を両辺で比べると、余因子の側が出る。

1. $x$ を足した行列もブロック巡回である（対角に足すだけなので核の $u=v,\ d=0$ の成分が動く）。
   したがって $\det(M+x)=\prod_j\det(\widehat M(j)+x)$ が $R[x]$ で成り立つ。
2. 左辺の $x$ による微分を $x=0$ で見ると、余因子行列の跡が出る
   （Jacobi の公式。cycle 44 step 3 が書いた `JacobiFormula.derivative_det_eq_trace_adjugate` を、
   $M+x$ の微分が単位行列であることに当てるだけである）。
3. 右辺は積の微分で、$\det\widehat M(0)=0$ が他の項をすべて消す。
   残るのは $\widehat M(0)$ の余因子行列の跡と、$j\neq0$ の行列式の積である。

**したがって $\operatorname{tr}\operatorname{adj}M
=\operatorname{tr}\operatorname{adj}\widehat M(0)\cdot\prod_{j\neq0}\det\widehat M(j)$ である。**
全余因子が等しいこと（`AllCofactorsEqual` と `LaplacianKernelConnected`）と合わせると、
左辺は 頂点数 $\times$ 塔の全域木数、右辺の第 1 因子は 基礎グラフの頂点数 $\times$ その全域木数になる。
**これが本文の $(★_2)$ の形である。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**$\mathbb{R}$ へも $\mathbb{C}$ へも 1 度も出ない。**
係数環に要るのは「$1$ の原始 $N$ 乗根 $\zeta$ を持ち $N$ が単元である整域」だけで、
$\mathbb{Z}[\zeta_N]\subset\overline{\mathbb{Q}}$ で足りる（指標分解と同じ仮定である）。
変数 $x$ は多項式環 $R[x]$ の不定元であって、$\mathbb{R}$ の点ではない。
**固有値も特性根も使わない**——「非零固有値の積を頂点数で割る」という言い方は同じことを述べているが、
そちらは根の存在を要求するので係数を代数閉体へ広げることになる。
1 次の係数を比べる形で書けば、係数環は上の仮定のままで済む。

## 書いたこと（4 段）

1. 核の和と定数倍が、ブロック巡回行列と各層のブロックの両方で足し算・定数倍になること
   （`blockCirculant_add` / `hat_add` / `hat_smul`）。
2. 対角へ変数を足した指標分解（`det_add_X_smul_one`）。
3. 行列式の微分を $x=0$ で見ると余因子行列の跡になること（`eval_derivative_det_add_X`）。
4. 積の微分で $j=0$ の項だけが残ること（`eval_derivative_prod_of_eval_zero`）と、
   それらを合わせた結論（`trace_adjugate_blockCirculant`）、
   および導来グラフのラプラシアンへの当てはめ（`trace_adjugate_derivedLaplacian`）。

## 形式化しなかったもの

* **$\kappa_n$ の独立計算 に残るのは、2 通りのラプラシアンの同定である。**
  Kirchhoff の定理（外部定理として完了）が余因子を全域木数と結ぶのは、
  符号付き接続行列から作ったラプラシアン `lapMatrixOfInc` についてである。
  一方、本ファイルが扱うのは voltage 核から作った `derivedLaplacian` である。
  **この 2 つが同じ行列であることは書いていない**ので、
  本ファイルの等式の両辺を全域木数として読むところまでは届いていない。
* **$\mathbb{Z}_\ell^2$ の 2 変数の塔への当てはめ。** 巡回群 2 つの積についての指標分解は
  `CharacterDecompositionTwoVariable.lean` に在り、本ファイルの結論を 2 回当てる形になるが、
  その当てはめは書いていない。
-/
import Mathlib
import IntegrableLattice.CharacterDecomposition
import IntegrableLattice.CharacterDecompositionTwoVariable
import IntegrableLattice.JacobiFormula
import IntegrableLattice.AllCofactorsEqual

namespace IntegrableLattice
namespace KappaProductFormula

open Finset Matrix Polynomial CharacterDecomposition

variable {R : Type*} [CommRing R] [IsDomain R] {N : ℕ} [NeZero N] {ζ : R}
variable {V : Type*} [Fintype V] [DecidableEq V]

/-! ## 1. 核の和と定数倍 -/

/-- 核の和はブロック巡回行列の和である。 -/
theorem blockCirculant_add (c c' : V → V → ZMod N → R) :
    blockCirculant (N := N) (fun u v d => c u v d + c' u v d)
      = blockCirculant (N := N) c + blockCirculant (N := N) c' := by
  ext p q
  simp [blockCirculant]

/-- 核の和は各層のブロックの和である。 -/
theorem hat_add (c c' : V → V → ZMod N → R) (j : ZMod N) :
    hat ζ (fun u v d => c u v d + c' u v d) j = hat ζ c j + hat ζ c' j := by
  ext u v
  simp only [hat, Matrix.of_apply, Matrix.add_apply, add_mul]
  exact Finset.sum_add_distrib

/-- 核の定数倍は各層のブロックの定数倍である。 -/
theorem hat_smul (a : R) (c : V → V → ZMod N → R) (j : ZMod N) :
    hat ζ (fun u v d => a * c u v d) j = a • hat ζ c j := by
  ext u v
  simp only [hat, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun d _ => by ring

/-! ## 2. 対角へ変数を足した指標分解

多項式環 $R[x]$ へ移す。$\zeta$ の像 $C\zeta$ はやはり原始 $N$ 乗根であり、
$N$ の逆元も $C$ で送れば足りるので、指標分解の仮定はそのまま満たされる。 -/

/-- 対角に変数 $x$ を足した核。 -/
noncomputable def coreX (c : V → V → ZMod N → R) : V → V → ZMod N → R[X] :=
  fun u v d => C (c u v d) + (if u = v ∧ d = 0 then (X : R[X]) else 0)

/-- 係数を $C$ で送った核のブロック巡回行列は、もとの行列を $C$ で送ったものである。 -/
theorem blockCirculant_mapC (c : V → V → ZMod N → R) :
    blockCirculant (N := N) (fun u v d => C (c u v d))
      = (blockCirculant (N := N) c).map C := by
  ext p q
  simp [blockCirculant]

/-- 対角へ変数を足した核のブロック巡回行列は、$M$ を $C$ で送ったものに $x$ の対角を足したものである。 -/
theorem blockCirculant_coreX (c : V → V → ZMod N → R) :
    blockCirculant (N := N) (coreX c)
      = (blockCirculant (N := N) c).map C + (X : R[X]) • (1 : Matrix (V × ZMod N) (V × ZMod N) R[X]) := by
  classical
  ext p q
  obtain ⟨u, g⟩ := p
  obtain ⟨v, h⟩ := q
  by_cases huv : u = v
  · subst huv
    by_cases hgh : g = h
    · subst hgh
      simp [coreX, blockCirculant, Matrix.one_apply]
    · simp [coreX, blockCirculant, Matrix.one_apply, Prod.ext_iff, hgh, sub_eq_zero,
        Ne.symm hgh]
  · simp [coreX, blockCirculant, Matrix.one_apply, Prod.ext_iff, huv]

/-- 各層のブロックの側も同じ形になる。 -/
theorem hat_coreX (c : V → V → ZMod N → R) (j : ZMod N) :
    hat (C ζ) (coreX c) j = (hat ζ c j).map C + (X : R[X]) • (1 : Matrix V V R[X]) := by
  classical
  have hsplit : hat (C ζ) (coreX (N := N) c) j
      = hat (C ζ) (fun u v d => C (c u v d)) j
        + hat (C ζ) (fun u v (d : ZMod N) => X * (if u = v ∧ d = 0 then (1 : R[X]) else 0)) j := by
    rw [← hat_add]
    congr 1
    funext u v d
    by_cases h : u = v ∧ d = 0 <;> simp [coreX, h]
  rw [hsplit, hat_smul, hat_one]
  congr 1
  · ext u v
    simp only [hat, Matrix.of_apply, Matrix.map_apply, map_sum, map_mul, map_pow]

/-- **対角へ変数を足した指標分解。** $R[x]$ の中で成り立つ等式である。 -/
theorem det_add_X_smul_one (hζ : IsPrimitiveRoot ζ N) {cinv : R} (hcinv : cinv * (N : R) = 1)
    (c : V → V → ZMod N → R) :
    ((blockCirculant (N := N) c).map C
        + (X : R[X]) • (1 : Matrix (V × ZMod N) (V × ZMod N) R[X])).det
      = ∏ j : ZMod N, ((hat ζ c j).map C + (X : R[X]) • (1 : Matrix V V R[X])).det := by
  have hζ' : IsPrimitiveRoot (C ζ : R[X]) N := hζ.map_of_injective (C_injective (R := R))
  have hcinv' : (C cinv : R[X]) * (N : R[X]) = 1 := by
    rw [show ((N : R[X])) = C (N : R) by simp, ← map_mul, hcinv, map_one]
  have h := det_blockCirculant (V := V) (N := N) hζ' hcinv' (coreX (N := N) c)
  rw [blockCirculant_coreX] at h
  rw [h]
  exact Finset.prod_congr rfl fun j _ => by rw [hat_coreX]

/-! ## 3. 行列式の微分は余因子行列の跡である -/

/-- $M+x$ を $x$ で微分すると単位行列である。 -/
theorem map_derivative_add_X (M : Matrix V V R) :
    (M.map C + (X : R[X]) • (1 : Matrix V V R[X])).map derivative = 1 := by
  classical
  ext u v
  by_cases huv : u = v
  · subst huv; simp [Matrix.one_apply]
  · simp [Matrix.one_apply, huv]

/-- $x=0$ を代入すると、もとの行列に戻る。 -/
theorem mapMatrix_eval_zero (M : Matrix V V R) :
    (evalRingHom (0 : R)).mapMatrix (M.map C + (X : R[X]) • (1 : Matrix V V R[X])) = M := by
  classical
  ext u v
  by_cases huv : u = v
  · subst huv; simp [Matrix.one_apply]
  · simp [Matrix.one_apply, huv]

/-- したがって行列式の $x=0$ での値はもとの行列式である。 -/
theorem eval_det_add_X (M : Matrix V V R) :
    ((M.map C + (X : R[X]) • (1 : Matrix V V R[X])).det).eval 0 = M.det := by
  have := (evalRingHom (0 : R)).map_det (M.map C + (X : R[X]) • (1 : Matrix V V R[X]))
  rw [show (evalRingHom (0 : R)) ((M.map C + (X : R[X]) • (1 : Matrix V V R[X])).det)
      = ((M.map C + (X : R[X]) • (1 : Matrix V V R[X])).det).eval 0 from rfl] at this
  rw [this, mapMatrix_eval_zero]

/-- **$x=0$ で見ると余因子行列の跡になる**（Jacobi の公式の当てはめ）。 -/
theorem eval_derivative_det_add_X (M : Matrix V V R) :
    (derivative (M.map C + (X : R[X]) • (1 : Matrix V V R[X])).det).eval 0
      = trace M.adjugate := by
  classical
  rw [JacobiFormula.derivative_det_eq_trace_adjugate, map_derivative_add_X, mul_one]
  have hadj := (evalRingHom (0 : R)).map_adjugate
    (M.map C + (X : R[X]) • (1 : Matrix V V R[X]))
  calc (trace (M.map C + (X : R[X]) • (1 : Matrix V V R[X])).adjugate).eval 0
      = trace ((evalRingHom (0 : R)).mapMatrix
          (M.map C + (X : R[X]) • (1 : Matrix V V R[X])).adjugate) := by
        simp [Matrix.trace, Matrix.diag, RingHom.mapMatrix_apply, Matrix.map_apply,
          Polynomial.eval_finsetSum]
    _ = trace (Matrix.adjugate ((evalRingHom (0 : R)).mapMatrix
          (M.map C + (X : R[X]) • (1 : Matrix V V R[X])))) := by rw [hadj]
    _ = trace M.adjugate := by rw [mapMatrix_eval_zero]

/-! ## 4. 積の微分では $j=0$ の項だけが残る -/

omit [IsDomain R] in
/-- $f(0)$ の定数項が $0$ なら、積の微分の $x=0$ での値は $f(0)$ の項だけになる。 -/
theorem eval_derivative_prod_of_eval_zero (f : ZMod N → R[X])
    (h0 : (f 0).eval 0 = 0) :
    (derivative (∏ j : ZMod N, f j)).eval 0
      = (derivative (f 0)).eval 0 * ∏ j ∈ (univ : Finset (ZMod N)).erase 0, (f j).eval 0 := by
  classical
  rw [Polynomial.derivative_prod_finset, eval_finsetSum]
  rw [Finset.sum_eq_single (0 : ZMod N)]
  · simp [eval_mul, eval_prod, mul_comm]
  · intro a _ ha
    -- `a ≠ 0` の項には、`erase a` の中に `0` が残っているので `f 0` の値が因子として入る。
    have h0mem : (0 : ZMod N) ∈ (univ : Finset (ZMod N)).erase a :=
      Finset.mem_erase.mpr ⟨Ne.symm ha, Finset.mem_univ _⟩
    have : (∏ b ∈ (univ : Finset (ZMod N)).erase a, f b).eval 0 = 0 := by
      rw [eval_prod]
      exact Finset.prod_eq_zero h0mem h0
    rw [eval_mul, this, zero_mul]
  · intro h
    exact absurd (Finset.mem_univ (0 : ZMod N)) h

/-! ## 5. 結論 -/

/-- **$\kappa_n$ の独立計算の芯。**

ブロック巡回行列について、$\widehat M(0)$ が特異なら

$$\operatorname{tr}\operatorname{adj}M
  =\operatorname{tr}\operatorname{adj}\widehat M(0)\cdot\prod_{j\neq0}\det\widehat M(j).$$

全余因子が等しいこと（`AllCofactorsEqual` と `LaplacianKernelConnected`）と合わせると、
左辺は 頂点数 $\times$ 塔の全域木数、右辺の第 1 因子は基礎グラフの側の同じ量になる。
**これが本文の $(★_2)$ の形である。** -/
theorem trace_adjugate_blockCirculant (hζ : IsPrimitiveRoot ζ N) {cinv : R}
    (hcinv : cinv * (N : R) = 1) (c : V → V → ZMod N → R)
    (hsing : (hat ζ c 0).det = 0) :
    trace (blockCirculant (N := N) c).adjugate
      = trace (hat ζ c 0).adjugate * ∏ j ∈ (univ : Finset (ZMod N)).erase 0, (hat ζ c j).det := by
  classical
  set f : ZMod N → R[X] :=
    fun j => ((hat ζ c j).map C + (X : R[X]) • (1 : Matrix V V R[X])).det with hf
  have hf_eval : ∀ j, (f j).eval 0 = (hat ζ c j).det := fun j => eval_det_add_X (hat ζ c j)
  have hf_deriv : ∀ j, (derivative (f j)).eval 0 = trace (hat ζ c j).adjugate :=
    fun j => eval_derivative_det_add_X (hat ζ c j)
  have hdet0 : (f 0).eval 0 = 0 := by rw [hf_eval, hsing]
  calc trace (blockCirculant (N := N) c).adjugate
      = (derivative ((blockCirculant (N := N) c).map C
          + (X : R[X]) • (1 : Matrix (V × ZMod N) (V × ZMod N) R[X])).det).eval 0 :=
        (eval_derivative_det_add_X _).symm
    _ = (derivative (∏ j : ZMod N, f j)).eval 0 := by
        rw [det_add_X_smul_one hζ hcinv c]
    _ = (derivative (f 0)).eval 0 * ∏ j ∈ (univ : Finset (ZMod N)).erase 0, (f j).eval 0 :=
        eval_derivative_prod_of_eval_zero f hdet0
    _ = trace (hat ζ c 0).adjugate
          * ∏ j ∈ (univ : Finset (ZMod N)).erase 0, (hat ζ c j).det := by
        rw [hf_deriv]
        exact congrArg _ (Finset.prod_congr rfl fun j _ => hf_eval j)

/-! ## 6. 導来グラフのラプラシアンへ当てる

塔の側の仮定（$\widehat M(0)$ が特異であること）は、基礎グラフのラプラシアンの行の和が
$0$ であることから出る。**したがって当てはめに追加の仮定は要らない。** -/

open CharacterDecompositionTwoVariable

omit [IsDomain R] in
/-- $j=0$ の層は、核を層について足し合わせたものである（$\zeta^0=1$ だからである）。 -/
theorem hat_zero_apply (c : V → V → ZMod N → R) (u v : V) :
    hat ζ c 0 u v = ∑ d : ZMod N, c u v d := by
  simp [hat]

omit [IsDomain R] in
/-- **導来グラフの $j=0$ の層は、基礎グラフのラプラシアンである**——その行の和は $0$ である。 -/
theorem row_sum_hat_zero_derivedKernel (a : V → V → ZMod N → R) (u : V) :
    ∑ v : V, hat ζ (derivedKernel a) 0 u v = 0 := by
  classical
  have hterm : ∀ v : V, hat ζ (derivedKernel a) 0 u v
      = (if u = v then voltageDegree a u else 0) - ∑ d : ZMod N, a u v d := by
    intro v
    rw [hat_zero_apply]
    simp only [derivedKernel, Finset.sum_sub_distrib]
    congr 1
    by_cases huv : u = v
    · subst huv
      simp
    · simp [huv]
  rw [Finset.sum_congr rfl fun v _ => hterm v, Finset.sum_sub_distrib]
  simp [voltageDegree]

/-- 基礎グラフのラプラシアンは特異である（行の和が $0$ だからである）。 -/
theorem det_hat_zero_derivedKernel [Nonempty V] (a : V → V → ZMod N → R) :
    (hat ζ (derivedKernel a) 0).det = 0 :=
  AllCofactorsEqual.det_eq_zero_of_row_sum_zero (row_sum_hat_zero_derivedKernel a)

/-- **本文の $(★_2)$ の形**。導来グラフのラプラシアンの余因子行列の跡は、
基礎グラフの側の同じ量と、$j\neq0$ の層の行列式の積との積である。

全余因子が等しいこと（`LaplacianKernelConnected.adjugate_const_of_reachOn`）を両辺へ当てると、
左辺は 塔の頂点数 $\times$ 塔の全域木数、右辺の第 1 因子は
基礎グラフの頂点数 $\times$ 基礎グラフの全域木数になる。 -/
theorem trace_adjugate_derivedLaplacian [Nonempty V] (hζ : IsPrimitiveRoot ζ N) {cinv : R}
    (hcinv : cinv * (N : R) = 1) (a : V → V → ZMod N → R) :
    trace (derivedLaplacian a).adjugate
      = trace (hat ζ (derivedKernel a) 0).adjugate
          * ∏ j ∈ (univ : Finset (ZMod N)).erase 0, (hat ζ (derivedKernel a) j).det := by
  rw [derivedLaplacian_eq_blockCirculant]
  exact trace_adjugate_blockCirculant hζ hcinv _ (det_hat_zero_derivedKernel a)

omit [IsDomain R] [NeZero N] in
/-- 余因子行列が定数行列なら、その跡は 頂点数 $\times$ その定数である。 -/
theorem trace_adjugate_of_const {M : Matrix V V R} {κ : R} (h : M.adjugate = fun _ _ => κ) :
    trace M.adjugate = (Fintype.card V : R) * κ := by
  rw [h]
  simp [Matrix.trace, Matrix.diag, Finset.sum_const, nsmul_eq_mul]

/-- **本文の $(★_2)$ そのものの形**。両辺の余因子行列が定数行列であるとき
（連結なグラフではそうである。`LaplacianKernelConnected.adjugate_const_of_reachOn`）、

$$|V_{\text{塔}}|\,\kappa_{\text{塔}}
  =|V_{\text{基礎}}|\,\kappa_{\text{基礎}}\cdot\prod_{j\neq0}\det\widehat L(j).$$

余因子そのものが全域木数であることは Kirchhoff の定理の側であり、本ファイルの外である。 -/
theorem card_mul_kappa [Nonempty V] (hζ : IsPrimitiveRoot ζ N) {cinv : R}
    (hcinv : cinv * (N : R) = 1) (a : V → V → ZMod N → R) {κX κG : R}
    (hX : (derivedLaplacian a).adjugate = fun _ _ => κX)
    (hG : (hat ζ (derivedKernel a) 0).adjugate = fun _ _ => κG) :
    (Fintype.card (V × ZMod N) : R) * κX
      = (Fintype.card V : R) * κG
          * ∏ j ∈ (univ : Finset (ZMod N)).erase 0, (hat ζ (derivedKernel a) j).det := by
  rw [← trace_adjugate_of_const hX, ← trace_adjugate_of_const hG]
  exact trace_adjugate_derivedLaplacian hζ hcinv a

end KappaProductFormula
end IntegrableLattice
