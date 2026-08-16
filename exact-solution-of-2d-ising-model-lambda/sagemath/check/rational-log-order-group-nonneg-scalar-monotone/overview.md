# SageMath Check: 非負有理数倍は有理係数の対数順序群の順序を保つ

## 対象

**対象ラベル**: `claim_rational_log_order_group_nonneg_scalar_monotone`

- 実行日: 2026-08-16
- 状態: PASS（64 ベクトル、$\lambda\le\mu$ を満たす二元の組 2080 件、係数 5 点、主張の検査 10400 件、鎖の検査 10400 件。7 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-1,0,\tfrac12,\tfrac23$ から選ぶ有限台の有理係数ベクトル
$\lambda,\mu\in\Lambda_{\mathbb Q}$（零写像を含む）と、非負の有理数 $c\in\{0,1,2,\tfrac12,\tfrac74\}$ について、
`def_rational_log_order_group_order` の決定手続き $N_\mu\lambda_{N_\lambda}\le_\Lambda N_\lambda\mu_{N_\mu}$ で
$\le_{\Lambda_{\mathbb Q}}$ を計算し、$\lambda\le_{\Lambda_{\mathbb Q}}\mu$ を満たすすべての組とすべての $c$ について
$c\cdot\lambda\le_{\Lambda_{\mathbb Q}}c\cdot\mu$ を検査する。
さらに同じ組で証明の鎖を段ごとに検査する:
$u:=\operatorname{num}(c)\ge0$、$v:=\operatorname{den}(c)\ge1$、$vc=u$、
両方の共通分母 $N:=N_\lambda N_\mu$ とその証人 $\lambda_N,\mu_N$ で $\lambda_N\le_\Lambda\mu_N$ であること、$vN\ge1$、
六段 $(vN)\cdot(c\cdot\lambda)=((vN)c)\cdot\lambda=((vc)N)\cdot\lambda=(uN)\cdot\lambda=u\cdot(N\cdot\lambda)=u\cdot\iota(\lambda_N)=\iota(u\lambda_N)$
（$\mu$ についても同じ）と、$vN$ が $c\cdot\lambda$・$c\cdot\mu$ の共通分母で証人が $u\lambda_N$・$u\mu_N$ であること、
$u\ge1$ なら `claim_log_order_group_positive_multiple_invariant`（$u$ 倍で真偽が変わらない）、$u=0$ なら両証人が零写像であること、
$u\lambda_N\le_\Lambda u\mu_N$、そしてこの $vN$ における証人の比較が決定手続きの結果と一致すること。
$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ の値（正の有理数）の比較で計算する。
最初は係数 5 点・$c$ 7 点（125 ベクトル）で書いたが 2 分で終わらなかったので標本を縮めた（結果は変えていない）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-nonneg-scalar-monotone/check.sage
```
