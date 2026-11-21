# SageMath Check: inclusion_zz_to_rr_preserves_negation

## 対象

**対象ラベル**: `inclusion_zz_to_rr_preserves_negation` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_zz_to_rr_preserves_negation`（`a ∈ ℤ` なら `ι(-a) = -ι(a)`。`ι` は `inclusion_zz_to_rr`）
- 範囲: 証明の 5 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `ι(-a) = ι(0-a) = ι(0)-ι(a) = 0-ι(a) = 0+(-ι(a)) = -ι(a)` | `check_proof_lines.sage` | `a = -200..200` で 5 個の等号（QQ。差は `inclusion_zz_to_rr_preserves_difference`、`ι(0) = 0` は定義、4 行目は `def_real_difference`） | **PASS** |
| 主張 | `check_proof_lines.sage` | `a = -200..200` で主張と、組み込みの埋め込み `QQ(-a)` との一致 | **PASS** |

等号は 2807 個。否定コントロール: 定義の符号反転の節を `ι''(-n) := ι(n)` に取り違えた写像（`ι''(n) = |n|`）では `ι''(-3) = 3 ≠ -3 = -ι''(3)`。

## 計算の帰属と範囲

- **厳密**: 値はすべて QQ。ℝ への脱出は無い。範囲は `-200 ≤ a ≤ 200`。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は再帰の定義と QQ の環の法則をなぞるので構成上一致する。中身は組み込みの埋め込みとの比較にある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_zz_to_rr_preserves_negation
```

実行ログは `logs/` に保存する。
