# SageMath Check: 分配多項式の臨界点での値は正錐の元である

**対象ラベル**: `claim_critical_partition_value_mem_positive_cone`

$L\in\{1,2,3\}$ の全配位から多重度を数え、$s^2=2$ の二つの根について
$x_c=-1+s$ へ代入する。各項 $\Omega_L(m)x_c^m$ が零元または正錐の元であり、
$m=0$ の項が正錐の元であること、各部分和と最終値が正錐の三条件のいずれかを
満たすこと、係数表示の有限和が $\overline{\mathbb Q}$ での直接評価と一致することを
厳密計算で確認する。浮動小数点は使わない。

```sh
sage sagemath/check/critical-partition-value-positive-cone/check.sage
```

**2026-08-18 実行: すべて通過。**
