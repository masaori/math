# 行列単位の積の規則の検算

- 対象ラベル: `claim_product_of_matrix_units`
- 検算: [check_matrix_unit_product_rule.sage](check_matrix_unit_product_rule.sage)
- 方法: $`X=\{0,\dots,n-1\}`$（$`n=1,2,3`$）のすべての $`x,y,z,w,p,q,t\in X`$ について、主張の行列の等式、
  準備の等式の七行、$`(p,q)`$ 成分の鎖の十行を、整数の厳密計算で一行ずつ比べる。
  クロネッカーのデルタの値は $`0,1\in\mathbb{Z}`$ なので、浮動小数点は使わない。
- 実行: この VM には SageMath が無いため、Sage と Python の両方で動く書き方にしたファイルを
  `python3 -I` で実行した（2026-11-06）。
- 結果: 通過。$`(n,x,y,z,w,p,q)`$ の組 794 件（$`1+2^6+3^6`$）で、すべての行が一致した。
- 位置づけ: 成分の等式の裏取りであり、証明ではない。
