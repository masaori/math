# SageMath Check: index_skipping_map_never_takes_skipped_index

## 対象

**対象ラベル**: `index_skipping_map_never_takes_skipped_index` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_index_skipping_map_never_takes_skipped_index`（一つの添字を飛ばす写像は飛ばした添字を値に取らない）
- 範囲: 主張と、証明の二つの場合の鎖の各行

## 証明の行との対応

| 証明の行 | 根拠 | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `j < k` の 1 行目 `δ^m_k(j) = j` | `def_index_skipping_map`, `j < k` | `ZZ` の等号 | **PASS** | 165 件 |
| `j < k` の 2 行目 `< k` | `j < k` | `ZZ` の不等号と、鎖の両端 `δ^m_k(j) < k` | **PASS** | 165 件 |
| `j ≥ k` の 1 行目 `δ^m_k(j) = j + 1` | `def_index_skipping_map`, `j ≥ k` | `ZZ` の等号 | **PASS** | 165 件 |
| `j ≥ k` の 2 行目 `> j` | `1 > 0` | `j + 1 > j` | **PASS** | 165 件 |
| `j ≥ k` の 3 行目 `≥ k` | `j ≥ k` | `j ≥ k` と、鎖の両端 `δ^m_k(j) > k` | **PASS** | 165 件 |
| 結び「どちらの場合も `δ^m_k(j) ≠ k`」 | 上の二つの鎖 | `δ^m_k(j) ≠ k`、加えて値が終域 `{1,…,m+1}` に入ること | **PASS** | 330 件 |
| 定義の書き写しの検査 | `def_index_skipping_map` の読み方 | `δ^m_k(j)` が `{1,…,m+1} \ {k}` の小さい方から `j` 番目に一致する（`delta` と独立に作る） | **PASS** | 330 件 |
| 否定コントロール | — | 境界を 1 つずらした写像（`j ≤ k` なら `j`、`j > k` なら `j + 1`）は、`k ≤ m` のとき `k` を値に取る | **PASS** | 45 件 |

`m = 1,…,9`、全ての `k ∈ {1,…,m+1}`、全ての `j ∈ {1,…,m}` の全数検査で、鎖の段は 825 段である
（`check_index_skipping_map_never_takes_skipped_index.sage`）。

## 計算の帰属と範囲

添字は `ZZ` の元で、本文と同じ 1 始まりで書いた。浮動小数点と `RR` / `CC` への脱出はない。
一般の `m` は人手証明が担い、この検算は `m ≤ 9` の全数検査で書き間違いを検出する。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh index_skipping_map_never_takes_skipped_index
```

実行ログは `logs/` に保存する（2026-11-09）。
