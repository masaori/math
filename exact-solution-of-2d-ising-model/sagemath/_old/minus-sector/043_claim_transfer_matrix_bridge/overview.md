# SageMath Check: 043_claim_transfer_matrix_bridge の (−) セクター部分（退避）

## 対象

退避対象ラベル: `sector_replacement_of_V1` / `sector_replacement_pow` / `partition_function_sector_decomposition`
（および `epsilon_projector_properties` / `epsilon_commutes_with_transfer_matrices` の旧 (±) 両符号版）

**これらのブロック（と両符号の述べ方）はもう本文ではない。** (−) セクターを本文から外したとき（2026-09-26）、
010 章の `sector_replacement_of_V1`・`sector_replacement_pow`・`partition_function_sector_decomposition` は
参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` の
`note_maxeig_claim_symmetrized_transfer_matrix_on_sectors_minus_sector_bridge_011_claim_sector_replacement`、
`note_maxeig_claim_symmetrized_transfer_matrix_on_sectors_minus_sector_bridge_011a_claim_sector_replacement_pow`、
`note_partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix_minus_sector_bridge_012_claim_partition_function_sector_decomposition`
へ内容のまま退避され、射影子と可換性の主張は `P^{(+)}`・`V_1^{(+)}` だけの形に縮められた。

ここは `check/043_claim_transfer_matrix_bridge/` から移した旧版の記録である。

| ファイル | 検証内容 | 由来 | ステータス |
|---|---|---|---|
| `check_03_epsilon_projectors.sage` | `P^{(±)}` の性質（`P^{(+)}P^{(-)} = 0`、`P^{(+)}+P^{(-)} = I` を含む）、`ε` と `V_1^{(±)}`・`(V_1^{(±)})^{1/2}` の可換性、`V_1P^{(±)} = V_1^{(±)}P^{(±)}`、`(V_1V_2)^nP^{(±)} = (V_1^{(±)}V_2)^nP^{(±)}` | もと check の check_03（両符号版の複製） | PASS |
| `check_05_sector_decomposition.sage` | `tr((V_1V_2)^{N_row}) = tr(P^{(+)}(V^{(+)})^{N_row}) + tr(P^{(-)}(V^{(-)})^{N_row})`、4 項展開、対称化 | もと check の check_05（移動） | PASS |

本文に残った (+) 側の射影子・可換性は、`check/043_claim_transfer_matrix_bridge/` の check_03（(+) だけに書き直したもの）が検証する。
ラベルは本文に実在しないので、`tools/verify-check-linkage.ts`（`check/` 配下だけを見る）の対象外である。

## 実行方法

`_prelude.sage` は移動元の複製で、共有ライブラリを `../../../_shared/` から読む。このディレクトリで実行する。
2026-09-26 に SageMath 10.9 で再実行し、両検査とも PASS した（`logs/`）。
