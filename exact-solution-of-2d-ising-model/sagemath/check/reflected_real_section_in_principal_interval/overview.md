# SageMath Check: reflected_real_section_in_principal_interval

## 対象

**対象ラベル**: `reflected_real_section_in_principal_interval` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_reflected_real_section_in_principal_interval`（π < x < 2π なら (π + π/2) − x ∈ [−π/2, π/2]）
- 範囲: 主張と、証明の各鎖の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の第一（符号反転 `−x < −π`、`−(2π) < −x`） | `check_proof_lines.sage` | 差が仮定の差 `x − π`・`2π − x` に一致 | **PASS** | 厳密 |
| 準備の第二の 4 行（交換律、結合律、逆元、単位元） | 同上 | `QQ[π, x]` で一致 | **PASS** | 厳密 |
| 右側の鎖 3 行（`def_real_difference`、順序と加法の両立、準備の第二） | 同上 | 等号は多項式、不等号は差が `(−π) − (−x)` に一致 | **PASS** | 厳密 |
| 左側の鎖 11 行（`def_real_difference`、順序と加法の両立、`real_sum_of_two_equal_terms_is_twice`、`real_negation_of_sum_is_sum_of_negations`、結合律、準備の第二、`real_half_plus_half_is_original`、逆元、単位元） | 同上 | 等号は多項式、不等号は差が `(−x) − (−(2π))` に一致 | **PASS** | 厳密 |
| 主張 | 同上 | `x = (1 + k/16)π`（`1 ≤ k ≤ 15`）で狭義の両側の不等号 | **PASS** | 15 点 |
| 否定の対照 | 同上 | 準備の第二で `−π/2` を足すと `π/2` にならない。`x = π/2` で右側が、`x = 9π/4` で左側が崩れる | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: 等号の行は、π と変数を不定元に置いた多項式環 `QQ` 上で比べた。不等号の行は「大きい側 − 小さい側」が仮定の差と同じ多項式になること（順序と加法の両立の当てはめ）を確かめ、変数を π の有理数倍に置いた点で符号を `QQ` で判定した（π の値に依らない）。


## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh reflected_real_section_in_principal_interval
```

実行ログは `logs/` に保存する（2026-11-21、SageMath 10.9）。
