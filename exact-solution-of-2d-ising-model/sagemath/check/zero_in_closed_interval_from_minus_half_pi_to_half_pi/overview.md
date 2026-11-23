# SageMath Check: zero_in_closed_interval_from_minus_half_pi_to_half_pi

## 対象

**対象ラベル**: `zero_in_closed_interval_from_minus_half_pi_to_half_pi` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_zero_in_closed_interval_from_minus_half_pi_to_half_pi`（0 ∈ [−π/2, π/2]）
- 範囲: 主張と、証明の二本の鎖の各行（0 < π の鎖は主張 `pi_is_positive` の検算 `sagemath/check/pi_is_positive/` が扱う）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `0 < 2^{-1}`（`2` は `def_real_two` の `1 + 1`、`2^{-1}` は `real_two_is_nonzero` の `2 ≠ 0` で在る `2` の乗法の逆元、`real_zero_less_than_two` の `0 < 2` に `real_inverse_of_positive_is_positive`（`a → 2`）） | `check_proof_lines.sage` | QQ | **PASS** | 等号 1 個・不等号 2 件 |
| `0 < π/2` の鎖 2 行（`pi_is_positive` の `0 < π` と準備の `0 < 2^{-1}` と正の数どうしの積は正、`def_real_quotient`（`y → π, z → 2`）を右辺から左辺へ） | 同上 | 等号は SR、不等号はボール | **PASS** | 等号 1 個・不等号 1 件 |
| `−π/2 < 0` の鎖 3 行（加法の単位元 `0 + x = x` を右辺から左辺へ、`real_less_than_preserved_by_adding_on_right`（`x → 0, y → π/2, c → −π/2`）、`def_real_difference` の加法の逆元） | 同上 | 等号は SR、不等号はボール | **PASS** | 等号 2 個・不等号 1 件 |
| ℝ の加法の単位元を引く 1 行（`set_and_algebra_notation`）: `−π/2 < 0` の鎖の `−π/2 = 0 + (−π/2)`（`0 + x = x` の `x → −π/2` を右辺から左辺へ） | `check_unit_rows_cite_set_and_algebra_notation.sage` | 行に書いた形と代入で形の両辺を作り、前後の行が同じ文脈（式全体）の穴にそれを入れたものと `QQ[π]`（π は不定元のまま）で等しいことを確かめる。式を正規化するので、形の左右と向きは区別できず、それはレビューの目視で確かめた。対照（`−π/2 + 1 ≠ −π/2`） | **PASS** | 厳密（1 行） |
| 結論 `−π/2 ≤ 0 ≤ π/2` | 同上 | ボール | **PASS** | 不等号 2 件 |
| 否定コントロール | 同上 | 準備の逆数を `(−2)^{-1}` に取り違える（`0 < π·(−2)^{-1}`）、`π/2 ≤ 0` を判定する、のどちらも成り立たない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 等号は Sage の記号計算（SR）と QQ で判定した。
- **`ℝ` への脱出（`RealBallField(256)`）**: π の値の大小だけ。ボールの比較は真と判定できたときだけ真を返す。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh zero_in_closed_interval_from_minus_half_pi_to_half_pi
```

実行ログは `logs/` に保存する（2026-11-23、SageMath 10.9）。
