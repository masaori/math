# SageMath Check: angle_section_of_principal_angle_plus_half_pi

## 対象

**対象ラベル**: `angle_section_of_principal_angle_plus_half_pi` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_angle_section_of_principal_angle_plus_half_pi`（θ ∈ [−π/2, π/2] なら s_{[0,2π)}([θ + π/2]) = θ + π/2）
- 範囲: 主張と、証明の各鎖の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の第一の 3 行（`real_times_zero_is_zero`、`real_zero_times_is_zero`、`real_minus_zero_is_self`） | `check_proof_lines.sage` | `QQ[π, θ]` で一致 | **PASS** | 厳密 |
| 準備の第二の 2 行 | 同上 | 等号は多項式、不等号は `θ = (k/16)π`（`−8 ≤ k ≤ 8`）で | **PASS** | 厳密・17 点 |
| 準備の第三の 4 行（`principal_angle_plus_half_pi_at_most_pi`、単位元、`0 < π` と両立、`real_sum_of_two_equal_terms_is_twice`） | 同上 | 等号は多項式、1 行目は `QQ` で、3 行目は差が `π − 0` に一致し RIF で `0 < π` | **PASS** | 厳密・17 点 |
| 一意性による整数の同定 | 同上 | `0 ≤ (θ + π/2) − 2mπ < 2π` を満たす整数を `−20 ≤ m ≤ 20` で走査すると `m = 0` だけ（17 点） | **PASS** | 区間演算 |
| 本体の 2 行（`section_of_angle_representation`、準備の第一） | 同上 | 多項式で一致 | **PASS** | 厳密 |
| 否定の対照 | 同上 | 整数を `−1` と取り違えると上端を超える。準備の第一の `2·0` を `2` と取り違えると値が変わる。範囲外の `θ = 2π` では `n = 0` が条件を満たさない | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: 等号の行は、π と変数を不定元に置いた多項式環 `QQ` 上で比べた。不等号の行は「大きい側 − 小さい側」が仮定の差と同じ多項式になること（順序と加法の両立の当てはめ）を確かめ、変数を π の有理数倍に置いた点で符号を `QQ` で判定した（π の値に依らない）。
- 範囲外: 一意性そのもの（`angle_section_existence_uniqueness`）は `sagemath/check/102_angle_section_existence_uniqueness/` の対象で、ここでは有限の範囲の走査で当てはめの結果を裏取りしただけである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh angle_section_of_principal_angle_plus_half_pi
```

実行ログは `logs/` に保存する（2026-11-21、SageMath 10.9）。
