# SageMath Check: 差の一様な評価に現れる量は核の基準辺分の一倍である

## 対象

**対象ラベル**: `claim_open_square_density_difference_bound_is_core_over_base_side`

- 実行日: 2026-08-17
- 状態: PASS（基準辺 $a\in\{1,2,3,5\}$ × 正の有理数 8 点（$q\le1$ の 6 点と $q>1$ の 2 点）、692 検査。10 秒）
- 帰属: `QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

分配関数は要らない（主張は $\Lambda_{\mathbb Q}$ の有理数倍・加法・逆元の等式だけで、密度には触れない）ので、
基準辺 $a$ と正の有理数 $q$ について証明の中身を段ごとに検査する:
核 $\Gamma(q):=(X+(-Y))+2\cdot C$（`def_open_square_density_difference_bound_core`。$X:=2\iota(\ell_2)+4\iota(\log(1+q))$、
$Y:=4\iota(\log q)$、$C:=\iota(\ell_2)+2\iota(\log(1+q))$）、
準備の第一（$r\cdot(-\lambda)=-(r\cdot\lambda)$ を $r:=\frac1a$、$\lambda:=Y$ で、台の各素数で有理数倍の定義・逆元の定義・
$\mathbb Q$ の四則 $r(-u)=-(ru)$・有理数倍の定義・逆元の定義の五段で確かめる。素数の個数だけ検査数が増える）、
準備の第二（$\frac1a\cdot X=\frac2a\iota(\ell_2)+\frac4a\iota(\log(1+q))$。分配則・結合則・$\mathbb Q$ の四則）、
準備の第三（$\frac1a\cdot(-Y)=-(\frac4a\iota(\log q))$。第一・結合則・$\mathbb Q$ の四則）、
準備の第四（$\frac1a\cdot(2\cdot C)=\frac2a\cdot C$。結合則・$\mathbb Q$ の四則）、
本体（$\frac1a\cdot\Gamma(q)$ を分配則で三つの項へ配り、第二・第三・第四で読み替えて主張の右辺
$R:=(\frac2a\iota(\ell_2)+\frac4a\iota(\log(1+q)))+(-(\frac4a\iota(\log q)))+\frac2a\cdot C$——
`claim_open_square_large_sides_density_difference_upper_le_one` の右辺——に一致すること）。
$\Lambda_{\mathbb Q}$ の等号は `def_rational_log_order_group` の判定どおり、台の各素数の $\mathbb Q$ の値の一致で見る。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-density-difference-bound-is-core-over-base-side/check.sage
```
