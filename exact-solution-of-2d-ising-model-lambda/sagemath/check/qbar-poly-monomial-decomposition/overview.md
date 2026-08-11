# SageMath Check: 多項式は、その係数を定数として送ったものと不定元の冪との積の有限和に等しい

## 対象

**対象ラベル**: `claim_qbar_poly_monomial_decomposition`・
`def_qbar_poly_evaluation`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件と定義 1 件
- 併せて引く定義・主張: `def_qbar_polynomial_ring`（$\overline{\mathbb{Q}}[t]$）、
  `def_qbar_constant_embedding`（定数として送る写像 $\widehat{\ \cdot\ }$）、
  `claim_qbar_poly_indeterminate_power_coefficient`（$\mathrm{ac}_j(t^{\,k})$ の値）

### 何を確定させるための検証か

因数定理（根 $w$ を持つ多項式が $t-\widehat{w}$ を因子に持つこと）を示すには、
多項式 $f$ を単項式の有限和 $\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,t^{\,k}$ へ分解しておく必要がある。
本検証はその分解そのものと、根であることを述べるために要る代入 $\mathrm{aev}_w$ の約束を見る。
**因数定理そのもの・根の個数の上界・$\mu_n$ の元の個数はここでは扱わない。**

確かめるのは次の 5 である。

0. **代入の定義に置いた約束**。$\mathrm{aev}_w$ が和と積を保ち、零元と単位元を保ち、
   加法の逆元を逆元へ送ること、$\mathrm{aev}_w(\widehat{a})=a$、$\mathrm{aev}_w(t)=w$。
1. **準備の段**。$\mathrm{ac}_j(\widehat{a}\,t^{\,k})$ が $j=k$ のとき $a$、そうでなければ $0$ であることを、
   9 段の鎖（積の係数の定義・$i=0$ の項の取り出し・$i\ge1$ の係数が零・零元との積と有限和・
   $\mathrm{ac}_0(\widehat{a})=a$・不定元の冪の係数・積の単位元）に沿って確かめる。
2. **本体の 2 つの場合**。$j\le n$ の 6 段の鎖と $j>n$ の 4 段の鎖を、それぞれ別に確かめる。
3. **主張そのもの**。係数がすべて等しいことから $f$ と分解が多項式として等しいこと。
4. **使い道**。$f-\widehat{\mathrm{aev}_w(f)}$ が $t-\widehat{w}$ で割り切れること（次の段で書く因数定理の裏取り）。

冪は $f^{0}=1$, $f^{k+1}=f^{k}f$ の反復で作り、`f**k` へ委ねない（本文の約束と 1 対 1 にするため）。
計算はすべて厳密（`PolynomialRing(QQbar)`）で、浮動小数点は使わない。

## 実行

```sh
sage sagemath/check/qbar-poly-monomial-decomposition/check.sage
```

## 結果

**2026-08-11 実行: すべて通過。**

```
0. 代入 aev_w の約束（和と積を保つ、定数と不定元の行き先）
   通過（標本 9 個 × 多項式 6 個）
1. 準備の段（ac_j((a)^ t^k) の鎖）
   通過（a は標本 9 個、k = 0,...,4、j = 0,...,6）
2. 本体の鎖（場合 1: j ≤ n、場合 2: j > n）
   通過（多項式 6 個、n = 4、j = 0,...,7）
3. 主張そのもの（f = Σ_{k=0}^{n} (ac_k(f))^ t^k）
   通過（多項式 6 個、n = 4）
4. 使い道（f から代入の値を引いたものが t - (w)^ で割り切れる）
   通過（多項式 6 個 × 標本 9 個）
すべて通過
```
