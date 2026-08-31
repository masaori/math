# SageMath Check: 平面へ持ち上げた隣接二歩の非後退性

**対象ラベル**: `claim_lifted_steps_do_not_reverse`

一辺 $L=1,2,3,4$ の周期正方格子について、すべての向き付き辺 $\vec e$ と
すべての直ちに引き返さない後続辺 $\vec f\in\operatorname{Next}(\vec e)$ を列挙し、
方向単位ベクトルが $u(\operatorname{dir}(\vec f))\ne-u(\operatorname{dir}(\vec e))$ を満たすことを検査する。
$L=1,2$ の自己ループ・多重辺も辺番号と向きを保ったまま列挙する。

- 実行: `sage sagemath/check/lifted-nonbacktracking/check.sage`
- 状態: PASS（2026-08-31。件数は実行出力に記録）
- 計算: 有限集合の全列挙と `ZZ` の等式比較だけ。浮動小数点は使わない。
