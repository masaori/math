# SageMath Check: pi_is_positive

## 対象

**対象ラベル**: `pi_is_positive` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_pi_is_positive`（0 < π）
- 範囲: 主張と、証明の三本の鎖の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の `arcsin(−1)` の鎖 3 行（`def_arcsin` の第二の式の `y' → −1`、`−(−1) = 1`、`arcsin(1) = π/2`） | `check_proof_lines.sage` | 記号計算（SR）と QQ で行の式どうしの等号 | **PASS** | 厳密（等号 3 個） |
| 準備の `−π/2 < π/2` の鎖 3 行（上の鎖、`−1 < 1` と狭義単調増加、`arcsin(1) = π/2`） | 同上 | 等号は SR、`arcsin(−1) < arcsin(1)` は RealBallField(256) | **PASS** | 等号 2 個・不等号 2 件 |
| 本体の `0 < π` の鎖 3 行（`−a + a = 0`、順序と加法の両立、`a/2 + a/2 = a`）と主張 | 同上 | 等号は SR、不等号はボール | **PASS** | 等号 2 個・不等号 2 件 |
| 否定コントロール | 同上 | `arcsin(−1)` の符号を取り違える、本体の 2 行目で両辺に同じ数を足さない（左辺に π/2、右辺に −π/2）、3 行目の `a/2 + a/2` を `a/2` と取り違える、のいずれも成り立たない | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: 等号は Sage の記号計算（SR）と QQ で判定した。
- **`ℝ` への脱出（`RealBallField(256)`）**: π と arcsin の値の大小だけ。ボールの比較は真と判定できたときだけ真を返す。
- 本文の arcsin（弧の長さ）が標準の arcsin に等しいことは `arcsin_is_bijection` の検算で確かめてある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh pi_is_positive
```

実行ログは `logs/` に保存する（2026-11-08、SageMath 10.9）。
