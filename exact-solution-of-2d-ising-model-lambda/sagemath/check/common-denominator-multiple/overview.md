# SageMath Check: 共通分母の正整数倍は共通分母である

## 対象

**対象ラベル**: `claim_common_denominator_multiple`（あわせて `claim_common_common_denominator_exists`
——$N_\lambda N_\mu$ が $\lambda$ と $\mu$ の両方の共通分母であること——も確かめる）

- 実行日: 2026-08-16
- 状態: PASS（512 ベクトル、$(N,k)$ の組 8836 件、二元の組 262144 件）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-\tfrac32,-1,-\tfrac12,0,\tfrac13,\tfrac12,1,\tfrac54$ から選ぶ有限台の有理係数ベクトル
$\lambda\in\Lambda_{\mathbb Q}$（零写像を含む）について、$N\le12$ の範囲の共通分母 $N$ とその一意な証人
$\lambda_N$ を列挙し、各 $k\le4$ について、$kN$ が共通分母で証人が $k\lambda_N$（$\Lambda$ の整数倍）であること、
証明の鎖の各段 $(kN)\cdot\lambda=k\cdot(N\cdot\lambda)=k\cdot\iota(\lambda_N)=\iota(k\lambda_N)$、および
$kN\le12$ のとき列挙した証人と $k\lambda_N$ が一致すること（一意性）を検査する。
さらに全ての二元 $\lambda,\mu$ について、非零値の既約分母の積 $N_\lambda,N_\mu$ とその証人
（`claim_common_denominator_exists`）から、$N_\lambda N_\mu=N_\mu N_\lambda$ が $\lambda$ の共通分母
（証人 $N_\mu\lambda_{N_\lambda}$）かつ $\mu$ の共通分母（証人 $N_\lambda\mu_{N_\mu}$）であることを検査する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/common-denominator-multiple/check.sage
```
