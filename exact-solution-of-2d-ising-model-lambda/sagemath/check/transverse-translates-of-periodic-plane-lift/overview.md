# SageMath Check: 周期持ち上げの横断平行移動

**対象ラベル**: `claim_transverse_translates_of_periodic_plane_lift_disjoint`

$L=1,2,3$ の非零巻き付きの頂点単純な閉じた非後退辺列について、整数横断移動
$u\in\{-3,\ldots,3\}$ と周期商 $q\in\{-1,0,1\}$ を走らせ、
$\kappa_\gamma(\widetilde P_k^{[u]})=\kappa_\gamma(\widetilde P_k)+uW_\perp$ を検査する。
さらに $(v-u)W_\perp>K_{\max}-K_{\min}$ を満たす全移動対・全検査点対について、
$u$ 側の横断座標が $v$ 側より真に小さく、点も異なることを検査する。

- 実行: `sage sagemath/check/transverse-translates-of-periodic-plane-lift/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付きの頂点単純閉路 3,464 本について、横断座標の等式
  520,632 件と、横断幅を超えて離した点対 21,566,088 組を検査した。
- 計算: 有限列挙と `ZZ` の四則・順序だけ。浮動小数点は使わない。
