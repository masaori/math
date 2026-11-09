# SageMath Check: bijection_composed_with_index_skipping_map_is_bijective

## 対象

**対象ラベル**: `bijection_composed_with_index_skipping_map_is_bijective` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_bijection_composed_with_index_skipping_map_is_bijective`
  （最後の添字へ送られる添字を飛ばしてから全単射で送る写像は全単射である）と、同じ回に足した
  `calc_formulae_definition_bijection_composed_with_index_skipping_map`（`def_bijection_composed_with_index_skipping_map`）の値
- 同じ回に足した `bijection_composed_with_index_skipping_map_stays_in_lower_indices` の証明は
  `sagemath/check/bijection_composed_with_index_skipping_map_stays_in_lower_indices/` が確かめる
- 範囲: 値が `{1,…,m}` に入ること、`τ^π_k` の値、単射性と全射性の鎖の各行、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `τ^π_k` の終域 | `check_bijection_composed_with_index_skipping_map.sage` | `m = 1,…,5`、`{1,…,m+1}` の全ての置換 `π`（872 個）と `π(k) = m+1` の `k` で、全ての `j` について `π(δ^m_k(j)) ∈ {1,…,m}` | **PASS** | 有限の全数検査 |
| 単射性の 3 行と結び | 同上 | `τ(j) = τ(j')` の全ての組で各行、`δ^m_k(j) = δ^m_k(j')`、`j = j'` | **PASS** | 有限の全数検査 |
| 全射性の背理法の鎖 `i = π(p) = π(k) = m+1`（3 行） | 同上 | 仮定 `p = k` は成り立たないので、鎖の各行が使う事実 `π(p) = i`・`π(k) = m+1` と、結びの「`i ≤ m` に反する」が使う `i ≤ m < m+1` を確かめ、`p ≠ k` を確かめる | **PASS** | 4166 件 |
| 全射性の `τ^π_k(j)` の 3 行 | 同上 | `δ^m_k(j) = p` の `j` がちょうど 1 つあり、各行が成り立つ | **PASS** | 4166 件 |
| 主張そのもの | 同上 | `τ^π_k` の値の並べ替えが `1,…,m` に一致する（独立な経路） | **PASS** | 872 個 |
| 否定コントロール | 同上 | `π(k) ≠ m+1` の `k` を使うと、値が `m+1` に届く `j` がある | **PASS** | 4166 件 |

鎖の段は全体で 37494 段である。`τ^π_k(j) = π(δ^m_k(j))` の行は、`τ^π_k` を定義どおりに作るので同じ式の比較になる（定義を書き換える行なので避けられない）。

## 計算の帰属と範囲

添字は `ZZ` の元で、本文と同じ 1 始まりで書いた。浮動小数点と `RR` / `CC` への脱出はない。
一般の `m` は人手証明が担い、この検算は `m ≤ 5` の全数検査で書き間違いを検出する。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh bijection_composed_with_index_skipping_map_is_bijective
```

実行ログは `sagemath/check/bijection_composed_with_index_skipping_map_is_bijective/logs/` に保存する（2026-11-06。2026-11-09 に値の範囲の証明の検算を各自のディレクトリへ分けた）。
