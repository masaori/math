# SageMath Check: 基準辺の平方以上の二つの辺の密度の差の一様な上からの評価（q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_large_sides_density_difference_upper_le_one`

- 実行日: 2026-08-17
- 状態: PASS（$a=1$、$(L,M)\in\{2,3\}^2$ の四組 × 正の有理数 6 点、360 検査。11 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

$a\ge1$、$a<L$、$a<M$、$a^2\le L$、$a^2\le M$、$L,M\le3$（一辺 4 以上の配位和は 10 分を超えるため含めない）を満たす四組と、
$0<q\le1$ の 6 点について、証明の中身を段ごとに検査する:
上端（`claim_open_square_large_side_density_upper_vs_base_side_le_one` を辺 $a,L$ で読む）$\Psi_L\le U+\Psi_a$、
下端（`claim_open_square_large_side_density_lower_vs_base_side_le_one` を辺 $a,M$ で読む）$(D+\Psi_a)+(-\frac2aC)\le\Psi_M$、
準備（下端の両辺に $(-D)+\frac2aC$ を足し、左辺を結合則・交換則・逆元・単位元で $\Psi_a$ に戻す）、
本体（上端に $-\Psi_M$ を足す、並べ替え、準備の結論に $(-\Psi_M)+U$ を足す、並べ替え、逆元、単位元、推移律）と結論
$\Psi_L+(-\Psi_M)\le U+(-D)+\frac2aC$。
$\le_{\Lambda_{\mathbb Q}}$ は分母の最小公倍数を共通分母にした決定手続きで計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-large-sides-density-difference-upper/check.sage
```
