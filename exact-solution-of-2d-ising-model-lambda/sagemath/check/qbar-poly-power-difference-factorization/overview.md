# SageMath Check: 不定元と定数の冪の差は、その 2 元の差を因子に持つ

## 対象

**対象ラベル**: `claim_qbar_poly_power_difference_factorization`・
`def_qbar_polynomial_ring`・`def_qbar_constant_embedding`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 2 件と主張 1 件
- 併せて引く定義: `def_algebraic_numbers`（代数的数の全体 $\overline{\mathbb{Q}}$）

### 何を確定させるための検証か

$\mu_n$ がちょうど $n$ 個の元を持つことを示すには「$z^{n}-1$ の根が高々 $n$ 個であること」が要り、
その論法は因数定理（根 $w$ を持つ多項式が $(t-\widehat{w})$ を因子に持つこと）を使う。
本検証は、その一歩手前である $\overline{\mathbb{Q}}[t]$ の中での因数分解
$(t-\widehat{w})K_{n}(w)=t^{\,n}-\widehat{w}^{\,n}$ だけを見る。
**因数定理そのものも、根の個数の上界も、$\mu_n$ の元の個数もここでは扱わない。**

確かめるのは次の 7 である。

0. **定数として送る写像**。$\widehat{a}$ の係数（$\mathrm{ac}_0=a$、他は $0$）と、
   和・積・単位元・零元を保つこと。
1. **準備の段**。任意の $k$ について $t\,t^{k}=t^{k}t$（冪の約束が与えるのは
   $t^{k+1}=t^{k}t$ の向きだけなので、一歩の第 8 の等号にはこれが要る）。
2. **出発点**。$K_{0}(w)=0$ と $(t-\widehat{w})K_{0}(w)=t^{0}-\widehat{w}^{\,0}=0$。
3. **一歩**。鎖の第 1 から第 10 の等号を、それぞれ別に確かめる
   （$K_{n+1}$ の約束・分配則・積の結合則・帰納法の仮定・分配則・冪の約束
   $\widehat{w}^{\,n+1}=\widehat{w}^{\,n}\widehat{w}$・分配則・準備の等式・冪の約束
   $t^{\,n+1}=t^{\,n}t$・$t$ と $\widehat{w}$ の可換性）。
4. **主張そのもの**。$(t-\widehat{w})K_{n}(w)=t^{\,n}-\widehat{w}^{\,n}$。
5. **$\overline{\mathbb{Q}}$ の 2 元についての版との一致**。$t$ に値 $z$ を入れると
   $K_{n}(w)$ の値が $H_{n}(z,w)$（`claim_qbar_power_difference_factorization`）に一致すること。
   すなわち住む環だけが違う同じ鎖であることの裏取りである。
6. **使い道**。$t^{\,n}-\widehat{w}^{\,n}$ が $t-\widehat{w}$ で割り切れ、商が $K_{n}(w)$ であること。
   これが因数定理でくくり出す部分にあたる。

冪は $f^{0}=1$, $f^{j+1}=f^{j}f$ の反復で作り、`f**k` へ委ねない（本文の約束と 1 対 1 にするため）。
$K_n$ も本文の約束 $K_{n+1}=K_{n}\widehat{w}+t^{\,n}$ の反復で作る。
計算はすべて厳密（`PolynomialRing(QQbar)`）で、浮動小数点は使わない。

## 実行

```sh
sage sagemath/check/qbar-poly-power-difference-factorization/check.sage
```

## 結果

**2026-08-11 実行。すべて通過。**

```
=== claim_qbar_poly_power_difference_factorization ===
0. 定数として送る写像（â の性質）
   通過
1. 準備（t t^k = t^k t）
   通過（k = 0,...,6）
2. 出発点（(t-ŵ) K_0(w) = t^0 - ŵ^0 = 0）
   通過
3. 一歩（鎖の各段）
   通過（n = 0,...,6）
4. 主張そのもの（(t-ŵ) K_n(w) = t^n - ŵ^n）
   通過（n = 0,...,6）
5. Qbar の 2 元についての版との一致（t に値を入れる）
   通過（n = 0,...,4）
6. 使い道（t^n - ŵ^n が t - ŵ で割り切れる）
   通過（n = 0,...,6）
すべて通過
```

係数の標本は $0$・$1$・$-1$・$2$・$1/3$・$\zeta_3$・$\zeta_5^{2}$・$\sqrt2$・$\sqrt{-1}$ の 9 個で、
$w$ はこの 9 個すべて（一致の確認では $(z,w)$ の 81 通りすべて）である。

## Lean

**具体版と導出の 2 本を置いた（2026-08-11）。** 必要十分版は
$\overline{\mathbb{Q}}$ の 2 元についての版と共有する
（`Ising2DLambda.NecSuf.AlgebraicEigenvalue.power_difference_factorization_necSuf`）。
すなわちこの多項式版は、`R := Polynomial Qbar`・`z := X`・`w := C w` と取った特殊化であり、
**人手証明で同じ鎖を 2 度書いているのは、人手証明を一般の環へ持ち上げない規則によるものである**
ことが導出（`qbarPolyPowerDifferenceFactorization_from_necSuf`）で示されている。
`lake build` と sorry 検査（定理 573 件）が通る。
