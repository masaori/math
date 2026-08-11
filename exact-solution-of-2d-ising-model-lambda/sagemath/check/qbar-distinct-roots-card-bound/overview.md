# SageMath Check: 零でない多項式の相異なる根は係数の上界を超えない

**対象ラベル**: `claim_qbar_distinct_roots_card_bound`

`PolynomialRing(QQbar)` で、零でない多項式・相異なる根の有限集合・係数が尽きる番号の
4 組を厳密計算する。主張そのものに加え、根を一つ選び一次因子で割った商が零でなく、
係数の上界が一つ下がり、残りの根が商の根になるという帰納法の一歩を検査する。
また零多項式なら任意個の根を持つ例を置き、零でないという仮定を外せないことを確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/qbar-distinct-roots-card-bound/check.sage
```

**2026-08-11 実行: すべて通過。**
