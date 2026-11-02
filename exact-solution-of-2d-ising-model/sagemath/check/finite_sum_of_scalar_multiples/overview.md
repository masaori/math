# SageMath Check: finite_sum_of_scalar_multiples

## 対象

**対象ラベル**: `finite_sum_of_scalar_multiples` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_finite_sum_of_scalar_multiples`（スカラー倍した行列の有限和は有限和のスカラー倍に等しい）
- 範囲: 主張 `Σ_{j=1}^{r} (cX_j) = cΣ_{j=1}^{r} X_j` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の 2 行 | `check_induction_chain.sage` | `def_finite_sum_of_matrices` どおり左から足した和で、隣り合う行が等しい | **PASS** | `(m, n) ∈ {1,2,3}²` で厳密等号 |
| `r → r+1` の 4 行 | 同上 | `r = 1,…,4` で帰納法の仮定を確かめ、隣り合う行が等しい | **PASS** | `(m, n) ∈ {1,2,3}²` で厳密等号 |
| 主張そのもの | 同上 | Sage の行列演算と `sum`（独立な経路）と比べる。否定コントロールとして、最後の項だけ `c` 倍しなかった和とは一致しないことも確かめる | **PASS** | `r = 1,…,5`、`(m, n) ∈ {1,2,3}²` で厳密等号（否定コントロールは `r = 2,…,5`） |

## 計算の帰属と範囲

`c` と `X_j` の成分を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `m`・`n`・`r` は人手証明が担う。

和・有限和・スカラー倍は共通の準備 `_shared/matrix_operations_by_definition.sage` で本文の定義どおり成分から組んだ。
定義の行はその組み方と同じ式なので構成上かならず一致し、検出できるのは本文の式の写し間違いだけである。
これを補うため、主張は Sage 組み込みの演算とも比べた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_scalar_multiples
```

実行ログは `sagemath/check/finite_sum_of_scalar_multiples/logs/` に保存する（2026-11-02）。
