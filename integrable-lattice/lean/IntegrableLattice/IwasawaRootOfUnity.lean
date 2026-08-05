/-
# Monsky の残りのうち「$\zeta-1$ が極大イデアルに属すること」— cycle 44 step 4

対応する外部定理: P. Monsky, *On p-adic power series*, Math. Ann. 255(2), 217–227 (1981), Theorem 5.6。
台帳のエントリは `structured-latex/tools/external-theorem-coverage.ts` の
「Monsky の p 進冪級数の定理」である。

## この step が何を埋めるか

cycle 43 step 4（`IwasawaEvaluation.lean`）は評価写像を構成したが、**評価点を
「イデアルに属する元」として受け取った**まま終わり、残りを 2 つと記録した。

1. $\sum_{\zeta}v(\varphi_\zeta(f))=\lambda n+O(1)$ の側（Theorem 5.6 に残る最後の中身）。
2. **$1$ の $p^n$ 乗根 $\zeta$ について $\zeta-1$ が極大イデアルに属することの数論側の同定。**

**本ファイルは 2 を書く。1 は書いていない**（下の「形式化しなかったもの」を見よ）。

## 中身は Frobenius ひとつである

剰余体の標数が $p$ なら、そこでは $(x-1)^{p^n}=x^{p^n}-1$ である（Frobenius）。
$\zeta^{p^n}=1$ を入れると右辺が $0$ になり、剰余体は体だから $\bar\zeta-1=0$、
すなわち $\zeta-1$ は極大イデアルに入る。

**cycle 44 step 2（`PropTResidueRoot.lean`）と対になっている。そう書く**——
あちらは**位数が剰余標数と素な**根が剰余体でも位数を保つこと、
こちらは**位数が剰余標数の冪である**根が剰余体で $1$ に潰れることである。
同じ「剰余体へ落としたときに根がどうなるか」の、互いに補い合う 2 つの場合である。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは可換環の演算と剰余体への還元だけである。
$p$ と $n$ は $\mathbb{N}$ に住む。舞台となる環（$\mathbb{Z}_p$ など）は非可算でありうるが、
`IwasawaEvaluation.lean` と同じく**濃度は主張に入らない。**

## 書いたこと（2 段）

1. **$1$ の $p^n$ 乗根は剰余体で $1$ に潰れる**（`sub_one_mem_maximalIdeal_of_pow_eq_one`）。
2. **したがって評価点として使える**（`hasEval_sub_one_of_pow_eq_one`）。
   cycle 43 step 4 の評価写像が要求している `HasEval` が、この元について成り立つ。
   **本文が $\varphi_\zeta$ と書いている評価はこれである。**

## 形式化しなかったもの

* **$\sum_{\zeta}v(\varphi_\zeta(f))=\lambda n+O(1)$ の側。**
  distinguished 多項式の $1$ の冪根での値の付値を数える段であり、
  これが Monsky の Theorem 5.6 に残る最後の中身である。**書いていない。そう書く。**
  **2026-08-05 に、この段が要求する材料を測った**——要るのは
  「$f$ が distinguished なら $v(f(a))=(\deg f)\cdot v(a)$ が $v(a)$ の小さいところで成り立つ」
  という Newton 多角形の評価であり、それには**$f$ の根を取り出す拡大**（$v$ を延長した体）が要る。
  **2026-08-05 実測**（mathlib `520045ab14` の 8264 ファイル）: `Polynomial.IsDistinguishedAt` は
  2 ファイルに在るが（`WeierstrassPreparation.lean` と `Eisenstein/Distinguished.lean`）、
  後者に `Valuation` は 1 度も現れない。**Newton 多角形（`NewtonPolygon`）は 1 ファイルも無い。**
  **したがってここは配線ではなく素材の側である。そう書く。**
-/
import Mathlib
import IntegrableLattice.IwasawaEvaluation

namespace IntegrableLattice
namespace IwasawaRootOfUnity

open IsLocalRing PowerSeries

/-! ## 段 1: $1$ の $p^n$ 乗根は剰余体で $1$ に潰れる -/

section Residue

variable {R : Type*} [CommRing R] [IsLocalRing R] {p : ℕ}

/-- **剰余体の標数が $p$ なら、$1$ の $p^n$ 乗根 $\zeta$ について $\zeta-1$ は極大イデアルに属する。**

剰余体では Frobenius により $(\bar\zeta-1)^{p^n}=\bar\zeta^{p^n}-1=0$ であり、
体には冪零元が無いので $\bar\zeta=1$ である。

**`PropTResidueRoot.isPrimitiveRoot_residue` と対になっている**——
あちらは位数が剰余標数と素な場合（位数が保たれる）、こちらは位数が剰余標数の冪の場合
（$1$ に潰れる）である。 -/
theorem sub_one_mem_maximalIdeal_of_pow_eq_one [ExpChar (ResidueField R) p]
    {ζ : R} {n : ℕ} (h : ζ ^ p ^ n = 1) : ζ - 1 ∈ maximalIdeal R := by
  rw [← residue_eq_zero_iff, map_sub, map_one]
  have hzero : (residue R ζ - 1) ^ p ^ n = 0 := by
    rw [sub_pow_expChar_pow, ← map_pow, h, map_one, one_pow, sub_self]
  exact pow_eq_zero_iff (pow_ne_zero n (expChar_ne_zero (ResidueField R) p)) |>.mp hzero

end Residue

/-! ## 段 2: したがって評価点として使える

cycle 43 step 4 の評価写像は評価点に `HasEval`（位相的冪零性）を要求する。
極大イデアルに属する元はこれを満たす（`IwasawaEvaluation.hasEval_of_mem`）。 -/

section Eval

variable {R : Type*} [CommRing R] [IsLocalRing R] [WithIdeal R] {p : ℕ}

/-- **$1$ の $p^n$ 乗根 $\zeta$ について、$\zeta-1$ は冪級数の評価点として使える。**

**本文が $\varphi_\zeta$ と書いている評価はこれである。**
位相を与えるイデアルが極大イデアルを含んでいることだけを仮定する
（$\mathbb{Z}_p$ ではどちらも $(p)$ である）。 -/
theorem hasEval_sub_one_of_pow_eq_one [ExpChar (ResidueField R) p]
    (hI : maximalIdeal R ≤ WithIdeal.i (R := R)) {ζ : R} {n : ℕ}
    (h : ζ ^ p ^ n = 1) : HasEval (ζ - 1) :=
  IwasawaEvaluation.hasEval_of_mem (hI (sub_one_mem_maximalIdeal_of_pow_eq_one h))

end Eval

end IwasawaRootOfUnity
end IntegrableLattice
