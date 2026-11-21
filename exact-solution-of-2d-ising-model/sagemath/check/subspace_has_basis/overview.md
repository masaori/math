# SageMath Check: subspace_has_basis

## 対象

**対象ラベル**: `subspace_has_basis` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_subspace_has_basis`
- 範囲: 証明の各段・主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の各段・主張 | `check_maximal_family.sage` | 証明の論法（U の元を、線型結合でない間だけ足す）を実装し、Step 1、Step 2（個数 ≤ mn、行列単位の線型結合）、Step 3（足せなくなった族は U を張り線型独立）。零部分空間と線型独立でない生成元を含む。対照 | **PASS** | 636 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh subspace_has_basis
```

実行ログは `logs/` に保存してある（2026-11-21）。
