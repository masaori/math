# SageMath Check: 核は非負である

## 対象

**対象ラベル**: `claim_open_square_density_difference_bound_core_nonneg_le_one`

- 実行日: 2026-08-17
- 状態: PASS（正の有理数 $q\le1$ の 7 点で証明の各段 38 検査ずつ、$q>1$ の 2 点で否定側 1 検査ずつ、計 268 検査。10 秒）
- 帰属: `QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

分配関数は要らない（主張は $\Lambda_{\mathbb Q}$ の元 $\Gamma(q)$ の符号だけで、密度には触れない）ので、
正の有理数 $q\le1$ について証明の中身を段ごとに検査する:
核 $\Gamma(q):=(X+(-Y))+2\cdot C$（`def_open_square_density_difference_bound_core`。$X:=2\iota(\ell_2)+4\iota(\log(1+q))$、
$Y:=4\iota(\log q)$、$C:=\iota(\ell_2)+2\iota(\log(1+q))$）、
準備の第一（符号 $\iota(\log q)\le0$（$q\le1$）、$0\le\iota(\ell_2)$、$0\le\iota(\log(1+q))$。`claim_rational_embedded_log_order_iff`）、
準備の第二（$0=2\cdot0\le2\iota(\ell_2)$、$0=4\cdot0\le4\iota(\log(1+q))=0+4\iota(\log(1+q))\le2\iota(\ell_2)+4\iota(\log(1+q))=X$。
有理数倍・非負有理数倍の順序保存・単位元・加法単調性）、
準備の第三（$Y=4\iota(\log q)\le4\cdot0=0$、$0=-0\le-Y$。非負有理数倍の順序保存・逆元・逆元の順序反転）、
準備の第四（$0\le C$ の既出の一続き、$0=2\cdot0\le2\cdot C$）、
本体（$0=0+0\le X+0=0+X\le(-Y)+X=X+(-Y)=0+(X+(-Y))\le2C+(X+(-Y))=(X+(-Y))+2C=\Gamma(q)$。単位元・加法単調性・交換則・核の定義）。
$\Lambda_{\mathbb Q}$ の順序は `def_rational_log_order_group_order` の判定どおり共通分母の証人の $\Lambda$ の比較で、
等号は `def_rational_log_order_group` の判定どおり台の各素数の $\mathbb Q$ の値の一致で見る。
否定側として、$q>1$ の 2 点では第一の符号 $\iota(\log q)\le0$ が成り立たないこと（仮定 $q\le1$ が要ること）を記録する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-density-difference-bound-core-nonneg/check.sage
```
