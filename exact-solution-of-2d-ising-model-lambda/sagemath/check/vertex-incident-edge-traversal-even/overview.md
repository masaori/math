# SageMath Check: 格子頂点に接する四辺の通過回数の総和は頂点の通過数の二倍である

**対象ラベル**: `claim_vertex_incident_edge_traversal_even`, `def_vertical_edge_traversal_count`, `def_horizontal_edge_traversal_count`

原点から始まる長さ $8$ 以下の閉じた単位格子歩をすべて列挙し、外接長方形の一回り外まで
含めた各格子点 $(a,b)$ について、接する四本の単位辺の通過回数の総和
$V_{a-1,b}+V_{a,b}+H_{a,b-1}+H_{a,b}$ が、一周期の持ち上げ点のうち $(a,b)$ に一致する
ものの個数の二倍に等しいことを検査する。

- 実行: `sage sagemath/check/vertex-incident-edge-traversal-even/check.sage`
- 状態: PASS（2026-08-31。閉歩道 5,340 本・格子点 111,792 個）
- 計算: 単位格子歩の有限列挙と `ZZ` の比較・加法だけ。浮動小数点は使わない。
