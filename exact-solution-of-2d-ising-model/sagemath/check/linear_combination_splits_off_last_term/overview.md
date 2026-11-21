# SageMath Check: linear_combination_splits_off_last_term

## 対象

**対象ラベル**: `linear_combination_splits_off_last_term` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_linear_combination_splits_off_last_term`
- 範囲: 主張の式・証明の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 主張の式・証明の鎖 | `check_two_cases.sage` | p = 0 の 4 行の鎖と p ≥ 1 の 3 行の鎖（m, n ∈ {1,2,3}、p = 0, …, 4。係数は不定元、u_t は乱数行列）。対照: 最後の項を落とすと崩れる | **PASS** | 145 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh linear_combination_splits_off_last_term
```

実行ログは `logs/` に保存してある（2026-11-21）。
