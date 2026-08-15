# SageMath Check: 有限系の密度の分母消去

## 対象

**対象ラベル**: `claim_scaled_free_entropy_denominator_clearing`

- 実行日: 2026-08-15
- 状態: PASS（768 件）
- 帰属: `QQ` と有限台辞書による厳密計算。浮動小数点は使わない。

## 検査内容

正の格子サイズの 12 組と有限台指数ベクトルの 16 組について、共通倍数 $L^2M^2$ を
$L^{-2}\lambda$ と $M^{-2}\mu$ へ掛ける二段の式変形が、それぞれ $M^2\lambda$ と
$L^2\mu$ を与えること、および整数倍と $\iota$ の交換 $n\cdot\iota(\nu)=\iota(n\nu)$ を全件検査する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/scaled-free-entropy-denominator-clearing/check.sage
```
