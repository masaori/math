# 行列単位にあたる元がクリフォード代数の基底をなすことの検算

- 対象ラベル: `claim_entry_of_image_of_linear_combination_of_matrix_unit_elements`
- 対象ラベル: `claim_family_of_matrix_unit_elements_is_linearly_independent`
- 対象ラベル: `claim_family_of_matrix_unit_elements_spans_clifford_algebra`
- 対象ラベル: `theorem_matrix_unit_elements_form_basis_of_clifford_algebra`
- 検算: [check_matrix_unit_elements_form_basis_of_clifford_algebra.sage](check_matrix_unit_elements_form_basis_of_clifford_algebra.sage)
- 方法: クリフォード代数の中の族 $`b_m=\mathcal{E}_{S_m,T_m}`$ を、準同型 $`\Phi`$（$`\Phi(a^{\dagger}_i)=c_i`$、$`\Phi(a_i)=c_i^{\mathsf T}`$）による行列の像で確かめる。
  $`M=1,2,3`$ で、$`p_M`$ を `def_numbering_of_pairs_of_subsets` の式どおりに作り、証明の準備（イ）$`\Phi(b_m)=E_{S_m,T_m}`$ と（ロ）$`(E_{S_m,T_m})_{S_j,T_j}=\delta_{m,j}`$、
  乱数の種を固定した整数の係数 $`\lambda_m`$ について $`\Phi(\sum_m\lambda_mb_m)_{S_j,T_j}=\lambda_j`$、整数行列 $`F`$ について $`\sum_mF_{S_m,T_m}\Phi(b_m)=F`$、
  $`\Phi(b_m)`$ を並べた $`N_M\times 4^M`$ 行列の階数が $`N_M`$ であることを確かめる。否定の対照として、第二成分を第一成分に揃えた族 $`\mathcal{E}_{S_m,S_m}`$ の像の階数は $`N_M`$ より小さいことを確かめた。
  計算は整数行列の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/matrix-unit-elements-form-basis-of-clifford-algebra/check_matrix_unit_elements_form_basis_of_clifford_algebra.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 行列への像での確認であり、クリフォード代数の中の主張の証明ではない。像の一次独立と張ることは $`\Phi`$ の側の事実であり、
  クリフォード代数の側へ戻すのは証明の中の $`\Psi\circ\Phi=\mathrm{id}`$ の段である。有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明でもない。
