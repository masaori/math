# SageMath Check: one_dimensional_subspace_is_multiples_of_nonzero_element

## 対象

**対象ラベル**: `one_dimensional_subspace_is_multiples_of_nonzero_element` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_one_dimensional_subspace_is_multiples_of_nonzero_element`
- 範囲: 証明・主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明・主張 | `check_claim.sage` | 1 次元の部分空間の基底 (q) で q ≠ O、u = Σ_{t=1}^{1} c_t q = Σ(c_t q) = c_1 q の 3 行の鎖、cq ∈ U。対照: 2 次元 | **PASS** | 97 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh one_dimensional_subspace_is_multiples_of_nonzero_element
```

実行ログは `logs/` に保存してある（2026-11-21）。
