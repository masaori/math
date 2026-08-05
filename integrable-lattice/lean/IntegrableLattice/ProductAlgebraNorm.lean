/-
# 直積代数のノルムの分解（中国剰余の代数側）— cycle 43 step 1

対応する人手証明:

* 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の
  「さらに $\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda\neq0$ であり」の段のうち、
  **可約な $\rho$ の場合の $N(\mu)=\prod_\lambda m_\lambda$**
* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）が同じ量を
  $\eta$ のノルムの形で述べている段

## この step が何を埋めるか

cycle 42 step 1 は $\det G=N(\mu)\cdot\operatorname{disc}(\rho)$ まで書き、
$\rho$ が既約な場合だけ $N(\mu)=\prod_\lambda m_\lambda$ を出した。
可約な場合が残ったのは、$\mu$ が成分ごとに違う値 $a_i$ をとる元だからで、
そのノルムを因子ごとのノルムの積へ分けるには
$A_\mathbb{Q}\cong\prod_i K_i$ の分解と、直積代数のノルムの分解が要る。

**本ファイルが書いたのは後者である。**

## 2026-08-05 実測（走査の結果を、当ててみる前に書く）

* 中国剰余定理は環同型としては在る（`Ideal.quotientInfRingEquivPiQuotient`。
  参照しているファイルは 6 本）。**代数としての同型は無い。**
* **トレースの側は在る**——`Algebra.trace_prod_apply`
  （`Mathlib/RingTheory/Trace/Defs.lean` 152 行）が
  $\operatorname{Tr}_{R}(S\times T)$ を成分のトレースの和へ分けている。
* **ノルムの側は無い。** 同じ形の宣言（`Algebra.norm` を直積の成分のノルムの積へ分けるもの）は
  mathlib に 1 件も無く、`Algebra.norm` と `Pi` を結ぶ宣言も 0 件である。
* **`Matrix.det_blockDiagonal` は添字が全成分で共通の場合しか無い**
  （`Mathlib/LinearAlgebra/Matrix/Determinant/Basic.lean` 611 行）。
  成分ごとに次数が違う場合（`Matrix.blockDiagonal'`、`Mathlib/Data/Matrix/Block.lean` 570 行）の
  行列式の宣言は無い。**したがって行列の側から降りる道は素材が足りない。**

**そこで行列を経由しない道を取る。** $\det$ の側には二成分の直積の宣言が在るので
（`LinearMap.det_prodMap`、`Mathlib/LinearAlgebra/Determinant.lean` 386 行）、
二成分で書いてから成分数についての帰納法で伸ばす。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは有限自由加群の行列式と直積の分解だけで、
係数環は任意の可換環である（本文が当てる先は $\mathbb{Q}$ と $\mathbb{Z}$。どちらも可算）。

## 書いたこと

1. **二成分**（`norm_prod_apply`）。$N_{R}(x)=N_{R}(x_1)N_{R}(x_2)$。
   芯は 1 行で、$(S\times T)$ の $x$ 倍写像が成分ごとの $x_1$ 倍・$x_2$ 倍の直積であること。
2. **有限個の成分**（`norm_pi_fin`）。成分の個数についての帰納法で伸ばす。
3. **成分ごとに定数をとる元**（`norm_pi_fin_of_scalar`）。
   これが本文の $\mu$ の形で、$N(\mu)=\prod_i a_i^{\,r_i}$（$r_i$ は成分の階数）になる。
4. **中国剰余定理の代数版**（`quotientInfAlgEquivPiQuotient`）。
   ノルムを移すには代数の同型が要る（`Algebra.norm_eq_of_algEquiv`）ので、環同型のままでは渡せない。

## 形式化しなかったもの

* **本文の $\rho$ の既約因子分解を、この形の互いに素なイデアルの族として与える段。**
  $\mathbb{Q}[x]/(\rho)$ に当てるには $(\,f_i\,)$ が対ごとに互いに素であることが要り、
  それは $f_i$ が相異なる既約多項式であることから出るが、本ファイルはその配線を書いていない。
  **段の外側ではなく、この段の内側に残っている。そう書く。**
-/
import Mathlib

namespace IntegrableLattice
namespace ProductAlgebraNorm

open Module

/-! ## 段 1: 二成分の直積のノルム

トレースの側（`Algebra.trace_prod_apply`）と同じ形である。
$x$ 倍写像が成分ごとの $x_1$ 倍・$x_2$ 倍の直積であることだけを見て、
行列式が直積について積になること（`LinearMap.det_prodMap`）へ渡す。 -/

section Binary

variable {R S T : Type*} [CommRing R] [CommRing S] [CommRing T]
variable [Algebra R S] [Algebra R T]

/-- **$x$ 倍写像は成分ごとの $x_1$ 倍・$x_2$ 倍の直積である。**

直積環の積が成分ごとであること（`Prod.mul_def`）だけの内容である。 -/
theorem lmul_prod_eq_prodMap (x : S × T) :
    Algebra.lmul R (S × T) x
      = LinearMap.prodMap (Algebra.lmul R S x.1) (Algebra.lmul R T x.2) :=
  LinearMap.ext fun _ => rfl

/-- **直積代数のノルムは成分のノルムの積である。**

$N_{R}(S\times T)(x)=N_{R}(S)(x_1)\cdot N_{R}(T)(x_2)$。

mathlib はトレースの側だけを持っている（`Algebra.trace_prod_apply`）。
**ノルムの側は無いので書いた**（2026-08-05 実測）。 -/
theorem norm_prod_apply [Module.Free R S] [Module.Finite R S]
    [Module.Free R T] [Module.Finite R T] (x : S × T) :
    Algebra.norm R x = Algebra.norm R x.1 * Algebra.norm R x.2 := by
  rw [Algebra.norm_apply, Algebra.norm_apply, Algebra.norm_apply, lmul_prod_eq_prodMap,
    LinearMap.det_prodMap]

end Binary

/-! ## 段 2: 有限個の成分の直積のノルム

成分の個数についての帰納法で段 1 を伸ばす。
成分の型が個数に依存するので、`Fin (n+1)` 上の族を
「先頭の成分」と「残りの族」へ割るところが唯一の手数である
（`Fin.consEquiv` の代数版を組む）。 -/

section Pi

variable {R : Type*} [CommRing R]

/-- $\prod_{i<n+1}A_i\cong A_0\times\prod_{i<n}A_{i+1}$ を $R$ 代数の同型として与える。

中身は成分の並べ替えだけで、環の構造も代数の構造も成分ごとに定義されている。 -/
@[simps!]
def piFinSuccAlgEquiv (n : ℕ) (A : Fin (n + 1) → Type*)
    [∀ i, CommRing (A i)] [∀ i, Algebra R (A i)] :
    (∀ i, A i) ≃ₐ[R] A 0 × (∀ i : Fin n, A i.succ) where
  toFun x := (x 0, fun i => x i.succ)
  invFun y := Fin.cases y.1 y.2
  left_inv x := by funext i; induction i using Fin.cases <;> simp
  right_inv y := by ext <;> simp
  map_mul' _ _ := rfl
  map_add' _ _ := rfl
  commutes' _ := rfl

/-- **有限個の成分の直積のノルムは、成分のノルムの積である。**

$N_{R}\bigl(\prod_i A_i\bigr)(x)=\prod_i N_{R}(A_i)(x_i)$。

証明は成分の個数 $n$ についての帰納法で、各段で段 1（二成分）を使う。
**要る仮定は各成分が有限自由であることだけで、体も整域も分離性も使わない。** -/
theorem norm_pi_fin (n : ℕ) (A : Fin n → Type*)
    [∀ i, CommRing (A i)] [∀ i, Algebra R (A i)]
    [∀ i, Module.Free R (A i)] [∀ i, Module.Finite R (A i)] (x : ∀ i, A i) :
    Algebra.norm R x = ∏ i, Algebra.norm R (x i) := by
  induction n with
  | zero =>
    -- 成分が無いとき、直積は自明な環で、両辺とも $1$ である
    have : Subsingleton (∀ i : Fin 0, A i) := ⟨fun _ _ => funext fun i => i.elim0⟩
    rw [Algebra.norm_apply, LinearMap.det_eq_one_of_subsingleton]
    simp
  | succ n ih =>
    have h1 : ((piFinSuccAlgEquiv (R := R) n A) x).1 = x 0 := rfl
    have h2 : ((piFinSuccAlgEquiv (R := R) n A) x).2 = fun i : Fin n => x i.succ := rfl
    rw [← Algebra.norm_eq_of_algEquiv (piFinSuccAlgEquiv (R := R) n A) x,
      norm_prod_apply, h1, h2, ih (fun i => A i.succ) (fun i => x i.succ),
      Fin.prod_univ_succ]

/-- **成分ごとに定数をとる元のノルムは、定数の冪の積である。**

$x_i=a_i\cdot 1$ のとき $N_{R}(x)=\prod_i a_i^{\,r_i}$（$r_i$ は成分 $A_i$ の階数）。

**これが本文の $\mu$ の形である**——$\mu$ は成分 $K_i$ の上で重複度 $a_i$ をとる元なので、
$N(\mu)=\prod_i a_i^{\deg f_i}$ になり、$\deg f_i$ が成分の根の個数なので
右辺はちょうど本文の $\prod_\lambda m_\lambda$ である。 -/
theorem norm_pi_fin_of_scalar (n : ℕ) (A : Fin n → Type*)
    [∀ i, CommRing (A i)] [∀ i, Algebra R (A i)]
    [∀ i, Module.Free R (A i)] [∀ i, Module.Finite R (A i)]
    [∀ i, Nontrivial (A i)] (a : Fin n → R) :
    Algebra.norm R (fun i => algebraMap R (A i) (a i))
      = ∏ i, a i ^ Module.finrank R (A i) := by
  rw [norm_pi_fin]
  exact Finset.prod_congr rfl fun i _ => Algebra.norm_algebraMap (a i)

end Pi

/-! ## 段 4: 中国剰余定理を代数の同型として述べる

mathlib が持っているのは環同型（`Ideal.quotientInfRingEquivPiQuotient`）だけで、
係数環を固定した代数の同型は無い（2026-08-05 実測）。
ノルムは代数の同型でしか移せない（`Algebra.norm_eq_of_algEquiv`）ので、ここを埋める。 -/

section CRT

variable {R : Type*} [CommRing R] {S : Type*} [CommRing S] [Algebra S R]
variable {ι : Type*} [Finite ι]

/-- **中国剰余定理の代数版。**

互いに素なイデアルの族 $f$ について $R/\bigcap_i f_i\cong\prod_i R/f_i$ が
$S$ 代数の同型として成り立つ。

環同型としては mathlib に在る。**代数の同型として述べる宣言が無かったので書いた。**
中身は環同型に「係数の像が一致する」ことを添えるだけで、
それは両辺とも `Ideal.Quotient.mk` で定義されているので $\mathrm{rfl}$ である。 -/
noncomputable def quotientInfAlgEquivPiQuotient (f : ι → Ideal R)
    (hf : Pairwise (Function.onFun IsCoprime f)) :
    (R ⧸ ⨅ i, f i) ≃ₐ[S] ∀ i, R ⧸ f i :=
  { Ideal.quotientInfRingEquivPiQuotient f hf with
    commutes' := fun _ => rfl }

end CRT

end ProductAlgebraNorm
end IntegrableLattice
