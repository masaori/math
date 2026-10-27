# ブロック対角行列の置換項のファイバー別分解

**対象ラベル**: `claim_block_diagonal_term_factorization`

有限添字集合の大きさ 0〜4、三つのファイバーへの全写像、各ファイバーの全置換を対象に、本文の四つの等号を一行ずつ検算する。係数は `\mathbb Q[x]` で厳密に計算し、`\overline{\mathbb Q}[x]` の主張の有理係数の例を確認する。一般の有限集合についての証明は本文と Lean に置く。

| ファイル | 対象の等号 | 実行状態 |
|---|---|---|
| `check_sign_factor.sage` | 貼合せの符号と各ファイバーの符号 | PASS（2026-10-27、436項） |
| `check_constant_embedding.sage` | 定数多項式への埋込みと有限積 | PASS（2026-10-27、436項） |
| `check_fiber_product.sage` | 全添字の成分積とファイバー別の成分積 | PASS（2026-10-27、436項） |
| `check_pair_products.sage` | 符号の積と成分積の組合せ | PASS（2026-10-27、436項） |
