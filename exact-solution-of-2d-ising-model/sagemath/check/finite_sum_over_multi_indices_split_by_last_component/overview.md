# SageMath Check: finite_sum_over_multi_indices_split_by_last_component

## 対象

**対象ラベル**: `finite_sum_over_multi_indices_split_by_last_component` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_000_claim_finite_sum_over_multi_indices_split_by_last_component`（多重添字の集合の上の有限和を、最後の成分で分ける）
- 範囲: 主張 `Σ_{I∈𝓘_{M+1}} a(I) = Σ_{t=1}^{2} Σ_{K∈𝓘_M} a(K,t)` と、証明の準備（`ν(K,t) = 2(ν(K)−1)+t` の 6 行、`ν^{-1}(2(k−1)+t) = (ν^{-1}(k),t)`）・本体の 9 行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `ν(K,t) = 2(ν(K)−1)+t` の 6 行 | `check_split_chain.sage` | `M = 1,…,5` の全ての `K ∈ 𝓘_M`、`t ∈ {1,2}` で、各行の整数値が等しい | **PASS** | 厳密等号（`ZZ`） |
| 準備 `ν^{-1}(2(k−1)+t) = (ν^{-1}(k),t)` | 同上 | `ν` の値から作った逆写像の表で、全ての `k`・`t` について一致する（`ν` が全単射であることも表で確かめる） | **PASS** | 一致 |
| 本体の 9 行 | 同上 | `𝓘_M`・`𝓘_{M+1}` の上の和を `def_finite_sum_of_complex_numbers_over_multi_indices` どおり、`𝓘` を列挙して `ν(I) = k` の `I` を引く別の経路（`msum`）で組み、隣り合う行が等しい | **PASS** | `M = 1,…,5` で厳密等号 |
| 主張そのもの | 同上 | `𝓘_{M+1}` の全ての元を Sage の `sum` で足したもの（独立な経路）と比べる。否定コントロールとして、最後の成分が 2 の項を落とした和とは一致しないことも確かめる | **PASS** | 厳密等号 |

## 計算の帰属と範囲

`ν` の値は `ZZ`、`a(I)` は `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の複素数を代入しても成り立つ。
浮動小数点と `RR` / `CC` への脱出はない。一般の `M` は人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_over_multi_indices_split_by_last_component
```

実行ログは `sagemath/check/finite_sum_over_multi_indices_split_by_last_component/logs/` に保存する（2026-11-25）。
