# SageMath Check: 有限格子の Fisher 零点の有限部分集合の個数は $2L^2$ を超えない

## 対象

**対象ラベル**: `claim_fisher_zero_finset_card_bound`（structured-latex 側の安定識別子）

- 本文: 章「熱力学極限」の主張「有限格子の Fisher 零点の有限部分集合の個数は $2L^2$ を超えない」
- 併せて引く定義・主張: `def_integer_polynomial_qbar_lift`、`claim_integer_polynomial_qbar_lift_evaluation`、
  `claim_coefficient_representation`、`claim_coefficient_sum`、`def_finite_lattice_fisher_zeros`、
  `claim_qbar_distinct_roots_card_bound`

### 何を確定させるための検証か

$\mathcal F_L$ の有限性（次の段）と、有理円板内の零点の個数 $N_L(c,r)\in\mathbb N$ を定めるために、
$\mathcal F_L$ の任意の有限部分集合 $S$ について $\lvert S\rvert\le2L^2$ を確かめる。

確かめるのは次の四つである。

1. 準備: $\mathrm{ac}_k(\widehat{Z_L}^{\,F})=\Omega_L(k)$（$k\le2L^2$）、$0$（$2L^2<k$）。
2. 第 1 の仮定: $\widehat{Z_L}^{\,F}\ne0$（多重度の総和が $2^{L^2}\ne0$ なので零な係数ばかりではない）。
3. 第 3 の仮定: $\xi\in\mathcal F_L$ ならば $\mathrm{aev}_\xi(\widehat{Z_L}^{\,F})=\mathrm{Ev}^F_\xi(Z_L)=0$。
4. 主張そのもの: $\mathcal F_L$ 全体と、大きさ 1・2 の部分集合すべてについて $\lvert S\rvert\le2L^2$。

対象は $L\le3$（$\lvert\mathcal F_1\rvert=0$、$\lvert\mathcal F_2\rvert=8$、$\lvert\mathcal F_3\rvert=12$）。
計算はすべて `ZZ[x]`・`PolynomialRing(QQbar)`・`QQbar` の厳密計算であり、浮動小数点は使わない。

## 実行

```sh
sage sagemath/check/fisher-zero-finset-card-bound/check.sage
```

## 結果

- 2026-08-17: 部分集合 117 組（$L=1$: 1、$L=2$: 37、$L=3$: 79）、すべて通過（約 13 秒）。
