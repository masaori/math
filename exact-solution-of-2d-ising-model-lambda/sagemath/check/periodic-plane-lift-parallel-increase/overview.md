# SageMath Check: 周期並進による平行座標の増加

**対象ラベル**: `claim_periodic_plane_lift_parallel_period_increase`

$L=1,2,3$ の全頂点単純な閉じた非後退辺列のうち巻き付きベクトルが $(0,0)$ でないものについて、
$k=qm+r$（$q\in\{-2,\ldots,2\}$、$r\in\{0,\ldots,m-1\}$）を走らせ、
$\pi_{\gamma}(\widetilde P_{k+m})=\pi_{\gamma}(\widetilde P_{k})+L(w_{\mathrm v}^2+w_{\mathrm h}^2)$ と、
増分が $1$ 以上の正の整数であることを `ZZ` で検査する。

- 実行: `sage sagemath/check/periodic-plane-lift-parallel-increase/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付きの頂点単純閉路 3,464 本・一周期ずらしの比較 延べ 123,960 件を全列挙した。
- 計算: 有限列挙、整数の除法、`ZZ` の四則と順序だけ。浮動小数点は使わない。
