# SageMath Check: identity_matrix_is_right_unit_of_mat_mult

## 対象

**対象ラベル**: `identity_matrix_is_right_unit_of_mat_mult` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_identity_matrix_is_right_unit_of_mat_mult`（単位行列を右から掛けても変わらない）
- 範囲: 主張 `AI = A` と、証明の `(i,k)` 成分の八行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `(AI)_{ik}` の鎖の八行（積の定義、単位行列の定義、`j = k` の項を分ける、δ の値、`z1 = z`、積の交換律、`0z = 0`、`z + 0 = z`） | `check_component_chain.sage` | 九つの項を各行に書かれた式どおりに組み（分けた和は、分けた項と残りの添字の和を別々に組む）、隣り合う項が等しい | **PASS** | 9 通りの大きさ、全成分で厳密等号 |
| 主張そのもの | `check_statement_whole_matrix.sage` | δ から組んだ単位行列が Sage の `identity_matrix`（独立な経路）と一致し、本文の成分の式で組んだ積で `AI = A` | **PASS** | 9 通りの大きさで厳密等号 |

## 計算の帰属と範囲

`A` の成分を `QQ` 上の多項式環の不定元に置いた。大きさは `m, n ∈ {1, 2, 3}` で、分けた残りの和が空になる `n = 1` を含む。
不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさは検算の範囲外で、人手証明が担う。

鎖の項は多項式環の元なので、各行の根拠（項を分けること、`z1 = z`、積の交換律、`0z = 0`、`z + 0 = z`）の適用は Sage の正規形で吸収される。
この検査が確かめるのは、各行に書かれた式（添字・和の範囲・括弧）が前の行と同じ値を持つことである。
とくに「積の定義」「単位行列の定義」「δ の値」の行（第一・第二・第四行）は、共通の準備 `_shared/matrix_operations_by_definition.sage` の
組み方と同じ式なので構成上かならず一致し、検出できるのは本文の式の写し間違いだけである。これを補うため、主張は
Sage 組み込みの演算（独立な経路）とも比べた。添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh identity_matrix_is_right_unit_of_mat_mult
```

実行ログは `sagemath/check/identity_matrix_is_right_unit_of_mat_mult/logs/` に保存する。
