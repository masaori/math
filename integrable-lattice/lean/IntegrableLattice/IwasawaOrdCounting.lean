/-
# Monsky の $\mathrm{ord}$ の漸近の第 3 段（$1$ の冪根での評価と、その積の付値を数える段）— cycle 42 step 5

対応する外部定理: P. Monsky, *On p-adic power series*, Math. Ann. 255(2), 217–227 (1981), Theorem 5.6。
台帳のエントリは `structured-latex/tools/external-theorem-coverage.ts` の
「Monsky の p 進冪級数の定理」である。

## これまでの段と、この段が置かれる位置

| 段 | 内容 | どこ |
|---|---|---|
| 1 | $\mu$ 不変量の存在と、Weierstrass 準備定理が $\mathbb{Z}_p[[X]]$ へ当たること | `IwasawaMuInvariant.lean`（cycle 40 step 4） |
| 2 | 岩澤分解 $g=p^{\mu}fh$ と $\lambda=\deg f$ の同定 | `IwasawaDecomposition.lean`（cycle 41 step 3） |
| 3 | **$1$ の冪根での評価と、その積の付値を数える段** | **本ファイル**（cycle 42 step 5） |

cycle 41 総括の焦点 4 は「次は $1$ の冪根での評価と、その積の付値を数える段である」だった。

## 着手して測ったこと（先に書く）

**この段は 2 つに割れる。書けたのは片方である。そう書く。**

1. **評価を環準同型として受け取れば、付値は分解に沿って足し算になる。**
   $g=p^{\mu}fh$ で $h$ が単元なら、任意の評価 $\varphi$ について
   $v(\varphi(g))=\mu+v(\varphi(f))$ である（$\varphi(p)$ を素元にとる）。
   **本ファイルが書いたのはこちらである。**
2. **その評価が実際に存在すること**——$\mathbb{Z}_p[[X]]$ の元を $\zeta-1$（$\zeta$ は $1$ の $p^n$ 乗根）で
   評価する写像を作る段。**冪級数の収束が要るので、代数だけでは出ない。**
   **書いていない。そう書く。**

**2 を仮定として型に出す形は、`PropT.lean` の段 5（`v2_tau_eq_of_root_valuations`）や
本サイクル step 2 の舞台の受け取り方と同じである。**
何が外部依存かが型に現れるので、どこまでが閉じているかが機械から読める。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。付値は $\mathbb{N}$ に値をとり（`addVal` ではなく
自然数値の重複度で数える）、使うのは整除の判定と有限和だけである。
$\mathbb{Z}_p$ は非可算だが、cycle 41 step 3 と同じく、
**使うのは整除の判定と付値が自然数値であることだけ**であって $\mathbb{Z}_p$ の濃度は主張に入らない。

## 書いたこと（2 段）

1. **分解に沿った付値の足し算**（`emultiplicity_eval_iwasawa`）。
   評価 $\varphi$ を環準同型として受け取り、$\varphi(h)$ が単元であること・$\varphi(p)$ が素元であることを仮定する。
   単元の付値は $0$ なので（`emultiplicity_of_unit_right`）、
   $v(\varphi(g))=\mu+v(\varphi(f))$ になる。
2. **積の付値を数える**（`sum_emultiplicity_eval_iwasawa`）。
   本文が要求している形——$1$ の冪根を走る有限集合 $s$ について
   $\sum_{\zeta\in s}v(\varphi_\zeta(g))=|s|\,\mu+\sum_{\zeta\in s}v(\varphi_\zeta(f))$。
   **$\mu$ の側が $|s|$ に比例し、$\lambda$ の側が $f$ の評価の和に落ちる**という、
   Monsky の漸近の骨格そのものである。

## 形式化しなかったもの

* **評価写像そのものの構成（$\mathbb{Z}_p[[X]]$ の元を $\zeta-1$ で評価すること）。**
  冪級数の収束が要る。**代数だけでは出ない段であり、書いていない。**
  本ファイルは評価を環準同型として仮定に受け取っている。
* **$\sum_{\zeta}v(\varphi_\zeta(f))=\lambda n+O(1)$ の側。**
  distinguished 多項式の $1$ の冪根での値の付値を数える段である。
  **段 3 の残り半分であり、書いていない。**
-/
import Mathlib
import IntegrableLattice.IwasawaDecomposition

namespace IntegrableLattice
namespace IwasawaOrdCounting

open Finset

variable {R : Type*} [CommRing R] {S : Type*} [CommRing S]

/-- **岩澤分解に沿って付値が足し算になる。**

$g=\pi^{\mu}\,g_1$ と $g_1=f\,h$（$h$ は単元へ写る）のとき、
評価 $\varphi$ の像の付値は $\pi$ の側と $f$ の側の和になる。
**単元の付値が $0$ である**というだけの内容である。 -/
theorem emultiplicity_eval_iwasawa [IsDomain S] (φ : R →+* S) {g g₁ : R} {π : R} {μ : ℕ}
    {f h : R} (hg : g = π ^ μ * g₁) (hg₁ : g₁ = f * h) (hu : IsUnit (φ h))
    (hp : Prime (φ π)) :
    emultiplicity (φ π) (φ g) = (μ : ℕ∞) + emultiplicity (φ π) (φ f) := by
  subst hg
  subst hg₁
  obtain ⟨u, hu⟩ := hu
  rw [map_mul, map_mul, map_pow, ← hu, ← mul_assoc,
    emultiplicity_mul hp, emultiplicity_mul hp,
    emultiplicity_pow_self hp.ne_zero hp.not_unit,
    emultiplicity_of_unit_right hp.not_unit u, add_zero]

/-- **積の付値を数える段**（本文が要求している形）。

$1$ の冪根を走る有限集合 $s$ について、$\mu$ の側は $|s|$ に比例し、
$\lambda$ の側は $f$ の評価の和に落ちる。**Monsky の漸近の骨格そのものである。**

評価の族 $(\varphi_\zeta)$ とその素元性は仮定として受け取っている
（$\mathbb{Z}_p[[X]]$ の元を $\zeta-1$ で評価する写像の構成は冪級数の収束を要するので、
代数だけでは出ない。ヘッダの「形式化しなかったもの」を見よ）。 -/
theorem sum_emultiplicity_eval_iwasawa {ι : Type*} [IsDomain S]
    (s : Finset ι) (φ : ι → (R →+* S)) {g g₁ : R} {π : R} {μ : ℕ} {f h : R}
    (hg : g = π ^ μ * g₁) (hg₁ : g₁ = f * h)
    (hu : ∀ i ∈ s, IsUnit (φ i h)) (hp : ∀ i ∈ s, Prime (φ i π)) :
    ∑ i ∈ s, emultiplicity (φ i π) (φ i g)
      = s.card • (μ : ℕ∞) + ∑ i ∈ s, emultiplicity (φ i π) (φ i f) := by
  classical
  have hterm : ∀ i ∈ s, emultiplicity (φ i π) (φ i g)
      = (μ : ℕ∞) + emultiplicity (φ i π) (φ i f) := fun i hi =>
    emultiplicity_eval_iwasawa (φ i) hg hg₁ (hu i hi) (hp i hi)
  rw [Finset.sum_congr rfl hterm, Finset.sum_add_distrib, Finset.sum_const]

end IwasawaOrdCounting
end IntegrableLattice
