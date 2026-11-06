# 2 進の番号付けが部分集合全体の番号付けであることの検算

- 対象ラベル: `claim_binary_numbering_is_numbering_of_power_set`
- 検算: [check_binary_numbering_of_power_set.sage](check_binary_numbering_of_power_set.sage)
- 方法: $`e_M`$ を `def_binary_numbering_of_power_set` の帰納的な式どおりに作り、$`M=0,\dots,8`$ について、
  値が $`\mathcal{P}_M`$ に入ること・単射・全射を、$`\{1,\dots,M\}`$ の部分集合をすべて列挙した集合と比べて確かめる。
  $`M\ge 1`$ では証明の準備（ア）（イ）（ウ）と、全射の証明の場合分けで置く $`k`$（$`M\notin T`$ なら $`j`$、$`M\in T`$ なら $`j+h`$）が
  $`e_M(k)=T`$ を満たすことも確かめる。整数と有限集合だけの計算で、浮動小数点は使わない。
- 実行: `micromamba run -n sage sage sagemath/check/binary-numbering-of-power-set/check_binary_numbering_of_power_set.sage`（SageMath 10.9、2026-11-06）。
- 結果: 通過。$`M=0,\dots,8`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
