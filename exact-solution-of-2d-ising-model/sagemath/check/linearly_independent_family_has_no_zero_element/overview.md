# SageMath Check: linearly_independent_family_has_no_zero_element

## 対象

**対象ラベル**: `linearly_independent_family_has_no_zero_element` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_linearly_independent_family_has_no_zero_element`
- 範囲: 証明の論法・主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の論法・主張 | `check_chains.sage` | u_s = O の族で c_t := δ_{ts} の t ≠ s・t = s の鎖と和の 3 行の鎖、c_s = 1 ≠ 0、その族が線型独立でないこと。主張: 線型独立な乱数の族は O を含まない | **PASS** | 330 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh linearly_independent_family_has_no_zero_element
```

実行ログは `logs/` に保存してある（2026-11-21）。
