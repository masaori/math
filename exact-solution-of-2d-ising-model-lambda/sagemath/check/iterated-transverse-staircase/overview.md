# SageMath Check: 反復横断階段の単純性と横断座標の下界

**対象ラベル**: `claim_iterated_transverse_staircase_lower_bound`

$L=1,2,3$ の非零巻き付きの頂点単純な閉じた非後退辺列について、基点 $Q\in\{(0,0),(2,-1)\}$・
反復回数 $t\in\{1,2\}$ の反復横断階段の各差が、整数の除法で定まる横断階段の一歩
$C^{\gamma}_{r+1}-C^{\gamma}_r$ に等しい単位格子ベクトルであり、整数横断座標が各歩で真に増え、
$s$ 歩後の横断座標が $\kappa_{\gamma}(Q)+s$ 以上であることを `ZZ` で検査する。
始点 $Q$・終点 $Q+t\,(w_{\mathrm h},-w_{\mathrm v})$ と頂点の相異なりも同時に確かめる。

- 実行: `sage sagemath/check/iterated-transverse-staircase/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付きの頂点単純閉路 3,464 本に対する反復横断階段
  30,048 歩（基点 2 通り × 反復回数 2 通り）を全列挙した。
- 計算: 有限列挙、整数の除法・絶対値・四則と順序だけ。浮動小数点は使わない。
