# SageMath Check: extending_independent_family_by_element_outside_span

## 対象

**対象ラベル**: `extending_independent_family_by_element_outside_span` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_extending_independent_family_by_element_outside_span`
- 範囲: 証明の鎖・主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の鎖・主張 | `check_chains.sage` | 主張（乱数）。Step 1 の 8 行の鎖と γL の 4 行の鎖（p ≥ 1）・p = 0 の場合は、矛盾の仮定 c_{p+1} ≠ 0 の下の式なので x を u の線型結合に取った族で確かめる。Step 2 の 4 行の鎖は c_{p+1} = 0 の不定元係数で。対照: x が線型結合なら線型独立でない | **PASS** | 233 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh extending_independent_family_by_element_outside_span
```

実行ログは `logs/` に保存してある（2026-11-21）。
