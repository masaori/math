# 一つの番号の消滅と生成の積についての等式の検算

- 対象ラベル: `claim_annihilation_generator_commutes_with_other_number_reversed_pair`
- 対象ラベル: `claim_vacuum_factors_with_different_numbers_commute`
- 対象ラベル: `claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator`
- 対象ラベル: `claim_creation_generator_times_vacuum_factor_is_creation_generator`
- 対象ラベル: `claim_vacuum_factor_is_idempotent`
- 対象ラベル: `claim_creation_vacuum_annihilation_factor_of_one_number`
- 検算: [check_single_number_identities_of_vacuum_factor.sage](check_single_number_identities_of_vacuum_factor.sage)
- 方法: クリフォード代数の中の等式を、準同型 $`\Phi`$（$`\Phi(a^{\dagger}_i)=c_i`$、$`\Phi(a_i)=c_i^{\mathsf T}`$、$`\Phi(1)=I`$）による行列の像で確かめる。$`x_i`$ の像は $`c_i^{\mathsf T}c_i`$ とする。番号の違う $`i,j`$ について、準備の反交換 $`c_i^{\mathsf T}c_j+c_jc_i^{\mathsf T}=0`$ と交換 $`c_i^{\mathsf T}(c_jc_j^{\mathsf T})=(c_jc_j^{\mathsf T})c_i^{\mathsf T}`$ の鎖の各行、$`x_ix_j=x_jx_i`$ の鎖の各行を確かめる。各 $`i`$ について、$`x_ic_i^{\mathsf T}=c_i^{\mathsf T}`$・$`c_ix_i=c_i`$ の鎖の分配法則の行と反交換関係 $`c_i^{\mathsf T}c_i+c_ic_i^{\mathsf T}=I`$、$`x_ix_i=x_i`$、すべての $`S`$ での $`(\Phi(y^S_i)x_i)\Phi(z^S_i)=\Phi(u^S_i)`$ を確かめる。否定コントロールとして、$`c_i^{\mathsf T}x_i\neq c_i^{\mathsf T}`$、$`x_ic_i\neq c_i`$、$`i\in S`$ で積が $`c_i^{\mathsf T}c_i`$ にならないことを確かめた。計算は整数行列の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/single-number-identities-of-vacuum-factor/check_single_number_identities_of_vacuum_factor.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 行列への像での確認であり、クリフォード代数の中の等式の証明ではない。有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明でもない。
