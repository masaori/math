# 辺列に沿うねじれ符号の積

**対象ラベル**: `claim_walk_twist_sign_product`
- 実行: `sage sagemath/check/walk-twist-sign-product/check.sage`
- 状態: PASS（2026-08-29）

辺列を横・縦の切断線を横切る偶奇の列で表し、四つのスピン構造それぞれについて、
辺ごとのねじれ符号の積が列全体の二つの偶奇だけで決まることを検査する。
長さ 0 から 8 までの全列を整数だけで総当たりし、浮動小数点は使わない。
