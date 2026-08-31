# SageMath Check: 頂点単純閉路の巻き付きベクトル

**対象ラベル**: `claim_vertex_simple_winding_zero_or_primitive`

一辺 $L=1,2,3,4$ の周期正方格子で、通過の頂点が相異なる閉じた非後退辺列を
基点と向きを区別して全列挙する。各辺列について整数巻き付き数 $(w_{\mathrm h},w_{\mathrm v})$ を計算し、

- $(w_{\mathrm h},w_{\mathrm v})=(0,0)$、または
- $\gcd(|w_{\mathrm h}|,|w_{\mathrm v}|)=1$

のどちらかが成り立つことを検査する。

全 $373{,}720$ 本のうち、巻き付きベクトルが零のものは $73{,}616$ 本、零でなく原始的なものは
$300{,}104$ 本であった。$L=1$ の四本も含めている。

- 実行: `sage sagemath/check/vertex-simple-winding-primitive/check.sage`
- 状態: PASS（2026-08-31）
- 計算: `ZZ` の加減乗除、最大公約数、有限列挙だけ。浮動小数点は使わない。
