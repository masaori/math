# SageMath Check: real_bilinear_value_of_scalar_multiple_vector

## 対象

**対象ラベル**: `real_bilinear_value_of_scalar_multiple_vector` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- ブロック: `maxeig_claim_real_bilinear_value_of_scalar_multiple_vector`（ベクトルを実数倍すると、実数の双線型値 `w^T P w` はその実数どうしの積の倍になる）
- 主張は `w^T P w = (c c)(u^T P u)`（`w_k = c u_k`）。`x^T P y` は定義 `def_real_bilinear_value`（`Σ_k Σ_l (x_k P_kl) y_l`、左から順に足す）どおりに成分から組む。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 13 行の鎖 | `check_scalar_multiple_chain.sage` | `P`・`u`・`c` を不定元に置き、`w` を仮定の成分の等式で組み、`n = 1,…,5` で隣り合う行が `QQ` 上の多項式として等しい | **PASS** | 厳密等号（65 段） |
| 主張そのもの | 同上 | 鎖の両端を Sage の `vector * matrix * vector`（独立な経路）と比べる。否定コントロールとして、仮定の成分の等式を 1 か所崩した `w` では主張が成り立たないことを確かめる | **PASS** | 同上 |

## 計算の帰属と範囲

成分を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `n` は人手証明の鎖が担う。

鎖の項は多項式環の元なので、積の括弧の付け方と因子の順序の違いは Sage の正規形で吸収される。
この検査が確かめるのは、各行に書かれた式（添字の位置、`c` を外へ出す和の位置、外側と内側の和の分け方）が前の行と同じ値を持つことである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_bilinear_value_of_scalar_multiple_vector
```

実行ログは `sagemath/check/real_bilinear_value_of_scalar_multiple_vector/logs/` に保存する（2026-11-07）。
