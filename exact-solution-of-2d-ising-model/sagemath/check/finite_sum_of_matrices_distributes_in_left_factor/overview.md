# SageMath Check: finite_sum_of_matrices_distributes_in_left_factor

## 対象

**対象ラベル**: `finite_sum_of_matrices_distributes_in_left_factor` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_finite_sum_of_matrices_distributes_in_left_factor`（行列の有限和を左の因子とする積は各項の積の有限和に等しい）
- 範囲: 主張 `(Σ_{j=1}^{r} X_j)C = Σ_{j=1}^{r} (X_jC)` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の 2 行 | `check_induction_chain.sage` | `def_finite_sum_of_matrices` どおり左から足した和と `mat_mult` の成分の式の積で、隣り合う行が等しい | **PASS** | `(m, n, p) ∈ {1,2,3}³` で厳密等号 |
| `r → r+1` の 4 行 | 同上 | `r = 1,…,4` で帰納法の仮定を確かめ、隣り合う行が等しい | **PASS** | `(m, n, p) ∈ {1,2,3}³` で厳密等号（108 段） |
| 主張そのもの | 同上 | Sage の行列演算と `sum`（独立な経路）と比べる。否定コントロールとして、最後の項に `C` を掛けなかった和とは一致しないことも確かめる（形が合う `n = p` のとき） | **PASS** | `r = 1,…,5` で厳密等号 |

## 計算の帰属と範囲

`X_j` と `C` の成分を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `m`・`n`・`p`・`r` は人手証明が担う。

和・有限和・積は共通の準備 `_shared/matrix_operations_by_definition.sage` で本文の定義どおり成分から組んだ。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_matrices_distributes_in_left_factor
```

実行ログは `sagemath/check/finite_sum_of_matrices_distributes_in_left_factor/logs/` に保存する（2026-11-03）。
