# SageMath Check: index_skipping_map_is_injective

## 対象

**対象ラベル**: `index_skipping_map_is_injective` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_index_skipping_map_is_injective`（一つの添字を飛ばす写像は単射である）
- 範囲: 主張と、証明の 4 つの場合の鎖の各行
- 同じ回に足した `index_skipping_map_never_takes_skipped_index`・`index_skipping_map_reaches_every_other_index` は、
  それぞれ `sagemath/check/index_skipping_map_never_takes_skipped_index/`・`sagemath/check/index_skipping_map_reaches_every_other_index/` が確かめる

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `index_skipping_map_is_injective` の 4 つの場合の鎖（3 行・5 行・5 行・5 行） | `check_index_skipping_map_properties.sage` | 全ての `j, j'` の組で、`δ^m_k(j) = δ^m_k(j')` の組は各行を、`j < k ≤ j'`・`j' < k ≤ j` の組は不等号の鎖と仮定が成り立たないことを確かめ、結論 `j = j'` | **PASS** | 有限の全数検査 |
| 定義の書き写しの検査 | 同上 | `δ^m_k(j)` が `{1,…,m+1} \ {k}` の小さい方から `j` 番目に一致する（`delta` と独立に作る） | **PASS** | 330 件 |
| 否定コントロール | 同上 | `j ≥ k` で `j + 1` の代わりに `j − 1` を取る写像は、`2 ≤ k ≤ m` のとき単射でない | **PASS** | 36 件 |

鎖の段は全体で 4620 段である。`δ^m_k(j) = δ^m_k(j')` の組は `j = j'` だけなので、場合が同じ側の鎖は同じ値どうしの比較になる（主張が正しいことの裏返しで避けられない）。

## 計算の帰属と範囲

添字は `ZZ` の元で、本文と同じ 1 始まりで書いた。浮動小数点と `RR` / `CC` への脱出はない。
一般の `m` は人手証明が担い、この検算は `m ≤ 9` の全数検査で書き間違いを検出する。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh index_skipping_map_is_injective
```

実行ログは `sagemath/check/index_skipping_map_is_injective/logs/` に保存する（2026-11-06。2026-11-09 に同じ回の 2 つの主張を各自のディレクトリへ分けた）。
