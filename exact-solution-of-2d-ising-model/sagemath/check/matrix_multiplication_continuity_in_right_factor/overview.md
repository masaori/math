# SageMath Check: matrix_multiplication_continuity_in_right_factor

## 対象

**対象ラベル**: `matrix_multiplication_continuity_in_right_factor` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_multiplication_continuity_in_right_factor`（行列乗算の右の因子についての連続性）
- 範囲: 主張 `‖A_N − A‖ → 0 ⟹ ‖BA_N − BA‖ → 0` と、証明の 3 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目（左分配則） | `check_chain.sage` | 成分を不定元に置き、本文の定義で組んだ `BA_N − BA` と `B(A_N − A)` が等しい。否定コントロールとして、左右を取り違えた `A_NB − AB` とは一致しない（`n ≥ 2`） | **PASS** | `n = 1, 2, 3` で厳密等号 |
| 2 行目（劣乗法性） | 同上 | 成分が `QQ(i)` の行列で `‖B(A_N − A)‖^2 ≤ ‖B‖^2‖A_N − A‖^2` | **PASS** | `n = 1..4`、各 5 組、`N = 0..11` |
| 3 行目（→ 0） | 同上 | `A_N := A + 2^{-N}E` で評価の 2 乗 `4^{-N}‖B‖^2‖E‖^2` が狭義に減り、`10^{-1}, 10^{-3}, 10^{-6}` を下回る `N` が取れる | **PASS** | 同上 |

## 計算の帰属と範囲

1 行目は `QQ` 上の多項式環、2・3 行目は `QQ(i)` の厳密計算で、ノルムは平方根を取らずに 2 乗（`def_matrix_norm` の平方根の中身）どうしを比べた。
極限そのもの（実数列が 0 に収束すること）は ℝ への脱出なので、確かめたのは評価の形と、任意に与えた正の有理数を下回る番号が取れることだけである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_multiplication_continuity_in_right_factor
```

実行ログは `sagemath/check/matrix_multiplication_continuity_in_right_factor/logs/` に保存する（2026-11-03）。
