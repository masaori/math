# SageMath Check: 埋め込んだ対数の順序は正の有理数の順序と一致する

## 対象

**対象ラベル**: `claim_rational_embedded_log_order_iff`

- 実行日: 2026-08-16
- 状態: PASS（正の有理数の標本 30 点の全組 900 について同値の検査 900 件・鎖の検査 900 件、符号の読み方の検査 42 件。12 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

正の有理数の標本 30 点（$1$ を含み、$1$ より小さいもの・大きいもの・整数・非整数を混ぜる）のすべての組 $(q,q')$ について
$q\le q'\iff\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\log q)\le_{\Lambda_{\mathbb Q}}\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\log q')$ を検査する。
さらに同じ組で証明の同値の鎖を段ごとに検査する:
$q\le q'\iff\log q\le_\Lambda\log q'$（`claim_rational_log_order_iff`）、
$\log q\le_\Lambda\log q'\iff\frac1{1^2}\cdot\iota(\log q)\le_{\Lambda_{\mathbb Q}}\frac1{1^2}\cdot\iota(\log q')$（`claim_scaled_embedding_order_transfer` の $L:=1$）、
$\frac1{1^2}=1$、$1\cdot\iota(\lambda)=\iota(\lambda)$。
最後に、後で引く三つの読み方（$q\le1$ で $\iota(\log q)\le_{\Lambda_{\mathbb Q}}0$、$0\le_{\Lambda_{\mathbb Q}}\iota(\ell_2)$、$0\le_{\Lambda_{\mathbb Q}}\iota(\log(1+q))$）と補助等式 $\log1=0$、$\iota(0)=0$、$\log2=\ell_2$ を検査する。
$\log$ は分子・分母の素因数分解、$\le_{\Lambda_{\mathbb Q}}$ は分母の積を共通分母にした決定手続き、$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ の値（正の有理数）の比較で計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-embedded-log-order-iff/check.sage
```
