# SageMath Check: real_section_minus_half_pi_in_principal_interval

## 対象

**対象ラベル**: `real_section_minus_half_pi_in_principal_interval` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_section_minus_half_pi_in_principal_interval`（0 ≤ x ≤ π なら x − π/2 ∈ [−π/2, π/2]）
- 範囲: 主張と、証明の各鎖の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 左側の鎖の等号 2 行（加法の単位元、`def_real_difference`） | `check_proof_lines.sage` | `QQ[π, x]` で一致 | **PASS** | 厳密 |
| 左側の鎖の不等号（`0 ≤ x` と順序と加法の両立） | 同上 | 差が `x − 0` に一致、`x = (k/16)π`（`0 ≤ k ≤ 16`）で符号 | **PASS** | 厳密・17 点 |
| 右側の鎖の等号 5 行（`def_real_difference`、`real_half_plus_half_is_original`、結合律、逆元、単位元） | 同上 | 多項式で一致 | **PASS** | 厳密 |
| 右側の鎖の不等号（`x ≤ π` と順序と加法の両立） | 同上 | 差が `π − x` に一致、同じ 17 点で符号 | **PASS** | 厳密・17 点 |
| 否定の対照 | 同上 | 右側 3 行目を取り違えると等号が崩れる。`x = −π/4` で左側が、`x = 5π/4` で右側が崩れる | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: 等号の行は、π と変数を不定元に置いた多項式環 `QQ` 上で比べた。不等号の行は「大きい側 − 小さい側」が仮定の差と同じ多項式になること（順序と加法の両立の当てはめ）を確かめ、変数を π の有理数倍に置いた点で符号を `QQ` で判定した（π の値に依らない）。


## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_section_minus_half_pi_in_principal_interval
```

実行ログは `logs/` に保存する（2026-11-21、SageMath 10.9）。
