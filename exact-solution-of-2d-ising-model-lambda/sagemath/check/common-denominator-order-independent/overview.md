# SageMath Check: 共通分母を通した順序の判定は共通分母の取り方によらない

## 対象

**対象ラベル**: `claim_common_denominator_order_independent`（あわせて `def_common_denominator` の
証人 $\lambda_N$ が $N\cdot\lambda=\iota(\lambda_N)$ を満たすことも確かめる）

- 実行日: 2026-08-16
- 状態: PASS（343 ベクトル、証人 1786 件、交差等式 2082724 件、同値 2082724 件）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-1,-\tfrac12,0,\tfrac13,\tfrac12,1,\tfrac32$ から選ぶ有限台の有理係数ベクトル
$\lambda,\mu\in\Lambda_{\mathbb Q}$ と $N,N'\in\{1,\dots,12\}$ について、$N$ が $\lambda$ の共通分母のとき
証人 $\lambda_N\in\Lambda$ を作り $\iota(\lambda_N)=N\cdot\lambda$ を確認する。$N,N'$ がともに $\lambda,\mu$ の
共通分母である全組で、準備の等式 $N'\lambda_N=N\lambda_{N'}$、$N'\mu_N=N\mu_{N'}$ と、主張
$\lambda_N\le_{\Lambda}\mu_N\iff\lambda_{N'}\le_{\Lambda}\mu_{N'}$（`QQ` の厳密比較）を検査する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/common-denominator-order-independent/check.sage
```
