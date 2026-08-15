# SageMath Check: 有理数倍と埋め込みを通した順序の移送

## 対象

**対象ラベル**: `claim_scaled_embedding_order_transfer`

- 実行日: 2026-08-16
- 状態: PASS（$L\in\{1,2,3\}$、$\Lambda$ のベクトル 64 本、鎖の検査 192 件、共通分母の検査 192 件、同値の検査 12288 件、証人の比較の一致 12288 件）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-1,0,1,2$ から選ぶ有限台の整数係数ベクトル $\lambda,\mu\in\Lambda$（零写像を含む）と
$L\in\{1,2,3\}$ について、
証明の準備の三段の鎖 $L^2\cdot(\frac{1}{L^2}\cdot\iota(\lambda))=(L^2\cdot\frac{1}{L^2})\cdot\iota(\lambda)=1\cdot\iota(\lambda)=\iota(\lambda)$
を段ごとに検査し、$N=L^2$ が $\frac{1}{L^2}\cdot\iota(\lambda)$ の共通分母で証人が $\lambda$ 自身であること
（`def_common_denominator`、一意な証人の一致）を確かめる。
そのうえで、すべての組 $(\lambda,\mu)$ について、`def_rational_log_order_group_order` の決定手続き
$N_\mu\lambda_{N_\lambda}\le_\Lambda N_\lambda\mu_{N_\mu}$ で計算した
$\frac{1}{L^2}\cdot\iota(\lambda)\le_{\Lambda_{\mathbb Q}}\frac{1}{L^2}\cdot\iota(\mu)$ が $\lambda\le_\Lambda\mu$ と一致すること（主張）、
および $N=L^2$ における証人の比較（順序の定義の「すべての共通分母で」の言い換え）がその判定と一致することを検査する。
$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ の値（正の有理数）の比較で計算する。

規模の注記: 素数 4 個・係数 5 種・$L\le6$ では決定手続きの $N_\lambda N_\mu$ の指数が大きくなり 10 分で終わらなかったので、
上の規模に縮めた（内容は同じ。時間の見積もりではなく実測で判断）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/scaled-embedding-order-transfer/check.sage
```
