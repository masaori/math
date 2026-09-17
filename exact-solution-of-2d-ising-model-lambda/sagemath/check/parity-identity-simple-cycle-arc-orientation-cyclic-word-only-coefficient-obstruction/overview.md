# SageMath Check: 内部語だけでは二つの軌道係数を決められない

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

辺長二・三から得た有限合同系の全弧型について、内部語を巡回移動と反転で
同一視した。同じ内部語の軌道に属しながら、端点署名の違いによって正準支持の
係数が 0 と 1 に分かれる対が、二つの支持のどちらにも存在するかを厳密に判定する。

この有限データ上で係数が内部語だけの関数でなければ、内部語から作る巡回不変な
局所量だけでも係数を表せない。これは一般の辺長についての不可能性定理ではない。

```sh
sage sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-word-only-coefficient-obstruction/check.sage
```

**2026-09-18 実行: すべて通過。**
