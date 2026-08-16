# SageMath Check: 倍数辺の密度と基準辺の密度の差の評価（q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_multiple_side_density_vs_base_side_le_one`

- 実行日: 2026-08-16
- 状態: PASS（$(a,k)=(1,1),(1,2),(1,3),(2,1),(3,1)$ × 正の有理数 6 点、270 検査。19 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

$a,k\ge1$、$ka\le3$（一辺 4 以上の配位和は 10 分を超えるため含めない）を満たす五組と、
$0<q\le1$ の 6 点について、証明の中身を段ごとに検査する:
ブロック敷き詰め密度（`claim_open_square_block_tiling_density` の $0<q\le1$ の場合）の両側、
準備の第一（$\mathbb Q$ の係数の比較 $\frac{2(k-1)}{ka}\le\frac{2k}{ka}=\frac2a$）、
準備の第二（符号 $\iota(\log q)\le\iota(\log1)=\iota(0)=0$）、
準備の第三（$\Lambda_{\mathbb Q}$ の比較 $\frac2a\cdot\iota(\log q)\le\frac{2(k-1)}{ka}\cdot\iota(\log q)$）、
本体の左の二段と推移律の結論、および右（ブロック敷き詰め密度の右そのもの）。
$\le_{\Lambda_{\mathbb Q}}$ は分母の最小公倍数を共通分母にした決定手続きで計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-multiple-side-density-vs-base-side/check.sage
```
