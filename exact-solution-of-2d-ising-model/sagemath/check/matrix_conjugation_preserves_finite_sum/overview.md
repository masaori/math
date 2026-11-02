# SageMath Check: matrix_conjugation_preserves_finite_sum

## 対象

**対象ラベル**: `matrix_conjugation_preserves_finite_sum` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_matrix_conjugation_preserves_finite_sum`（行列の共役は有限和を保つ）
- 範囲: 主張 `T_B(Σ_{j=1}^{r} X_j) = Σ_{j=1}^{r} T_B(X_j)` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の 2 行 | `check_induction_chain.sage` | `def_finite_sum_of_matrices` どおり左から足した和で、隣り合う行が等しい | **PASS** | `n = 1, 2, 3` で厳密等号 |
| `r → r+1` の 4 行 | 同上 | `r = 1,…,4` で帰納法の仮定を確かめ、隣り合う行が等しい | **PASS** | `n = 1, 2, 3` で厳密等号 |
| 主張そのもの | 同上 | Sage の行列演算と `sum`（独立な経路）と比べる。否定コントロールとして、最後の項を落とした右辺とは一致しないことも確かめる | **PASS** | `r = 2,…,5`、`n = 1, 2, 3` で厳密等号 |

## 計算の帰属と範囲

`B`、`B^{-1}`、`X_j` の成分を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `n`・`r` は人手証明が担う。

`T_B(X) = (BX)B^{-1}` の `B^{-1}` は、鎖のどの行も `B^{-1}B = I` を使わないので、`B` と独立な不定元の行列に置いた。
積・和・有限和は共通の準備 `_shared/matrix_operations_by_definition.sage` で本文の定義どおり成分から組んだ。
定義の行はその組み方と同じ式なので構成上かならず一致し、検出できるのは本文の式の写し間違いだけである。
これを補うため、主張は Sage 組み込みの演算とも比べた。添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_conjugation_preserves_finite_sum
```

実行ログは `sagemath/check/matrix_conjugation_preserves_finite_sum/logs/` に保存する（2026-11-02）。
