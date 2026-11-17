# SageMath Check: real_less_than_is_asymmetric

## 対象

**対象ラベル**: `real_less_than_is_asymmetric` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_less_than_is_asymmetric`（`ℝ` で `a < b` ならば `b < a` は成り立たない）
- 範囲: 主張と、証明の段（`<` の意味から `a ≤ b`・`a ≠ b`・`b ≤ a` を読み出す段、反対称律で `a = b` とする 1 行の鎖、`a ≠ b` との矛盾）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `<` の意味（`x < y` は `x ≤ y` かつ `x ≠ y`）の読み出し | `check_proof_lines.sage` | `QQ` と `AA` の標本の全ての組で `(x < y) == (x ≤ y かつ x ≠ y)` | **PASS** | 117 件（反対称律と合わせて 234 件） |
| 鎖 `a = b`（`a ≤ b` と `b ≤ a` に反対称律） | 同上 | 同じ標本の全ての組で、`x ≤ y` かつ `y ≤ x` なら `x = y` | **PASS** | 117 件 |
| 主張 `a < b ⇒ ¬(b < a)` と、`a ≠ b` との矛盾 | 同上 | `a < b` の組で `a ≤ b`・`a ≠ b`、`b ≤ a` が反対称律と `a ≠ b` に両立しないこと、`b < a` でないこと | **PASS** | 51 件 |
| 否定コントロール | 同上 | `<` を `≤` に替えると非対称でない（`0 ≤ 0`）。反対称律の無い関係（いつも真）から作った「かつ `≠`」は非対称でない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: `QQ`・`AA` の比較だけで計算した。浮動小数点は使わない。
- 範囲外: 標本で公理の形を確かめるだけで、ℝ の順序体の公理からの証明ではない。検算は証明の段の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_less_than_is_asymmetric
```

実行ログは `logs/` に保存する（2026-11-17、SageMath 10.9）。
