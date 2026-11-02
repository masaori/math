# SageMath Check: difference_of_negated_matrices

## 対象

**対象ラベル**: `difference_of_negated_matrices` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_difference_of_negated_matrices`（符号反転した行列の差は差の符号反転に等しい）
- 範囲: 主張 `(-A) - (-B) = -(A - B)` と、証明の行列の等号の三行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 行列の等号の三行 | `check_matrix_chain.sage` | 鎖の項を各行に書かれた式どおりに組み、隣り合う項が行列として等しい | **PASS** | 9 通りの大きさで厳密等号 |
| 主張そのもの | 同上 | Sage 組み込みの演算（独立な経路）で組んだ両辺と比べる。否定コントロールとして、符号を外へ出さない `A - B` とは一致しないことも確かめる | **PASS** | 9 通りの大きさで厳密等号 |

## 計算の帰属と範囲

`A`、`B` の成分（`m, n ∈ {1, 2, 3}`）を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさは検算の範囲外で、人手証明が担う。

差・符号反転・和・積は共通の準備 `_shared/matrix_operations_by_definition.sage`・`_shared/matrix_negation_and_difference_by_definition.sage` で本文の定義どおり成分から組んだ。
定義の行はその組み方と同じ式なので構成上かならず一致し、検出できるのは本文の式の写し間違いだけである。
これを補うため、主張は Sage 組み込みの演算とも比べた。添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh difference_of_negated_matrices
```

実行ログは `sagemath/check/difference_of_negated_matrices/logs/` に保存する（2026-11-02）。
