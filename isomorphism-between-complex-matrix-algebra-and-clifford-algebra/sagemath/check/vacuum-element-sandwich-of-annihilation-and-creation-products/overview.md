# 消滅の逆順の積と生成の積の積を真空への射影にあたる元で挟んだ元の検算

- 対象ラベル: `claim_initial_reverse_ordered_annihilation_product_splits_off_last_number`
- 対象ラベル: `claim_vacuum_factor_commutes_with_lower_initial_parts`
- 対象ラベル: `claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset`
- 対象ラベル: `claim_vacuum_sandwich_when_last_number_is_in_neither_subset`
- 対象ラベル: `claim_vacuum_sandwich_when_last_number_is_in_both_subsets`
- 対象ラベル: `claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part`
- 対象ラベル: `claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero`
- 対象ラベル: `claim_vacuum_element_sandwich_of_annihilation_and_creation_products`
- 検算: [check_vacuum_element_sandwich_of_annihilation_and_creation_products.sage](check_vacuum_element_sandwich_of_annihilation_and_creation_products.sage)
- 方法: クリフォード代数の中の等式を、準同型 $`\Phi`$ による行列の像で確かめる。$`a_{T,\le m}`$・$`a^{\dagger}_{U,\le m}`$・$`P_{\le m}`$ の像は因子の像を同じ順に掛けた行列の積、$`Q^{T,U}_m`$ の像は定義と同じ括弧の積とする。すべての $`T,U\in\mathcal{P}_M`$ と $`m`$ について、$`m=M`$ での定義の読み、番号が $`m`$ 以下で一致するなら $`Q^{T,U}_m=P_{\le m}`$、一致しないなら $`0`$、$`a_{T,\le m}=z^T_ma_{T,\le m-1}`$、$`x_m`$ と $`a_{T,\le m-1}a^{\dagger}_{U,\le m-1}`$ の交換、準備の三つの等式、番号 $`m`$ の入り方の三つの場合の漸化式、主張 $`(P(a_Ta^{\dagger}_U))P=\delta_{T,U}P`$ を確かめる。否定コントロールとして、両方に入る場合の漸化式の生成と消滅を取り違えると成り立たないこと、$`P`$ で挟まない $`a_Ta^{\dagger}_U`$ が $`\delta_{T,U}I`$ にならない組があることを確かめた。主張が両辺とも零で自明に通っていないことを見るため、非自明に成り立った件（一致する場合で $`Q^{T,U}_m\ne0`$、一致しない場合で $`a_{T,\le m}a^{\dagger}_{U,\le m}\ne0`$ なのに $`Q^{T,U}_m=0`$、両方に入る場合・どちらにも入らない場合の漸化式で両辺が零でない、$`T=U`$ で両辺が零でない、$`T\ne U`$ で $`a_Ta^{\dagger}_U\ne0`$ なのに両辺が零）を数え、正であることを確かめる（零でないのに挟むと零になる二つの件は $`M\ge2`$ で確かめる）。計算は整数行列の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/vacuum-element-sandwich-of-annihilation-and-creation-products/check_vacuum_element_sandwich_of_annihilation_and_creation_products.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った（漸化式は 4 件・32 件・192 件）。非自明に成り立った件は、$`M=3`$ で、一致して $`Q\ne0`$ が 120 件、挟む前は零でないのに $`Q=0`$ が 136 件、両方に入る漸化式・どちらにも入らない漸化式で両辺が零でないものが各 28 件、$`T=U`$ で両辺が零でないものが 8 件、$`T\ne U`$ で $`a_Ta^{\dagger}_U\ne0`$ なのに両辺が零が 56 件（$`M=1`$: 6・2・1・1・2・2 件、$`M=2`$: 28・20・6・6・4・12 件）。
- 位置づけ: 行列への像での確認であり、クリフォード代数の中の等式の証明ではない。有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明でもない。
