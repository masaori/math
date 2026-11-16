# 分裂した二次空間のクリフォード代数の生成元の反交換関係と平方を、クリフォード代数の中で直接比べる検算

- 対象ラベル: `claim_annihilation_and_creation_generators_anticommute`
- 対象ラベル: `claim_creation_generators_anticommute`
- 対象ラベル: `claim_annihilation_generators_anticommute`
- 対象ラベル: `claim_square_of_creation_generator_is_zero`
- 対象ラベル: `claim_square_of_annihilation_generator_is_zero`
- 検算: [check_anticommutation_and_squares_of_split_clifford_generators.sage](check_anticommutation_and_squares_of_split_clifford_generators.sage)
- 方法: $`M=1,2,3`$ で、$`V=W\oplus W^{*}`$ の基底 $`c=(\mathrm{in}_1(w_1),\dots,\mathrm{in}_1(w_M),\mathrm{in}_2(f_1),\dots,\mathrm{in}_2(f_M))`$ の座標 $`y`$ について
  $`q(y)=\sum_k y_ky_{M+k}`$ とし、$`\mathrm{Cl}(V,q)`$ を SageMath の `CliffordAlgebra`（係数 `QQ`）で作る。
  $`V`$ の元は組 $`(x,\xi)`$（$`x`$ は基底 $`w`$ の座標、$`\xi`$ は双対基底 $`f`$ の座標）で持ち、$`f(w)`$ にあたる値を $`\sum_k\xi_kx_k`$、
  $`q_W((x,\xi))`$ をその値、偏極 $`B_q(u,v)=(q(u+v)-q(u))-q(v)`$ を定義どおりに、$`\mathrm{Cl}(V,q)`$ とは別の関数として計算した。
  SageMath の二次形式が $`q_W`$ と一致することを、基底の元と乱数の元 4 つで確かめた。
  $`a^{\dagger}_i=\gamma(\mathrm{in}_1(w_i))`$、$`a_i=\gamma(\mathrm{in}_2(f_i))`$ とし、五つの主張の証明の式変形の各行の値を $`\mathrm{Cl}(V,q)`$ の中で計算して、
  隣どうしを `==` で比べた（行列への像での確認ではない）。反交換関係の三つは $`i,j\in\{1,\dots,M\}`$ の全部の組で、平方の二つは $`i\in\{1,\dots,M\}`$ の全部で比べた。
  比べた等号の数は、$`M=1,2,3`$ の合計で 370 個である（$`a_ia^{\dagger}_j+a^{\dagger}_ja_i`$ が組ごとに 8 個、$`a^{\dagger}_ia^{\dagger}_j+a^{\dagger}_ja^{\dagger}_i`$ が 8 個、$`a_ia_j+a_ja_i`$ が 7 個、二つの平方が 4 個ずつ）。
  否定の対照（各 $`M`$）: $`a_ia^{\dagger}_i+a^{\dagger}_ia_i`$ は 0 でないこと、$`a^{\dagger}_ia_i`$ は 0 でも $`1`$ でもないこと、
  対角に 1 を足した二次形式 $`\sum_ky_ky_{M+k}+\sum_ky_k^2`$ のクリフォード代数では $`a^{\dagger}_i`$ の平方が 0 にならないこと、$`M\ge2`$ で $`a_1a^{\dagger}_2\ne0`$ であること。
- 実行: `micromamba run -n sage sage sagemath/check/anticommutation-and-squares-of-split-clifford-generators/check_anticommutation_and_squares_of_split_clifford_generators.sage`（SageMath 10.9、2026-11-16、約 25 秒）。
- 結果: 通過（確認 397 件、否定の対照 11 件）。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。$`\mathrm{Cl}(V,q)`$ の実装は SageMath のものであり、本文の商代数の構成の検算ではない。
