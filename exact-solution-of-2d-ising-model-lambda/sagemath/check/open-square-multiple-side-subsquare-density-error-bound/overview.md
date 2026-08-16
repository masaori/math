# SageMath Check: 倍数辺の部分正方形による密度の挟み込みの誤差評価（q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_multiple_side_subsquare_density_error_bound`

- 実行日: 2026-08-16
- 状態: PASS（形の三組 $(a,k,L)=(1,1,2),(2,1,3),(1,2,3)$ × 正の有理数 6 点、342 検査。11 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

$ka<L\le ka+a$、$a,k\ge1$、$L\le3$（一辺 4 以上の配位和は 10 分を超えるため含めない）を満たす形の三組と、
$0<q\le1$ の 6 点について、証明の中身を段ごとに検査する:
準備の第一（`claim_open_square_subsquare_comparison_density_le_one` を $a:=ka$ で読んだ両側）、
準備の第二（$\mathbb Q$ の係数の比較 $\frac{ka+L}{L^2}\le\frac2L$、$\frac{L^2-(ka)^2}{L^2}\le\frac{2a}L$、$\frac{2(L^2-(ka)^2)}{L^2}\le\frac{4a}L$）、
準備の第三（符号 $\iota(\log q)\le0$、$0\le\iota(\ell_2)$、$0\le\iota(\log(1+q))$ と $\log1=0$・$\iota(0)=0$・$\log2=\ell_2$）、
準備の第四（$\Lambda_{\mathbb Q}$ の三つの係数比較）、本体の左の二段と右の三段、および推移律の結論。
$\le_{\Lambda_{\mathbb Q}}$ は分母の最小公倍数を共通分母にした決定手続きで計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-multiple-side-subsquare-density-error-bound/check.sage
```
