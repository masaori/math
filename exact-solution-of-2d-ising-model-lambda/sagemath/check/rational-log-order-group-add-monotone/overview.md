# SageMath Check: 有理係数の対数順序群の順序は加法について単調である

## 対象

**対象ラベル**: `claim_rational_log_order_group_add_monotone`

- 実行日: 2026-08-16
- 状態: PASS（125 ベクトル、$\lambda\le\mu$ を満たす二元の組 7875 件、三元の組 984375 件、鎖の検査 196875 件）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-1,-\tfrac12,0,\tfrac13,\tfrac34$ から選ぶ有限台の有理係数ベクトル
$\lambda,\mu,\nu\in\Lambda_{\mathbb Q}$（零写像を含む）について、`def_rational_log_order_group_order` の決定手続き
$N_\mu\lambda_{N_\lambda}\le_\Lambda N_\lambda\mu_{N_\mu}$ で $\le_{\Lambda_{\mathbb Q}}$ を計算し、
$\lambda\le_{\Lambda_{\mathbb Q}}\mu$ を満たすすべての組とすべての $\nu$ について
$\lambda+\nu\le_{\Lambda_{\mathbb Q}}\mu+\nu$ を検査する。
さらに $\nu$ を 5 本に 1 本取った組で、証明の鎖を段ごとに検査する:
$N:=N_\lambda N_\mu N_\nu$ が三元すべての共通分母であること（証人は `claim_common_denominator_multiple` のとおり）、
$N\cdot(\lambda+\nu)=N\cdot\lambda+N\cdot\nu=\iota(\lambda_N)+N\cdot\nu=\iota(\lambda_N)+\iota(\nu_N)=\iota(\lambda_N+\nu_N)$
の四段、$N$ が $\lambda+\nu$・$\mu+\nu$ の共通分母で証人が $\lambda_N+\nu_N$・$\mu_N+\nu_N$ であること、
$\lambda_N\le_\Lambda\mu_N$ と `claim_log_order_group_add_monotone` の $\lambda_N+\nu_N\le_\Lambda\mu_N+\nu_N$、
そしてこの $N$ における証人の比較が決定手続きの結果と一致すること。
$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ の値（正の有理数）の比較で計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-add-monotone/check.sage
```
