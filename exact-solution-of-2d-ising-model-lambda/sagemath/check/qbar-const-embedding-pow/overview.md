# SageMath Check: 定数として送る写像は冪を冪へ写す

## 対象

**対象ラベル**: `claim_qbar_constant_embedding_pow`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて引く定義: `def_qbar_polynomial_ring`（$\overline{\mathbb{Q}}[t]$ とその冪の約束）、
  `def_qbar_constant_embedding`（定数として送る写像 $\widehat{\ \cdot\ }$）、
  `def_root_of_unity_set`（$\overline{\mathbb{Q}}$ の元の冪の約束）

### 何を確定させるための検証か

因数定理の鎖では、根の条件 $\mathrm{aev}_w(f)=0$ を定数として送った
$\widehat{\mathrm{aev}_w(f)}$ を係数ごとの項 $\widehat{\mathrm{ac}_k(f)}\,\widehat{w}^{\,k}$ の
有限和へ開く。その一段で $\widehat{w^{\,k}}$ を $\widehat{w}^{\,k}$ へ書き換える。
左右の冪は住む環（$\overline{\mathbb{Q}}$ と $\overline{\mathbb{Q}}[t]$）が違う別々の約束なので、
この書き換えは約束からは出ず、示すべき主張である。本検証はその主張だけを見る。
**代入 $\mathrm{aev}_w$ が冪を保つこと・値の有限和表示・因数定理そのものはここでは扱わない。**

確かめるのは次の 4 である。

1. **出発点**（$n=0$）の 3 段の鎖。$\widehat{w^{\,0}}=\widehat{1}=1=\widehat{w}^{\,0}$。
2. **一歩**（$n$ から $n+1$ へ）の 4 段の鎖。$\overline{\mathbb{Q}}$ の冪の約束・
   $\widehat{a\,b}=\widehat{a}\,\widehat{b}$・帰納法の仮定・$\overline{\mathbb{Q}}[t]$ の冪の約束。
3. **主張そのもの**。$\widehat{w^{\,n}}=\widehat{w}^{\,n}$。
4. **使い道**。$\widehat{\sum_k a_k w^{\,k}}=\sum_k\widehat{a_k}\,\widehat{w}^{\,k}$
   （因数定理の鎖で開く段の裏取り）。

冪は $f^{0}=1$, $f^{k+1}=f^{k}f$ の反復で作り、`f**k` へ委ねない（本文の約束と 1 対 1 にするため）。
計算はすべて厳密（`PolynomialRing(QQbar)`）で、浮動小数点は使わない。

## 実行

```sh
sage sagemath/check/qbar-const-embedding-pow/check.sage
```

## 結果

**2026-08-11 実行: すべて通過。**

```
1. 出発点（(w^0)^ = (1)^ = 1 = ((w)^)^0）
   通過（標本 9 個）
2. 一歩（(w^{n+1})^ = (w^n w)^ = (w^n)^ (w)^ = ((w)^)^n (w)^ = ((w)^)^{n+1}）
   通過（標本 9 個、n = 0,...,6）
3. 主張そのもの（(w^n)^ = ((w)^)^n）
   通過（標本 9 個、n = 0,...,6）
4. 使い道（有限和を定数として送ったものが項ごとに開ける）
   通過（標本 9 個、k = 0,...,4）
すべて通過
```
