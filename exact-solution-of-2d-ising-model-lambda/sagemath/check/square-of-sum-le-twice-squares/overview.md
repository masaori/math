# SageMath Check: 和の平方は平方和の二倍以下である

**対象ラベル**: `claim_square_of_sum_le_twice_sum_of_squares`

$R$ のモデルとして `AA` を取り、標本 7 個（$0,\pm1$、有理数 2 個、$\sqrt2$、$-\sqrt5/7$）の
全 49 組について、本文の証明の各段を厳密に確かめる。
差 $D:=(2u^2+2v^2)-(u+v)^2$ の三段の式変形（展開・同類項・因数分解）が $(u-v)^2$ に一致すること、
$u=v$ の 7 組では差が零元で両辺が等しいこと、$u\ne v$ の 42 組では $w:=u-v$ が零でない証人で
差が正（狭義順序のモデル）であること。比較はすべて `AA` の厳密比較で、浮動小数点は使わない。

```sh
sage sagemath/check/square-of-sum-le-twice-squares/check.sage
```

**2026-08-18 実行: 49 組すべて通過。**
