# 単位行列の分解の検算

- 対象ラベル: `claim_decomposition_of_identity_matrix_into_matrix_units`
- 検算: [check_identity_matrix_decomposition_into_matrix_units.sage](check_identity_matrix_decomposition_into_matrix_units.sage)
- 方法: $`X=\{0,\dots,n-1\}`$（$`n=1,2,3,4`$）について、主張の行列の等式を、左辺の和を番号順に足して比べる。
  すべての $`p,q,x\in X`$ について、準備の等式の行と $`(p,q)`$ 成分の鎖の行を、整数の厳密計算で一行ずつ比べる。
  クロネッカーのデルタの値は $`0,1\in\mathbb{Z}`$ なので、浮動小数点は使わない。
- 実行: この VM には SageMath が無いため、Sage と Python の両方で動く書き方にしたファイルを
  `python3 -I` で実行した（2026-11-06）。
- 結果: 通過。$`(n,p,q)`$ の組 30 件（$`1+4+9+16`$）で、すべての行が一致した。
- 位置づけ: 成分の等式の裏取りであり、証明ではない。
