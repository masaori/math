# SageMath Check: real_log_negative_below_one

## 対象

**対象ラベル**: `real_log_negative_below_one`

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `transfer_matrix_claim_real_log_negative_below_one`（1 より小さい正の実数の実対数は負）
- 範囲: 証明の全行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| log y < log 1（real_log_strictly_increasing） | `check_proof_lines.sage` | `0 < y < 1` の 6 点でボール | **PASS** | 成り立つ |
| log 1 = log(exp 0)（scalar_exp_zero） | `check_proof_lines.sage` | 本文の 1 行 1 列の行列の部分和 `S_N([0])` の成分が `N = 0,1,5,40` で `QQ` の中でちょうど 1 | **PASS** | 成り立つ |
| log(exp 0) = 0 | `check_proof_lines.sage` | 逆写像の定義そのもので計算を含まない。log 1 = 0 を `QQ` の 0 として以後の比較に使う | **PASS** | 成り立つ |
| 主張 log y < 0 | `check_proof_lines.sage` | 同じ 6 点（`10^{-9}` と `1 - 10^{-6}` を含む） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `exp 0 = 1` は本文の部分和で `QQ` の中で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 実対数の値は `QQ` に収まらないので、2 進の有理数の端点 `lo < hi` の区間で挟んだ。端点の候補は Arb の `log` から作るが、本文の log の値が区間に入ることは、本文の exp の部分和をボール演算で計算し尾の評価を半径に足したボール（Arb の exp は使わない）で `exp(lo) < y < exp(hi)` を確かめ、`real_exp_strictly_increasing` と `exp(log y) = y` から導く（共通の準備の `real_log_enclosure`）。許容誤差は置かず、区間の上端・下端の比較だけで判定する。

範囲外のもの: 選んだ以外の点。集合への所属だけを述べる推論の行（`ℝ_{>0} ⊂ ℝ`、閉性、等しい対象による置換）は、計算を含まないので、値が実数のボール（または `QQ`）として作れたことを見るだけである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_log_negative_below_one
```

実行ログは `logs/` に保存する。共通の準備は `sagemath/_shared/positive_coupling_and_real_log.sage`。
