# 2 進の番号付けによる行列の添字の付け替えの検算

- 対象ラベル: `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism`
- 対象ラベル: `claim_inverse_reindexing_after_reindexing_of_matrices_is_identity`
- 対象ラベル: `claim_reindexing_after_inverse_reindexing_of_matrices_is_identity`
- 対象ラベル: `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism`
- 対象ラベル: `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras`
- 検算: [check_reindexing_of_matrices_by_binary_numbering.sage](check_reindexing_of_matrices_by_binary_numbering.sage)
- 方法: $`X:=\mathcal{P}_M`$、$`(n,e):=(2^M,e_M)`$ で $`\nu_e(F)_{k,l}=F_{e(k),e(l)}`$ と $`\mu_e(G)_{x,y}=G_{e^{-1}(x),e^{-1}(y)}`$ を作る。
  $`\mathcal{P}_M`$ で添字づけた行列は部分集合の組を鍵にした表で持ち、積は定義どおり $`\sum_{z\in\mathcal{P}_M}`$ で計算する。
  $`M=1,2,3`$ で、乱数の種を固定した整数行列について、$`\nu_e`$ と $`\mu_e`$ が和・積・スカラー倍・単位元を保つこと、
  $`\mu_e\circ\nu_e=\mathrm{id}`$、$`\nu_e\circ\mu_e=\mathrm{id}`$ を確かめる。否定の対照として、列だけを別の全単射 $`l\mapsto e_M(2^M+1-l)`$ で付け替えた写像は、
  単位行列も積も保たないことを確かめた。計算は整数の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/reindexing-of-matrices-by-binary-numbering/check_reindexing_of_matrices_by_binary_numbering.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ と有限個の行列での裏取りであり、証明ではない。
