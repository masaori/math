# SageMath Check: angle_section_integer_of_pi_is_zero

## 対象

**対象ラベル**: `angle_section_integer_of_pi_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_angle_section_integer_of_pi_is_zero`（`angle_section_existence_uniqueness` を `θ → π` に当てた整数は `0`）
- 範囲: 主張と、証明の準備の `π < 2π` の 5 行の鎖、`π − 2·0·π = π` の 3 行の鎖、`0 ≤ π`、`0 ≤ π − 2·0·π < 2π`、一意性による整数の同定

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `π < 2π` の鎖の 1 行目 `π = 0 + π`（ℝ で `0 + a = a` を右辺から左辺へ） | `check_proof_lines.sage` | `QQ[π]`（π は不定元）で一致 | **PASS** | 厳密 |
| 同 2 行目 `0 + π < π + π`（`pi_is_positive` の `0 < π` の両辺に π を足す） | 同上 | RIF の π で成り立つ | **PASS** | 区間演算 |
| 同 3〜5 行目 `π + π = 1·π + 1·π = (1 + 1)π = 2π` | 同上 | `QQ[π]` で一致、`1 + 1 = 2`（`def_real_two` を右辺から左辺へ） | **PASS** | 厳密 |
| `π − 2·0·π = π − 0·π`（`real_times_zero_is_zero`、`x → 2`） | 同上 | `QQ[π]` で一致 | **PASS** | 厳密 |
| `π − 0·π = π − 0`（`real_zero_times_is_zero`、`x → π`） | 同上 | 同上 | **PASS** | 厳密 |
| `π − 0 = π`（`real_minus_zero_is_self`、`a → π`） | 同上 | 同上 | **PASS** | 厳密 |
| `0 ≤ π` と `0 ≤ π − 2·0·π < 2π` | 同上 | RIF の π で成り立つ | **PASS** | 区間演算 |
| 一意性による整数の同定 | 同上 | `0 ≤ π − 2kπ < 2π` を満たす整数を `−20 ≤ k ≤ 20` で走査すると `k = 0` だけ | **PASS** | 区間演算 |
| 否定の対照 | 同上 | 整数を `1`・`−1` に取り違えると条件を満たさない。鎖の `2·0` を `2` と取り違えると `π` にならない。`1 + 1` を `1` と取り違えると `2π` にならない | **PASS** | 4 件 |

## 計算の帰属と範囲

- **厳密**: 等号は多項式環 `QQ[π]`（π を不定元に置く）で計算した。
- **区間演算**: 不等号と整数の同定は π の値が要るので RIF（区間演算）で比べた。浮動小数点の丸めで判定していない。
- 範囲外: 一意性そのもの（`angle_section_existence_uniqueness`）は `sagemath/check/102_angle_section_existence_uniqueness/` の対象で、ここでは有限の範囲の走査で当てはめの結果を裏取りしただけである。`0 < π` の鎖は `sagemath/check/pi_is_positive/` の対象である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh angle_section_integer_of_pi_is_zero
```

実行ログは `logs/` に保存する（2026-11-15、SageMath 10.9）。
