# 局所偶奇を仮定した標準双対路の縦方向の内部一歩

**対象ラベル**: `claim_standard_dual_height_vertical_internal_conditional`

局所偶奇を満たす二値の辺割当で、長方形の辺偶奇から高さの変化への代入を検算する。辺長二では生成した全割当、辺長三・四では固定乱数種の各千件を調べる。閉歩道から局所偶奇を導く接続は対象外である。

- 実行: `sage sagemath/check/standard-dual-height-vertical-internal-conditional/check.sage`
- 状態: PASS（2026-11-05。有限場合 18,512 件）
- 計算: 整数の有限和と二で割った余りだけ。浮動小数点は使わない。
