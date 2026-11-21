# SageMath Check: sin_on_all_reals_agrees_on_principal_interval

## 対象

**対象ラベル**: `sin_on_all_reals_agrees_on_principal_interval` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_sin_on_all_reals_agrees_on_principal_interval`（θ ∈ [−π/2, π/2] なら sin_ℝ(θ) = sin(θ)）
- 範囲: 主張と、証明の各鎖の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 3 行（`def_angle_section_of_theta_plus_half_pi`、`angle_section_of_principal_angle_plus_half_pi`、`principal_angle_plus_half_pi_at_most_pi`） | `check_proof_lines.sage` | `θ = (k/16)π`（`−8 ≤ k ≤ 8`。端点を含む）で `ξ_θ/π` を `QQ` で求め、`ξ_θ = θ + π/2` と `ξ_θ ≤ π` | **PASS** | 厳密・17 点 |
| 本体の 6 行（`def_sin_on_all_reals` の一つ目の場合、準備、`def_real_difference`、結合律、逆元、単位元） | 同上 | 引数の 5 等号を `QQ[π, θ]` で一致。定義の場合分けをそのまま書いた関数の値と標準の sin の値が同じ 17 点で一致（RealBallField(256)） | **PASS** | 厳密・17 点 |
| 主張の範囲外の裏取り | 同上 | 二つ目の場合の点と負の点（`k ∈ {9, 13, 17, 23, 30, −9, −20, −27}`）でも、定義の関数の値が標準の sin の値と一致する | **PASS** | 8 点 |
| 否定の対照 | 同上 | 引数の鎖で `−π/2` を落とすと `θ` にならない。一つ目の場合（`θ = π/4`）に二つ目の場合の引数を使うと `3π/4` になり主値区間を外れる | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 等号の行は、π と変数を不定元に置いた多項式環 `QQ` 上で比べた。不等号の行は「大きい側 − 小さい側」が仮定の差と同じ多項式になること（順序と加法の両立の当てはめ）を確かめ、変数を π の有理数倍に置いた点で符号を `QQ` で判定した（π の値に依らない）。
- 値の比較は RealBallField(256) で行った。本文の弧の長さで定めた sin・cos が標準の sin・cos と一致することは `arcsin_is_bijection` の検算に依る。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sin_on_all_reals_agrees_on_principal_interval
```

実行ログは `logs/` に保存する（2026-11-21、SageMath 10.9）。
