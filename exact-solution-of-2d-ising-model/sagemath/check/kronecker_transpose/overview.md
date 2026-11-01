# SageMath Check: kronecker_transpose

## 対象

**対象ラベル**: `kronecker_transpose` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_000d_claim_kronecker_transpose`（クロネッカー積の転置）
- 範囲: 主張 `(A_1⊠⋯⊠A_M)^⊤ = A_1^⊤⊠⋯⊠A_M^⊤` と、証明の成分計算の四行、最後の段の「ν が全単射」

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `((A_1⊠⋯⊠A_M)^⊤)_{ν(I),ν(J)} = (A_1⊠⋯⊠A_M)_{ν(J),ν(I)}` | `check_transpose_definition_on_kronecker.sage` | Sage の `transpose` で取った転置の成分が、元の行列の添字を入れ替えた成分に一致する。本文の定め方（`def_matrix_transpose`）どおりに成分から組んだ転置が Sage の `transpose` と一致する | **PASS** | `M=1,…,4` の 340 成分で厳密等号 |
| `= ∏_k (A_k)_{j_k i_k}` | `check_kronecker_entry_of_original.sage` | Sage の `tensor_product` で組んだクロネッカー積の成分が、不定元の積を直接書いたものに一致する。本文の定め方（`def_kronecker`）どおりに組んだ行列が `tensor_product` の行列と一致する（ν の番号付けが Sage の行・列の並びと同じ） | **PASS** | 340 成分で厳密等号 |
| `= ∏_k (A_k^⊤)_{i_k j_k}` | `check_factorwise_transpose.sage` | 各因子の転置を Sage の `transpose` で取り、積が一致する。各因子について、本文の定め方どおりの転置と一致する | **PASS** | 340 成分で厳密等号 |
| `= (A_1^⊤⊠⋯⊠A_M^⊤)_{ν(I),ν(J)}` | `check_kronecker_entry_of_transposes.sage` | 転置した因子を Sage の `tensor_product` で組んだ行列の成分が、積に一致する | **PASS** | 340 成分で厳密等号 |
| 最後の段（ν は全単射で、どの番号も `ν(I)` の形） | `check_index_numbering_bijective.sage` | `ν` の値が `1,…,2^M` をちょうど一度ずつ取る | **PASS** | `M=1,…,4` |
| 主張そのもの | `check_statement_whole_matrix.sage` | 両辺を行列全体として、Sage 組み込みの経路と本文の定め方の経路の両方で比べる。対照として、一般の `A_1⊠A_2` が転置と一致しない（不定元の比較が自明でない）ことも確かめる | **PASS** | `M=1,…,4` で厳密等号 |

## 計算の帰属と範囲

`A_1,…,A_M` の成分をすべて `QQ` 上の多項式環の不定元として置いた。多項式の等号は厳密に決定でき、
不定元で成り立つ等号は成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）ので、
各 `M` については主張を一般の複素数成分で確かめたことになる。浮動小数点と `RR` / `CC` への脱出はない。

`M ∈ {1,2,3,4}` を確かめた。一般の `M` は検算の範囲外で、人手証明が担う。

第一行と第三行は転置の定め方を、第二行と第四行はクロネッカー積の定め方をそのまま当てはめる行である。
定め方どおりに成分から組んだ行列（`_prelude.sage` の `transpose_by_definition`・`kron_by_definition`）だけで
比べると構成上かならず一致して何も確かめないので、Sage 組み込みの `transpose`・`tensor_product` を
独立な経路として置き、各行の片側をそちらで作った。両経路の行列の一致もあわせて確かめた。

添字は本文の 1 始まりで持ち、Sage の行列を引くときだけ 1 を引く（`_prelude.sage` の `entry`）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh kronecker_transpose
```

実行ログは `sagemath/check/kronecker_transpose/logs/` に保存する。
