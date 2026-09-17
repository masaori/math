# SageMath Check: 内部語と端点局所量による二つの軌道係数の判定

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

辺長二・三から得た有限合同系の全弧型について、巡回移動と反転で
正規化した内部語と、二端点の完全な局所署名との組ごとに、二つの
正準支持の係数が一定かを厳密に判定する。

これは一般の辺長についての係数式ではなく、次に残すべき端点情報を
切り分ける有限データ上の判定である。

プログラミングによる検証では、9,739 弧型のそれぞれが異なる
「巡回・反転内部語と完全端点署名」の組を持ち、二つの支持のどちらでも
係数衝突は 0 件だった。従ってこの有限範囲では完全端点署名を残せば
両係数を決められる。ただし鍵が弧型数と同数なので、これはまだ閉じた
係数式ではなく、次は端点署名のどの成分を落とせるかを判定する。

```sh
sage sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-word-endpoint-coefficient-decision/check.sage
```

**2026-09-18 実行: すべて通過。**
