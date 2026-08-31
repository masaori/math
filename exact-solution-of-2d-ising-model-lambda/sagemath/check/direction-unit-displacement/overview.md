# SageMath Check: 方向番号と平面変位の対応

**対象ラベル**: `claim_displacement_is_direction_unit`

一辺 $L=1,2,3,4$ の周期正方格子の全向き付き辺（各 $4L^2$ 本、計 $120$ 本）について、
行変位・列変位の組 $(\delta_{\mathrm{row}},\delta_{\mathrm{col}})$ が
方向単位ベクトル $u(\operatorname{dir})$（右・下・左・上 $=0,1,2,3\in\mathbb Z/4\mathbb Z$ に
$(0,1),(1,0),(0,-1),(-1,0)$ を与える写像）に一致することを検査する。
あわせて $u$ の四つの値が相異なること（定義の well-defined 性の裏取り）も確認する。

- 実行: `sage sagemath/check/direction-unit-displacement/check.sage`
- 状態: PASS（2026-08-31。全 120 本）
- 計算: `ZZ` の等式比較と有限列挙だけ。浮動小数点は使わない。
