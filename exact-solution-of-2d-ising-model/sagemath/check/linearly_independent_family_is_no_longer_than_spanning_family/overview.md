# SageMath Check: linearly_independent_family_is_no_longer_than_spanning_family

## 対象

**対象ラベル**: `linearly_independent_family_is_no_longer_than_spanning_family` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_linearly_independent_family_is_no_longer_than_spanning_family`
- 範囲: 証明の鎖・主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の鎖・主張 | `check_chain.sage` | p > q ≥ 1、u_i = Σ_j a_ij w_j、c を係数行列の左核から取り、9 行の鎖と u が線型独立でないこと。主張: 線型独立なら p ≤ q。対照: w の線型結合でない元を許すと崩れる | **PASS** | 369 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh linearly_independent_family_is_no_longer_than_spanning_family
```

実行ログは `logs/` に保存してある（2026-11-21）。
