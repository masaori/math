# SageMath Check: 周期延長した平面持ち上げの有限幅の整数帯

**対象ラベル**: `claim_periodic_plane_lift_transverse_bounded`

$L=1,2,3$ の全頂点単純な閉じた非後退辺列のうち巻き付きベクトルが $(0,0)$ でないものについて、
商 $q\in\{-2,\ldots,2\}$・余り $r\in\{0,\ldots,m-1\}$ にわたる周期延長した持ち上げ点に対し、
$\kappa_{\gamma}(\widetilde P_{qm+r})=\kappa_{\gamma}(P_r)$ と、横断座標の値集合が一周期の有限集合に
等しいことを `ZZ` で検査する。

- 実行: `sage sagemath/check/periodic-plane-lift-transverse-bounded/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付きの頂点単純閉路 3,464 本・周期延長した持ち上げ点 延べ 123,960 個を全列挙した。
- 計算: 有限列挙、有限集合、`ZZ` の四則と順序だけ。浮動小数点は使わない。
