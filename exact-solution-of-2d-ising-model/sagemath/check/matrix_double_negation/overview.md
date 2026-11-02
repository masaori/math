# SageMath Check: matrix_double_negation

## 対象

**対象ラベル**: `matrix_double_negation` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_double_negation`（行列の符号反転を二回施すと元に戻る）
- 範囲: 主張 `-(-A) = A` と、証明の `(i,j)` 成分の六行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の六行 | `check_component_chain.sage` | 鎖の項を各行に書かれた式どおりに組み、隣り合う項が等しい | **PASS** | 9 通りの大きさ、全成分で厳密等号 |
| 主張そのもの | 同上 | 本文の成分の式で組んだ左辺を右辺 `A` と比べ、Sage 組み込みの符号反転（独立な経路）で組んだ `-(-A)` とも比べる。否定コントロールとして、一回だけ符号反転した `-A` とは一致しないことも確かめる | **PASS** | 9 通りの大きさで厳密等号 |

## 計算の帰属と範囲

`A` の成分（`m, n ∈ {1, 2, 3}`）を `QQ` 上の多項式環の不定元に置いた。
不定元で成り立つ多項式の等号は、任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさは検算の範囲外で、人手証明が担う。

符号反転は `multiply_by_minus_one` のとおり `(-1)·z`、行列の符号反転は共通の準備
`_shared/matrix_operations_by_definition.sage`・`_shared/matrix_negation_and_difference_by_definition.sage` で本文の定義どおり成分から組んだ。
定義の行はその組み方と同じ式なので構成上かならず一致し、検出できるのは本文の式の写し間違いだけである。
これを補うため、主張は Sage 組み込みの符号反転とも比べた。添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_double_negation
```

実行ログは `sagemath/check/matrix_double_negation/logs/` に保存する（2026-11-02）。
