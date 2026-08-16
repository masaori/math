# SageMath Check: 基準辺の平方以上の辺の密度の基準辺の密度による一様な下からの評価（q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_large_side_density_lower_vs_base_side_le_one`

- 実行日: 2026-08-17
- 状態: PASS（$(a,L)=(1,2),(1,3)$ × 正の有理数 6 点、288 検査。11 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

$a\ge1$、$a<L$、$a^2\le L$、$L\le3$（一辺 4 以上の配位和は 10 分を超えるため含めない）を満たす二組と、
$0<q\le1$ の 6 点について、証明の中身を段ごとに検査する:
準備の第一（自然数の除法 $L-1=ka+r$、$0\le r<a$ から $k\ge1$、$ka<L\le ka+a$）、
準備の第二（$\mathbb Q$ の係数 $\frac2L\le\frac2a$、$-\frac2a\le-\frac{2a}{a^2}\le-\frac{2a}L$）、
準備の第三（符号 $\iota(\log q)\le0$、$0\le C:=\iota(\ell_2)+2\iota(\log(1+q))$ の四段）、
準備の第四（非正の元の係数比較 $\frac2a\iota(\log q)\le\frac2L\iota(\log q)$、
非負の元の負の係数のままの比較 $-(\frac2aC)=(-\frac2a)C\le(-\frac{2a}L)C=-(\frac{2a}LC)$）、
本体（分配則 $\frac4a\iota(\log q)=\frac2a\iota(\log q)+\frac2a\iota(\log q)$、第一の項と末尾の項を加法単調性で置き換え、
倍数でない辺の下からの評価（`claim_open_square_non_multiple_side_density_lower_vs_base_side_le_one`）を第一の $k$ で読み、推移律）と結論。
$\le_{\Lambda_{\mathbb Q}}$ は分母の最小公倍数を共通分母にした決定手続きで計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-large-side-density-lower-vs-base-side/check.sage
```
