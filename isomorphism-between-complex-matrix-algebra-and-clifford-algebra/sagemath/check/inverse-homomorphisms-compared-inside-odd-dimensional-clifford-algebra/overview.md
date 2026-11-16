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
  単位元と、行列単位の組 $`(E_{S,T},0)`$・$`(0,E_{S,T})`$ どうしの積を保つことを、$`M=1,2,3`$ のすべてで全部の組（$`M=3`$ は $`128^2=16384`$ 組、約 170 秒）について $`\mathrm{Cl}(V',q')`$ の中で直接比べた。
  $`\Psi'(\Phi'(a))=a`$ を、基底 $`2\cdot4^M`$ 個・生成元 $`\gamma'(y)`$（基底の座標と乱数の座標 3 つ）・その二つの積・乱数の元 3 つで、
  $`\mathrm{Cl}(V',q')`$ の元として直接比べた（行列への像での確認ではない）。
  $`\Psi'\circ\Phi'=\mathrm{id}`$ の証明の式変形は、各行の値を $`\mathrm{Cl}(V',q')`$ の中で計算し、隣どうしを `==` で比べた（行列への像での確認ではない）。
  そのために $`A=\mathrm{Cl}(V,q)`$ を別の `CliffordAlgebra` として作り、$`j`$ を生成元 $`\gamma(d_k)\mapsto\gamma'(\mathrm{in}'_1(d_k))`$ の単調な積で計算し（$`A`$ の基底 $`4^M`$ 個どうしの積を保つことも確かめた）、
  $`\Phi:A\to B`$ と $`\Psi:B\to A`$ は $`A`$ の中で計算した（$`\Psi'`$ の値は $`A'`$ の中で $`j(\mathcal{E}_{S,T})`$ を直接組み立てるので、別の経路になる）。$`j(\varepsilon)`$ と $`\Phi(\varepsilon)`$ が上の値と一致することも確かめた。
  $`\Xi(j(y))=j(y)`$ の 6 個の等号を、$`y`$ が $`A`$ の基底 $`4^M`$ 個と乱数の元 2 つのそれぞれで比べた。
  $`\Xi(g)=g`$ の 15 個の等号（$`\Psi'((\Phi(\varepsilon),(-1_{\mathbb{C}})\ast\Phi(\varepsilon)))`$ から $`1_{A'}\cdot g`$ を経て $`g`$ まで）を比べた。
  $`\Xi(\gamma'(x))=\gamma'(x)`$ の 6 個の等号（最後の $`\mathrm{id}_{A'}`$ の行を除く）を、$`x=(v,t)`$ の $`v`$ が基底の座標と乱数の座標 3 つ、$`t`$ が $`0`$、$`1`$、乱数のそれぞれで比べた。
  比べた等号の数は、$`\Xi(j(y))`$ が 540 個、$`\Xi(g)`$ が 45 個、$`\Xi(\gamma'(x))`$ が 378 個である（$`M=1,2,3`$ の合計）。
  否定の対照: $`\Phi'(g)`$ を $`(I,-I)`$ にすると基底どうしの積を保たないこと、$`e_\pm`$ の $`\tfrac12`$ を落とすと $`\Psi'(\Phi'(1))=1`$ が崩れること、
  $`e_+`$ と $`e_-`$ を入れ替えると $`\Psi'(\Phi'(g))=g`$ が崩れること、$`\Xi(g)`$ の一行目で第二成分の $`-1_{\mathbb{C}}`$ を落とすと値が $`g`$ にならないこと、
  $`\Xi(j(y))`$ の二行目で $`e_-`$ を $`e_+`$ にすると $`y=1_A`$ で $`1_{A'}`$ にならないこと。
- 実行: `micromamba run -n sage sage sagemath/check/inverse-homomorphisms-compared-inside-odd-dimensional-clifford-algebra/check_inverse_homomorphisms_compared_inside_odd_dimensional_clifford_algebra.sage`（SageMath 10.9、2026-11-16、約 150 秒）。
- 結果: 通過（2026-11-16 の実行で確認 40700 件、否定の対照 15 件）。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。$`\mathrm{Cl}(V',q')`$ の実装は SageMath のものであり、本文の商代数の構成の検算ではない。
