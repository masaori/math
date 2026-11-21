# SageMath Check: concatenated_bases_of_direct_sum_form_basis

## 対象

**対象ラベル**: `concatenated_bases_of_direct_sum_form_basis` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_concatenated_bases_of_direct_sum_form_basis`
- 範囲: 証明の各段・主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の各段・主張 | `check_steps.sage` | V = ℂ^n = im Q ⊕ ker Q（n = 1, …, 4、r = 0, …, n）で直和の (i)(ii)、Step 1 の 4 行の鎖、Step 2 の u + w の鎖・u = −w = (−1)w・O + w = w、主張（つないだ族は基底、次元の和）。対照: U ∩ W ≠ {O} | **PASS** | 197 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh concatenated_bases_of_direct_sum_form_basis
```

実行ログは `logs/` に保存してある（2026-11-21）。
