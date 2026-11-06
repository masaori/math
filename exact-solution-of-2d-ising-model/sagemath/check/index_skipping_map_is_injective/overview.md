# SageMath Check: index_skipping_map_is_injective

## 対象

**対象ラベル**: `index_skipping_map_is_injective` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_index_skipping_map_is_injective`（一つの添字を飛ばす写像は単射である）と、同じ回に足した
  `calc_formulae_claim_index_skipping_map_never_takes_skipped_index`（`index_skipping_map_never_takes_skipped_index`）・
  `calc_formulae_claim_index_skipping_map_reaches_every_other_index`（`index_skipping_map_reaches_every_other_index`）
- 範囲: 3 つの主張と、各証明の場合分けの鎖の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `index_skipping_map_never_takes_skipped_index` の `j < k` の 2 行・`j ≥ k` の 3 行 | `check_index_skipping_map_properties.sage` | `m = 1,…,9`、全ての `k`、全ての `j` で各行の等号・不等号と結論 `δ^m_k(j) ≠ k` | **PASS** | 有限の全数検査 |
| `index_skipping_map_is_injective` の 4 つの場合の鎖（3 行・5 行・5 行・5 行） | 同上 | 全ての `j, j'` の組で、`δ^m_k(j) = δ^m_k(j')` の組は各行を、`j < k ≤ j'`・`j' < k ≤ j` の組は不等号の鎖と仮定が成り立たないことを確かめ、結論 `j = j'` | **PASS** | 有限の全数検査 |
| `index_skipping_map_reaches_every_other_index` の `i < k` の 2 行・`i > k` の 3 行 | 同上 | `i ≠ k` の全ての `i` で、置いた `j` が `{1,…,m}` に入り `j ≥ k`（`i > k` の場合）であることと各行 | **PASS** | 有限の全数検査 |
| 否定コントロール | 同上 | 境界を 1 つずらした写像（`j ≤ k` なら `j`）は、`k ≤ m` のとき `k` を値に取る | **PASS** | 45 件 |

鎖の段は全体で 6270 段である。

## 計算の帰属と範囲

添字は `ZZ` の元で、本文と同じ 1 始まりで書いた。浮動小数点と `RR` / `CC` への脱出はない。
一般の `m` は人手証明が担い、この検算は `m ≤ 9` の全数検査で書き間違いを検出する。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh index_skipping_map_is_injective
```

実行ログは `sagemath/check/index_skipping_map_is_injective/logs/` に保存する（2026-11-06）。
