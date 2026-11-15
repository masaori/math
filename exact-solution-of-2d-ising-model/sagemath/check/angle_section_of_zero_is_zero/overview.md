# SageMath Check: angle_section_of_zero_is_zero

## 対象

**対象ラベル**: `angle_section_of_zero_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_angle_section_of_zero_is_zero`（`s_{[0,2π)}([0]_{∼angle}) = 0`）
- 範囲: 主張と、証明の準備の記号 `n_0` と 5 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `s([0]) = 0 − 2n_0π`（`section_of_angle_representation` の `θ → 0, n → n_0`） | `check_proof_lines.sage` | 定義の値 `θ − 2nπ` を `(θ, n)` の関数として書き、`n_0` を不定元に置いて `(0, n_0)` を当てたものが 1 行目の右辺と `QQ[π, n_0]` で一致する | **PASS** | 厳密 |
| 2 行目 `0 − 2n_0π = 0 − 2·0·π`（`angle_section_integer_of_zero_is_zero` の `n_0 = 0`） | 同上 | 1 行目の右辺の `n_0` を `0` に置き換えると 2 行目になる | **PASS** | 厳密 |
| 3 行目 `0 − 2·0·π = 0 − 0·π`（`real_times_zero_is_zero`、`x → 2`） | 同上 | `QQ[π]` で一致 | **PASS** | 厳密 |
| 4 行目 `0 − 0·π = 0 − 0`（`real_zero_times_is_zero`、`x → π`） | 同上 | 同上 | **PASS** | 厳密 |
| 5 行目 `0 − 0 = 0`（`real_minus_zero_is_self`、`a → 0`） | 同上 | 同上 | **PASS** | 厳密 |
| 否定の対照 | 同上 | `n_0` を `0` に置き換えなければ 2 行目は成り立たない。整数を `1` に取り違えると `0` にならない。`θ` を `π` に取り違えると `0` にならない | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `QQ[π, n_0]`（π と整数 `n_0` を不定元に置く）だけで計算した。浮動小数点は使わない。
- 範囲外: 整数が `0` であること自体は `sagemath/check/angle_section_integer_of_zero_is_zero/` が確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh angle_section_of_zero_is_zero
```

実行ログは `logs/` に保存する（2026-11-15、SageMath 10.9）。
