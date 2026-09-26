# SageMath Check: 044_claim_max_eigenvalue の (−) セクター部分（退避）

## 対象

退避対象ラベル: `sector_decomposition_of_rayleigh_sup`（`c(M) = max(c_+(M), c_-(M))`）、
および `symmetrized_transfer_matrix_on_sectors` の旧 (±) 両符号版（`W P^{(±)} = V^{(±)} P^{(±)}`）

**これらはもう本文ではない。** (−) セクターを本文から外したとき（2026-09-26）、上限の最大値分解は参照用ノート
`structured-latex/notes/minus_sector_not_adopted.ts` の `note_maxeig_claim_c_plus_le_c_minus_sector_maxeig_010_claim_sector_decomposition_of_c` へ内容のまま退避され、
本文には片側の不等式 `c_plus_le_c`（`c_+(M) ≤ c(M)`）だけが残った。`symmetrized_transfer_matrix_on_sectors` は
`W P^{(+)} = V^{(+)} P^{(+)}` だけの主張に縮められた。

ここは `check/044_claim_max_eigenvalue/` から複製した旧版の記録である（本文側の検査は同ディレクトリで (+) だけに書き直した）。

| ファイル | 検証内容 | ステータス |
|---|---|---|
| `check_03_sector_split.sage` | `c(M) = max(c_+,c_-)`、`W P^{(±)} = V^{(±)} P^{(±)}`、最大が `(+)` セクターにあること | PASS |
| `check_B_P_equals_C_P.sage` ほか 9 本（`_sector_representation_prelude.sage` を使う） | `BP=CP` から `CV_2CP=V^{(±)}P` までの九段を両セクターで一行ずつ | PASS |

`_prelude.sage` は `../043_claim_transfer_matrix_bridge/_prelude.sage`（同じく退避先の複製）を読む。
ラベルは本文に実在しないので、`tools/verify-check-linkage.ts` の対象外である。

## 実行方法

このディレクトリで各 `check_*.sage` を実行する。2026-09-26 に SageMath 10.9 で再実行し、全 10 本 PASS した（`logs/`）。
