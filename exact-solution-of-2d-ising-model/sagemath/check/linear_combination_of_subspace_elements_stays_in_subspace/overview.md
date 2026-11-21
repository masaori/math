# SageMath Check: linear_combination_of_subspace_elements_stays_in_subspace

## 対象

**対象ラベル**: `linear_combination_of_subspace_elements_stays_in_subspace` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_linear_combination_of_subspace_elements_stays_in_subspace`
- 範囲: 証明の各段

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の各段 | `check_induction.sage` | 乱数の生成元の線型結合の全体 U が def_subspace (i)〜(iii) を満たすこと、帰納法の p = 0 と p → p+1 の 1 行の鎖・各項の所属（p = 0, …, 4）。対照: U 外の元を混ぜると出る | **PASS** | 461 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh linear_combination_of_subspace_elements_stays_in_subspace
```

実行ログは `logs/` に保存してある（2026-11-21）。
