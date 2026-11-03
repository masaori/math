# SageMath Check: scalar_sequence_times_matrix_converges

## 対象

**対象ラベル**: `scalar_sequence_times_matrix_converges` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_scalar_sequence_times_matrix_converges`（収束する複素数の列による行列のスカラー倍は収束する）
- 範囲: 主張 `|c_N − c| → 0 ⟹ ‖c_NA − cA‖ → 0` と、証明の 3 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目（`difference_of_scalar_multiples_of_one_matrix`） | `check_chain.sage` | 係数と成分を不定元に置き、本文の定義で組んだ `c_NA − cA` と `(c_N − c)A` が等しい。否定コントロールとして `(c − c_N)A` とは一致しない | **PASS** | `n = 1, 2, 3` で厳密等号 |
| 2 行目（`matrix_norm_triangle_inequality` (2)） | 同上 | 成分が `QQ(i)` のとき `‖(c_N − c)A‖^2 = |c_N − c|^2‖A‖^2` | **PASS** | `n = 1..4`、各 5 組、`N = 0..11` で厳密等号 |
| 3 行目（→ 0） | 同上 | `c_N := c + 2^{-N}w` で右辺の 2 乗 `4^{-N}|w|^2‖A‖^2` が狭義に減り、`10^{-1}, 10^{-3}, 10^{-6}` を下回る `N` が取れる | **PASS** | 同上 |

## 計算の帰属と範囲

1 行目は `QQ` 上の多項式環、2・3 行目は `QQ(i)` の厳密計算で、ノルムと絶対値は平方根を取らずに 2 乗どうしを比べた。
極限そのものは ℝ への脱出なので、確かめたのは評価の形と、任意に与えた正の有理数を下回る番号が取れることだけである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh scalar_sequence_times_matrix_converges
```

実行ログは `sagemath/check/scalar_sequence_times_matrix_converges/logs/` に保存する（2026-11-03）。
