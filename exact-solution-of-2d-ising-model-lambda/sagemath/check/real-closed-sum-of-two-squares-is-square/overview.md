# SageMath Check: 実閉部分体では二つの平方の和が平方であり、$2$ が平方である

**対象ラベル**: `claim_real_closed_sum_of_two_squares_is_square`, `claim_two_is_square_in_real_closed`

本文の証明を厳密計算で確かめる。浮動小数点は使わない。
$R$ のモデルは実代数的数体 `AA`、$\omega$ のモデルは `QQbar(I)`、$\overline{\mathbb Q}$ の代数閉性は
`QQbar` の平方根で代用する。

- 恒等式 $(a^2-b^2)^2+(2ab)^2=(a^2+b^2)^2$（必要十分版の中身そのもの）。
- $u\cdot u=x+y\omega$ を満たす $u$ の一意表示 $u=a+b\omega$ から $x=a^2-b^2$、$y=2ab$ が読めること、
  および $c:=a^2+b^2$ が $x\cdot x+y\cdot y=c\cdot c$ を与えること。
- $2$ が $R$ の零でない元の平方であること、$-2$ が $R$ の平方でないこと（三分法のうち第 2 の場合だけが
  成り立つこと）。
- $R$ の外では $-2$ も平方になること（仮定 $w\in R$ が本質であることの確認）。

$x,y$ は $0,\pm1,\tfrac23,\sqrt2,-\tfrac{\sqrt5}{7}$ の組すべて。

```sh
sage sagemath/check/real-closed-sum-of-two-squares-is-square/check.sage
```

**2026-08-18 実行: すべて通過。**
