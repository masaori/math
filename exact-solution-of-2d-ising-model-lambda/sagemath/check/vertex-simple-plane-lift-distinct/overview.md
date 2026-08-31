# SageMath Check: 頂点単純閉路の一周期の平面持ち上げ点の相異なり

**対象ラベル**: `claim_vertex_simple_plane_lift_points_distinct`

一辺 $L=1,2,3$ の周期正方格子について、すべての頂点単純な閉じた非後退辺列
$\gamma=(\vec e_1,\ldots,\vec e_m)$ を列挙する。`def_plane_lift` の漸化式で
$P_0(\gamma),\ldots,P_m(\gamma)$ を計算し、一周期の始点を含み終点を除いた
$P_0(\gamma),\ldots,P_{m-1}(\gamma)$ が二つずつ相異なることを検査する。

- 実行: `sage sagemath/check/vertex-simple-plane-lift-distinct/check.sage`
- 状態: PASS（2026-08-31。件数は実行出力に記録）
- 計算: 有限集合の全列挙と `ZZ` の加法・等式比較だけ。浮動小数点は使わない。
