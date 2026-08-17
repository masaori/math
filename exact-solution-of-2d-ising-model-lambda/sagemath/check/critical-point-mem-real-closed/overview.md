# SageMath Check: 自己双対点の平方根と臨界点は実閉部分体の元である

**対象ラベル**: `claim_critical_point_mem_real_closed`

本文の証明（$s=a+b\omega$ の一意表示から $a\cdot a-b\cdot b=2$、$2ab=0$ を読み、$a=0$ の枝を
「$-2$ は $R$ の平方でない」で潰す）を厳密計算で確かめる。浮動小数点は使わない。
$R$ のモデルは実代数的数体 `AA`、$\omega$ のモデルは `QQbar(I)`。

- $s\cdot s=2$ の 2 根がいずれも `AA` の元であること（$b=0$ の枝）。
- 一意表示から読める 2 つの等式。
- $a=0$ の枝が起きないこと（$-2$ が `AA` の平方でないこと）。
- 臨界点 $x_c=-1+s$ が `AA` の元で、自己双対方程式 $\xi^2+2\xi-1=0$ の根であること。
- $-2$ の平方根は `AA` の外にあること（仮定の効き方の確認）。

```sh
sage sagemath/check/critical-point-mem-real-closed/check.sage
```

**2026-08-18 実行: すべて通過。**
