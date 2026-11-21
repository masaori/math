# SageMath Check: principal_angle_plus_half_pi_at_most_pi

## 対象

**対象ラベル**: `principal_angle_plus_half_pi_at_most_pi` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_principal_angle_plus_half_pi_at_most_pi`（θ ≤ π/2 なら θ + π/2 ≤ π）
- 範囲: 主張と、証明の各鎖の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `θ + π/2 ≤ π/2 + π/2`（順序と加法の両立） | `check_proof_lines.sage` | 差 `(π/2 + π/2) − (θ + π/2) = π/2 − θ` を多項式で、符号を `θ = (k/16)π`（`−32 ≤ k ≤ 8`）で | **PASS** | 厳密・41 点 |
| 2 行目 `= π`（`real_half_plus_half_is_original` の `b → π`） | 同上 | 多項式で一致 | **PASS** | 厳密 |
| 否定の対照 | 同上 | `θ = π`（仮定を外す）で主張が崩れる。2 行目を `π/2` と取り違えると `π` にならない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 等号の行は、π と変数を不定元に置いた多項式環 `QQ` 上で比べた。不等号の行は「大きい側 − 小さい側」が仮定の差と同じ多項式になること（順序と加法の両立の当てはめ）を確かめ、変数を π の有理数倍に置いた点で符号を `QQ` で判定した（π の値に依らない）。


## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh principal_angle_plus_half_pi_at_most_pi
```

実行ログは `logs/` に保存する（2026-11-21、SageMath 10.9）。
