# SageMath Check: 実代数的数の狭義順序は推移的である

**対象ラベル**: `claim_real_algebraic_order_transitive`

本文の証明（$c-a=(c-b)+(b-a)=u\cdot u+v\cdot v$ を平方の和が平方であることで $w\cdot w$ へ書き直し、
$w\ne0$ を「平方の和が零なら両方が零」から出す）を厳密計算で確かめる。浮動小数点は使わない。
$R$ のモデルは実代数的数体 `AA`、$<_R$ は「差が零でない元の平方であること」。

- 推移律そのもの（$0,\pm1,\tfrac23,\sqrt2,-\tfrac{\sqrt5}{7},3$ の三つ組すべて）。
- 鎖の各段と、証人 $w$ が `AA` の元で零でないこと。
- 反射的でないこと・非対称であること（前提が空虚でないことの確認）。

```sh
sage sagemath/check/real-algebraic-order-transitive/check.sage
```

**2026-08-18 実行: すべて通過。**
