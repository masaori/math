# SageMath Check: int_negation_of_sum_is_sum_of_negations

## 対象

**対象ラベル**: `int_negation_of_sum_is_sum_of_negations` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_integer_negation_of_sum_is_sum_of_negations`（`x, y ∈ ℤ` について `−(x + y) = (−x) + (−y)`）
- 範囲: 証明の 10 行の鎖、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `−(x+y) = −(x+y)+0 = −(x+y)+(x+(−x)) = −(x+y)+((x+0)+(−x)) = −(x+y)+((x+(y+(−y)))+(−x)) = −(x+y)+(((x+y)+(−y))+(−x)) = −(x+y)+((x+y)+((−y)+(−x))) = (−(x+y)+(x+y))+((−y)+(−x)) = 0+((−y)+(−x)) = (−y)+(−x) = (−x)+(−y)` | `check_proof_lines.sage` | `ZZ[x, y]` で 10 個の等号と、各段の根拠の形（和の単位元・加法の逆元・加法の結合律・加法の交換律）の両辺 10 個 | **PASS** |
| 主張 | `check_proof_lines.sage` | 整数の標本 `x, y = −40..40`（6561 件）で全ての行と主張 | **PASS** |

否定コントロール: 片方の符号を落とした `(−x) + y`、加法の逆元を `x + x` と取り違えた 2 行目は、どちらも検出される。

## 計算の帰属と範囲

- **厳密**: 多項式環 `ZZ[x, y]` と `ZZ`。浮動小数点は使わない。ℝ への脱出は無い。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は `ZZ[x, y]` の加法で計算するので構成上一致する。行の書き写しと根拠の形の代入の誤りを検出する。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh int_negation_of_sum_is_sum_of_negations
```

実行ログは `logs/` に保存する。
