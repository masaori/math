# 行列が、成分を係数にした行列単位の和であることの検算

- 対象ラベル: `claim_matrix_is_double_sum_of_entries_times_matrix_units`
- 検算: [check_matrix_is_double_sum_of_entries_times_matrix_units.sage](check_matrix_is_double_sum_of_entries_times_matrix_units.sage)
- 方法: 添字の集合を $`\mathcal{P}_M`$（$`M=1,2,3`$）とし、乱数の種を固定した整数行列 $`F`$ について、$`\sum_x1\cdot(\sum_yF_{x,y}E_{x,y})=F`$ を確かめる。証明の準備の一つ目（項の成分を $`\delta_{q,y}(F_{x,y}\delta_{x,p})`$ に直すこと）、二つ目（内側の和がデルタで一項を取り出すこと）、三つ目（外側の項を $`\delta_{p,x}F_{x,q}`$ に直すこと）と最後の取り出しを成分ごとに確かめる。否定コントロールとして、係数の添字を入れ替えた和が転置になり、対称でない $`F`$ では $`F`$ に一致しないことを確かめた。計算は整数の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/matrix-is-double-sum-of-entries-times-matrix-units/check_matrix_is_double_sum_of_entries_times_matrix_units.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 特定の行列での確認であり、証明ではない。
