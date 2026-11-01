# SageMath Check: mat_columnwise

## 対象

**対象ラベル**: `mat_columnwise` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_004_action_on_matrix_pair`（行列の積は列ごとに作用する）
- 範囲: 主張 `A[b_1 … b_p] = [Ab_1 … Ab_p]` と、証明の成分計算の四行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `(A[b_1 … b_p])_{ik} = Σ_j A_{ij}([b_1 … b_p])_{jk}` | `check_matrix_product_definition_on_left.sage` | Sage の行列積の成分と、成分の和を直接書いたものが一致する | **PASS** | 108 成分で厳密等号 |
| `= Σ_j A_{ij}(b_k)_j` | `check_column_matrix_entry.sage` | 定め方の行。本文の定め方どおりに組んだ行列が Sage の `column_matrix` で組んだ行列と一致し、後者の成分で作った和が `Σ_j A_{ij}(b_k)_j` に一致する | **PASS** | 27 通りの大きさで行列が一致、108 成分で厳密等号 |
| `= (Ab_k)_i` | `check_matrix_product_definition_on_column.sage` | 成分の和と、Sage の行列とベクトルの積の第 `i` 成分が一致する | **PASS** | 108 成分で厳密等号 |
| `= ([Ab_1 … Ab_p])_{ik}` | `check_column_matrix_entry_of_products.sage` | 定め方の行。積 `Ab_k` を Sage の `column_matrix` で列に並べた行列の `(i,k)` 成分が `(Ab_k)_i` であり、その行列が本文の定め方どおりに組んだ行列と一致する | **PASS** | 27 通りの大きさで行列が一致、108 成分で厳密等号 |
| 主張そのもの | `check_statement_whole_matrix.sage` | 両辺を行列全体として比べる（左辺の列に並べた行列は本文の定め方で、右辺は Sage の `column_matrix` で組む） | **PASS** | 27 通りの大きさで厳密等号 |

## 計算の帰属と範囲

`A` の成分と `b_k` の成分をすべて、`QQ` 上の多項式環の不定元として置いた。
多項式の等号は厳密に決定でき、不定元で成り立つ等号は成分へ任意の複素数を代入しても成り立つ
（代入は環準同型である）ので、各大きさについては主張を一般の複素数成分で確かめたことになる。
浮動小数点と `RR` / `CC` への脱出はない。

大きさは `m, n, p ∈ {1, 2, 3}` の 27 通りである。一般の `m, n, p` は検算の範囲外で、人手証明が担う。

第二行と第四行は「列に並べた行列」の定め方をそのまま当てはめる行である。定め方どおりに成分から組んだ行列
（`_prelude.sage` の `columns_matrix`）だけで比べると構成上かならず一致して何も確かめないので、
Sage 組み込みの `column_matrix` で組んだ行列を独立な経路として置き、両者の一致と成分を確かめた。
第一行と第三行は、片側が Sage の行列積、もう片側が成分の和を直接書いたもので、独立な経路である。

検算の添字は Sage の 0 始まりで、本文の `i, j, k` から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh mat_columnwise
```

実行ログは `sagemath/check/mat_columnwise/logs/` に保存する。
