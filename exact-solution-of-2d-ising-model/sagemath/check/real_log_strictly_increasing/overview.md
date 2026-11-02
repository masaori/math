# SageMath Check: real_log_strictly_increasing

## 対象

**対象ラベル**: `real_log_strictly_increasing`

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `transfer_matrix_claim_real_log_strictly_increasing`（正の実数上の実対数は狭義単調増加）
- 範囲: 証明の全行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 一つめの場合 v = exp(log v) < exp(log u) = u | `check_proof_lines.sage` | 背理法の仮定は具体の点では偽なので、大小を入れ替えた 8 組で同じ形の鎖の各行（exp(log y) = y、exp の狭義単調増加）を確かめる | **PASS** | 成り立つ |
| 二つめの場合 v = exp(log v) = exp(log u) = u | `check_proof_lines.sage` | 両端の行の根拠 exp(log y) = y を 8 組の点で（囲みの作り方から構成上かならず成り立つ）。中の行は等しいものの置換で計算を含まない | **PASS** | 成り立つ |
| exp の狭義単調増加（real_exp_strictly_increasing） | `check_proof_lines.sage` | 4 組の有理数の点で本文の exp のボール | **PASS** | 成り立つ |
| 主張 0 < u < v ⇒ log u < log v | `check_proof_lines.sage` | 8 組の有理数の点（1 に近い組、10^5 規模の組を含む） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **`ℝ` への脱出（`RealBallField(512)`）**: 実対数の値は `QQ` に収まらないので、2 進の有理数の端点 `lo < hi` の区間で挟んだ。端点の候補は Arb の `log` から作るが、本文の log の値が区間に入ることは、本文の exp の部分和をボール演算で計算し尾の評価を半径に足したボール（Arb の exp は使わない）で `exp(lo) < y < exp(hi)` を確かめ、`real_exp_strictly_increasing` と `exp(log y) = y` から導く（共通の準備の `real_log_enclosure`）。許容誤差は置かず、区間の上端・下端の比較だけで判定する。

範囲外のもの: 選んだ以外の点。集合への所属だけを述べる推論の行（`ℝ_{>0} ⊂ ℝ`、閉性、等しい対象による置換）は、計算を含まないので、値が実数のボール（または `QQ`）として作れたことを見るだけである。 三分律・順序の非対称性・非反射性による場合分けと矛盾の導出は論理の行で、計算を含まない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_log_strictly_increasing
```

実行ログは `logs/` に保存する。共通の準備は `sagemath/_shared/positive_coupling_and_real_log.sage`。
