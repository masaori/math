# SageMath Check: real_inclusion_preserves_power

## 対象

**対象ラベル**: `real_inclusion_preserves_power` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_real_inclusion_preserves_power`（`r ∈ ℝ`、`m ∈ ℤ_{≥0}` なら `(r^m)_ℂ = (r_ℂ)^m`）
- 範囲: `m = 0` の 3 行、帰納法の段の 4 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `m = 0`: `(r^0)_ℂ = (1_ℝ)_ℂ = 1_ℂ = (r_ℂ)^0` | `check_proof_lines.sage` | `r` を `QQ[r]` の不定元に置き、ℂ を実数の対として、ℝ の冪・ℂ の冪をそれぞれの定義の再帰で作って 3 個の等号 | **PASS** |
| 帰納法の段: `(r^{m+1})_ℂ = (r^m r)_ℂ = (r^m)_ℂ r_ℂ = (r_ℂ)^m r_ℂ = (r_ℂ)^{m+1}` | `check_proof_lines.sage` | `m = 0..12` で帰納法の仮定と 4 個の等号 | **PASS** |
| 主張 | `check_proof_lines.sage` | `m = 0..12` で、ℂ の冪を `QQ(i)[s]` の組み込みの冪の実部・虚部と比べる（独立な経路） | **PASS** |

等号は 81 個。否定コントロール: 虚部が 0 でない数 `(r, 1)` の 2 乗は `(r^2)_ℂ` にならない。

## 計算の帰属と範囲

- **厳密**: 値はすべて `QQ[r]`。不定元の多項式の等号は、任意の実数を代入しても保たれる。浮動小数点は無い。範囲は `m ≤ 13`。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は再帰の定義と対の積の式をなぞるので構成上一致する。中身は組み込みの冪との比較にある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_inclusion_preserves_power
```
