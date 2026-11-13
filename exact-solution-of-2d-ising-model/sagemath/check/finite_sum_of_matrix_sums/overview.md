# SageMath Check: finite_sum_of_matrix_sums

## 対象

**対象ラベル**: `finite_sum_of_matrix_sums` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_finite_sum_of_matrix_sums`（行列の和の有限和は有限和の和に等しい）
- 範囲: 主張 `Σ_{j=1}^{r}(X_j + Y_j) = (Σ X_j) + (Σ Y_j)` と、証明の `(i,k)` 成分の五行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の五行 | `check_component_chain.sage` | 鎖の項を各行に書かれた式どおりに組み（有限和は左から足す）、隣り合う項が等しい | **PASS** | `m, n ∈ {1, 2}`・`r ∈ {1,…,4}` の 16 通り、全成分（36 個）で厳密等号 |
| 主張そのもの | 同上 | 本文の定義で組んだ両辺を比べ、Sage の `sum` と行列の和（独立な経路）で組んだ右辺とも比べる。否定コントロールとして、`Y_r` を落とした右辺とは一致しないことも確かめる | **PASS** | 16 通りで厳密等号 |

## 計算の帰属と範囲

`X_j`、`Y_j` の成分を `QQ` 上の多項式環の不定元に置いた。
不定元で成り立つ多項式の等号は、任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさと項数は検算の範囲外で、人手証明が担う。

行列の和・有限和は共通の準備 `_shared/matrix_operations_by_definition.sage` で本文の定義どおり成分から組んだ。
添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_matrix_sums
```

実行ログは `sagemath/check/finite_sum_of_matrix_sums/logs/` に保存する（2026-11-13）。
