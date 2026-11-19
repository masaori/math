# SageMath Check: 正の元の平方根を添加した部分体への正錐の延長

**対象ラベル**: `claim_square_root_adjoined_positive_cone_extension`

`check.sage` は $F=\mathbb Q$、$a=2$、$E=\mathbb Q(\sqrt2)$ について、重み付き平方和が負の単位元を含まないこと、延長した正錐の和・積・三分法、$C_E\cap F=C_F$ を有限標本で検算する。数体の等号と実代数的数 `AA` の厳密な符号比較だけを使い、浮動小数点は使わない。`AA` は検算の符号判定に限り、本文の構成と Lean の証明は実数体への埋め込みを用いない。有限標本は全称命題の証明ではない。

| ファイル | ステータス | 結果 |
|---|---|---|
| `check.sage` | PASS | 2026-11-19、厳密計算 44426 件通過 |

実行: `sage check.sage`
