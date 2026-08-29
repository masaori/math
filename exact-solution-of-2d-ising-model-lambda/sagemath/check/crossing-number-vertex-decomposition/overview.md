# 横断数の頂点ごとの分解

**対象ラベル**: `claim_crossing_number_vertex_decomposition`
- 実行: `sage sagemath/check/crossing-number-vertex-decomposition/check.sage`
- 状態: PASS（2026-08-30、閉じた非後退辺列 1,064 件・横断あり 56 件・横断対 96 対）
- 使用する環: `ZZ` と有限集合だけ。浮動小数点は使わない。

L=1,2,3・辺 1〜5 本の全閉じた非後退辺列について、横断数 $c(\gamma)$ が
格子頂点ごとの横断数 $c_v(\gamma)$ の全頂点にわたる和に等しいことを検査する。
あわせて、横断対の二つの通過の頂点が等しいこと（`def_vertexwise_crossing_number` の
頂点の well-defined 性）も検査する。
