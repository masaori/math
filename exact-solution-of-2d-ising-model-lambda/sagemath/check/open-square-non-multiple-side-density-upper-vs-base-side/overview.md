# SageMath Check: 倍数でない辺の密度の基準辺の密度による上からの評価（q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_non_multiple_side_density_upper_vs_base_side_le_one`

- 実行日: 2026-08-16
- 状態: PASS（$(a,k,L)=(1,1,2),(2,1,3),(1,2,3)$ × 正の有理数 6 点、180 検査。10 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

$a,k\ge1$、$ka<L\le ka+a$、$L\le3$（一辺 4 以上の配位和は 10 分を超えるため含めない）を満たす三組と、
$0<q\le1$ の 6 点について、証明の中身を段ごとに検査する:
誤差評価の右（`claim_open_square_multiple_side_subsquare_density_error_bound`）、
準備の第一（$\mathbb Q$ の係数の比較 $(ka)^2\le L^2$、$\frac{(ka)^2}{L^2}\le1$）、
準備の第二（符号 $0\le\Psi^{\mathrm{op}}_{ka}$）、
準備の第三（$\Lambda_{\mathbb Q}$ の比較 $\frac{(ka)^2}{L^2}\cdot\Psi^{\mathrm{op}}_{ka}\le1\cdot\Psi^{\mathrm{op}}_{ka}=\Psi^{\mathrm{op}}_{ka}\le\Psi^{\mathrm{op}}_a$ と推移律の結論）、
本体の二段（誤差評価の右、加法単調性）と推移律の結論。
$\le_{\Lambda_{\mathbb Q}}$ は分母の最小公倍数を共通分母にした決定手続きで計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-non-multiple-side-density-upper-vs-base-side/check.sage
```
