# SageMath Check: finite_sum_of_matrices_entrywise

## 対象

**対象ラベル**: `finite_sum_of_matrices_entrywise` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_finite_sum_of_matrices_entrywise`（行列の有限和の成分は成分の有限和）
- 範囲: 帰納法の基底の鎖（二行）、帰納の段の鎖（四行）、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 基底 `(Σ_{j=1}^{1} X_j)_ik = (X_1)_ik = Σ_{j=1}^{1} (X_j)_ik` | `check_induction_chains.sage` | 三つの項を各行の式どおりに組み、等しいことを確かめる | **PASS** | 9 通りの大きさ、全成分で厳密等号 |
| 帰納の段の四行 | 同上 | `r = 1..5` で五つの項を各行の式どおりに別々に組み、隣り合う項が等しいことを確かめる | **PASS** | 9 通りの大きさ、全成分で厳密等号 |
| 主張そのもの | 同上 | `r = 1..6` で、本文の定義どおりに組んだ有限和が Sage の行列の和（独立な経路）で作った有限和に等しい。対照として、右辺の添字を入れ替えると一致しない | **PASS** | 厳密等号、対照は不一致 |

帰納法そのもの（`r` についての全称）は有限の計算に落ちない。`r` を固定した各段を確かめた。

## 計算の帰属と範囲

`X_j` の成分を `QQ` 上の多項式環の不定元に置いた。大きさは `m, n ∈ {1, 2, 3}` の 9 通りである。
不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。`r > 6` と一般の大きさは検算の範囲外で、人手証明が担う。

鎖の各行は、行列の有限和を `_shared/matrix_operations_by_definition.sage` の `body_finite_sum`（本文の定義どおりに
`def_matrix_sum` の和を左から順に足す）で、複素数の有限和を本文の定義どおりに左から順に足して組んだ。
定義を当てはめる行（基底の二行、帰納の段の第一行と第四行）は、組み方が定義と同じなので構成上かならず一致し、
検出できるのは本文の式の写し間違いだけである。これを補うため、主張は Sage の行列の和（独立な経路）とも比べた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_matrices_entrywise
```

実行ログは `logs/` に保存する。
