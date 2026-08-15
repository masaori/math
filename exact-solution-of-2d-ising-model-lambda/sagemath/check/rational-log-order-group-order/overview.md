# SageMath Check: 有理係数の対数順序群の順序

## 対象

**対象ラベル**: `def_rational_log_order_group_order`

- 実行日: 2026-08-16
- 状態: PASS（512 ベクトル、二元の組 262144 件、共通分母ごとの判定 1439022 件）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-\tfrac32,-1,-\tfrac12,0,\tfrac13,\tfrac12,1,\tfrac54$ から選ぶ有限台の有理係数ベクトル
$\lambda,\mu\in\Lambda_{\mathbb Q}$（零写像を含む）の全ての組について、両方の共通分母 $N\le24$ とその一意な証人
$\lambda_N,\mu_N$ を列挙し、定義「ある両方の共通分母 $N$ で $\lambda_N\le_\Lambda\mu_N$」と言い換え「すべての両方の
共通分母 $N$ で $\lambda_N\le_\Lambda\mu_N$」が一致すること、および決定手続き
$N_\mu\lambda_{N_\lambda}\le_\Lambda N_\lambda\mu_{N_\mu}$（$N_\lambda N_\mu$ の証人が
`claim_common_denominator_multiple` のとおりであることも含む）が定義と一致することを検査する。
$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ の値（正の有理数）の比較で計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-order/check.sage
```
