# 部分集合の組全体の番号付けの検算

- 対象ラベル: `claim_numbering_of_pairs_of_subsets_is_numbering`
- 検算: [check_numbering_of_pairs_of_subsets.sage](check_numbering_of_pairs_of_subsets.sage)
- 方法: $`e_M`$（`def_binary_numbering_of_power_set`）と $`\eta_{2^M,2}`$（`def_base_n_numbering_of_maps`）を定義の帰納的な式どおりに作り、
  $`p_M(m)=(e_M(\eta(m)(1)),e_M(\eta(m)(2)))`$ について、$`M=0,\dots,4`$ で値が $`\mathcal{P}_M\times\mathcal{P}_M`$ に入ること・単射・全射を、
  部分集合の組をすべて列挙した集合と比べて確かめる。全射の証明で置く $`m:=\eta^{-1}(x)`$（$`x(1)=e_M^{-1}(S)`$、$`x(2)=e_M^{-1}(T)`$）が
  $`p_M(m)=(S,T)`$ を満たすことも確かめる。否定の対照として、第一成分を $`e_M(1)`$ に固定した写像は $`M\ge1`$ で全射にならないことを確かめた。
  整数と有限集合だけの計算で、浮動小数点は使わない。
- 実行: `micromamba run -n sage sage sagemath/check/numbering-of-pairs-of-subsets/check_numbering_of_pairs_of_subsets.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=0,\dots,4`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
