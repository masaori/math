# SageMath Check: 挟み込み区間から取る臨界点の有理近似

**対象ラベル**: `claim_critical_point_rational_approximation`

`R` のモデルを `AA` に取り、正の有理誤差 `1/2, 1/10, 1/100, 3/1000` について、次を厳密に検査する。

- 有理等分区間 `p ≤ x_c < q`、`q-p=h` と `q>0`。
- `h-a²=d²`、`h+a²=v²` と平方差 `h²-(q-x_c)²=(dv)²`。
- `delta-h²=r²` と二平方和から `delta-(x_c-q)²=z²`、`z≠0`。

`QQ` と `AA` だけを使い、浮動小数点は使わない。

```sh
sage sagemath/check/critical-point-rational-approximation/check.sage
```

**2026-08-18 実行: すべて通過。**
