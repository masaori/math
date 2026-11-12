# 分裂した二次空間から行列環への写像の値の自分自身との積の検算

- 対象ラベル: `claim_square_of_matrix_valued_map_on_split_quadratic_space`
- 検算: [check_square_of_matrix_valued_map_on_split_quadratic_space.sage](check_square_of_matrix_valued_map_on_split_quadratic_space.sage)
- 方法: $`W:=\mathbb{Q}^M`$、基底 $`w`$ を標準基底とし、$`\beta^w_k(x)`$ と $`g(w_k)`$ を多項式環 $`\mathbb{Q}[x_1,\dots,x_M,g_1,\dots,g_M]`$ の不定元 $`x_k`$・$`g_k`$ に取る。$`C:=\sum_kx_kc_k`$、$`D:=\sum_kg_kc_k^{\mathsf T}`$ について、準備の一つ目 $`CC=0`$、二つ目 $`DD=0`$、項の等式 $`c_l^{\mathsf T}c_k+c_kc_l^{\mathsf T}=\delta_{k,l}I`$、三つ目 $`c_kD+Dc_k=g_kI`$、四つ目 $`CD+DC=\sum_kx_k(g_kI)`$、五つ目 $`g(x)I=\sum_kx_k(g_kI)`$、本文の分配法則の行と、主張 $`(C+D)(C+D)=g(x)I`$（$`q((x,g))=g(x)`$）を、多項式環の上の行列の厳密計算で確かめる。多項式環の不定元で確かめるので、係数の個々の値ではなく恒等式として確かめている。否定コントロールとして、$`c_k^{\mathsf T}`$ を $`c_k`$ に替えた $`C+\sum_kg_kc_k`$ の自分自身との積は $`g(x)I`$ にならないことを確かめた。
- 実行: `micromamba run -n sage sage sagemath/check/square-of-matrix-valued-map-on-split-quadratic-space/check_square_of_matrix_valued_map_on_split_quadratic_space.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
