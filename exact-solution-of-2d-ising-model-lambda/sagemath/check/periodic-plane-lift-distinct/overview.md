# SageMath Check: 周期延長した平面持ち上げの点の相異なり

**対象ラベル**: `claim_periodic_plane_lift_points_distinct`

$L=1,2,3$ の全頂点単純な閉じた非後退辺列のうち巻き付きベクトルが $(0,0)$ でないものについて、
商 $q\in\{-2,\ldots,2\}$・余り $r\in\{0,\ldots,m-1\}$ にわたる周期延長した持ち上げ点
$\widetilde P_{qm+r}=P_r+q\cdot(L\,w_{\mathrm v},L\,w_{\mathrm h})$ が二つずつ相異なることを
`ZZ` で検査する。巻き付き数は切断線指示値の符号付き和で計算し、$P_m-P_0$ との一致も確認する。

- 実行: `sage sagemath/check/periodic-plane-lift-distinct/check.sage`
- 状態: PASS（2026-08-31）。非零巻き付きの頂点単純閉路 3,464 本・周期延長した持ち上げ点 延べ 123,960 個を全列挙した。
- 計算: 有限列挙、有限和、`ZZ` の四則だけ。浮動小数点は使わない。
