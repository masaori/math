# SageMath Check: angle_section_integer_of_zero_is_zero

## 対象

**対象ラベル**: `angle_section_integer_of_zero_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_angle_section_integer_of_zero_is_zero`（`angle_section_existence_uniqueness` を `θ → 0` に当てた整数は `0`）
- 範囲: 主張と、証明の準備の `0 < 2π`、`0 − 2·0·π = 0` の 3 行の鎖、`0 ≤ 0 − 2·0·π < 2π`、一意性による整数の同定

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `0 < 2π`（`pi_is_positive` と順序体の正の数どうしの積） | `check_proof_lines.sage` | RIF の π で `0 < π` と `0 < 2π` | **PASS** | 区間演算 |
| 鎖の 1 行目 `0 − 2·0·π = 0 − 0·π`（`real_times_zero_is_zero`、`x → 2`） | 同上 | `QQ[π]`（π は不定元）で一致 | **PASS** | 厳密 |
| 鎖の 2 行目 `0 − 0·π = 0 − 0`（`real_zero_times_is_zero`、`x → π`） | 同上 | 同上 | **PASS** | 厳密 |
| 鎖の 3 行目 `0 − 0 = 0`（`real_minus_zero_is_self`、`a → 0`） | 同上 | 同上 | **PASS** | 厳密 |
| `0 ≤ 0 − 2·0·π < 2π` | 同上 | RIF の π で成り立つ | **PASS** | 区間演算 |
| 一意性による整数の同定 | 同上 | `0 ≤ 0 − 2kπ < 2π` を満たす整数を `−20 ≤ k ≤ 20` で走査すると `k = 0` だけ | **PASS** | 区間演算 |
| 否定の対照 | 同上 | 整数を `1`・`−1` に取り違えると条件を満たさない。鎖の `2·0` を `2` と取り違えると `0` にならない | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: 鎖は多項式環 `QQ[π]`（π を不定元に置く）で計算した。
- **区間演算**: `0 < 2π` と整数の同定は π の値が要るので RIF（区間演算）で比べた。浮動小数点の丸めで判定していない。
- 範囲外: 一意性そのもの（`angle_section_existence_uniqueness`）は `sagemath/check/102_angle_section_existence_uniqueness/` の対象で、ここでは有限の範囲の走査で当てはめの結果を裏取りしただけである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh angle_section_integer_of_zero_is_zero
```

実行ログは `logs/` に保存する（2026-11-15、SageMath 10.9）。
