/-
# 命題 W\* の可約な場合の降下（$A$ が整域でなくてよい形）— cycle 36 step 1

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の第 2 段・第 3 段

## なぜこのファイルが要るのか（cycle 36 step 1 の実測で見つかった）

本文は $\rho=\mathrm{rad}(\chi)$、$A=\mathbb{Z}[x]/(\rho)$ と置く。
$\rho$ は無平方だが**既約とは限らない**ので、$A$ は一般に整域ではない
（既約成分が 2 つ以上あれば $A\otimes\mathbb{Q}$ は体の積である）。

ところが `WStarIntegralDescent.lean` の降下 `isLeast_isPLevel_range_of_euler` は
`[IsDomain S]` を仮定している。台帳は 命題 W\* の残りを
「$\rho$ が可約な場合の $C\,G=M_\eta$ そのもの」1 件と書いていたが、
**実測すると、その等式を可換環の上で書いても降下の側が整域を要求したままである。**
すなわち残りは 1 件ではなく 2 件だった。本ファイルは 2 件めを埋める。

## 整域はどこで効いていたのか

効いていたのは 1 箇所だけである——結論に現れる適合基底の係数を
`Ideal.smithCoeffs` で作っていたところで、これが `[IsDomain S]` を要求する
（mathlib `Mathlib/LinearAlgebra/FreeModule/PID.lean` の `Ideal.smithCoeffs` の宣言行で直読）。

**しかし主定理 `isLeast_isPLevel` のほうは整域を 1 度も使っていない**——
適合基底 $(b'_i)$・$(a_i b'_i)$ と $a_i\neq0$ さえあればよい。
そして適合基底は、整域でなくても
`Submodule.exists_smith_normal_form_of_rank_eq` で作れる（PID であることを要求されるのは
係数環 $\mathbb{Z}$ の側だけで、$S$ の側ではない）。要るのは階数が一致することだけで、
それは $\eta$ が**零因子でない**ことから出る（$\eta$ 倍が単射なので $\eta S\cong S$）。

すなわち、整域という仮定は本質ではなく、$\eta$ が零因子でないことへ落ちる。
本文が $\det G=\pm N_{A/\mathbb{Q}}(\eta)\neq0$ を主張している以上、
$\eta$ が零因子でないことは主張の側が要求している事柄であって、余計な仮定ではない。

## 形式化しなかったもの

* **$\eta=(\chi'/h)(\theta)$ が実際に零因子でないこと。** 本ファイルはそれを仮定として受け取る。
  $\rho$ が無平方であることから従うはずだが、その段は書いていない。
  **cycle 37 step 1 で、この仮定が本文の $\det G\neq0$ と同じ事柄であることは書いた**
  （`EulerDualBasisCommRing.norm_ne_zero_iff_mem_nonZeroDivisors` と
  `WStarPowerBasisInstance.mem_nonZeroDivisors_of_det_weightedGram_ne_zero`）。
  したがってこの仮定は余計ではない。残るのは無平方性から $\det G\neq0$ を出す段である。
* **$\det G=\pm N_{A/\mathbb{Q}}(\eta)$ の可約な場合**。`det_weightedGram` は `PowerBasis K L`
  （$L$ は体）で書かれており、本文の 2 つめの等式は既約な場合しか覆っていなかった。
  **cycle 37 step 1 で可換環版を書いた**（`EulerDualBasis.det_weightedGram`）。
* 本ファイルは $w^*$ の値を存在の形で述べる（適合基底の係数 $a$ が在って、その付値の最大値が最小元）。
  `Ideal.smithCoeffs` のような正準な代表を可約な場合に選ぶことはしていない
  （整域でないと mathlib の正準な取り方が無いため）。
  **これは本文の主張の残りではない。そう書く**——本文が述べているのは
  $w^*=\min\{j:\ p^j\eta^{-1}\in A_{(p)}\}$ という最小元の形であり、その形は
  `isLeast_isPLevel` で書いてある。正準な代表を選ぶことを本文は要求していない
  （cycle 46 step 1 に、この主張を完了と呼ぶにあたって読み直した）。
-/
import Mathlib
import IntegrableLattice.WStarIntegralDescent

namespace IntegrableLattice
namespace WStarReducible

open Finset Module

variable {ι S : Type*} [Fintype ι] [DecidableEq ι] [CommRing S]

/-! ## 1. $\eta$ 倍は単射である -/

/-- $\eta$ が零因子でなければ $\eta$ 倍は単射。 -/
theorem injective_mulLeft {η : S} (hη : η ∈ nonZeroDivisors S) :
    Function.Injective ((LinearMap.mulLeft ℤ η).restrictScalars ℤ) := by
  intro x y hxy
  simp only [LinearMap.restrictScalars_apply, LinearMap.mulLeft_apply] at hxy
  have h0 : (x - y) * η = 0 := by
    rw [sub_mul, mul_comm x η, mul_comm y η, hxy, sub_self]
  exact sub_eq_zero.mp ((mem_nonZeroDivisors_iff.mp hη).2 (x - y) h0)

/-! ## 2. $\eta S$ は $S$ と同じ階数をもつ -/

omit [DecidableEq ι] in
/-- $\eta$ が零因子でなければ $\eta S$ の階数は $S$ の階数に等しい。**整域は使わない。** -/
theorem finrank_span_eq (b : Basis ι ℤ S) {η : S} (hη : η ∈ nonZeroDivisors S) :
    Module.finrank ℤ ((Ideal.span {η}).restrictScalars ℤ) = Module.finrank ℤ S := by
  have hmod : Module.Finite ℤ S := Module.Finite.of_basis b
  rw [← range_mulLeft_eq_span (S := S) η]
  exact ((LinearEquiv.ofInjective _ (injective_mulLeft hη)).finrank_eq).symm

/-! ## 3. 可約でも通る $w^*$ -/

omit [DecidableEq ι] in
/-- **本ファイルの主定理その 1**。$S$ が整域でなくてよい形の $w^*$。

`WStarElementaryDivisors.isLeast_isPLevel_ideal` の $[IsDomain S]$ を落とし、
代わりに $\eta$ が零因子でないことだけを使う。 -/
theorem exists_isLeast_isPLevel_span {p : ℕ} (hp : p.Prime) (b : Basis ι ℤ S) {η : S}
    (hη : η ∈ nonZeroDivisors S) :
    ∃ a : ι → ℤ, IsLeast {j | IsPLevel p ((Ideal.span {η}).restrictScalars ℤ) j}
      (wStarOfCoeffs p a) := by
  classical
  obtain ⟨b', a, ab', hab⟩ :=
    Submodule.exists_smith_normal_form_of_rank_eq
      (N := (Ideal.span {η}).restrictScalars ℤ) b (finrank_span_eq b hη)
  refine ⟨a, isLeast_isPLevel b' _ ab' a hp hab ?_⟩
  -- 係数が $0$ なら基底ベクトルが $0$ になってしまう。
  intro i hai
  have hzero : (ab' i : S) = 0 := by rw [hab i, hai, zero_smul]
  exact ab'.ne_zero i (Subtype.ext hzero)

/-! ## 4. 降下（可約な場合） -/

/-- **本ファイルの主定理その 2（降下）**。可逆な整数行列 $C$ と $C\,G=M_\eta$ から、
$G$ の像の $p$ レベルの最小元が適合基底の係数の $p$ 進付値の最大値であることを出す。

`WStarIntegralDescent.isLeast_isPLevel_range_of_euler` の $[IsDomain S]$ を落とした形で、
仮定 $C\,G=M_\eta$ は `EulerDualBasisCommRing.eulerMatrix_mul_weightedGram` が、
$C$ の可逆性は `WStarIntegralDescent.isUnit_det_eulerHankel` が供給する。 -/
theorem exists_isLeast_isPLevel_range_of_euler {p : ℕ} (hp : p.Prime) (b : Basis ι ℤ S)
    {η : S} (hη : η ∈ nonZeroDivisors S) (G C : Matrix ι ι ℤ) (hC : IsUnit C.det)
    (hCG : C * G = LinearMap.toMatrix b b (LinearMap.mulLeft ℤ η)) :
    ∃ a : ι → ℤ, IsLeast {j | IsPLevel p (LinearMap.range (Matrix.toLin b b G)) j}
      (wStarOfCoeffs p a) := by
  classical
  obtain ⟨a, ha⟩ := exists_isLeast_isPLevel_span hp b hη
  refine ⟨a, ?_⟩
  -- $C$ が定める同型で像を移す。
  set u := Matrix.toLinearEquiv b C hC with hu
  have hcomp : Matrix.toLin b b (C * G)
      = ((u : S →ₗ[ℤ] S).comp (Matrix.toLin b b G)) := by
    rw [Matrix.toLin_mul b b b]
    rfl
  have hrange : LinearMap.range (Matrix.toLin b b (C * G))
      = (Ideal.span {η}).restrictScalars ℤ := by
    rw [hCG, Matrix.toLin_toMatrix]
    ext x
    simp only [LinearMap.mem_range, LinearMap.mulLeft_apply, Submodule.restrictScalars_mem,
      Ideal.mem_span_singleton']
    constructor
    · rintro ⟨y, rfl⟩; exact ⟨y, by ring⟩
    · rintro ⟨y, rfl⟩; exact ⟨y, by ring⟩
  have hiff : ∀ j : ℕ,
      IsPLevel p (LinearMap.range (Matrix.toLin b b G)) j
        ↔ IsPLevel p ((Ideal.span {η}).restrictScalars ℤ) j := by
    intro j
    rw [← hrange, hcomp]
    exact (isPLevel_range_comp u (Matrix.toLin b b G) p j).symm
  constructor
  · exact (hiff _).mpr ha.1
  · intro j hj
    exact ha.2 ((hiff j).mp hj)

end WStarReducible
end IntegrableLattice
