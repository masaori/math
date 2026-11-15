# 二つの準同型の合成を奇数次元の二次空間のクリフォード代数の中で直接比べる検算

- 対象ラベル: `claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity`
- 対象ラベル: `claim_existence_and_uniqueness_of_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras`
- 対象ラベル: `claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism`
- 検算: [check_inverse_homomorphisms_compared_inside_odd_dimensional_clifford_algebra.sage](check_inverse_homomorphisms_compared_inside_odd_dimensional_clifford_algebra.sage)
- 方法: $`M=1,2,3`$ で、$`V'=V\oplus\mathbb{C}^{\mathrm{vec}}`$ の基底 $`d'_k=\mathrm{in}'_1(d_k)`$（$`k\le 2M`$）、$`d'_{2M+1}=u=\mathrm{in}'_2(1)`$ の座標 $`y`$ について
  $`q'(y)=\sum_k y_ky_{M+k}+y_{2M+1}^2`$ とし、$`\mathrm{Cl}(V',q')`$ を SageMath の `CliffordAlgebra`（係数 `QQ`）で作る。
  $`j(a^{\dagger}_i)=\gamma'(d'_i)`$、$`j(a_i)=\gamma'(d'_{M+i})`$、$`g=\gamma'(u)`$ とする。
  $`B\times B`$ の元 $`(X,Y)`$ は、計算の便宜として区分対角の行列 $`\mathrm{diag}(X,Y)`$ で持つ（積と和は成分ごとの積と和に一致する）。
  $`\Phi'`$ は、生成元の像 $`\Phi'(j(a^{\dagger}_i))=(c_i,c_i)`$・$`\Phi'(j(a_i))=(c_i^{\mathsf T},c_i^{\mathsf T})`$・$`\Phi'(g)=(\Phi(\varepsilon),-\Phi(\varepsilon))`$
  （$`\Phi(\varepsilon)=\prod_i(c_i^{\mathsf T}c_i-c_ic_i^{\mathsf T})`$）から、基底の単調な積を像の積へ送って線型に延ばした写像として計算し、
  単位元と基底 $`2\cdot4^M`$ 個どうしの積をすべて保つことを確かめた（$`\Phi'`$ の存在の裏取り）。
  $`\Psi'(F,G)=j(\Psi(F))e_++j(\Psi(G))e_-`$（$`e_\pm=\tfrac12(1\pm z)`$、$`z=j(\varepsilon)g`$）は $`\mathrm{Cl}(V',q')`$ の中で計算し、
  単位元と、行列単位の組 $`(E_{S,T},0)`$・$`(0,E_{S,T})`$ どうしの積を保つことを確かめた（$`M=1,2`$ は全部の組、$`M=3`$ は固定した種で無作為に選んだ 400 組）。
  $`\Psi'(\Phi'(a))=a`$ を、基底 $`2\cdot4^M`$ 個・生成元 $`\gamma'(y)`$（基底の座標と乱数の座標 3 つ）・その二つの積・乱数の元 3 つで、
  $`\mathrm{Cl}(V',q')`$ の元として直接比べた（行列への像での確認ではない）。
  否定の対照: $`\Phi'(g)`$ を $`(I,-I)`$ にすると基底どうしの積を保たないこと、$`e_\pm`$ の $`\tfrac12`$ を落とすと $`\Psi'(\Phi'(1))=1`$ が崩れること、
  $`e_+`$ と $`e_-`$ を入れ替えると $`\Psi'(\Phi'(g))=g`$ が崩れること。
- 実行: `micromamba run -n sage sage sagemath/check/inverse-homomorphisms-compared-inside-odd-dimensional-clifford-algebra/check_inverse_homomorphisms_compared_inside_odd_dimensional_clifford_algebra.sage`（SageMath 10.9、2026-11-15、約 25 秒）。
- 結果: 通過（確認 19373 件、否定の対照 9 件）。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。$`\mathrm{Cl}(V',q')`$ の実装は SageMath のものであり、本文の商代数の構成の検算ではない。
