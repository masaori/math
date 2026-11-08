# SageMath Check: zero_in_closed_interval_from_minus_half_pi_to_half_pi

## 対象

**対象ラベル**: `zero_in_closed_interval_from_minus_half_pi_to_half_pi` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_zero_in_closed_interval_from_minus_half_pi_to_half_pi`（0 ∈ [−π/2, π/2]）
- 範囲: 主張と、証明の五本の鎖の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の `arcsin(−1)` の鎖 3 行（`def_arcsin` の第二の式の `y' → −1`、`−(−1) = 1`、`arcsin(1) = π/2`） | `check_proof_lines.sage` | 記号計算（SR）と QQ で行の式どうしの等号 | **PASS** | 厳密（等号 3 個） |
| `−π/2 < π/2` の鎖 3 行（上の鎖、`−1 < 1` と狭義単調増加、`arcsin(1) = π/2`） | 同上 | 等号は SR、`arcsin(−1) < arcsin(1)` は RealBallField(256) | **PASS** | 等号 2 個・不等号 2 件 |
| `0 < π` の鎖 3 行（`−a + a = 0`、順序と加法の両立、`a/2 + a/2 = a`） | 同上 | 等号は SR、不等号はボール | **PASS** | 等号 2 個・不等号 2 件 |
| `0 < π/2` の鎖 2 行（`0/x = 0`、正の数で割っても順序は保たれる） | 同上 | 等号は QQ、不等号はボール | **PASS** | 等号 1 個・不等号 1 件 |
| `−π/2 < 0` の鎖 3 行（`a + 0 = a`、順序と加法の両立、`−a + a = 0`） | 同上 | 等号は SR、不等号はボール | **PASS** | 等号 2 個・不等号 1 件 |
| 結論 `−π/2 ≤ 0 ≤ π/2` | 同上 | ボール | **PASS** | 不等号 2 件 |
| 否定コントロール | 同上 | `arcsin(−1)` の符号を取り違える、2 の代わりに −2 で割る、`π/2 ≤ 0` を判定する、のいずれも成り立たない | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: 等号は Sage の記号計算（SR）と QQ で判定した。
- **`ℝ` への脱出（`RealBallField(256)`）**: π と arcsin の値の大小だけ。ボールの比較は真と判定できたときだけ真を返す。
- 本文の arcsin（弧の長さ）が標準の arcsin に等しいことは `arcsin_is_bijection` の検算で確かめてある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh zero_in_closed_interval_from_minus_half_pi_to_half_pi
```

実行ログは `logs/` に保存する（2026-11-08、SageMath 10.9）。
