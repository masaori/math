# 二つの準同型の合成を分裂した二次空間のクリフォード代数の中で直接比べる検算

- 対象ラベル: `claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity`
- 対象ラベル: `claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra`
- 対象ラベル: `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units`
- 検算: [check_inverse_homomorphisms_compared_inside_split_clifford_algebra.sage](check_inverse_homomorphisms_compared_inside_split_clifford_algebra.sage)
- 方法: $`M=1,2,3`$ で、$`V=W\oplus W^{*}`$ の基底 $`d_k=\mathrm{in}_1(w_k)`$、$`d_{M+k}=\mathrm{in}_2(f_k)`$ の座標 $`y`$ について
  $`q(y)=\sum_k y_ky_{M+k}`$ とし、$`\mathrm{Cl}(V,q)`$ を SageMath の `CliffordAlgebra`（関係 $`\gamma(y)\gamma(y)=q(y)1`$、係数 `QQ`）で作る。
  $`a^{\dagger}_i=\gamma(d_i)`$、$`a_i=\gamma(d_{M+i})`$ とする。
  $`\Phi`$ は、生成元の像 $`\Phi(a^{\dagger}_i)=c_i`$・$`\Phi(a_i)=c_i^{\mathsf T}`$（符号 $`(-1)^{N_i(T)}`$ で定義どおりに作った行列）から、
  基底の単調な積 $`\gamma(d_{j_1})\cdots\gamma(d_{j_r})`$（$`j_1<\dots<j_r`$）を像の積へ送って線型に延ばした写像として計算する。
  この写像が単位元と $`\mathrm{Cl}(V,q)`$ の基底 $`4^M`$ 個どうしの積をすべて保つことを確かめた（$`\Phi`$ の存在の裏取り）。
  $`\Psi(F)=\sum_{S,T}F_{S,T}\,a^{\dagger}_SPa_T`$ は $`\mathrm{Cl}(V,q)`$ の中で計算し、
  $`\Psi(E_{S,T})\Psi(E_{U,R})=\delta_{T,U}\Psi(E_{S,R})`$ をすべての $`S,T,U,R`$ で、
  $`\Psi(\Phi(a))=a`$ を基底 $`4^M`$ 個・生成元 $`\gamma(y)`$（基底の座標と乱数の座標 3 つ）・その二つの積・乱数の元 3 つで、
  $`\mathrm{Cl}(V,q)`$ の元として直接比べた（行列への像での確認ではない）。
  否定の対照: 生成元の像から符号を落とした行列では基底どうしの積を保たないこと（$`M=2,3`$）、$`\Psi`$ の式で $`P`$ を $`1`$ に替えると
  $`\Psi(\Phi(1))=1`$ が崩れること、$`a_i`$ と $`a^{\dagger}_i`$ を取り違えると $`\Psi(\Phi(\gamma(d_1)))=\gamma(d_1)`$ が崩れること。
- 実行: `micromamba run -n sage sage sagemath/check/inverse-homomorphisms-compared-inside-split-clifford-algebra/check_inverse_homomorphisms_compared_inside_split_clifford_algebra.sage`（SageMath 10.9、2026-11-15）。
- 結果: 通過（確認 9014 件、否定の対照 8 件）。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。$`\mathrm{Cl}(V,q)`$ の実装は SageMath のものであり、本文の商代数の構成の検算ではない。
