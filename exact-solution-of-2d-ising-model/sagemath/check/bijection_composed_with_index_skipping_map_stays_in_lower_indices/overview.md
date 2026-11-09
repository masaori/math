# SageMath Check: bijection_composed_with_index_skipping_map_stays_in_lower_indices

## 対象

**対象ラベル**: `bijection_composed_with_index_skipping_map_stays_in_lower_indices` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_bijection_composed_with_index_skipping_map_stays_in_lower_indices`
  （最後の添字へ送られる添字を飛ばしてから全単射で送ると、最後の添字には届かない）
- 範囲: 主張と、証明の背理法の各段が使う事実

## 証明の行との対応

証明は「`π(δ^m_k(j)) = m+1` と仮定すると」から矛盾を導く背理法で、主張が正しい限り仮定が成り立つ点は無い。
そこで鎖の各行が使う事実をそれぞれ確かめ、結論を確かめる。

| 証明の行 | 根拠 | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の 1 行目 `π(δ^m_k(j)) = m+1` | 仮定 | 仮定は成り立たない（下の結論の行で確かめる） | — | — |
| 鎖の 2 行目 `= π(k)` | `π(k) = m+1` | 取った `k` で `π(k) = m+1` | **PASS** | 872 件 |
| 「`π` は単射なので `δ^m_k(j) = k`」 | `π` の単射性 | `π` の値が `π(k)` になる添字は `k` だけ（`j` に依らないので置換ごとに 1 回） | **PASS** | 872 件 |
| 「`index_skipping_map_never_takes_skipped_index` に反する」 | `index_skipping_map_never_takes_skipped_index` | `δ^m_k(j) ≠ k` | **PASS** | 4166 件 |
| 「よって `π(δ^m_k(j)) ≠ m+1`」 | 上の三つ | `π(δ^m_k(j)) ≠ m+1` | **PASS** | 4166 件 |
| 「`π(δ^m_k(j)) ∈ {1,…,m+1}`」 | `π` の終域 | `1 ≤ π(δ^m_k(j)) ≤ m+1` | **PASS** | 4166 件 |
| 主張 `π(δ^m_k(j)) ∈ {1,…,m}` | 上の二つ | `1 ≤ π(δ^m_k(j)) ≤ m` | **PASS** | 4166 件 |
| 否定コントロール（`k` の条件） | — | `π(k') ≠ m+1` の `k'` で飛ばすと、値が `m+1` に届く `j` がある | **PASS** | 4166 件 |
| 否定コントロール（単射性） | — | `m ≤ 3` の `{1,…,m+1}` 上の全ての写像 `f` と `f(k) = m+1` の `k` で、`f(δ^m_k(j)) = m+1` となる `j` があるのは `f` が単射でないときだけで、その組がある | **PASS** | 165 件 |

`m = 1,…,5` の `{1,…,m+1}` の全ての置換 `π`（872 個）の全数検査で、段は 14242 段である
（`check_bijection_composed_with_index_skipping_map_stays_in_lower_indices.sage`）。

## 計算の帰属と範囲

添字は `ZZ` の元で、本文と同じ 1 始まりで書いた。浮動小数点と `RR` / `CC` への脱出はない。
一般の `m` は人手証明が担い、この検算は `m ≤ 5` の全数検査で書き間違いを検出する。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh bijection_composed_with_index_skipping_map_stays_in_lower_indices
```

実行ログは `logs/` に保存する（2026-11-09）。
