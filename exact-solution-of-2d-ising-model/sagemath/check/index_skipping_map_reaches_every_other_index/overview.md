# SageMath Check: index_skipping_map_reaches_every_other_index

## 対象

**対象ラベル**: `index_skipping_map_reaches_every_other_index` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_index_skipping_map_reaches_every_other_index`（一つの添字を飛ばす写像は飛ばした添字以外のすべてを値に取る）
- 範囲: 主張と、証明が置く `j` の所属の論証、二つの場合の鎖の各行

## 証明の行との対応

| 証明の行 | 根拠 | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `i < k` の準備 `j := i`、`1 ≤ i`、`i < k ≤ m+1`、`i ≤ m`、`j ∈ {1,…,m}` | `i ∈ Z` | 各不等号と所属 | **PASS** | 165 件 |
| `i < k` の 1 行目 `δ^m_k(j) = δ^m_k(i)` | `j` の置き方 | `ZZ` の等号 | **PASS** | 165 件 |
| `i < k` の 2 行目 `= i` | `def_index_skipping_map`, `i < k` | `ZZ` の等号 | **PASS** | 165 件 |
| `i > k` の場合に入ること | `i ≠ k` かつ `i < k` でない | `i > k` | **PASS** | 165 件 |
| `i > k` の準備 `j := i − 1`、`i > k ≥ 1`、`i − 1 ≥ 1`、`i ≤ m+1`、`i − 1 ≤ m`、`j ∈ {1,…,m}`、`j ≥ k` | `i, k ∈ Z` | 各不等号と所属 | **PASS** | 165 件 |
| `i > k` の 1 行目 `δ^m_k(j) = j + 1` | `def_index_skipping_map`, `j ≥ k` | `ZZ` の等号 | **PASS** | 165 件 |
| `i > k` の 2 行目 `= (i − 1) + 1` | `j` の置き方 | `ZZ` の等号 | **PASS** | 165 件 |
| `i > k` の 3 行目 `= i` | `−1 + 1 = 0` | `ZZ` の等号 | **PASS** | 165 件 |
| 主張 `δ^m_k(j) = i` | 上の鎖 | 置いた `j` で `δ^m_k(j) = i`。独立な経路として、像の全体が `{1,…,m+1} \ {k}` に一致すること | **PASS** | 330 件・45 組 |
| 否定コントロール | — | 境界を 1 つずらした写像（`j ≤ k` なら `j`、`j > k` なら `j + 1`）は、`k ≤ m` のとき `k + 1` を値に取らない | **PASS** | 45 件 |

`m = 1,…,9`、全ての `k ∈ {1,…,m+1}`、`k` でない全ての `i ∈ {1,…,m+1}` の全数検査で、鎖と所属の段は 2145 段である
（`check_index_skipping_map_reaches_every_other_index.sage`）。「`j` の置き方」の 2 行は `j` を置いた直後の比較なので、同じ式の比較になる（代入の行なので避けられない）。

## 計算の帰属と範囲

添字は `ZZ` の元で、本文と同じ 1 始まりで書いた。浮動小数点と `RR` / `CC` への脱出はない。
一般の `m` は人手証明が担い、この検算は `m ≤ 9` の全数検査で書き間違いを検出する。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh index_skipping_map_reaches_every_other_index
```

実行ログは `logs/` に保存する（2026-11-09）。
