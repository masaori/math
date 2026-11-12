# 行列環からクリフォード代数への準同型と、主定理の検算

- 対象ラベル: `claim_product_of_matrix_unit_elements_of_split_clifford_algebra`
- 対象ラベル: `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit`
- 対象ラベル: `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism`
- 対象ラベル: `claim_homomorphism_to_matrix_algebra_on_matrix_unit_element`
- 対象ラベル: `claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity`
- 対象ラベル: `claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements`
- 対象ラベル: `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix`
- 対象ラベル: `claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements`
- 対象ラベル: `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix`
- 対象ラベル: `theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra`
- 検算: [check_homomorphism_from_matrix_algebra_to_clifford_algebra.sage](check_homomorphism_from_matrix_algebra_to_clifford_algebra.sage)
- 方法: クリフォード代数の中の等式を、準同型 $`\Phi`$（$`\Phi(a^{\dagger}_i)=c_i`$、$`\Phi(a_i)=c_i^{\mathsf T}`$）による行列の像で確かめる。$`M=1,2,3`$ で、$`\Phi(a^{\dagger}_S)\Phi(P)\Phi(a_T)=E_{S,T}`$ と、その証明の中間の等式（$`\Phi(P)=E_{\emptyset,\emptyset}`$、$`\Phi(a^{\dagger}_S)E_{\emptyset,\emptyset}=E_{S,\emptyset}`$、$`E_{S,\emptyset}E_{\emptyset,\emptyset}=E_{S,\emptyset}`$、$`E_{\emptyset,\emptyset}\Phi(a_T)=E_{\emptyset,T}`$）、行列単位にあたる元の積の規則の像、$`\Phi(\Psi(F))=F`$ と $`\Psi`$ が和・スカラー倍・積・単位元を保つことの像（乱数の種を固定した整数行列 $`F,G`$）、$`\Psi(E_{S,T})`$ の像、生成作用素の行列の列の和と消滅作用素の行列の行の和の像、$`\Psi(c_i)=a^{\dagger}_i`$・$`\Psi(c_i^{\mathsf T})=a_i`$ の像を確かめる。列の和の証明の場合分け（$`(c_i)_{S,T}`$ が $`i\notin T`$ のとき $`\varsigma(N_i(T))\delta_{T\cup\{i\},S}`$、$`i\in T`$ のとき 0）は成分で確かめる。否定コントロールとして、$`a_T`$ を番号順に掛けると $`E_{S,T}`$ にならないこと（$`M\ge2`$）、列の和を右から掛けた形 $`\Phi(e_{T,T})c_i`$ と比べると一致しないこと（$`M\ge2`$）、$`e_{T,S}`$ で作った写像の像が転置になり逆写像にならないこと、1 の分解から一項を抜くと単位行列にならないことを確かめた。計算は整数行列の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/homomorphism-from-matrix-algebra-to-clifford-algebra/check_homomorphism_from_matrix_algebra_to_clifford_algebra.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 行列への像での確認であり、クリフォード代数の中の等式の証明ではない。$`\Phi`$ が単射であることはこの検算の前提に入っていないので、$`\Psi\circ\Phi=\mathrm{id}`$ は生成元の像での一致として確かめただけである。有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明でもない。
