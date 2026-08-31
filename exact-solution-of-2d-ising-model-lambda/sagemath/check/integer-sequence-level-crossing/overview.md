# SageMath Check: 隣接差が高々 1 の整数列の水準横断数

**対象ラベル**: `claim_integer_sequence_level_crossing`, `def_integer_sequence_level_crossing_counts`

初項 $a_1\in\{-2,\ldots,2\}$、隣接差が $\{-1,0,1\}$、長さ $n\le6$ のすべての整数列
$a=(a_1,\ldots,a_n)$（$1{,}820$ 本）と、列の値域を両側へ $2$ ずつ広げた範囲のすべての水準
$c$（列と水準の組 $12{,}630$ 件）について、上横断数と下横断数の差
$U_c(a)-D_c(a)$ が、$a_1\le c<a_n$ なら $1$、$a_n\le c<a_1$ なら $-1$、
それ以外なら $0$ に一致することを検査する。

- 実行: `sage sagemath/check/integer-sequence-level-crossing/check.sage`
- 状態: PASS（2026-08-31。列 1,820 本・列と水準の組 12,630 件）
- 計算: 有限列の全列挙と `ZZ` の比較・加法だけ。浮動小数点は使わない。
