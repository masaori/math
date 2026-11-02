# SageMath Check: def_second_dual_coupling_constant

## 対象

**対象ラベル**: `def_second_dual_coupling_constant`

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `transfer_matrix_000k_definition_second_dual_coupling_constant`（第二の双対結合定数 K_2^* := -(1/2)log(tanh K_2) ∈ ℝ_{>0}）
- 範囲: 証明の全行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 0 < tanh K_2 < 1 と tanh K_2 ∈ ℝ_{>0}（def_positive_coupling_tanh） | `check_proof_lines.sage` | `K_2 = log q` の 6 点で `QQ`（`tanh = (q²-1)/(q²+1)`）、`K_2 ∈ QQ` の 7 点で本文の exp のボール | **PASS** | 成り立つ |
| log(tanh K_2) ∈ ℝ と log(tanh K_2) < 0（real_log_negative_below_one） | `check_proof_lines.sage` | 同じ点で、log を有理数の端点で挟んだ区間の上端が負。端点は本文の exp で確かめ、tanh K_2 を含む区間 | **PASS** | 成り立つ |
| -1/2 ∈ ℝ と -1/2 < 0 | `check_proof_lines.sage` | `QQ` | **PASS** | 成り立つ |
| -(1/2)log(tanh K_2) ∈ ℝ と、負の数二つの積 > 0 | `check_proof_lines.sage` | 同じ点でボール | **PASS** | 成り立つ |
| K_2^* の定義と置換、K_2^* ∈ ℝ_{>0}（主張） | `check_proof_lines.sage` | K_2^* > 0。定義と置換の行は計算を含まず、定義の関数で作った K_2^* は積と同じ計算になる（構成上一致する）ので比べない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: `-1/2 < 0` と、`K = log q`（`q ∈ QQ`、`q > 1`）の点の `tanh K = (q²-1)/(q²+1)` と `0 < tanh K < 1` を `QQ` で確かめた（本文 `def_real_logarithm_positive` の `exp(log y) = y` により `exp(K) = q`）。
- **`ℝ` への脱出（`RealBallField(512)`）**: `K ∈ QQ` の点の `exp(K)` は `QQ` に収まらないので、本文の exp の部分和に尾の評価を半径として足したボール（`sagemath/_shared/hyperbolic_by_definition.sage`）で比べた。Arb の exp は使わない。許容誤差は置かず、ボールの上端・下端の比較だけで判定する。
- **`ℝ` への脱出（`RealBallField(512)`）**: 実対数の値は `QQ` に収まらないので、2 進の有理数の端点 `lo < hi` の区間で挟んだ。端点の候補は Arb の `log` から作るが、本文の log の値が区間に入ることは、本文の exp の部分和をボール演算で計算し尾の評価を半径に足したボール（Arb の exp は使わない）で `exp(lo) < y < exp(hi)` を確かめ、`real_exp_strictly_increasing` と `exp(log y) = y` から導く（共通の準備の `real_log_enclosure`）。許容誤差は置かず、区間の上端・下端の比較だけで判定する。

範囲外のもの: 選んだ以外の点。集合への所属だけを述べる推論の行（`ℝ_{>0} ⊂ ℝ`、閉性、等しい対象による置換）は、計算を含まないので、値が実数のボール（または `QQ`）として作れたことを見るだけである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh def_second_dual_coupling_constant
```

実行ログは `logs/` に保存する。共通の準備は `sagemath/_shared/positive_coupling_and_real_log.sage`。
