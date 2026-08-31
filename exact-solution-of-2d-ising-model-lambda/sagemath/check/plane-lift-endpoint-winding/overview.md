# SageMath Check: 閉歩道の平面持ち上げの終点と巻き付きベクトル

**対象ラベル**: `claim_plane_lift_endpoint_winding`

一辺 $L=1,2,3$ の周期正方格子について、長さ $6$ までのすべての閉じた非後退辺列
$\gamma=(\vec e_1,\ldots,\vec e_m)$ を列挙する。`def_plane_lift` の漸化式で
$P_0(\gamma),\ldots,P_m(\gamma)$ を計算し、`def_directed_winding_numbers` の
$w_{\mathrm h}(\gamma),w_{\mathrm v}(\gamma)$ を用いて
$P_m(\gamma)=P_0(\gamma)+(L\,w_{\mathrm v}(\gamma),\ L\,w_{\mathrm h}(\gamma))$
が成り立つことを検査する。

- 実行: `sage sagemath/check/plane-lift-endpoint-winding/check.sage`
- 状態: PASS（2026-08-31。閉じた非後退辺列 4,128 本）
- 計算: 有限集合の全列挙と `ZZ` の加法・等式比較だけ。浮動小数点は使わない。
