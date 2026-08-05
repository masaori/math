/-
# Monsky の $\mathrm{ord}$ の漸近の第 3 段の残り半分（評価写像の構成）— cycle 43 step 4

対応する外部定理: P. Monsky, *On p-adic power series*, Math. Ann. 255(2), 217–227 (1981), Theorem 5.6。
台帳のエントリは `structured-latex/tools/external-theorem-coverage.ts` の
「Monsky の p 進冪級数の定理」である。

## この step が何を埋めるか

cycle 42 step 5（`IwasawaOrdCounting.lean`）は、$1$ の冪根での評価を
**環準同型として仮定に受け取った形**で付値の足し算を書き、
「評価写像そのものの構成は冪級数の収束が要るので代数だけでは出ない。書いていない」と記録した。

**本ファイルはその構成を入れる。**

## $\mathbb{R}$ 脱出かどうかの判定（cycle 42 総括の焦点 4 が問うていたもの）

**$\mathbb{R}$ 脱出ではない。そう書く。**

冪級数の評価に mathlib が要求している収束は
`PowerSeries.HasEval`（＝`IsTopologicallyNilpotent`。$a^n\to0$）であり、
**位相は線形位相**（`IsLinearTopology`。$0$ の近傍が両側イデアルの基本系をなす）である。
アルキメデス的な順序も絶対値も距離も使わない。$p$ 進の位相はまさにこの形（イデアル進位相）なので、
**この段は $\mathbb{R}$ へ出ない。**

これは cycle 42 総括が「$p$ 進の収束はアルキメデス的ではないので $\mathbb{R}$ 脱出にならない可能性がある」と
書いていた点の答えである。**実測で決まった**——`Mathlib/RingTheory/PowerSeries/Evaluation.lean` の
`eval₂Hom`（160 行）が要求している型クラスは
`Continuous φ` / `HasEval a` / `CompleteSpace S` / `IsLinearTopology S S` であり、
$\mathbb{R}$ も順序体も現れない。

## 2026-08-05 実測（台帳の記録の射程を狭める）

台帳は「評価写像の構成には**冪級数の収束が要り、代数だけでは出ない**」と書いていた。
**収束が要るという側は正しい。「書けない」という側は誤りである。そう書く**——
mathlib は評価写像を持っている（`PowerSeries.eval₂Hom`）。
cycle 42 step 5 が 0 件と読んだのは、探した語が「収束」の側だったためである。
**cycle 40・41 が見つけた「定理の名前で引くと道具が見えない」の、
概念の名前の側の版である。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない（上の判定のとおり）。
係数環はイデアル進位相を入れた任意の可換環で、本文が当てる先は $\mathbb{Z}_p$ である。
$\mathbb{Z}_p$ は非可算だが、使うのは整除の判定と付値が自然数値であることだけで、
濃度は主張に入らない（cycle 41 step 3・cycle 42 step 5 と同じ扱い）。

## 書いたこと

1. **イデアルに属する元は評価点として使える**（`hasEval_of_mem`）。
   イデアル進位相では $a\in I$ なら $a^n\to0$ である。
   **本文の $\zeta-1$ がこの形である**（$\zeta$ は $1$ の $p$ 冪乗根なので $\zeta-1$ は極大イデアルに入る）。
2. **評価写像そのもの**（`evalHom`）。$a$ を評価点とする環準同型 $R[[X]]\to R$。
3. **$X$ と定数の行き先**（`evalHom_X` / `evalHom_C`）。
   これで「評価」と呼んでよいことが確かめられる。
4. **cycle 42 step 5 の付値の足し算に、この評価を実際に渡した形**
   （`emultiplicity_evalHom_iwasawa`）。仮定として受け取っていた環準同型が、構成したもので埋まる。

## 形式化しなかったもの

* **$\sum_{\zeta}v(\varphi_\zeta(f))=\lambda n+O(1)$ の側。**
  distinguished 多項式の $1$ の冪根での値の付値を数える段であり、
  これが Monsky の Theorem 5.6 に残る最後の中身である。**書いていない。そう書く。**
* **$\zeta-1$ が極大イデアルに属することの数論側の同定。**
  本ファイルは評価点をイデアルの元として受け取っている。
  $1$ の $p^n$ 乗根 $\zeta$ について $\zeta-1$ がそこに入ることは、
  剰余体の標数が $p$ であることから出るが、その配線は書いていない。
-/
import Mathlib
import IntegrableLattice.IwasawaOrdCounting

namespace IntegrableLattice
namespace IwasawaEvaluation

open PowerSeries

/-! ## 段 1–3: 評価写像の構成

イデアル進位相（`WithIdeal`）を入れた完備な可換環の上で書く。
$p$ 進の設定はこの形であり、**アルキメデス的な収束は 1 度も使わない。** -/

section Evaluation

variable {R : Type*} [CommRing R] [WithIdeal R]

/-- **イデアルに属する元は評価点として使える。**

イデアル進位相では $a\in I$ から $a^n\to0$ が出る（`WithIdeal.isTopologicallyNilpotent_of_mem`）。
**本文の $\zeta-1$ がこの形である。** -/
theorem hasEval_of_mem {a : R} (ha : a ∈ WithIdeal.i (R := R)) : HasEval a :=
  WithIdeal.isTopologicallyNilpotent_of_mem ha

variable [T2Space R] [CompleteSpace R]

/-- **評価写像 $R[[X]]\to R$。**

$a$ を評価点とする環準同型である。`PowerSeries.eval₂Hom` に恒等写像を渡す。

**要求している収束は線形位相での位相的冪零性だけで、$\mathbb{R}$ へは出ない。** -/
noncomputable def evalHom {a : R} (ha : HasEval a) : PowerSeries R →+* R :=
  eval₂Hom (φ := RingHom.id R) continuous_id ha

@[simp]
theorem evalHom_X {a : R} (ha : HasEval a) : evalHom ha X = a := by
  simp [evalHom, coe_eval₂Hom]

@[simp]
theorem evalHom_C {a : R} (ha : HasEval a) (r : R) : evalHom ha (C r) = r := by
  simp [evalHom, coe_eval₂Hom]

end Evaluation

/-! ## 段 4: cycle 42 step 5 の付値の足し算へ、構成した評価を渡す -/

section Counting

variable {R : Type*} [CommRing R] [WithIdeal R] [T2Space R] [CompleteSpace R]

/-- **cycle 42 step 5 の付値の足し算を、実際の評価写像について述べたもの。**

$g=p^{\mu}fh$（岩澤分解）を評価点 $a$ で評価すると
$v(\varphi(g))=\mu+v(\varphi(f))$ になる。
`IwasawaOrdCounting.emultiplicity_eval_iwasawa` は評価を仮定として受け取っていたが、
段 2 でそれが構成できるので**仮定が埋まる。** -/
theorem emultiplicity_evalHom_iwasawa [IsDomain R] {a : R} (ha : HasEval a)
    {g g₁ π f h : PowerSeries R} {μ : ℕ}
    (hg : g = π ^ μ * g₁) (hg₁ : g₁ = f * h)
    (hu : IsUnit (evalHom ha h)) (hp : Prime (evalHom ha π)) :
    emultiplicity (evalHom ha π) (evalHom ha g)
      = (μ : ℕ∞) + emultiplicity (evalHom ha π) (evalHom ha f) :=
  IwasawaOrdCounting.emultiplicity_eval_iwasawa (evalHom ha) hg hg₁ hu hp

end Counting

end IwasawaEvaluation
end IntegrableLattice
