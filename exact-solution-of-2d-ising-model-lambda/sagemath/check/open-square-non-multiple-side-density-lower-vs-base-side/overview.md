# SageMath Check: 倍数でない辺の密度の基準辺の密度による下からの評価（q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_non_multiple_side_density_lower_vs_base_side_le_one`

- 実行日: 2026-08-16
- 状態: PASS（$(a,k,L)=(1,1,2),(2,1,3),(1,2,3)$ × 正の有理数 6 点、396 検査。10 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

$a,k\ge1$、$ka<L\le ka+a$、$L\le3$（一辺 4 以上の配位和は 10 分を超えるため含めない）を満たす三組と、
$0<q\le1$ の 6 点について、証明の中身を段ごとに検査する:
誤差評価の左（`claim_open_square_multiple_side_subsquare_density_error_bound`）、
準備の第一（$\mathbb Q$ の係数 $\frac{(ka)^2}{L^2}+\frac{L^2-(ka)^2}{L^2}=1$、$0\le\frac{L^2-(ka)^2}{L^2}\le\frac{2a}L$）、
準備の第二（符号 $0\le C:=\iota(\ell_2)+2\cdot\iota(\log(1+q))$）、
準備の第三（$\frac{L^2-(ka)^2}{L^2}\cdot\Psi^{\mathrm{op}}_{ka}\le\frac{L^2-(ka)^2}{L^2}\cdot C\le\frac{2a}L\cdot C$）、
本体（分配則で $\Psi_{ka}$ を二つの項へ割る、加法単調性、$-\frac{2a}L\cdot C$ を両辺に足す、
倍数辺の差の評価の左に同じものを足して推移律、$\frac2L\iota(\log q)$ を足して誤差評価の左へ推移律）と結論。
$\le_{\Lambda_{\mathbb Q}}$ は分母の最小公倍数を共通分母にした決定手続きで計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-non-multiple-side-density-lower-vs-base-side/check.sage
```
