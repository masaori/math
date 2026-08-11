# SageMath Check: 不定元の冪の係数は、番号が指数と一致するときだけ単位元である

## 対象

**対象ラベル**: `claim_qbar_poly_indeterminate_power_coefficient`・
`def_qbar_polynomial_ring`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて引く定義: `def_algebraic_numbers`（代数的数の全体 $\overline{\mathbb{Q}}$）

### 何を確定させるための検証か

因数定理（根 $w$ を持つ多項式が $(t-\widehat{w})$ を因子に持つこと）を示すには、
多項式 $f$ を係数を用いた単項式の有限和 $\sum_k\widehat{\mathrm{ac}_k(f)}\,t^{\,k}$ へ分解し、
各項へ $(t-\widehat{w})K_{k}(w)=t^{\,k}-\widehat{w}^{\,k}$
（`claim_qbar_poly_power_difference_factorization`）を当てる必要がある。
本検証はその足場である $\mathrm{ac}_j(t^{\,k})$ の値だけを見る。
**単項式の有限和への分解そのものも、代入の定義も、因数定理も、
根の個数の上界も、$\mu_n$ の元の個数もここでは扱わない。**

確かめるのは次の 5 である。

0. **定義に置いた約束そのもの**。$\mathrm{ac}_1(t)=1$、$j\ne1$ で $\mathrm{ac}_j(t)=0$、
   単位元 $1$ の係数、および係数がすべて等しい 2 つの多項式が等しいこと。
1. **出発点**（$k=0$）。$t^{0}=1$ と $\mathrm{ac}_j(1)$ の値。
2. **一歩**。場合 1（$j=0$）の 5 段の鎖と、場合 2（$j=j'+1$）の 10 段の鎖を、
   それぞれ別に確かめる（冪の約束・積の係数の定義・$i=j'$ の項の取り出し・
   $i\ne j'$ の項が零であること・零元との積と有限和・$\mathrm{ac}_1(t)=1$ と積の単位元・
   帰納法の仮定・後者の単射性）。
3. **主張そのもの**。$\mathrm{ac}_j(t^{\,k})$ が $j=k$ のとき $1$、そうでなければ $0$ であること。
4. **使い道**。係数を用いた単項式の有限和 $\sum_j \widehat{\mathrm{ac}_j(f)}\,t^{\,j}$ が
   もとの多項式 $f$ に戻ること（次の段で書く分解の裏取り）。

冪は $f^{0}=1$, $f^{j+1}=f^{j}f$ の反復で作り、`f**k` へ委ねない（本文の約束と 1 対 1 にするため）。
計算はすべて厳密（`PolynomialRing(QQbar)`）で、浮動小数点は使わない。

## 実行

```sh
sage sagemath/check/qbar-poly-indeterminate-power-coefficient/check.sage
```

## 結果

**2026-08-11 実行: すべて通過。**

```
0. 定義の約束（t と 1 の係数、係数による相等）
   通過（j = 0,...,8）
1. 出発点（k = 0）
   通過（j = 0,...,8）
2. 一歩（鎖の各段）
   通過（k = 0,...,6、j' = 0,...,6）
3. 主張そのもの（ac_j(t^k) は j = k のとき 1、そうでなければ 0）
   通過（k = 0,...,6、j = 0,...,8）
4. 使い道（係数を用いた単項式の有限和がもとの多項式に戻る）
   通過（次数 6 まで）
すべて通過
```
